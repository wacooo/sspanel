#!/usr/bin/env php
<?php
require __DIR__ . '/bootstrap/app.php';
use App\Command\Loop;
use App\Services\VpnPackage\VpnPackage;

function routine($text) {
	throw new Exception("Errro, Can't you catch?");
	printf("I'm a timer callback %s\n", $text);
}

// Test Suite
// $now = time();
// $end = $now + 3600000;
// $package = VpnPackage::createNewPackage(2, 50000, 10, $now, $end);
// VpnPackage::preparePackage($package->id);

// $package = VpnPackage::createNewPackage(12, 50000, 10, $now, $end);
// VpnPackage::preparePackage($package->id);

// $p = VpnPackage::findPackage(34);
// $pe = VpnPackage::createExtendedPackage($p, 3600);
// VpnPackage::preparePackage($pe->id);


function packageRoutine(){
	$p = new VpnPackage();
	$p->enablePendingPackages();
	$p->stopTimeoutPackages();
	$p->resetTraffics();
	unset($p);
}


$loop = new Loop();
$loop->schedule(5, "packageRoutine", false, true);
$loop->start();