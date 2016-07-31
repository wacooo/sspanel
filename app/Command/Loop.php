<?php


namespace App\Command;

use App\Command\Events;
use App\Services\VpnPackage\VpnPackage;

class Loop
{
	public $events;

	public function __construct()
	{
		$this->events = new Events();
	}
	
	public function schedule($secondsSinceNow, $fun, $args = false, $repeat) {
		$flags = Events::EVENT_SEQUENCE;
		if ($repeat) {
			$flags = Events::EVENT_REPEAT;
		}
		$this->events->AddTimer($secondsSinceNow, $fun, $args, $flags);
	}

	public function start()
	{
		while (true) {
			try {
				$this->events->CheckTimers();
				$secs = $this->events->GetNextTimer();
			}catch (\Exception $e) {
                $res["msg"] = $e->getMessage();
                printf($e->getMessage() ."\n");
                $secs = 1.0;
            }
            if ($secs == false) {
            	$secs = 1.0;
            	printf("Next timer in %s seconds...\n", $secs);
            }            
			sleep($secs);
		}

	}
}

class Events {
	
	const EVENT_REPEAT      = 0x0001;
	const EVENT_SEQUENCE    = 0x0002;
	var $events;
	var $timers;

	function __construct() {
		$this->events = array();
		$this->timers = array();
	}

	function AddTimer($when, $action, $args = false, $flags = 0) {
		$time = time(NULL) + $when;
		if ($flags & self::EVENT_SEQUENCE) {
			while ($this->IsArrayCount($this->timers[$time])) {
				$time ++;
			}
		}
		$this->timers[$time][] = array("when" => $when, "action" => $action, "args" => $args, "flags" => $flags);
		ksort($this->timers);
	}

	function GetNextTimer() {
		if (!$this->IsArrayCount($this->timers)) {
			return false;
		}
		reset($this->timers);
		$firstevent = each($this->timers);
		if ($firstevent === false) {
			return false;
		}
		$time = $firstevent["key"];
		$nextEvent = $time - time(NULL);
		if ($nextEvent < 1) {
			return 1;
		}

		return $nextEvent;
	}

	// @todo Make sure the call_func_array exception would not break the routine.
	function CheckTimers() {
		$rv = false;
		$now = time(NULL);
		foreach ($this->timers as $time => $events) {
			if ($time > $now) {
				break;
			}
			foreach ($events as $key => $event) {
				if (!$event["args"]) {
					call_user_func($event["action"]);
				} else {
					$rv = call_user_func_array($event["action"], is_array($event["args"]) ? $event["args"] : array($event["args"]));
				}
				unset($this->timers[$time][$key]);
				if ($event["flags"] & self::EVENT_REPEAT) {
					$this->AddTimer($event["when"], $event["action"], $event["args"], $event["flags"]);
				}
			}
			if (!$this->IsArrayCount($this->timers[$time])) {
				unset($this->timers[$time]);
			}
		}
	}


	function IsArrayCount($possibleArray) {
		return (isset($possibleArray) && is_array($possibleArray)) ? count($possibleArray) : false;
	}
}
