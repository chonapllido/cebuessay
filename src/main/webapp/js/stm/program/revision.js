// JavaScript Document

function ClsRevision(){
}

ClsRevision.prototype = {
	
	 countWords: function(wordsperpage){
		var f	= document.Form_revision,
			txt 	= f.content.value,
			wrd 	= f.no_words,
			cnt 	= 0,
			str 	= txt.replace(/\s/g,' '),
			str 	= str.split(' ');
		
		for (var i=0; i<str.length; i++) {
			if (str[i].length > 0 && (str[i]!= '\u2014') && (str[i]!= '\u2013' ) )
			cnt++;
		}
	 	
		if( cnt == 0) var pages = 0;
		else if(cnt > 0 && cnt <= wordsperpage ) var pages = 1;
		else var pages = Math.ceil(cnt / wordsperpage);
		
	 	wrd.value = cnt;
		
		this.calcTotal(pages);
	 },
	 
	 calcTotal: function(pages){
		if( pages == undefined || pages == 0 ){
			pages = 0;
		}
		
		var f 		= document.Form_revision,
			lang	= f.session_lang.value,
			no_days	= f.days.value,
			no_page	= f.no_pages, 
			rate	= f.rate.value,
			hasorder= f.hasorder.value,
			arr_prices = rate.split(","),
			arr_rates = new Array();
		
		for(var i=0; i<arr_prices.length; i++){
			var p = arr_prices[i];
			var d = p.substring(0, p.indexOf('-'));
			var pr = p.substring(p.indexOf('-')+1, p.length);
			arr_rates[d] = pr;
		}
		
		var reg = arr_prices[arr_prices.length - 1];
		var reg_rate = reg.substring(0, reg.indexOf('-'));
		
		if(arr_rates[no_days] == undefined) 
			price = arr_rates[reg_rate];
		else 
			price = arr_rates[no_days];
		
		if(hasorder == 0){
				
		}
		
		if(hasorder == 0){
			var tmppage = (pages > 0) ? parseInt(pages)-1 : 0;		
			total = price * parseInt(tmppage);
		} else {
			total = price * parseInt(pages);
		}
		
		no_page.value = pages;
	
		document.getElementById("total_text").innerHTML = total + ' $';	
		f.total_payment.value = total;	
		f.total.value = total;
	 },
	 
	 set_date: function(date){
		
		var f = document.Form_revision,
			date_year = date.substring(0, 4),
			date_month = date.substring(5, 7),
			date_day = date.substring(8, 10);
		var thisday,
			days = document.Form_revision.days.value;
			months = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
			today = new Date();
			
		today.setDate(date_day);
		today.setMonth(date_month - 1);
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
		var date = month + " "+day + this.getDateSuffix(day)+' 7pm (GMT +9 Asian Time)';
		
		document.getElementById("del_date_rev").innerHTML = date;
		f.deldaterev.value = date;
		f.end_date.value = tmpDate;
	
	 },
	
	 validateForm: function(){

		var f 		= document.Form_revision, 
			lang	= f.session_lang.value,
			topic 	= f.topic,
			days  	= f.days,
			content	= f.content,
			total	= f.total_payment,
			price	= f.price,
			hasorder = f.hasorder.value;
		
		if( trim(topic.value) == '' ){
			alert('Please enter the Main Topic!');
			topic.focus();
			return false;
		} else {
			if(!this.isHalfSize(topic)){
				alert('Please input only English characters to Main Topic!');
				topic.focus();
				return false;
			}
		}
		if( trim(days.value) == '' ){
			alert('Please select the Deadline!');
			days.focus();
			return false;
		}
		
		if( trim(content.value) == ''){
			alert('Please supply the content of the file that need to be revised!');
			content.focus();
			return false;
		}
		
		if( (trim(total.value) == '0' || trim(total.value) == '') && hasorder == 1){
			alert('Please click "Count Words" button so that total payment will be computed!');
			total.focus();
			return false;
		}
		
		// set price for paypal
		if( days.value == 3 || days.value == 4 ){
			price.value = 4.5;
		} else {
			price.value = 3;	
		}
		
		return true;
	 },
	 
	 revisionEditAdmin: function(){
			document.form_revision.action = 'revision.php?adminedit=1';
			document.form_revision.submit();
	 },
	 
	 download_file: function(){
			browser=getBrowser();	
			document.form_revision.browser.value=browser;	
			document.form_revision.action = 'download_files.php';
			document.form_revision.submit();
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

var JSRevision = new ClsRevision();
// JavaScript Document