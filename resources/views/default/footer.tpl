	<footer class="footer">
	    <div class="container">
	        <span class="copyright">京ICP备14029588号-6</span>
	    </div>
	</footer>

	<script src="http://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/assets/public/js/jquery-scrolltofixed.js"></script>
	<script src="http://cdn.bootcss.com/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script src="http://cdn.bootcss.com/jquery.isotope/1.5.25/jquery.isotope.min.js"></script>
	<script src="http://cdn.bootcss.com/wow/1.1.2/wow.min.js"></script>
	<script src="http://cdn.bootcss.com/classie/1.0.1/classie.min.js"></script>
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