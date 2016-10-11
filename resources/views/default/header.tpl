<!doctype html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, maximum-scale=1">
<title>{$config["appTitle"]}</title>
<meta name="keywords" content="{$config["appKeywords"]}">     
<meta name="description" content="{$config["appDescription"]}">

<link rel="shortcut icon" href="favicon.ico" type="img/x-icon"/>

<!-- Bootstrap Core CSS -->
<link href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
<!-- Custom Fonts -->
<link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<!-- Animate-->
<link href="http://cdn.bootcss.com/animate.css/3.5.2/animate.css" rel="stylesheet">

<link href="/assets/public/css/home.css" rel="stylesheet" type="text/css"/>

<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
    <script src="http://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="/assets/public/js/jquery-scrolltofixed.js"></script>
    <script src="http://cdn.bootcss.com/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="http://cdn.bootcss.com/jquery.isotope/1.5.25/jquery.isotope.min.js"></script>
    <script src="http://cdn.bootcss.com/wow/1.1.2/wow.min.js"></script>
    <script src="http://cdn.bootcss.com/classie/1.0.1/classie.min.js"></script>

    <nav class="main-nav-outer" id="test"><!--main-nav-start-->
		<div class="container">
	        <ul class="main-nav">
	            <li><a href="/#team">购买</a></li>
	            {if $user->isLogin}
	            <li><a href="/wiki/index.php">教程/下载</a></li>
	            {/if}
	            <li class="small-logo"><a href="/"><img src="/assets/public/img/small-logo.png" alt=""></a></li>
	            {if $user->isLogin}
	                <li><a href="/user">用户中心</a></li>
	                <li><a href="/user/logout">退出</a></li>
	            {else}
	                <li><a href="/auth/login">登录</a></li>
	                <li><a href="/auth/register">注册</a></li>
	            {/if}
	        </ul>
	        <a class="res-nav_click" href="#"><i class="fa-bars"></i></a>
	    </div>
	</nav><!--main-nav-end-->