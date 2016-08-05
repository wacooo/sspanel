{include file='header.tpl'}

<div class="container">
    <br><br>

	<div class="section">
	
	<div class="row">
	  <div class="col m8">
		<div class="calculator-box" style="display: block;"><div class="calculator-container" style="">
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
	</div>	
	
		<div class="row">
			<h5>已优惠 <span id="discount" class="red-text">0元</span></h5>
			<h6 class="red-text">购满6个月或1年将有优惠</h6>
			<br>
		  	<h5>请选择您的购买的月数：</h5>
		</div>
		<div class="row">
		<div class="input-field col s12">
		  <form id="renewForm" action="/order/renew" class="col s7 m7" method="post" target="_blank">
		    <select id="month" name="month">
		      <option value="1" selected>续约1个月</option>
		      <option value="3">续约3个月</option>
		      <option value="6">续约6个月</option>
		      <option value="12">续约12个月</option>
		    </select>
		    <input id="amount" name="amount" hidden="hidden" value={$amount} />
		  </form>
		  </div>
		</div>
		</div>
		
		<div class="row">
			<div class="col s4 m2">
				<p>
					<a id="buynow" class="waves-effect waves-light btn red">立即购买</a>
				</p>
			</div> 		
		</div>
	</div>
   <div class="section">
	   <br><br><br><br><br><br>
    </div>
</div>

{include file='footer.tpl'}

<script type="text/javascript">
$(document).ready(function(){

	$("#month").change(function() {
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
		var prices = [10, 35, 58, 15, 45, 78, 20, 60, 108];
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
				
		var discount = prices[r*mons.length] * y - p;		
		$("#discount").text(discount+"元");
		displayPrice(p);
	}
	
	$("#buynow").click(function(){
		$("#renewForm").submit();
	});
	
	update();
});

</script>