// JavaScript Document

function ClsEssay(){
}

ClsEssay.prototype = {
	
	updateDeadline: function(date){
		var selectbox = document.Form_essay.days;
		var months = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		var days = selectbox.options[selectbox.selectedIndex].value;
		
		var options = {
			url: 'output_days.php?days='+days,
			success: function(data){
				var mind = data;
				selectbox.length = 0;
				var c = 0;
				
				for(var i= mind; i<=30; i++){
					var start = i * 24;
					var opt = new Option(start+' hrs ('+i+' days)', i);
					selectbox.options.add(opt);
					if(days == i) var index = c;
					c++;
				}

				selectbox.selectedIndex = index;
				JSEssay.set_date(date);
				JSEssay.calcTotal();

			}};

		$('#Form_essay').ajaxSubmit(options);		
	},

	calcTotal: function(){
		var f			= document.Form_essay,
			lang		= f.session_lang.value,
			pages		= f.no_pages.value,
			no_days		= f.days.value,
			category 	= f.category.value,
			format 		= f.format.value,
			etcformat 	= f.etcformatcheck,
			hasorder 	= f.hasorder.value,
			def_days 	= parseInt(f.def_days.value),
			price 		= parseInt(f.default_price.value),
			user_price 	= parseInt(f.user_price.value);
		
		if(hasorder == 0){
			pages = pages - 1;
		}
		
		/** Price for Undergraduate (Dissertation or Thesis) **/
		if( (category == "Dissertation (Undergraduate)") || (category == "Thesis (Undergraduate)") ){
			price = 18;
		/** Price for Masteral (Dissertation or Thesis) **/
		} else if( (category == "Dissertation (Masteral)") || (category == "Thesis (Masteral)") ){
			price = 25;
		/** Price for User with Special Price **/
		} else {
			price = this.getPrice(no_days, user_price);
		}
		/*} else {
			var days_add = parseInt(def_days-no_days);
			if( (days_add) > 0)
				price = price + (days_add-1); 	//Since 10 and 9 days have the same price
		}
		*/
		
		if(f.read_material.value == '') var material_price  = 0;
		else var material_price = parseFloat(f.read_material.value);

		var total = price * parseInt(pages);
		
		total = total + material_price;

		/** If business or Law, add $2 **/
		if(category == "Business" || category == "Law"){
			total = total + parseInt(2*pages);
		}

		/** If with citation or with format, add $1 **/
		if(format != "" || etcformat.checked){
			total = total + parseInt(1*pages);	
		}

		document.getElementById("total_text").innerHTML = total + ' $';	

		f.total_payment.value = total;	
		f.price.value = price;
	},

	update_materials: function(){
		var f 		= document.Form_essay,
			lang 	= f.session_lang.value,
		  	no_days	= f.days.value,
		    materials = f.read_material.selectedIndex;
		    f.read_material.value = 0;

		    
		var html = '<select name="read_material" id="read_material" onchange="JSEssay.calcTotal();" class="ipt">';
		
		$.ajax({
			//url: 'output_html.php?action=updatematerials&materials='+materials+'&days='+no_days,
			url: '/front/order/essay/updateMaterialSelect.do',
			type: 'get',
			data: {'days':no_days,'selected':materials},
			success: function(data){
				html = html + data;
				html = html + '</select>';
				id =  document.getElementById('select_materials');
				id.innerHTML = html;
				document.getElementById('read_material').selectedIndex = 0;
			}
		});
	},
	
	set_date: function(date){

		var date_year = date.substring(0, 4);
		var date_month = date.substring(5, 7);
		var date_day = date.substring(8, 10);
		var thisday;
		var days = document.Form_essay.days.value;
		var months = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		var today = new Date();
		
		today.setMonth(date_month - 1);
		today.setDate(date_day);	
		today.setFullYear(date_year);

		var counter = days;
		
		while(counter != 0){
			today.setDate(today.getDate() + 1);
			thisday = today.getDay();

			counter = counter - 1;
		}

		var tmpMonth = today.getMonth() + 1;
		var tmpDay = today.getDate();
		
		if(tmpMonth < 10) {
			tmpMonth = "0" + tmpMonth;
		}

		if(tmpDay < 10)
			tmpDay = "0" + tmpDay;
			
		var tmpDate = today.getFullYear() + '-' + tmpMonth + '-' + tmpDay + ' ' + '00:00:00';
		
		var month = months[today.getMonth()];
		var day = today.getDate();
		var date = month + ' '+day+this.getDateSuffix(day) + ' 7pm (GMT +9 Asian Time)';

		document.getElementById("del_date").innerHTML = date;
		document.Form_essay.deldate.value = date;
		document.Form_essay.end_date.value = tmpDate;
	},

	checkPageByType: function(){
		var form = document.Form_essay;
		var days = form.days.value;
		var pages = form.no_pages.value;
		var minpage = form.no_pages.options[0].value;

		//var url = "price_management_pro.php?action=checkMaxpage&days="+days+"&etype=essay";
		var url = "/front/order/essay/checkMaxPage.do";
		$.ajax({
			url: url,
			type: 'get',
			data: {'days' : days, 'etype':'essay'},
			success: function(data){

				var maxpage = data.substr(0, data.indexOf("&"), data.indexOf("&"));
				var words = data.substr(data.indexOf("=")+1, data.length);
				
				if(maxpage != "" && maxpage != "0"){
					form.no_pages.length = 0;
					for(var i=1; i<=maxpage; i++){
						var strt = i * parseInt(words);
						var opt = new Option(i+' pages ('+strt+' words)', i);
						form.no_pages.options.add(opt);
					}

				} else {
					form.no_pages.length = 0;
					for(var j = 1; j <= 20; j++){
						var start = j * parseInt(words);
						var nopt = new Option(j+' pages ('+start+' words)', j);
						form.no_pages.options.add(nopt);
					}
					form.no_pages.options.add(new Option("40 pages (10000 words)", 40));
				}
					JSEssay.setPageAdmin(pages);
					JSEssay.calcTotal();
			}
		});
	
	},	

	setPageAdmin: function(totalpage){
		var form = document.Form_essay;
		var pages = form.no_pages;
		
		for(var i=0; i<pages.options.length; i++){	
			if(pages.options[i].value == totalpage){
				pages.selectedIndex = i;
			}	
		};
	},

	otherCatOn: function(){
		var category = document.Form_essay.category;
		var cat = document.Form_essay.other_category;

		if(cat.disabled === true){
			cat.disabled = false;
			category.disabled = true;
		} else {
			cat.disabled = true;
			cat.value = '';
			category.disabled = false;
		}
	},

	etcFormatOn: function(){
		var format = document.Form_essay.format;
		var etc = document.Form_essay.etc_format;
		
		if(etc.disabled === true){
			etc.disabled = false;
			format.disabled = true;
		} else {
			etc.disabled = true;
			etc.value = '';
			format.disabled = false;
		}

		this.calcTotal();
	},

	validateForm: function(){

		var f			= document.Form_essay,
		 	lang		= f.session_lang.value,
			category 	= f.category,
			other_cat 	= f.other_category,
			no_pages 	= f.no_pages,
			days 		= f.days,
			bod			= f.in_body,
			price		= f.price,
			material	= f.read_material.selectedIndex,
			level      	= f.level.selectedIndex,
			etcformatcheck = f.etcformatcheck,
			etcformat 	= f.etc_format;

		if( trim(category.value) == '' && trim(other_cat.value) == '' ){

			if(lang == 'KO') alert('카테고리를 정해주세요. 없는 경우 적어주세요!');
			else alert('Please select or enter a category!');
			category.focus();
			return false;
		} 
		
		if(etcformatcheck.checked && etcformat.value == ""){
			alert("Please enter the writing format!");
			etcformat.focus();
			return false;
		}

		if( trim(no_pages.value) == '' ){
			if(lang == 'KO') alert('페이지 수를 적어주세요!');
			else alert('Please select number of pages!');
			no_pages.focus();
			return false;
		}
		
		if( trim(days.value) == ''){
			if(lang == 'KO') alert('마감일을 적어주세요!');
			else alert('Please select the deadline!');
			days.focus();
			return false;
		}
		if( !this.isHalfSize(bod) ){
			alert('Please input only English characters to Body!');
			bod.focus();
			return false;
		}

		if(f.chkplagiarism){
			if( !f.chkplagiarism.checked){
				if(lang == 'KO') alert('환불정책에 동의해주세요.');
				else alert('You have to agree to the REFUND POLICY first!');
				return false;
			}
		}
		this.calcTotal();
		f.materials_text.value = f.read_material.options[f.read_material.selectedIndex].text;		

		return true;
	},

	essayAdminEdit: function(){
		document.Form_essay.action = "essay.php?adminedit=1";
		document.Form_essay.submit();
	},

	download_file: function(){
		browser=getBrowser();
		document.Form_essay.browser.value=browser;
		document.Form_essay.action = "download_files.php";
		document.Form_essay.submit();
	},

	download_file_from_multiple: function(fileedit, filereal){
		browser = new getBrowser();
		document.Form_essay.browser.value=browser;
		document.Form_essay.file_upload.value = fileedit;
		document.Form_essay.file.value = filereal;
		document.Form_essay.action = "download_files.php";
		document.Form_essay.submit();
	},

	check: function(obj){
		alert(isHalfSize(obj));
	},

	updatePriceByCategory: function(date){
		var f 			= document.Form_essay,
		    cat 		= f.category.value,
		    temptotal 	= f.total_payment.value,
		    total 		= parseInt(temptotal),
		    special_categories = new Array("Dissertation (Undergraduate)", "Dissertation (Masteral)", "Thesis (Undergraduate)", "Thesis (Masteral)"),
		    flg 		= f.category_flag.value;
		
		if( special_categories.indexOf(cat) >= 0){
			// If thesis or Dissertation
			if(flg == 1){
				$.ajax({
					url: '/front/order/essay/updateDeadlineSelect.do',
					type: 'get',
					data: {'category' : 2},
					success: function(data){
						id =  document.getElementById('due');
						id.innerHTML = data;
						JSEssay.checkPageByType();
						JSEssay.set_date(date);
						document.getElementById('due').selectedIndex = 0;
					}					
				});	
				f.category_flag.value = 2;
			}
			
		} else {
			if(flg == 2){
				$.ajax({
					url: '/front/order/essay/updateDeadlineSelect.do',
					type: 'get',
					data: {'category' : 1},
					success: function(data){
						id =  document.getElementById('due');
						id.innerHTML = data;
						JSEssay.set_date(date);
						JSEssay.checkPageByType();
					}
				});	
				f.category_flag.value = 1;
			}
		}
		
		this.set_date(date);
		this.calcTotal();
	},

	getDateSuffix: function(day){
		var suffix;

		if(day == 1 || day == 21 || day == 31){
			suffix = "st";
		} else if(day == 2 || day == 22){
			suffix = "nd";
		} else if(day == 3 || day == 23){
			suffix = "rd";
		} else {
			suffix = "th";
		}

		return suffix;
	},
	
	enableSources: function(){
	  if(document.Form_essay.format.value != ""){
		  document.Form_essay.no_sources.disabled = false;
	  } else {
		  document.Form_essay.no_sources.disabled = true;
	  }
	},
	
	getPrice: function(no_days, user_price){
		
		var price = 0;
		
		$.ajax({
			url: '/front/order/essay/calculatePrice.do',
			data: {
					"user_price": user_price,
					"days": no_days
			},
			type: 'get',
			async: false,
			dataType: 'json',
			success: function(data){
				price = data;
			}
		});	

		return price;
	},
	
	isHalfSize: function(obj) {

		  var str = obj.value;
		  
		  if (str=='') {
			return true;
		  }
		  
		  for (var i = 0; i < str.length; i++) {
			var ch  = str.charAt(i);
			var esc = escape(ch);
			
			if ( !(esc.length == 3 && esc.indexOf('%') == 0) && !(esc.length == 1 && esc.indexOf('%') == -1) ) {
				return false;
		  	}
		  }
		  return true;
	}
}



var JSEssay = new ClsEssay();