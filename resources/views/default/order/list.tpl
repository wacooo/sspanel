{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
           订单列表
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
                                <th>价格</th>
                                <th>创建时间</th>
                                <th>支付时间</th>
                                <th>状态</th>
                                <th>套餐内容</th>
                                <th>操作</th>
                            </tr>
                            {foreach $orders as $order}
                            <tr>
                                <td>{$order->orderid}</td>
                                <td>{$order->price}</td>
                                <td>{$order->getCreateTime()}</td>
                                <td>{$order->getPayTime()}</td>
                                <td>{$order->getStatus()}</td>
                                <td>{$order->name}</td>
                                <td>
                                {if $order->status == 0 }
                                    <a class="btn btn-info btn-sm" href="/order/payorder?orderid={$order->orderid}" target="_blank">支付</a>
                                {/if}
                                </td> 
                            </tr>
                            {/foreach}
                        </table>
                        {$orders->render()}
                    </div>
                </div>
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->


<script>
  
</script>

{include file='admin/footer.tpl'}