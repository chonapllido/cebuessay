// JavaScript Document

var text="We offer only the best!";
var delay=50;
var currentChar=1;
var destination="[not defined]";
var angle = 0;

$(document).ready(function(){
			
	runAds();
	//runAnimate();
	//runTextAnimation();
	
	$(".top-menu ul li a").click(function(){
		$(".top-menu ul li a").removeClass("on");
		$(this).addClass("on");
	});
	
	$("#english_link, #korean_link1, #korean_link2").click(function(){
		if($(this).attr("id") == "korean_link1"){
			var url = 'http://www.screenr.com/embed/7YVs';
			
			$(".video #video-title1").show();
			$(".video #video-title2").hide();
			$(".video #video-embed iframe").attr("src", url);
			
		} else if( $(this).attr("id") == "korean_link2"){
			var url = 'http://www.screenr.com/embed/CYVs';
			
			$(".video #video-title1").hide();
			$(".video #video-title2").show();
			$(".video #video-embed iframe").attr("src", url);
			
		} else {
			var url = 'http://player.vimeo.com/video/36817379?title=0&amp;byline=0&amp;portrait=0';
			
			$(".video #video-title1").show();
			$(".video #video-title2").hide();
			$(".video #video-embed iframe").attr("src", url);
		}
	});
	
	/** Country Dropdown 
	if($('#country-selector').length > 0 ){
		$('#country-selector').selectToAutocomplete();
	}
	**/
});

function runAnimate(){
	$('.animate-img').animate({'rotate': 10},2000);
	 $('.animate-img').animate({'rotate': -10}, 2000, runAnimate);
}

function runGuaranteeAnimate(){
	$('.imgGuarantee').animate({'rotate': 10},2000);
	$('.imgGuarantee').animate({'rotate': -10}, 2000, runGuaranteeAnimate);
}

function runAds(){
	$(".ads .first").show("fade", {percent:100}, 1000);
	$(".ads .second").delay(800).show("fade", {percent:100}, 1000);
	$(".ads .second").delay(1500).slideUp("fast", function(){$(".ads .first").delay(500).slideUp("fast");});
	
	setTimeout("runAds()", 5000);
}

function type(){
  if (document.getElementById){
	var dest=document.getElementById(destination);
	if (dest){
	  dest.innerHTML=text.substr(0, currentChar);
	  currentChar++
	  if (currentChar>text.length) {
		currentChar=1;
		setTimeout("type()", 5000);
	  } else {
		setTimeout("type()", delay);
	  }
	}
  }
}


function runTextAnimation(){
		
	$(".animation-tit").show("blind", {percent: 100}, 1000);
	$("#animate-txt1").delay(1000).show("slide", { percent: 100}, 1000);
	$("#animate-txt2").delay(1700).show("slide", { percent: 100}, 1000);
	$("#animate-txt3").delay(2400).show("slide", { percent: 100}, 1000);
	
	$("#animate-txt1").delay(4000).hide("clip", { percent: 100}, 1000);
	$("#animate-txt2").delay(4700).hide("clip", { percent: 100}, 1000);
	$("#animate-txt3").delay(5400).hide("clip", { percent: 100}, 1000, function(){
		$(".animation-tit").hide("slide", { percent: 100}, 1000);
	});

	setTimeout("runTextAnimation()", 11000);
}

