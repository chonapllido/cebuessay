  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48055953-2', 'auto');
  ga('send', 'pageview');
 
/**
 * 클립보드 복사
 */
doCopy = function(v) {
	var result = window.clipboardData.setData('Text', v);
	alert("텍스트가 복사되었습니다. 붙여넣기(Ctrl + V)하면 됩니다.");
};

/**
 * 숫자앞에 0 붙이기
 * @param n
 * @param width
 * @param z
 * @returns
 */
fnPad = function(n, width, z) {
	z = z || '0';
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
};

/**
 * 파일 확장자 체크
 * 
 * @param obj
 * @param type
 * @returns
 */
fnFileType = function(obj, type){
	switch (type){
		case 'image':
			return obj.match(/\.(gif|jpg|jpeg|png)$/i);
		case 'doc':
			return obj.match(/\.(doc|docx|hwp|txt|ppt|pptx|pdf)$/i);
		case 'vod':
			return obj.match(/\.(mp4|mp3|mov|asf|asx|wma|wmv|avi|mpeg|mpg|mkv|rm)$/i);
		default :
			return obj.match(/\.(gif|jpg|jpeg|png|doc|docx|hwp|txt|ppt|pptx|pdf|mp4|mp3|mov|asf|asx|wma|wmv|avi|mpeg|mpg|mkv|rm)$/i);
	}
	return false;
};

/**
 * 파일 확장자 가져오기
 * 
 * @param obj
 * @returns
 */
fnFileExt = function(obj){
	if (obj.match(/\.(gif|jpg|jpeg)$/i)) {
		return 'jpg';
	}
	if (obj.match(/\.(png)$/i)) {
		return 'png';
	}
	if (obj.match(/\.(ppt|pptx)$/i)) {
		return 'ppt';
	}
	if (obj.match(/\.(xls|xlsx)$/i)) {
		return 'xls';
	}
	if (obj.match(/\.(pdf)$/i)) {
		return 'pdf';
	}
	if (obj.match(/\.(doc|docx)$/i)) {
		return 'doc';
	}
	if (obj.match(/\.(hwp)$/i)) {
		return 'hwp';
	}
	if (obj.match(/\.(zip)$/i)) {
		return 'zip';
	}
	
	return 'etc';
};

/**
 * 엑셀 업로드
 */
fnExcel = function() {
	fnPopup(context + '/excel' + url_ext + '?loc=' + location.pathname, 'win_excel', 'width=400px, height=350px, scrollbar=no');
};

/**
 * 주소찾기 팝업
 */
fnZipcode = function() {
	fnPopup(context + '/sym/ccm/zip/EgovCcmZip' + url_ext + '?loc=' + location.pathname, 'win_zipcode', 'width=520px, height=600px, scrollbar=yes');
};

/**
 * 전자정부 파일 업로드
 */
var multi_selector;
function makeFileAttachment(maxFile){
	 var maxFileNum = maxFile;
	 multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum, 0 );
	 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}
function makeFileAttachmentSn(maxFile, id){
	var maxFileNum = maxFile;
	multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum, id );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}

/**
 * 전자정부 파일 다운로드
 * @param atchFileId
 * @param fileSn
 */
function fn_egov_downFile(atchFileId, fileSn){
	window.open(context + '/cmm/fms/FileDown.do?atchFileId=' + atchFileId + "&fileSn=" + fileSn + "&is=Y");
}

/**
 * 전자정부 파일 삭제
 * 
 * @param atchFileId
 * @param fileSn
 */
function fn_egov_deleteFile(atchFileId, fileSn) {

	if(!confirm(language == 'ko' ? '삭제하시겠습니까?' : 'Delete?')) {
		return;
	}
	$('#iframehidden').attr('src', context + '/cmm/fms/deleteFileInfs.do?atchFileId=' + atchFileId + '&fileSn=' + fileSn);

}
function fn_egov_deleteFileSn(atchFileId, fileSn, fn_page_reload) {
	fn_egov_deleteFile(atchFileId, fileSn);
	setTimeout(function(){
		location.reload();
	}, 2000);
}

fnSearchWin = function(act) {
	fnPopup(context + act, 'search_win', 'width=800px, height=650px, scrollbars=yes');
};

fnGetImage = function(o, atch_file_id, file_sn) {
	setTimeout(function() {
		$(o).closest('span').html('<img src="' + context + '/cmm/fms/getImage.do?atchFileId=' + atch_file_id + '&fileSn=' + file_sn + '&thumbYn=Y" alt="" onerror="' + img_src + '/stm/thumb/file.jpg" style="max-width:116px; max-height:116px;" />');
	}, 1000);
};

popupClose = function(){ 
	fnSetCookie("popups", "1" , 1); 
	$('.popup-toggle-open').click();
};

/**
 * 영문 찾아오시는길 구글맵
 */
var map;
function mapInit() {
	if ($('#map-canvas').length <= 0) {
		return;
	}
	
	var myLatlng = new google.maps.LatLng(37.5910606,127.0337967);
	var mapOptions = {
		zoom : 18,
		center : myLatlng,
	    panControl: false,
	    zoomControl: true,
	    scaleControl: true
	}
	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	var marker = new google.maps.Marker({
		position : myLatlng,
		map : map,
		title : 'ARI'
	});
}

function doValidDoamin(str) {

	var pattern = new RegExp('^(https?:\\/\\/)?' + // 프로토콜
	'((([a-z\d](([a-z\d-]*[a-z\d])|([ㄱ-힣]))*)\.)+[a-z]{2,}|' + // 도메인명 <-이부분만  수정됨
	'((\\d{1,3}\\.){3}\\d{1,3}))' + // 아이피
	'(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // 포트번호
	'(\\?[;&a-z\\d%_.~+=-]*)?' + // 쿼리스트링
	'(\\#[-a-z\\d_]*)?$', 'i'); // 해쉬테그들

	if (!pattern.test(str)) {
		return false;
	} else {
		return true;
	}

}

/*google.maps.event.addDomListener(window, 'load', mapInit);*/