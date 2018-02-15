
jQuery(function($) {
	_init();
});

_init = function() {
	
	
	
	// select box template maker
	$('.selectbox').unbind("click");
	
	$('.selectbox').on('click','.selected>a',function(e){			
		e.preventDefault();
		//log('.selectbox selected>a');
		$('.selectbox').removeClass('open');
		$(this).closest('.selectbox').toggleClass('open');
	}).on('click','ul>li>a',function(e){
		//log('.selectbox ul>li>a');
		e.preventDefault();
		var $this = $(this),
			$icon = $this.find('img'),
			$selectbox = $this.closest('.selectbox');
		
		$selectbox.toggleClass('open');
		
		if ($icon.length > 0){
			$selectbox.find('.selected a .icon-area').empty().prepend($icon.clone())
		} else {
			$selectbox.find('.selected img').remove();
		}
	});
	
	// close selectbox if click outside.
	var selectbox = '.selectbox';
	$(document).on('click',function(e){
		if (!$(e.target).closest(selectbox).length)
			$(selectbox).removeClass('open');
	});
	
	
	$(':checkbox').change(function(){
		$(this).toggleClass('checked',this.checked);
	}).change();
	
	// tabs...
	var $tabs = '.editor-tabs,.tm-tabs';
	$($tabs).on('click','>.tab-menu a',function(e){
		e.preventDefault();
		$li = $(this).closest('li');
		$li.addClass('on').siblings().removeClass('on');
		$li.closest($tabs).find('.tab-contents .tab-content').eq($li.index()).show().siblings().hide();
	}).find('.tab-menu .on> a').click();
	// color picker
	if ($.fn.colorpicker) {
		$colorpickers = $("button.tm-colorpicker");
		if ($colorpickers.length) {
			select_color_class = 'selected-color';
			$colorpickers.each(function(e){
				var $colorpicker = $(this),
				$input_hidden = $colorpicker.siblings('input.tm-colorpicker'),
				$colorpicker_palette = $('<div class="colorpicker-palette">');
				if ($colorpicker.siblings('div.colorpicker-palette').length > 0) {
					return true;
				}
				default_color = $input_hidden.val();
				$colorpicker.after($colorpicker_palette);
				$colorpicker.click(function(e){
					$colorpickers.not(this).removeClass('open');
					$(this).toggleClass('open');
					return false;
				});
				$colorpicker_palette.colorpicker({
				    //showOn: "button"
					hideButton: true,
					color: default_color
				}).on("change.color", function(e, color){
					$colorpicker.css('color',color);
					$input_hidden.val(color);
				}).on("click", '.evo-palette td', function(e, color){
					e.stopPropagation();
					$('.'+select_color_class).removeClass(select_color_class);
					$(this).addClass(select_color_class);
				}).click(function(e){e.stopPropagation();})
				.find('td').each(function(){
					var $i = $('<i/>'),color;
					$i.css('background-color',default_color).appendTo('body');
					color = $i.css('background-color');
					$i.remove();
					if($(this).css('background-color') == color ) {
						$(this).addClass(select_color_class);
					}
				});
				$colorpicker.css('color',default_color);
				$input_hidden.val(default_color);
			});
			$('body').click(function(){
				$colorpickers.removeClass('open');
			});
		}
	}
};

doPostSubmit = function(f) {
	$('input[name="component_cnts"]').each(function(n){
		$(this).val($(this).closest('li').find('.component_area').children().length);
	});
	$('input[name="item_cnts"]').each(function(n) {
		var cnt = $(this).closest('li').find('ul:eq(0)').children().length;
		$(this).val(cnt < 1 ? 1 : cnt);
	});
	
	return confirm('저장하시겠습니까?');
};

_add = function(o, type) {

	//log(o);
	//log(type);
	
	if (type == '') {
		var _type = $(o).closest('li').find('select[name="component"]');
		//log(_type);
		if (_type.val() == '') {
			_type.focus();
			alert('콤포넌트를 선택하세요');
			return;
		}
		_add(o, _type.val());
		return;
	}
	
	var component = '';
	var component_item = '';
	var content_area = '';
	if (type == 'TITLE') {
		component = $('#component_title').val();
	} else if (type == 'LONGTEXT') {
		component = $('#component_longtext').val();
	} else if (type == 'TABLE') {
		component = $('#component_table').val();
	} else if (type == 'LIST') {
		component = $('#component_list').val();
	} else if (type == 'LISTADD') {
		component_item = $('#component_list_add').val();
	} else if (type == 'LISTADDLOW') {
		component_item = $('#component_list_add').val();
	} else if (type == 'IMAGE') {
		component = $('#component_image').val();
	} else if (type == 'TAB') {
		component = $('#component_tab').val();
	} else if (type == 'TABADD') {
		component_item = $('#component_tab_add').val();
	} else if (type == 'CONTENTAREA') {
		content_area = $('#content_area').val().replace('#n', '#' + ($(o).closest('ul').children().size() + 1));
	} else if (type == 'EDITOR') {
		component = $('#component_editor').val();
	} else if (type == 'SEPARATOR') {
		component = $('#component_separator').val();
	} else if (type == 'HTML') {
		component = $('#component_html').val();
	}
	
	if (content_area != '') {
		$(o).closest('ul').append(content_area.split('&lt').join('<'));
	} else if (component != '') {
		if ($(o).closest('li').find('.component_area').length >= 1) {
			$(o).closest('li').find('.component_area').append(component.split('&lt').join('<'));
		} else {
			$(o).closest('ul').append(component.split('&lt').join('<'));
		}
	} else {
		$(o).closest('ul').append(component_item.split('&lt').join('<'));
	}
	
	// doColorPicker();
	_init();
	doDragSort();

	if (type == 'LONGTEXT'
			|| type == 'TABLE'
			|| type == 'IMAGE'
			|| type == 'EDITOR'
			) {
		var id = mtime; 
		if ($(o).closest('li').find('.component_area').length >= 1) {
			$(o).closest('li').find('.component_area').children().last().find('textarea').attr('id', id);
		} else {
			$(o).closest('ul').children().last().find('textarea').attr('id', id);
		}
		_initEditor(id, type);
	}
	if (type == 'LISTADD' || type == 'LISTADDLOW') {
		var depth = parseInt($(o).closest('li').find('input[name="list_depths"]').val(), 10) + (type == 'LISTADDLOW' ? 1 : 0);
		if (depth >= 3) {
			depth = 3;
		}
		$(o).closest('ul').children().last().find('input[name="list_depths"]').val(depth);
		$(o).closest('ul').children().last().addClass('tm-list-level' + depth);
	}
};

_move = function(o, p) {
	var li = $(o).closest('li');
	
	if (p == 'U') {
		li.insertBefore(li.prev());
	} else {
		li.insertAfter(li.next());
	}

	var editor = li.find('textarea');
	var id = mtime;
	if (editor.length >= 1) {
		editor.each(function(){
			id --;
			log ($(this).closest('li').find('input[name="types"]').val());
			tinymce.get($(this).attr('id')).remove();
			
			$(this).attr('id', id);
			_initEditor($(this).attr('id'), $(this).closest('li').find('input[name="types"]').val());
		});
	}
};

_remove = function(o) {
	var li = $(o).closest('li');
	
	if (li.parent().hasClass('content_area') && $('.content_area').children().length == 1) {
		alert('최소 1개의 콘텐츠 영역이 존재 해야 합니다.');
		return;
	}
	
	li.remove();
};

_setVal = function(obj, nm, val) {
	$(obj).closest('.items').find('input[name="' + nm + '"]').val(val);
};

_initEditor = function(id, type) {

	var toolbar1 = "newdocument | table styleselect formatselect fontselect fontsizeselect";
	var toolbar2 = "forecolor backcolor | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist";
	var toolbar3 = "link unlink image images file media mediafile pdffile | searchreplace code preview";
	var style_formats = [
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
		     			{title: '링크', items: [
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
		     		}];
    if (type == 'IMAGE') {
    	toolbar1 = "newdocument | fontselect styleselect fontsizeselect";
    	toolbar2 = "forecolor backcolor | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify";
    	toolbar3 = "link unlink image images file media mediafile pdffile | searchreplace code preview";
    	style_formats = [{
    			title: '일반', items: [
    			                     {title: '굵게', inline: 'b'},
    			                     {title: '빨간 글자', inline: 'span', styles: {color: '#ff0000'}},
    			                     {title: '빨간색 제목', block: 'h1', styles: {color: '#ff0000'}}
    			                     ]
    		    	}];
    } else if (type == 'TABLE') {
    	toolbar1 = "newdocument | table styleselect fontselect fontsizeselect";
    	toolbar2 = "forecolor backcolor | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | bullist numlist";
    	toolbar3 = "link unlink image images file | searchreplace code preview";
    }

	tinymce.init({
		selector: 'textarea#' + id,
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
                "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
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
        toolbar1: toolbar1,
        toolbar2: toolbar2,
        toolbar3: toolbar3,
        contextmenu: "link unlink image images file media mediafile pdffile inserttable | cell column row  deletetable",
        
        menubar: false, 
        style_formats: style_formats,
		// Theme options
		font_formats: "맑은고딕='Malgun Gothic';굴림=Gulim;굴림체=GulimChe;궁서=Gungsuh;궁서체=GungsuhChe;돋움=Dotum;돋움체=DotumChe;바탕=Batang;바탕체=BatangChe;Arial=Arial;Comic Sans MS='Comic Sans MS';Courier New='Courier New';Tahoma=Tahoma;Times New Roman='Times New Roman';Verdana=Verdana",

		// Example content CSS (should be your site CSS)
		content_css : [css_src + "/stm/korean/webeditor/tinymce.css", css_src + "/stm/korean/webeditor/content.css"],
	});
};