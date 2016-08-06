	<footer class="footer">
	    <div class="container">
	        <span class="copyright">京ICP备14029588号-6</span>
	    </div>
	</footer>

	<script type="text/javascript">
		$(function() {
			$('#test').scrollToFixed();
			$('.main-nav li a,#header a').bind('click',function(event){
				var $anchor = $(this);
				
				$('html, body').stop().animate({
						scrollTop: $($anchor.attr('href')).offset().top - 102
					}, 1500,'easeInOutExpo');
				/*
				if you don't want to use the easing effects:
				$('html, body').stop().animate({
					scrollTop: $($anchor.attr('href')).offset().top
				}, 1000);
				*/
				event.preventDefault();
			});
		});
	</script>
</body>
</html>