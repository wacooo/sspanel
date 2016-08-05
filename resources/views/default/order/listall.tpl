{include file='admin/main.tpl'}

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
                                <th>partnerID</th>
                                <th>价格</th>
                                <th>创建时间</th>
                                <th>支付时间</th>
                                <th>状态</th>
                                <th>套餐内容</th>
                                <th>用户</th>
                                <th>套餐</th>
                                <th>状态描述</th>
                            </tr>
                            {foreach $orders as $order}
                            <tr>
                                <td>{$order->orderid}</td>
                                <td>{$order->getParnerPaymentID()}</td>
                                <td>{$order->price}</td>
                                <td>{$order->getCreateTime()}</td>
                                <td>{$order->getPayTime()}</td>
                                <td>{$order->getStatus()}</td>
                                <td>{$order->name}</td>
                                <td>{$order->uid}</td>
                                <td>{$order->pid}</td>
                                <td>{$order->status_desc}</td>
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