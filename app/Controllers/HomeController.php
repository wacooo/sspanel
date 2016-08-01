<?php

namespace App\Controllers;

//use Psr\Http\Message\ServerRequestInterface as Request;
//use Psr\Http\Message\ResponseInterface as Response;
use Slim\Http\Request;
use Slim\Http\Response;

use App\Models\InviteCode;
use App\Services\Auth;
use App\Services\Config;
use App\Services\DbConfig;
use App\Services\Logger;
use App\Utils\Check;
use App\Utils\Http;
use App\Services\VpnPackage\VpnPackage;
use App\Utils\Tools;

/**
 *  HomeController
 */
class HomeController extends BaseController
{

    public function index()
    {
        $homeIndexMsg = DbConfig::get('home-index');
        return $this->view()->assign('homeIndexMsg', $homeIndexMsg)->display('index.tpl');
    }

    public function code()
    {
        $msg = DbConfig::get('home-code');
        $codes = InviteCode::where('user_id', '=', '0')->take(10)->get();
        return $this->view()->assign('codes', $codes)->assign('msg', $msg)->display('code.tpl');
    }

    public function debug($request, $response, $args)
    {
        $server = [
            "headers" => $request->getHeaders(),
            "content_type" => $request->getContentType()
        ];
        $res = [
            "server_info" => $server,
            "ip" => Http::getClientIP(),
            "version" => Config::get('version'),
            "reg_count" => Check::getIpRegCount(Http::getClientIP()),
        ];
        Logger::debug(json_encode($res));
        return $this->echoJson($response, $res);
    }

    public function tos()
    {
        return $this->view()->display('tos.tpl');
    }

    public function postDebug(Request $request,Response $response, $args)
    {
        $res = [
            "body" => $request->getBody(), 
            "params" => $request->getParams() 
        ];
        return $this->echoJson($response, $res);
    }

    public function download()
    {
        $homeIndexMsg = DbConfig::get('home-download');
        return $this->view()->assign('homeIndexMsg', $homeIndexMsg)->display('download.tpl');
    }
    
    public function buy()
    {
    	return $this->view()->display('buy.tpl');
    }

    public function pay($request, $response, $args){
    	$pid = $request->getParam('pid');
    	if (empty($pid)) {
    		return $this->redirect($response, "/");
    	}
    	$p = VpnPackage::findPackage($pid);
    	if ($p == NULL || $p->status != 0) {
    		return $this->redirect($response, "/");
    	}
    	$price = VpnPackage::computePrice($p);
    	$amount = $p->amount;
    	$month = round(($p->end_time - $p->start_time) / 24 / 3600 / 31);
    	$desc = "购买".$month."个月,每月流量".Tools::flowAutoShow($amount);
    	return $this->view()->assign("price",$price)->assign("pdesc", $desc)->display('pay.tpl');
    }
}