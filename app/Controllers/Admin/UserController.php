<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\User;
use App\Utils\Hash;
use App\Utils\Tools;
use App\Services\VpnPackage\VpnPackage;

class UserController extends AdminController
{
    public function index($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $users = User::paginate(15, ['*'], 'page', $pageNum);
        $users->setPath('/admin/user');
        return $this->view()->assign('users', $users)->display('admin/user/index.tpl');
    }

    public function edit($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if ($user == null) {

        }
        return $this->view()->assign('user', $user)->display('admin/user/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);

        $user->email = $request->getParam('email');
        if ($request->getParam('pass') != '') {
            $user->pass = Hash::passwordHash($request->getParam('pass'));
        }
        if ($request->getParam('passwd') != '') {
            $user->passwd = $request->getParam('passwd');
        }
        $user->port = $request->getParam('port');
        $user->transfer_enable = Tools::toGB($request->getParam('transfer_enable'));
        $user->invite_num = $request->getParam('invite_num');
        $user->method = $request->getParam('method');
        $user->enable = $request->getParam('enable');
        $user->is_admin = $request->getParam('is_admin');
        $user->ref_by = $request->getParam('ref_by');
        if (!$user->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function delete($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if (!$user->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function deleteGet($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        $user->delete();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/user');
        return $newResponse;
    }
    
    public function createFreeAccount($request, $response, $args)
    {
    	$name = "cjt".Tools::genRandomDigits(8);
    	$email = $name."@changjingtu.com";
    	$passwd = "cjtpass2016";
    	 
    	$user = User::where('email', $email)->first();
    	if ($user != null) {
    		$res['ret'] = 0;
    		$res['error_code'] = AuthController::EmailUsed;
    		$res['msg'] = "邮箱已经被注册了";
    		return $this->echoJson($response, $res);
    	}
    
    	// do reg user
    	$user = new User();
    	$user->user_name = $name;
    	$user->email = $email;
    	$user->pass = Hash::passwordHash($passwd);
    	$user->passwd = Tools::genRandomChar(6);
    	$user->port = Tools::getLastPort() + 1;
    	$user->method = "aes-256-cfb";
    	$user->t = 0;
    	$user->u = 0;
    	$user->d = 0;
    	$user->enable = 0;
    	$user->transfer_enable = 0;
    
    	if ($user->save()) {
    		$amount = Tools::toMB(1024);
    		$duration = 31*24*3600;
    		$startTime = time();
    		$p = VpnPackage::createNewPackage($user->id, $amount, $duration, $startTime, $startTime + $duration, true);
    		$res['ret'] = 1;
    		$res['msg'] = "注册成功";
    		return $this->echoJson($response, $res);
    	}
    	$res['ret'] = 0;
    	$res['msg'] = "未知错误";
    	return $this->echoJson($response, $res);
    }
}