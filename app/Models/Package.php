<?php

namespace App\Models;

use App\Utils\Tools;
use App\Models\User;

class Package extends Model
{
	protected $table = "vpn_package";
	
	protected $casts = [
			"amount" => 'float'
	];
	
	public static function copy($o){
		if ($o != NULL) {
			$p = new Package();
			$p->id = $o->id;
			$p->amount = $o->amount;
			$p->uid = $o->uid;
			$p->start_time = $o->start_time;
			$p->end_time = $o->end_time;
			$p->reset_interval = $o->reset_interval;
			$p->next_reset_time = $o->next_reset_time;
			$p->status = $o->status;
		}
		return $p;
	}

	public function getUserEmail() {
		$u = User::where('id', $this->uid)->first();
		if ($u != NULL) {
			return $u->email;
		}
		return "--";
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
				$status = "使用中";
				break;
			case 3:
				$status = "已结束";
				break;
			case 3:
				$status = "被合并";
				break;
		}
		return $status;
	}
	
	public function getResetInterval(){
		$interval = $this->reset_interval;
		if ($interval == NULL) {
			return "--";
		}
		$month = round($interval / 3600 / 24 / 31);
		return "".$month."个月";
	}
	
	public function getTimeStr($time) {
		if ($time == NULL) {
			return "--";
		}
		return date("Y-m-d H:i", $time);
	}
	
	public function getStartTime(){
		return $this->getTimeStr($this->attributes['start_time']);
	}
	
	public function getEndTime(){
		return $this->getTimeStr($this->attributes['end_time']);
	}
	
	public function getNextResetTime(){
		return $this->getTimeStr($this->attributes['next_reset_time']);
	}
	
	public function getAmount(){
		$amount = $this->attributes['amount'];
		if ($amount == NULL) {
			return "--";
		}
		return Tools::flowAutoShow($amount);
	}
	
	public function nextResetTime(){
		$nextReset = $this->attributes['next_reset_time'];
		if ($nextReset == NULL) {
			return "--";
		}
		return date("Y-m-d H:i", $nextReset);
	}
}