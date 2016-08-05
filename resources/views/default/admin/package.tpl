{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
           套餐列表
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>用户id</th>
                                <th>用户名</th>
                                <th>状态</th>
                                <th>月流量</th>
                                <th>起始时间</th>
                                <th>终止时间</th>
                                <th>清零周期</th>
                                <th>下次重置时间</th>
                                <th>操作</th>
                            </tr>
                            {foreach $packages as $package}
                            <tr>
                                <td>{$package->id}</td>
                                <td>{$package->uid}</td>
                                <td>{$package->getUserEmail()}</td>
                                <td>{$package->getStatus()}</td>
                                <td>{$package->getAmount()}</td>
                                <td>{$package->getStartTime()}</td>
                                <td>{$package->getEndTime()}</td>
                                <td>{$package->getResetInterval()}</td>
                                <td>{$package->getNextResetTime()}</td>
                                <td>
                                {if $package->status == 0 }
                                    <a class="btn btn-info btn-sm" href="/admin/package/{$package->id}/enable">启用</a>
                                {/if}
                                    <a class="btn btn-danger btn-sm" href="/admin/package/{$package->id}/delete">删除</a>
                                   
                                </td> 
                            </tr>
                            {/foreach}
                        </table>
                        {{$packages->render()}}
                    </div>
                </div>
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->


<script>
  
</script>

{include file='admin/footer.tpl'}