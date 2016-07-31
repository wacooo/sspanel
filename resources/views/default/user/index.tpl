{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            我的信息
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
    
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-user"></i>

                        <h3 class="box-title">我的帐号</h3>
                    </div>
                    <div class="box-body">
                        <dl class="dl-horizontal">
                            <dt>用户名</dt>
                            <dd>{$user->user_name}</dd>
                            <dt>邮箱</dt>
                            <dd>{$user->email}</dd>
                        </dl>

                    </div>
                    <!--
                    <div class="box-footer">
                        <a class="btn btn-danger btn-sm" href="kill">删除我的账户</a>
                    </div>
                    -->
                    <!-- /.box -->
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">公告</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        {$msg}
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        </div>
        
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-exchange"></i>
                        <h3 class="box-title">套餐使用情况</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="width: {$user->trafficUsagePercent()}%">
                                        <span class="sr-only">Transfer</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <dl class="dl-horizontal">
                            <dt>到期时间</dt>
                            <dd>{$package->getEndTime()}</dd>
                            <dt>每月流量</dt>
                            <dd>{$package->getAmount()}</dd>
                            <dt>下次重置</dt>
                            <dd>{$package->nextResetTime()}</dd>
                            <dt>已用流量</dt>
                            <dd>{$user->usedTraffic()}</dd>
                            <dt>剩余流量</dt>
                            <dd>{$user->unusedTraffic()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa  fa-paper-plane"></i>

                        <h3 class="box-title">连接信息</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <dl class="dl-horizontal">
                            <dt>端口</dt>
                            <dd>{$user->port}</dd>
                            <dt>密码</dt>
                            <dd>{$user->passwd}</dd>
                            <dt>自定义加密方式</dt>
                            <dd>{$user->method}</dd>
                            <!--<dt>上次使用</dt>
                            <dd>{$user->lastSsTime()}</dd>
                            -->
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        </div>
        <!-- /.row --><!-- END PROGRESS BARS -->
        
        
        
        <div class="row">
        	<div class="col-md-12">
                <div class="box box-info">
                    <div class="box-header with-border">
                        <i class="fa  fa-paper-plane"></i>
                        <h3 class="box-title">可用地址</h3>
                    </div>
                    <div class="box-body">
                    	
                    	<div class="table-responsive">
			                <table class="table no-margin">
            			      <thead>
                  				<tr>
                    	    		<th>位置</th>
                    	    		<th>服务器地址</th>
                  				</tr>
                  			  </thead>
                  			  <tbody>                  			  
                  			  {foreach $nodes as $node}
                  				<tr>
                    	    	    <td>{$node->name}</td>
                    	    	    <td>{$node->server}</td>
                  				</tr>                  				
                  			  {/foreach}
                  			  </tbody>
                			</table>
              			</div>
                    </div>
                </div>
            </div>
        </div><!-- /.row -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<!--         <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-pencil"></i>
                        <h3 class="box-title">签到获取流量</h3>
                    </div>
                    
                    <div class="box-body">
                        <p> 每{$config['checkinTime']}小时可以签到一次。</p>

                        <p>上次签到时间：<code>{$user->lastCheckInTime()}</code></p>
                        {if $user->isAbleToCheckin() }
                            <p id="checkin-btn">
                                <button id="checkin" class="btn btn-success  btn-flat">签到</button>
                            </p>
                        {else}
                            <p><a class="btn btn-success btn-flat disabled" href="#">不能签到</a></p>
                        {/if}
                        <p id="checkin-msg"></p>
                    </div>                    
                </div>                
            </div>
-->

<script>
    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}