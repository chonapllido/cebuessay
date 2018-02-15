$(document).ready(function(){
	
	/*back to top*/ 	
	$('#back-to-top').click(function(){
		$('html, body').animate({scrollTop : 0},800);
		return false;
	});
	
	/*Top Menu*/
	$('.last').on('click',function() {		 
		if($(this).children('.language').is(':visible')){
			$(this).children('.language').hide();
			$('.last').removeClass('arrow-down');
		}else{
			$(this).children('.language').show();
			$('.last').addClass('arrow-down');	
		} 
	});
	
	/*Main Menu*/	
	$('.m-menus >li').on('mouseover', '>a' ,function() {
		if($(this).siblings('ul').size() > 0){
			$(this).siblings('ul').show();
		}
	}).on('mouseleave', function(){
        $(this).children('ul').hide();	   
    });	
	
	/*Log In Form*/
	$('.inner-login-box .form-holder input[type=text], .inner-login-box .form-holder input[type=password]').val(function(i,txt){
		this.defaultValue = txt;
		return txt;
	}).on('focus',function(){
		if (this.defaultValue == this.value) {
			this.value = "";
			
		}
	}).on('blur',function(){
		if ("" == this.value) {
			this.value = this.defaultValue;
		}
	});
	
	/*Left Menu*/	
	$('.left-menu >li').on('mouseover', '>a', function() {
	  $(this).parent().siblings().addBack().removeClass('on');
	}).on('mouseleave', function() {
	  $(this).parent().addClass('on');
	});
	
	$('.has-subs').on('click',function(){
		 $(this).addClass('on-click').siblings('.on-click').removeClass('on-click');
	});
	
	
	/*Footer Family Site*/	
	$('.fm-site-link a').on('click',function() {
		if($(this).parent().next('div').is(':visible')){	
			$('.fmenus').slideUp('slow');
			$(this).parent().css('background','#363636');
			$(this).parent().css({"background": "#181818", "border-color": "#575757"}); 
			$('span').removeClass('minus-sign');  			
		}else{
			$('.fmenus').slideDown('slow');
			$(this).parent().css({"background": "#181818", "border-color": "#131313"}); 
			$('span').addClass('minus-sign');	
		}
	});
});