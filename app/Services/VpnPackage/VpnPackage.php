<?php

namespace App\Services\VpnPackage;

use App\Models\Package;
use App\Models\User;

class VpnPackage {
	
	public static function findUsingPackageForUser($uid) {
		$p = Package::where('uid', $uid)->where('status', 2);
		return $p->first();

	}
	
	public static function findPackage($pid) {
		$p = Package::where('id', $pid);
		return $p->first();
	}
	
	public static function createExtendedPackage($originpackage, $secondsToExtend){
		$package = Package::copy($originpackage);
		unset($package->id);
		unset($package->next_reset_time);
		$package->start_time = $originpackage->end_time;
		$package->end_time = $package->start_time + $secondsToExtend;
		$package->status = 0;
		$package->save();
		return $package;
	}
	
	public static function computePrice($package) {
		$month = ($package->end_time - $package->start_time) / 3600 / 24 / 31;
		$x = $package->amount;
		$x = $x / 1024 / 1024 / 1024;
		$y = round($month);
		
		$traffics = [16, 51, 101];
		$prices = [10, 35, 58, 15, 45, 78, 20, 60, 108];
		$mons = [1, 6, 12];
		$r = 0;
		$tl = count($traffics);
		for ($r = 0 ; $r < $tl ; $r++) {
			if ($traffics[$r] > $x) {
				break;
			}
		}
		$r = ($r == $tl? $r-1 : $r);
		
		$p = 0;
		$ty = $y;
		$ml = count($mons);
		for ($i = 0 ; $i < $ml; $i++) {
			$index = $ml - $i - 1;
			if ($ty >= $mons[$index]) {
				$p += $ty/$mons[$index] * $prices[$r*$ml+$index];
				$ty = $ty % $mons[$index];
			}
		}
		return $p;
	}
	
	public static function computePrice2($package) {
		$month = ($package->end_time - $package->start_time) / 3600 / 24 / 31;
		$x = $package->amount;
		$x = $x / 1024 / 1024 / 1024;
		$y = round($month);
		$fy = $y - floor($y/6);
		$z = 0;			
		if ($x <= 100) {
			$z= (0.2 * $x + 8)* $fy;
		}else{
			$z = (0.1 * $x + 18) * $fy;
		}
		return $z;
	}
	
	public static function createNewPackage($uid, $amount, $resetInterval, $startTime, $endTime){
		$package = new Package();
		$package->amount = $amount;
		$package->uid = $uid;
		$package->reset_interval = $resetInterval;
		$package->start_time = $startTime;
		$package->end_time = $endTime;
		$package->status = 0;
		$package->save();
		return $package;
	}
	
	public static function preparePackage($pid) {
		$p = Package::where('id', $pid);
		if ($p->count() > 0) {
			$p ->update(array('status' => 1));
		}
	}
	
	public static function stopTimeoutPackages($doReset = true) {
		$now = time();
		$packages = Package::where('end_time', '<', $now)->where('status', 2);
		$packages->update(array('status' => 3));
		if (!$doReset) {
			return;
		}
		foreach ($packages as $package) {
			try{
				$user = User::where('id', $package->uid)->firstOrFail();
				$user->u = 0;
				$user->d = 0;
				$user->transfer_enable = 0;
				$user->save();
			} catch(Exception $e){
				printf($e."\n");
				continue;
			}
		}
	}
	
	public static function getUsingPackage($uid){
		$usingPackages = Package::where('uid', $uid)->where('status', 2);
		$usingPackage = $usingPackages->first();
		return $usingPackage;
	}
	
	public static function enablePendingPackages(){
		$packages = Package::where('status', '=', 1)->get();
		foreach ($packages as $package) {
			$usingPackages = Package::where('uid', $package->uid)->where('status', 2);
			$usingPackage = NULL;
			if ($usingPackages->count() > 0) {
				$usingPackage = $usingPackages->firstOrFail();
			}
			if($usingPackage == NULL || $package->amount != $usingPackage->amount || $package->start_time < time()) {
				if ($usingPackage != NULL) {
					$usingPackage->status = 3;
					$usingPackage->save();
				}
				$package->status = 2;
				$package->next_reset_time = time() + $package->reset_interval;
				$package->save();
				$user = User::where('id', $package->uid)->firstOrFail();
				$user->u = 0;
				$user->d = 0;
				$user->transfer_enable = $package->amount;
				$user->save();
			}else {
				// if can extend
				if ($package->start_time <= $usingPackage->end_time + 30 && $package->end_time > $usingPackage->end_time) {
					$usingPackage->end_time = $package->end_time;
					$usingPackage->save();
					$package->status = 4;
					$package->save();
				}
			}
		}
	}
	
	public static function resetTraffics(){
		$now = time();
		$packages = Package::where('next_reset_time', '<', $now)->where('status', 2)->get();
		foreach ($packages as $package) {
			try{
				$package->next_reset_time += $package->reset_interval;
				$package->save();
				$user = User::where('id', $package->uid)->firstOrFail();
				$user->u = 0;
				$user->d = 0;
				$user->transfer_enable = $package->amount;
				$user->save();
			} catch(Exception $e){
				printf($e."\n");
				continue;
			}
		}
	}
}