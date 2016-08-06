{include file='header.tpl'}
{include file='nav.tpl'}

<div class="container">
    <br><br>
    <div class="section">

        <!--   Icon Section   -->
        <div class="row">
            <div class="col s12 m4">
                <h5><i class="fa fa-windows fa-3x"></i> &nbsp; Windows</h5>
                <p><strong>客户端</strong></p>
                <ul>
                    <li>shadowsocks-win:
                        <ul>
                            <li>Windows 7以上系统: <a href="https://github.com/shadowsocks/shadowsocks-csharp/releases/download/2.5.6/Shadowsocks-win-2.5.6.zip">2.5.6.zip</a></li>
                        </ul>
                    </li>
                    <li>Shadowsocks-Qt5:
                        <ul>
                            <li><a href="https://github.com/shadowsocks/shadowsocks-qt5/releases">最新版</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="col s12 m4">
                <h5><i class="fa fa-apple fa-3x"></i> &nbsp; Mac OS X</h5><p><strong>客户端</strong></p><ul><li>ShadowsocksX: <a href="https://github.com/shadowsocks/shadowsocks-iOS/releases/download/2.6.3/ShadowsocksX-2.6.3.dmg">2.6.3.dmg</a></li><li>GoAgentX: <a href="https://goagentx.googlecode.com/files/GoAgentX-v2.2.9.dmg">v2.2.9.dmg</a></li></ul><p><strong>命令行客户端</strong></p><ul><li><code>brew install shadowsocks-libev</code></li></ul>
            </div>

            <div class="col s12 m4">
                <h5><i class="fa fa-linux fa-3x"></i> &nbsp; Linux</h5><p><strong>客户端</strong></p><ul><li>Shadowsocks-Qt5:<ul><li><a href="https://github.com/shadowsocks/shadowsocks-qt5/wiki/Installation">最新版</a></li></ul></li></ul><p><strong>命令行客户端</strong></p><ul><li>shadowsocks-python:<ul><li><code>pip install shadowsocks</code></li></ul></li></ul>
            </div>

            <div class="col s12 m4">
                <h5><i class="fa fa-android fa-3x"></i> &nbsp; Android</h5>
                <ul>
                    <li>shadowsocks-android:
                        <ul>
                            <li><a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks">谷歌市场</a> (<a href="https://play.google.com/apps/testing/com.github.shadowsocks">beta</a>)</li>
                        </ul>
                    </li>
                </ul>
            </div>

            <div class="col s12 m4">
                <h5><i class="fa fa-apple fa-3x"></i> &nbsp; iOS</h5><ul><li>Potatso:<ul><li><a href="https://itunes.apple.com/app/apple-store/id1070901416?pt=2305194&ct=shadowsocks.org&mt=8">App Store</a></li></ul></li><li>MobileShadowSocks:<ul><li><a href="http://apt.thebigboss.org/onepackage.php?bundleid=com.linusyang.shadowsocks">Big Boss（需越狱）</a></li></ul></li></ul>
            </div>

            <div class="col s12 m4">
                <h5><i class="fa fa-rss fa-flip-horizontal fa-3x"></i> &nbsp; OpenWRT</h5><ul><li>shadowsocks-libev</li><ul><li><code>opkg install shadowsocks-libev</code></li></ul><li>shadowsocks-libev-polarssl</li><ul><li><code>opkg install shadowsocks-libev-polarssl</code></li></ul></ul>
            </div>
        </div>

    </div>
    <br><br>

    <div class="section">
    </div>
</div>
{include file='footer.tpl'}