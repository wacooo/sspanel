{include file='header.tpl'}

<div class="container">
    <br><br>

	<div class="row">
		<div class="col m10 center">
			<h5 style="font-weight: 700;">
				套餐内容：<span style="color:#f60;">{$pdesc}</span>
			</h5>
		</div>
		<br><br><br>
	</div>

	<div class="row">
		<div class="col m10 center">
			<div data-role="qrPayArea" class="qrcode-integration qrcode-area center" id="J_qrPayArea">
		        <div>扫一扫付款（元）</div>
		        <div style="font-size:26px;font-weight:700;color:#f60;">{$price}</div>
		    </div>
		 </div>
    </div>

	<div class="row">
		<div class="col m10 center">
			<img id="responsive-img" style="width:300px;height:300px;" src="/assets/public/img/qr.png">
		</div>
	</div>
	
	<div class="row">
		<div class="col m10 center">
			<div class="center">打开手机支付宝<br>扫一扫继续付款</div>
		</div>
	</div>
	
   <div class="section">
	   <br><br><br><br><br><br>
    </div>
</div>

{include file='footer.tpl'}
