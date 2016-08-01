<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>{$config["appName"]}</title>

    <!-- Bootstrap Core CSS -->
    <link href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <link href="/assets/public/css/home.min.css" rel="stylesheet" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top">

    <nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> 菜单 <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">长颈兔</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a class="page-scroll" href="#">首页</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/buy">购买</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/download">客户端下载</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/auth/login">登录</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/auth/register">注册</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <header>
        <div class="header-content">
            <div class="header-content-inner">
                <h1 id="homeHeading">长颈兔VPN, 最划算的VPN</h1>
                <hr>
                <p>同时支持Shadowsocks,PPTP和IPSec VPN。 美国/日本/新加坡/台湾/香港/韩国精品服务线路。 手机电脑全平台支持,不限流量,同时5终端,仅需100元/年。</p>
                <a href="#about" class="btn btn-primary btn-xl page-scroll">申请试用</a>
            </div>
        </div>
    </header>

    <section class="bg-primary" id="about">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 text-center">
                    <h2 class="section-heading">免费测试，7天退款</h2>
                    <hr class="light">
                    <p class="text-faded">我们提供3天1G的免费测试期，测试满意后再考虑购买。 购买后我们仍然可在7天内申请退款，唯一的要求是流量不超过10G</p>
                    <a href="#services" class="page-scroll btn btn-default btn-xl sr-button">立即注册!</a>
                </div>
            </div>
        </div>
    </section>

    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">轻松科学上网 保护个人隐私</h2>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 text-center">
                    <div class="service-box">
                        <i class="fa fa-4x fa-diamond text-primary sr-icons"></i>
                        <h3>最快速</h3>
                        <p class="text-muted">采用基于异步I/O和事件驱动的最前沿技术，给每个接入用户不同以往的畅快体验。</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 text-center">
                    <div class="service-box">
                        <i class="fa fa-4x fa-paper-plane text-primary sr-icons"></i>
                        <h3>最安全</h3>
                        <p class="text-muted">拥有全球顶级的技术社区服务和长期稳定的技术支持，保证用户身份安全、终端/数据安全、传输安全、应用权限安全和审计安全。</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 text-center">
                    <div class="service-box">
                        <i class="fa fa-4x fa-newspaper-o text-primary sr-icons"></i>
                        <h3>最全面</h3>
                        <p class="text-muted">全面支持Windows、MAC、Linux、手机安卓、手机苹果等主流操作系统，同时支持路由器(OpenWRT)使用。管理容易，使用方便。</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 text-center">
                    <div class="service-box">
                        <i class="fa fa-4x fa-heart text-primary sr-icons"></i>
                        <h3>最全面</h3>
                        <p class="text-muted">全面支持Windows、MAC、Linux、手机安卓、手机苹果等主流操作系统，同时支持路由器(OpenWRT)使用。管理容易，使用方便。</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <aside class="bg-dark">
        <div class="container text-center">
            <div class="call-to-action">
                <h2>如何试用</h2>
                <p>请发邮件至holliability@gmail.com申请免费试用
12小时内回复试用帐号信息
试用时间3天，流量限制1G
本服务仅供科学研究和资料查询,禁止下载盗版视频
禁止一切违反中国法律的用途</p>
            </div>
        </div>
    </aside>

    <section id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 text-center">
                    <h2 class="section-heading">联系购买</h2>
                    <hr class="primary">
                    <p>如果试用满意需要购买,请支付宝或者Paypal转账至xxx@gmail.com。 付款完成后将交易号邮件发送过来，我们将在收到款项后尽快发送开通邮件至您的邮箱。 工作时间一般半小时，晚上和周末稍微长一点</p>
                </div>
                <div class="col-lg-4 col-lg-offset-2 text-center">
                    <i class="fa fa-phone fa-3x sr-contact"></i>
                    <p>123-456-6789</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fa fa-envelope-o fa-3x sr-contact"></i>
                    <p><a href="mailto:your-email@your-domain.com">123@456.com</a></p>
                </div>
            </div>
        </div>
    </section>

    <script src="http://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        (function($) {
    "use strict"; // Start of use strict

    // jQuery for page scrolling feature - requires jQuery Easing plugin
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: ($($anchor.attr('href')).offset().top - 50)
        }, 1250, 'easeInOutExpo');
        event.preventDefault();
    });

    // Highlight the top nav as scrolling occurs
    $('body').scrollspy({
        target: '.navbar-fixed-top',
        offset: 51
    });

    // Closes the Responsive Menu on Menu Item Click
    $('.navbar-collapse ul li a:not(.dropdown-toggle)').click(function() {
        $('.navbar-toggle:visible').click();
    });

    // Offset for Main Navigation
    $('#mainNav').affix({
        offset: {
            top: 100
        }
    })

    // Initialize and Configure Scroll Reveal Animation
    window.sr = ScrollReveal();
    sr.reveal('.sr-icons', {
        duration: 600,
        scale: 0.3,
        distance: '0px'
    }, 200);
    sr.reveal('.sr-button', {
        duration: 1000,
        delay: 200
    });
    sr.reveal('.sr-contact', {
        duration: 600,
        scale: 0.3,
        distance: '0px'
    }, 300);

})(jQuery); // End of use strict

    </script>

</body>

</html>