<?php

namespace App\Models;

use App\Utils\Tools;

class Order extends Model {
	
	protected $table = "vpn_order";

	public function getCreateTime(){
		return Tools::getTimeStr($this->create_time);
	}
	public function getPayTime(){
		return Tools::getTimeStr($this->pay_time);
	}
	public function getStatus(){
		$status = "--";
		switch($this->status) {
			case 0:
				$status = "新创建";
				break;
			case 1:
				$status = "已支付";
				break;
			case 2:
				$status = "支付失败";
				break;
			case 3:
				$status = "已关闭";
				break;
		}
		return $status;
	}
	
	public function getParnerPaymentID(){
		$paymentID = "--";
		if ($this->partner_payment_id != null) {
			$paymentID = $this->partner_payment_id;
		}
		return $paymentID;
	}
	
}