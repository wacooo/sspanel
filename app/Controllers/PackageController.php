<?php

namespace App\Controllers;

use App\Models\User;
use App\Services\Auth;
use App\Services\VpnPackage\VpnPackage;

class PackageController extends BaseController {
	
	public function add($request, $response, $args){
		
		$rs['ret'] = 0;
		$a = $request->getParam("amount");
		$m = $request->getParam("month");
		if (empty($a) || empty($m)) {
			$rs['msg'] = "参数不全";
			return $response->getBody()->write(json_encode($rs));
		}
		$amount = (int)$a;
		$month = (int)$m;
		if ($amount < 10 || $month < 1) {
			$rs['msg'] = "参数值不合预期";
			return $response->getBody()->write(json_encode($rs));
		}

		$user = Auth::getUser();
		if(!$user->isLogin) {
			$rs['msg'] = "用户未登录";
			return $response->getBody()->write(json_encode($rs));			
		}
		$startTime = time();
		$endTime = $startTime + $month*31*24*3600;
		$p = VpnPackage::createNewPackage($user->id, $amount*1024*1024*1024, 3600*24*31, $startTime, $endTime);
		$rs['msg'] = "创建新套餐成功";
		$rs['pid'] = $p->id;
		$rs['ret'] = 1;

		return $response->getBody()->write(json_encode($rs));
	}
	
	public function payedCheck($request, $response, $args){
		
		$pid = $request->getParam("pid");
		
		$rs['ret'] = 0;
		if (empty($pid)) {
			$rs['msg'] = "参数不全";
			return $response->getBody()->write(json_encode($rs));
		}
		
		// TODO: do pay check		
		VpnPackage::preparePackage($pid);
		$rs['msg'] = "套餐已经支付。";
		$rs['ret'] = 1;
		return $response->getBody()->write(json_encode($rs));
	}
	
	public function extend($request, $response, $args){
		$rs['ret'] = 0;
		if (!isset($args["month"])) {
			$rs['msg'] = "参数不全";
			return $response->getBody()->write(json_encode($rs));
		}
		$month = (int)$args["month"];
		if ($month < 1) {
			$rs['msg'] = "参数值不合预期";
			return $response->getBody()->write(json_encode($rs));
		}
	
		$user = Auth::getUser();
		if(!$user->isLogin) {
			$rs['msg'] = "用户未登录";
			return $response->getBody()->write(json_encode($rs));
		}
		$p = VpnPackage::getUsingPackage($user->id);
		if ($p == NULL) {
			$rs['msg'] = "目前没有套餐，无法续约";
			return $response->getBody()->write(json_encode($rs));
		}
		$ep = VpnPackage::createExtendedPackage($p, $month*31*24*3600);
		$rs['msg'] = "续约套餐成功";
		$rs['pid'] = $p->id;
		$rs['ret'] = 1;
		
		return $response->getBody()->write(json_encode($rs));
	}
}