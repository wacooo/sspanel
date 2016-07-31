<?php

namespace App\Models;

use App\Utils\Tools;

class Package extends Model
{
	protected $table = "vpn_package";
	
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
	
	public function getEndTime(){
		$endTime = $this->attributes['end_time'];
		if ($endTime == NULL) {
			return "--";
		}
		return date("Y-m-d H:i", $endTime);
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