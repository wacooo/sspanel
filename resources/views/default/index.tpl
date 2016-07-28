{include file='header.tpl'}
<div class="section no-pad-bot" id="index-banner">
    <div class="container">
        <br><br>
        <h1 class="header center orange-text">{$config["appName"]}</h1>
        <div class="row center">
            <h5 class="header col s12 light">轻松科学上网   保护个人隐私</h5>
            {$homeIndexMsg}
        </div>
        {if $user->isLogin}
            <div class="row center">
                <a href="/user" id="download-button" class="btn-large waves-effect waves-light orange col s4 offset-s3">进入用户中心</a>
                <div class="col s2" style="">
                  <a target="_blank" href="http://sighttp.qq.com/authd?IDKEY=bdfa6222a079d132d978a3d332bc1a2cb594ce046fa52229"><img border="0" src="http://wpa.qq.com/imgd?IDKEY=bdfa6222a079d132d978a3d332bc1a2cb594ce046fa52229&amp;pic=51" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
            </div>
        {else}
        <div class="row center">
            <a href="/auth/register" id="download-button" class="btn-large waves-effect waves-light orange">立即注册</a>
        </div>
        {/if}
        <br><br>
    </div>
</div>


<div class="container">
    <div class="section">

        <!--   Icon Section   -->
        <div class="row">
            <div class="col s12 m4">
                <div class="icon-block">
                    <h2 class="center light-blue-text"><i class="material-icons">flash_on</i></h2>
                    <h5 class="center">最快速</h5>

                    <p class="light">
                        采用基于异步I/O和事件驱动的最前沿技术，给每个接入用户不同以往的畅快体验。。
                    </p>
                </div>
            </div>

            <div class="col s12 m4">
                <div class="icon-block">
                    <h2 class="center light-blue-text"><i class="material-icons">group</i></h2>
                    <h5 class="center">最安全</h5>

                    <p class="light">
                        拥有全球顶级的技术社区服务和长期稳定的技术支持，保证用户身份安全、终端/数据安全、传输安全、应用权限安全和审计安全。
                    </p>
                </div>
            </div>

            <div class="col s12 m4">
                <div class="icon-block">
                    <h2 class="center light-blue-text"><i class="material-icons">settings</i></h2>
                    <h5 class="center">最全面</h5>

                    <p class="light">
                        全面支持Windows、MAC、Linux、手机安卓、手机苹果等主流操作系统，同时支持路由器(OpenWRT)使用。管理容易，使用方便。
                    </p>
                </div>
            </div>
        </div>

    </div>
    <br><br>

    <div class="section">

    </div>
</div>
{include file='footer.tpl'}