{include file='header.tpl'}

<section class="main-section" id="buy">
<div class="container">
	<h2>选择套餐</h2>
	<div class="section">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="calculator-box" style="display: block;">
					<div class="calculator-container" style="">
						<div class="screen-block">
							<div id="J_Screen" class="screen">
								<div class="left-box">
									<div class="product-name">
										<span>套餐价格</span>
									</div>
								</div>
								<div class="right-box const-empty">
									<div class="price-unit">元</div>
									<div class="price-box">
										<div class="price-content">
											 <span class="number number-0"></span> <span
												class="number number-d"></span> <span
												class="number number-0"></span>
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

		<div class="col-md-6 col-md-offset-3">
			<div class="buy-text-gray">
				已优惠 <span id="discount" class="red-text">0元</span>
			</div>
			<div class="red-text">您选择的套餐每月有{$amount}G流量</div>
			<br>
			<div class="buy-text-gray">请选择您购买的月数：</div>
		</div>
		<div class="input-field col-md-6 col-md-offset-3">
			<div class="input-field col s12">
				<form id="renewForm" action="/order/pay_renew" method="post" target="_blank" class="row">
					<br>
					<div class="col-md-6">
						<select class="form-control" disabled="disabled">
					      <option>每月{$amount}G</option>
					    </select>
					</div>
					<input hidden="hidden" name="amount" value="{$amount}" />
					<div class="col-md-6">
						<select id="month" name="month" class="form-control">
							<option value="1" selected>购买1个月</option>
							<option value="3">购买3个月</option>
							<option value="6">购买6个月</option>
							<option value="12">购买12个月</option>
						</select>
					</div>
					<div class="col-md-12">
						<br/>
						<button id="buynow" class="btn btn-danger" type="button">立即购买</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="section">
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
</div>
</section>

{include file='footer.tpl'}

<script type="text/javascript">
	$(document).ready(
			function() {

				$("#month").change(function() {
					update();
				});

				function round(num, digits) {
					digits = digits == null ? 1 : digits;
					var coef = Math.pow(10, digits);
					return Math.round(num * coef) / coef;
				}

				function displayPrice(price) {
					var pstr = price.toString();
					$(".price-content span").attr("class", "number number-t");
					var count = $(".price-content span").length;
					var plen = pstr.length;
					for (var i = 0; i < plen; i++) {
						var v = pstr.charAt(plen - i - 1);
						var addClass = "number-";
						if (v == '.') {
							addClass += "d";
						} else {
							addClass += v;
						}
						$(".price-content span").eq(count - 1 - i).attr(
								"class", "number " + addClass);
					}
				}

				function update() {
					var x = $("#amount").val();
					var y = $("#month").val();
					var traffics = [ 16, 51, 101 ];
					var prices = [ 10, 35, 58, 15, 45, 78, 20, 60, 108 ];
					var mons = [ 1, 6, 12 ];
					var r = 0;
					for (r = 0; r < traffics.length; r++) {
						if (traffics[r] > x) {
							break;
						}
					}
					r = (r == traffics.length ? r - 1 : r);

					var p = 0;
					var ty = y;
					for (var i = 0; i < mons.length; i++) {
						var index = mons.length - i - 1;
						if (ty >= mons[index]) {
							p += ty / mons[index]
									* prices[r * mons.length + index]
							ty = ty % mons[index];
						}
					}

					var discount = prices[r * mons.length] * y - p;
					$("#discount").text(discount + "元");
					displayPrice(p);
				}

				$("#buynow").click(function() {
					$("#renewForm").submit();
				});

				update();
			});
</script>