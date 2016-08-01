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

<script type="text/javascript">
$(document).ready(function(){
	
	function round(num, digits){
		digits = digits == null ? 1:digits; 
		var coef = Math.pow(10, digits);
		return Math.round(num*coef)/coef;  
	}
	
	$("#amount").change(function() {
		var nv = $(this).val()+"G";
		$("#display-amount").html(nv);
		update();
	});
	
	$("#month").change(function() {
		var nv = $(this).val()+"个月";
		$("#display-month").html(nv);
		update();
	});
	
	function displayPrice(price) {
		var pstr = price.toString();
		$(".price-content span").attr("class","number number-t");
		var count = $(".price-content span").length;
		var plen = pstr.length;
		for (var i=0;i<plen;i++) {
			var v = pstr.charAt(plen - i - 1);
			var addClass = "number-";
			if (v=='.') {
				addClass += "d";
			}else {
				addClass += v;
			}
			$(".price-content span").eq(count-1-i).attr("class", "number " + addClass);
		}
	}
	
	function update(){
		var x = $("#amount").val();
		var y = $("#month").val();
		
		// x<=100 z= (0.2x+8)* f(y)
		// x> =100 z =(0.1x+18) * f(y)
		var z = 0;
		var o = 0;
		var fy = y - Math.floor(y/6);
		if (x <= 100) {
			z = (0.2*x+8) * fy;
			o = (0.2*x+8) * y;
		}else {
			z = (0.1*x+18)*fy;
			o = (0.1*x+18) * y;
		}
		z = round(z).toFixed(1);
		var highp = (0.3*x + 8)*y;
		var discount = round(o - z);		
		$("#discount").text(discount+"元");
		displayPrice(z);
	}
	
	$("#buynow").click(function(){
		{if $user->isLogin}
			var a = $("#amount").val();
			var m = $("#month").val();
			var hash = {};
			hash["amount"] = a;
			hash["month"] = m;
			$.post("/package/add", hash, function(res){
				try {
					res = JSON.parse(res);
					console.log(res.ret + " " + res.msg);
					if (res.ret == 0) {
						alert(res.msg);
					}else {
						window.location = "/user";
					}
				}catch(e) {
					console.log(e.message);
				}
			}
			
			);
		{else}
			window.location = "/auth/login";
		{/if}
	});
	
	update();
});

</script>   

