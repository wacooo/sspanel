{include file='header.tpl'}
{include file='nav.tpl'}

<section class="main-section" id="buy">
	<div class="container">
		<h2>选择套餐</h2>
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="calculator-box">
					<div class="calculator-container" style="">
						<div class="screen-block">
							<div id="J_Screen" class="screen">
							  <div class="left-box">
							    <div class="product-name"><span>套餐价格</span></div>
							  </div>
							  <div class="right-box const-empty">
							    <div class="price-unit">元</div>
							    <div class="price-box"><div class="price-content">
								    <span class="number number-t"></span>  
								    <span class="number number-t"></span>  
								    <span class="number number-t"></span>  
								    <span class="number number-0"></span>  
								    <span class="number number-d"></span>  
								    <span class="number number-0"></span>  
									</div>
							   </div>
							 <div class="const-price-box"></div>
							</div>
							</div>						
						</div>  
					</div>
				</div>
			</div>
			<div class="col-md-6 col-md-offset-3">
    			<div class="buy-text-gray">已优惠 <span id="discount" class="red-text">0元</span></div>
				<br>
			  	<div class="buy-text-gray">请选择您购买的每月流量和月数：</div>
		  	</div>
		  	<div class="input-field col-md-6 col-md-offset-3">
				<form id="payForm" action="/order/pay_tuan" method="post" target="_blank" class="row">
					<br/>
					<div class="col-md-6">
						<select id="amount" name="amount" class="form-control">
					      <option value="100">每月100G</option>
					    </select>
					</div>
					<div class="col-md-6">
						<select id="month" name="month" class="form-control">
						  <option value="12">购买12个月</option>
						</select>
					</div>
					<div class="col-md-12">
						<br/>
						<button type="submit" class="btn btn-danger" type="button">立即购买</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<script type="text/javascript">
$(document).ready(function(){

	$("#month").change(function() {
		update();
	});
	
	$("#amount").change(function() {
		update();
	});

	function round(num, digits){
		digits = digits == null ? 1:digits; 
		var coef = Math.pow(10, digits);
		return Math.round(num*coef)/coef;  
	}
	
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
		var traffics = [16, 51, 101];
		var tprices = [10, 35, 58, 15, 45, 78, 20, 60, 108];
		var prices = [10, 35, 58, 15, 45, 78, 20, 60, 58];
		var mons = [1, 6, 12];
		var r = 0;
		for (r = 0 ; r < traffics.length ; r++) {
			if (traffics[r] > x) {
				break;
			}			
		}
		r = (r == traffics.length? r-1 : r);
		
		var p = 0;
		var ty = y;
		for (var i = 0 ; i < mons.length; i++) {
			var index = mons.length - i - 1;
			if (ty >= mons[index]) {
				p += ty/mons[index] * prices[r*mons.length+index]
				ty = ty % mons[index];
			}
		}
				
		var discount = tprices[r*mons.length] * y - p;		
		$("#discount").text(discount+"元");
		displayPrice(p);
	}	
	update();
});

</script>
{include file='footer.tpl'}