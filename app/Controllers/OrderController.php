<?php

namespace App\Controllers;

require BASE_PATH . '/app/Utils/Order.php';

use App\Services\Config;
use App\Models\Order;
use App\Services\VpnPackage\VpnPackage;
use App\Services\Logger;
use App\Services\Auth;
use App\Utils\Tools;
use App\Models\User;
use App\Utils\Helper;

class OrderController extends UserController
{
	protected $seller;
	protected $partner;
	protected $notifyURL;
	protected $returnURL;
	protected $keyUnique;
	protected $gateway;
	
	private $pagesize;
	
	public function __construct(){
		$this->seller = Config::get("sell");
		$this->partner = Config::get("partner");
		$this->keyUnique = Config::get("payKey");
		$this->notifyURL = Config::get("notifyURL");
		$this->returnURL = Config::get("returnURL");
		$this->gateway = Config::get("gateway");
		$this->pagesize = 10;
	}
	
	private function payWithPackage($request, $response, $package){

		// create order
		$price = VpnPackage::computePrice($package);
		$amount = $package->amount;
		$month = round(($package->end_time - $package->start_time) / 24 / 3600 / 31);
		
		$subject = "购买套餐：".$month."个月,月流量".Tools::flowAutoShow($amount);
		$total_fee = $price;
		$orderid = orderid();
		
		$o = new Order();
		$o->orderid = $orderid;
		$o->price = $price;
		$o->create_time = time();
		$o->name = $subject;
		$o->status = 0;
		$o->status_desc = "新创建";
		$o->uid = $package->uid;
		$o->pid = $package->id;
		$o->save();
		
		$parameter = array(
				"partner" => $this->partner,
				"user_seller"  => $this->seller,
				"out_order_no"	=> $orderid,
				"subject"	=> $subject,
				"total_fee"	=> $total_fee,
				"notify_url"	=> $this->notifyURL,
				"return_url"	=> $this->returnURL
		);
		
		$html_text = callPayGateway($parameter, $this->gateway, $this->keyUnique);
		return $response->getBody()->write($html_text);
	}
	
	public function payOrder($request, $response, $args){
		$orderid = $request->getParam('orderid');
		$o = Order::where("orderid", $orderid)->first();
		if ($o == null) {
			$rs['ret'] = 0;
			$rs['msg'] = "无效订单号";
			return $response->getBody()->write(json_encode($rs));
		}
		
		$parameter = array(
				"partner" => $this->partner,
				"user_seller"  => $this->seller,
				"out_order_no"	=> $orderid,
				"subject"	=> $o->name,
				"total_fee"	=> $o->price,
				"notify_url"	=> $this->notifyURL,
				"return_url"	=> $this->returnURL
		);
		
		$html_text = callPayGateway($parameter, $this->gateway, $this->keyUnique);
		return $response->getBody()->write($html_text);
	}
	
	public function pay($request, $response, $args)
	{
		// create package
		$a = $request->getParam("amount");
		$m = $request->getParam("month");
		if (empty($a) || empty($m)) {
			$rs['ret'] = 0;
			$rs['msg'] = "参数不全";
			return $response->getBody()->write(json_encode($rs));
		}
		$amount = (int)$a;
		$month = (int)$m;
		if ($amount < 10 || $month < 1) {
			$rs['msg'] = "参数值不合预期";
			return $response->getBody()->write(json_encode($rs));
		}

		$startTime = time();
		$endTime = $startTime + $month*31*24*3600;
		$user = Auth::getUser();
		$p = VpnPackage::createNewPackage($user->id, $amount*1024*1024*1024, 3600*24*31, $startTime, $endTime);
		
		return $this->payWithPackage($request, $response, $p);
	}
	
	public function renewOptions($request, $response, $args){
		$u = Auth::getUser();
		$p = VpnPackage::getUsingPackage($u->id);
		if ($p == null) {
			return $response->getBody()->write("没有正在使用的套餐，无法续约。");
		}
		return $this->view()->assign("amount", $p->amount/1024/1024/1024)->display('order/renew.tpl');
	}
	
	public function renew($request, $response, $args){
		// create package
		$u = Auth::getUser();
		$m = $request->getParam("month");
		$p = VpnPackage::findUsingPackageForUser($u->id);
		if (empty($p) || empty($m)) {
			$rs['msg'] = "参数不全";
			return $response->getBody()->write(json_encode($rs));
		}
		$np = VpnPackage::createExtendedPackage($p, $m*31*24*3600);
		return $this->payWithPackage($request, $response, $np);
	}
	
	public function callback($request, $response, $args){
		$orderid = $request->getParam('out_order_no');
		
		//计算得出通知验证结果
		$shanNotify = md5VerifyShan($request->getParam('out_order_no'),$request->getParam('total_fee'),$request->getParam('trade_status'),$request->getParam('sign'),
				$this->keyUnique,$this->partner);
		$o = Order::where("orderid", $orderid)->first();
		
		if ($o == null) {
			return $response->getBody()->write('failed, Invalid order.');
		}
		
		$tradeNo = $request->getParam('trade_no');
		$o->partner_payment_id = $tradeNo;
		$o->pay_time = time();
		
		if (Helper::isTesting()) {
			$shanNotify = true;
		}
		
		if($shanNotify) {//验证成功
			Logger::info("Pay Callback - Validated ".$orderid);
			if($request->getParam('trade_status')== "TRADE_SUCCESS"){
				Logger::info("Pay Callback - Success ".$orderid);
				if ($o->status == 0) {
					$cprice = (float)$request->getParam('total_fee');
					VpnPackage::preparePackage($o->pid);
					if (abs($o->price - $cprice) < 0.1) {
						$o->status = 1;
						$o->status_desc = "支付成功";
					}else{
						$o->status = 1;
						$o->status_desc = "金额不匹配. 原金额".$o->price.". 支付金额：".$cprice;
					}
					$o->save();
					return $response->getBody()->write('success');
				}
			}else {
				Logger::info("Pay Callback - Failed to pay ".$orderid);
				if ($o->status == 0) {
					$o->status = 2;
					$o->status_desc = "支付失败";
				}
			}		
		}else {
			Logger::info("Pay Callback - Failed to validate ".$orderid);
		}
		$o->save();
		return $response->getBody()->write('failed');
	}
	
	public function success(){
		$this->view()->display('order/success.tpl');
	}
	
	public function fail(){
		$this->view()->display('order/fail.tpl');
	}
	
	public function listAll($request, $response, $args) {
		$psize = $this->pagesize;
		$pindex = $request->getParam('page');
		$pindex = $pindex == null ? 1 : $pindex;
		$orders = Order::orderBy("id","desc")->paginate($psize, ['*'], 'page', $pindex);		
		$orders->setPath("/admin/order");
		return $this->view()->assign("orders", $orders)->display('order/listall.tpl');
	}
	
	public function list($request, $response, $args) {
		$pindex = $request->getParam('page');
		$pindex = $pindex == null ? 1 : $pindex;
		$u = Auth::getUser();
		$uid = $u->id;
		$orders = Order::where("uid",$uid)->orderBy('id', 'desc')->paginate($this->pagesize, ['*'], 'page', $pindex);
		$orders->setPath("/order/list");
		return $this->view()->assign("orders",$orders)->display('order/list.tpl');
	}
}