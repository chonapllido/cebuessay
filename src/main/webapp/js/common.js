/**
 * init
 */
$(function(){
	// 디버깅 활성
	gbDebug = true;
	try {
		doDragSort();
		fnCalendar();
	} catch(e) {
	}

	// https
	/*
	if(window.location.protocol == 'https:') {
		location.href = location.href.replace('https:', 'http:');
	}
	*/
});

$(document).ready(function(){
	$('img').each(function(v) {
		if (typeof $(this).attr('onerror') === 'undefined') {
			$(this).attr('onerror', 'this.src=\'' + img_src + '/stm/icon_noimage.png\'');
		}
	});
});

var gbDebug = false;

log = function(v){
	if(gbDebug){
		try {
			console.log(v);
		} catch(err) {
			gbDebug = false;
		}
	}
};

isMobile = function() {
	var tmpUser = navigator.userAgent;

	if (tmpUser.indexOf("iPhone") > 0 || tmpUser.indexOf("iPod") > 0 || tmpUser.indexOf("Android ") > 0 ) {
		return true;
	} else {
		return false;
	}
};

doDelete = function(msg, url, params) {
	if (!confirm(msg)) {
		return;
	}
	
	location.href = url + '?' + jQuery.param(params);
};

doDeleteFrame = function(msg, url, params) {
	if (!confirm(msg)) {
		return;
	}
	
	$('#iframehidden').attr('src', url + '?' + jQuery.param(params));
};

doUpdateList = function(msg, form_id){
	if(!bCheckAll($("#" + form_id))) {
		return;
	}
	if(!confirm(msg)) {
		return;
	}
	
	$("#" + form_id).attr('action', $("#" + form_id).attr('action').replace('deleteList', 'updateList'));
	$("#" + form_id).submit();
};

doUpdateListForAll = function(msg, form_id){
	if(!confirm(msg)) {
		return;
	}
	
	$("#" + form_id).attr('action', $("#" + form_id).attr('action').replace('deleteList', 'updateListForAll'));
	$("#" + form_id).submit();
};

doDeleteList = function(msg, form_id){
	if(!bCheckAll($("#" + form_id))) {
		return;
	}
	
	if(!confirm(msg)) {
		return;
	}
	
	$("#" + form_id).submit();
};

doSelectList = function(form_id){
	if(!bCheckAll($("#" + form_id))) {
		return;
	}
	
	// 해당 함수를 호출하는 창에서 _proc 함수를 추가하여 처리한다
	_proc($("#" + form_id).find('input:checkbox:checked'));
};

doProc = function(src) {
	$('#iframehidden').attr('src', src);
};

/*
 * copy your jsp
doPreSubmit = function (f) {
	log('doPreSubmit');
	return true;
};

doPostSubmit = function (f) {
	log('doPostSubmit');
	return true;
};
*/
doSubmit = function(f, cmd) {

	log('doSubmit');
	try {
		log('doPreSubmit() call');
		if(!doPreSubmit(f))
			return false;
	} catch (e) {
		log('doPreSubmit not found');
	}
	
	if ($(f).find('.tinymce').length > 0) {
		tinymce.triggerSave();
	}

	log('validate' + cmd + '() call');
	if (cmd != null && !eval('validate' + cmd + '(f)')) {
		return false;
	}

	log('doValidation() call');
	if (!doValidation(f)) {
		return false;
	}
	
	try {
		log('doPostSubmit() call');
		if(!doPostSubmit(f))
			return false;
	} catch (e) {
		log('doPostSubmit() not found');
	}
	
	return true;
};

doGo = function(id) {
	if ($('.column-left').css('display') == 'none') {
		return;
	}
	
	var url = $('#headermenu' + id).find('ul:eq(0) > li:eq(0) > a').attr('href');
	var target = $('#headermenu' + id).find('ul:eq(0) > li:eq(0) > a').attr('target');
	if (url.indexOf('javascript') > -1) {
		eval(url.replace('javascript:', ''));
	} else {
		if (target.indexOf('_blank') > -1) {
			window.open(url);
		} else {
			location.href = url;
		}
	}
};

/**
 * open popup
 */
fnPopup = function(url, nm, opt) {
	window.open(url, nm, opt);
};

fnGetCookie = function(nm) {
    var search = nm + "=";
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search);
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length;
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset);
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length;
            return unescape(document.cookie.substring(offset, end));
        }
    }
    return "";
};

fnSetCookie = function(name, value, expires) {
	var todayDate = new Date(); 
	todayDate.setDate(todayDate.getDate() + expires); 
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + todayDate.toGMTString();
};

fnCalendar = function() {
  $('._calendar,._calendarAfter').each(function(){
	 $(this).datepicker({
		dateFormat: 'yy-mm-dd',
		prevText: language == 'ko' ? '이전 달' : 'Prev',
		nextText: language == 'ko' ? '다음 달' : 'Next',
		monthNames: language == 'ko' ? ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] : ['1','2','3','4','5','6','7','8','9','10','11','12'],
		monthNamesShort: language == 'ko' ? ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] : ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: language == 'ko' ? ['일','월','화','수','목','금','토'] : ['Sun', 'Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat'],
		dayNamesShort: language == 'ko' ? ['일','월','화','수','목','금','토'] : ['Sun', 'Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat'],
		dayNamesMin: language == 'ko' ? ['일','월','화','수','목','금','토'] : ['Sun', 'Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat'],
		showMonthAfterYear: true,
		yearSuffix: language == 'ko' ? '년' : '',
		showOn: "button",
		buttonImage: "../../../images/stm/back/ko/ico/ico_calendar.png",
		buttonImageOnly: true,
		minDate: $(this).hasClass('_calendarAfter') ? 0 : new Date(2000, 0, 1),
		regional: language
	  }); 
  });
};

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|ms|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "ms": return d.getMilliseconds().zf(3);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

// SNS 내보내기
sendSns = function(sns, url, txt) {
    var o;
    var _url = encodeURIComponent(url);
    var _txt = encodeURIComponent(txt);
    var _br  = encodeURIComponent('\r\n');
 
    switch(sns)
    {
        case 'facebook':
            o = {
                method:'popup',
                url:'http://www.facebook.com/sharer/sharer.php?u=' + _url
            };
            break;
 
        case 'twitter':
            o = {
                method:'popup',
                url:'http://twitter.com/intent/tweet?text=' + _txt + '&url=' + _url
            };
            break;
 
        case 'me2day':
            o = {
                method:'popup',
                url:'http://me2day.net/posts/new?new_post[body]=' + _txt + _br + _url + '&new_post[tags]=epiloum'
            };
            break;
 
        case 'kakaotalk':
            o = {
                method:'web2app',
                param:'sendurl?msg=' + _txt + '&url=' + _url + '&type=link&apiver=2.0.1&appver=2.0&appid=dev.epiloum.net&appname=' + encodeURIComponent('Epiloum 개발노트'),
                a_store:'itms-apps://itunes.apple.com/app/id362057947?mt=8',
                g_store:'market://details?id=com.kakao.talk',
                a_proto:'kakaolink://',
                g_proto:'scheme=kakaolink;package=com.kakao.talk'
            };
            break;
 
        case 'kakaostory':
            o = {
                method:'web2app',
                param:'posting?post=' + _txt + _br + _url + '&apiver=1.0&appver=2.0&appid=dev.epiloum.net&appname=' + encodeURIComponent('Epiloum 개발노트'),
                a_store:'itms-apps://itunes.apple.com/app/id486244601?mt=8',
                g_store:'market://details?id=com.kakao.story',
                a_proto:'storylink://',
                g_proto:'scheme=kakaolink;package=com.kakao.story'
            };
            break;
 
        case 'band':
            o = {
                method:'web2app',
                param:'create/post?text=' + _txt + _br + _url,
                a_store:'itms-apps://itunes.apple.com/app/id542613198?mt=8',
                g_store:'market://details?id=com.nhn.android.band',
                a_proto:'bandapp://',
                g_proto:'scheme=bandapp;package=com.nhn.android.band'
            };
            break;
 
        default:
            alert('지원하지 않는 SNS입니다.');
            return false;
    }
 
    switch(o.method)
    {
        case 'popup':
            window.open(o.url);
            break;
 
        case 'web2app':
            if(navigator.userAgent.match(/android/i))
            {
                // Android
                setTimeout(function(){ location.href = 'intent://' + o.param + '#Intent;' + o.g_proto + ';end'}, 100);
            }
            else if(navigator.userAgent.match(/(iphone)|(ipod)|(ipad)/i))
            {
                // Apple
                setTimeout(function(){ location.href = o.a_store; }, 200);          
                setTimeout(function(){ location.href = o.a_proto + o.param }, 100);
            }
            else
            {
                alert('이 기능은 모바일에서만 사용할 수 있습니다.');
            }
            break;
    }
}

doPrint = function() {
	window.open(location.href + '&print=Y');
};

formatNumber = function(val) {

    while (/(\d+)(\d{3})/.test(val.toString())){
      val = val.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2');
    }
    return val;
};

goToPage = function(form_id){
	var url = $("#" + form_id).attr('action'),
		idx = 0,
		page_no = $("#" + form_id).find("#page_no").val();
	
	if(page_no == ""){
		alert("Please enter the page number!");
		return false;
	}
	
	url = replaceUrlParam(url, "current_page_no", page_no);

	location.href = url;
};

replaceUrlParam = function(url, paramName, paramValue){
	if(paramValue == null)
        paramValue = '';
	
    var pattern = new RegExp('\\b('+paramName+'=).*?(&|$)');
    
    if(url.search(pattern)>=0){
        return url.replace(pattern,'$1' + paramValue + '$2');
    }
    url = url.replace(/\?$/,'');
    
    return url + (url.indexOf('?')>0 ? '&' : '?') + paramName + '=' + paramValue;
};