$().ready(function() {
	tinymce.init({
		selector: 'textarea.tinymce',
		// customize button
		setup : function(tinyMCE) {
			tinyMCE.addButton('images', {
				title : language == 'ko' ? '이미지 업로드 '  :  'Upload Image',
				image : js_src + '/stm/webeditor/icon_uploadimage.png',
				onclick : function() {
					tinymceUploadImage(tinyMCE.id);
				}
			});
			tinyMCE.addButton('file', {
				title : language == 'ko' ? '파일 업로드 '  :  'Upload File',
				image : js_src + '/stm/webeditor/icon_uploadfile.png',
				onclick : function() {
					tinymceUploadFile(tinyMCE.id);
				}
			});
			tinyMCE.addButton('mediafile', {
				title : language == 'ko' ? '동영상 업로드 '  :  'Upload Media',
				image : js_src + '/stm/webeditor/icon_uploadmedia.png',
				onclick : function() {
					tinymceUploadMedia(tinyMCE.id);
				}
			});
			tinyMCE.addButton('pdffile', {
				title : language == 'ko' ? 'PDF 업로드 '  :  'Upload PDF',
				image : js_src + '/stm/webeditor/icon_uploadpdf.png',
				onclick : function() {
					tinymceUploadPDF(tinyMCE.id);
				}
			});
		},  
		
		// General options
		language : 'ko_KR',
	    remove_linebreaks : true,
	    apply_source_formatting : false,
	    force_p_newlines : false,
	    force_br_newlines : true,
	    convert_urls : false,
	    width: '100%',
	    height: '400px',
		//theme : "modern",
	    //toolbar_items_size: 'small',
	    /*
	    plugins: [
                "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker image",
                "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                "table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker textpattern"
        ],
        */
        plugins: [
			"advlist autolink autosave link lists charmap print preview hr anchor pagebreak spellchecker image",
			"searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
			"table contextmenu directionality emoticons template textcolor paste textcolor colorpicker textpattern"
		],

        /*
        toolbar1: "newdocument fullpage | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
        toolbar2: "cut copy paste | searchreplace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image media code | insertdatetime preview | forecolor backcolor",
        toolbar3: "table | hr removeformat | subscript superscript | charmap emoticons | print fullscreen | ltr rtl | spellchecker | visualchars visualblocks nonbreaking template pagebreak restoredraft",
        */
		toolbar1: "newdocument | table styleselect formatselect | fontselect fontsizeselect",
		toolbar2: "forecolor backcolor | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist",
		//toolbar3: "link unlink image images file media mediafile pdffile | searchreplace code preview",
		toolbar3: "link unlink image media | searchreplace code preview",
		// contextmenu: "link unlink image images file media mediafile pdffile inserttable | cell column row  deletetable",
		contextmenu: "link unlink image media inserttable | cell column row  deletetable",
		
        menubar: false, 
        style_formats: [
			{title: '일반', items: [
				{title: '굵게', inline: 'b'},
				{title: '빨간 글자', inline: 'span', styles: {color: '#ff0000'}},
				{title: '빨간색 제목', block: 'h1', styles: {color: '#ff0000'}}
			]
			},
			{title: '박스', items: [
			    {title: '박스 스타일 #1', block: 'div', classes: 'content-notice-box'},
			]
			},
			{title: '버튼', items: [
				{title: '버튼 스타일 #1', selector: 'a', classes: 'btn btn-ctedit'},
				{title: '버튼 스타일 #2', selector: 'a', classes: 'btn btn-ctedit btn-green'},
 				{title: '버튼 스타일 #3 (다운로드)', selector: 'a', classes: 'btn btn-ctedit btn-download icon1'},
 				{title: '버튼 스타일 #4 (보기)', selector: 'a', classes: 'btn btn-ctedit btn-download icon2'},
 				{title: '버튼 스타일 #5 (바로가기)', selector: 'a', classes: 'btn btn-ctedit btn-download icon3'}
			]
			},
			{title: '표', items: [
				{title: '표 스타일 #1', selector: 'table', classes: 'ctedit-tbl tbl1'},
				{title: '표 스타일 #2', selector: 'table', classes: 'ctedit-tbl tbl2'},
				{title: '상단 헤더 스타일', selector: 'td', classes: 'header-col'},
				{title: '좌측 헤더 스타일 #1', selector: 'td', classes: 'header-col2'},
				{title: '좌측 헤더 스타일 #2', selector: 'td', classes: 'header-col3'},
				{title: '좌측 헤더 스타일 #3', selector: 'td', classes: 'header-col4'}
			]
		}],
		// Theme options
		font_formats: "맑은고딕='Malgun Gothic';굴림=Gulim;굴림체=GulimChe;궁서=Gungsuh;궁서체=GungsuhChe;돋움=Dotum;돋움체=DotumChe;바탕=Batang;바탕체=BatangChe;Arial=Arial;Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",

		// Example content CSS (should be your site CSS)
		content_css : [css_src + "/stm/korean/webeditor/tinymce.css", css_src + "/stm/korean/webeditor/template.css", css_src + "/stm/korean/webeditor/content.css"],
	});
});

tinymceUploadImage = function(id) {
	window.open(context + '/utl/wed/insertImage.do?id=' + id, 'win_insertimage', 'width=450, height=450, status=no, menubar=no, scrollbars=no');
};

tinymceUploadFile = function(id) {
	window.open(context + '/utl/wed/insertFile.do?id=' + id, 'win_insertfile', 'width=450, height=260, status=no, menubar=no, scrollbars=no');
};

tinymceUploadMedia = function(id) {
	window.open(context + '/utl/wed/insertMedia.do?id=' + id, 'win_insertmedia', 'width=450, height=450, status=no, menubar=no, scrollbars=no');
};

tinymceUploadPDF = function(id) {
	window.open(context + '/utl/wed/insertPDF.do?id=' + id, 'win_insertpdf', 'width=450, height=450, status=no, menubar=no, scrollbars=no');
};