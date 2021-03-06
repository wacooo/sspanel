{include file='header.tpl'}

<div class="container">
    <br><br>

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
		<div class="col s4 m5"><p/>
			<h5>已优惠<span id="discount" class="red-text">0元</span></h5>
			<h6 class="red-text">满6个月送1个月，满1年送2个月</h6>			
		</div>
		 <div class="col s4 m1">
			<p>
				<!--<a class="waves-effect waves-light btn gray">重置</a>-->
			</p>
		</div> 
		<div class="col s4 m2">
			<p>
				<a id="buynow" class="waves-effect waves-light btn red">立即购买</a>
			</p>
		</div>
	</div>
	
	<div class="row">
	<br><br>

		<div class="col s12 m8">
    			<h5>月流量：<span id="display-amount" class="blue-text">10G</span></h5>
			 	<div class="range-field">
				  <input type="range" id="display-amount-value" min="10" max="1000" value="10" />
				</div>   	
  	    </div>
    </div>

    <div class="row">
     	<div class="col s12 m8">
    			<h5>月数：<span id="display-month" class="blue-text">1个月</span></h5>
			 	<div class="range-field">
				  <input type="range" id="display-month-value" min="1" max="36" value="1" />
				</div>   	
  	    </div>
  	</div>

   <div class="section">
   <br><br><br><br>
    </div>
    
  <form id="pay" hidden="hidden" action="/order/pay" method="post" target="_blank">
    <input name="amount" id="amount" type="text" value="10" size="35"  />
    <input name="month" id="month" type="text" value="10" size="35"  />
   </form>
    
</div>

{include file='footer.tpl'}

<script type="text/javascript">
$(document).ready(function(){
	
	function round(num, digits){
		digits = digits == null ? 1:digits; 
		var coef = Math.pow(10, digits);
		return Math.round(num*coef)/coef;  
	}
	
	$("#display-amount-value").change(function() {
		var nv = $(this).val()+"G";
		$("#display-amount").html(nv);
		update();
	});
	
	$("#display-month-value").change(function() {
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
		var x = $("#display-amount-value").val();
		var y = $("#display-month-value").val();
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
		
		var a = $("#display-amount-value").val();
		var m = $("#display-month-value").val();
		$("#amount").val(a);
		$("#month").val(m);
		$("#pay").submit();
	});
	
	update();
});

</script>   

