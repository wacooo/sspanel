<nav class="main-nav-outer" id="test"><!--main-nav-start-->
	<div class="container">
        <ul class="main-nav">
        	<li><a href="/#header">首页</a></li>
            <li><a href="/#team">购买</a></li>
            <li><a href="http://www.godusevpn.mobi/wiki.html">教程</a></li>
            <li class="small-logo"><a href="/#header"><img src="/assets/public/img/small-logo.png" alt=""></a></li>
            <li><a href="/download">客户端下载</a></li>
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