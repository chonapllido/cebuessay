/*
Author: Robert Hashemian
http://www.hashemian.com/
*/
	CountStepper = -1;
	var SetTimeOutPeriod;
	
	function startTimer(targetDate, nowDate){
	
		alert(nowDate);
		CountActive = true;
		LeadingZero = true;
		DisplayFormat = "%%H%%:%%M%%:%%S%%";
		FinishMessage = "Order is cancelled!";	
		TargetDate = targetDate;
		CountStepper = Math.ceil(CountStepper);
		
		if (this.CountStepper == 0)
			CountActive = false;
		SetTimeOutPeriod = (Math.abs(CountStepper)-1)*1000 + 990;
		
		var dnow = new Date();
		dnow.setFullYear(parseInt(nowDate.substr(0, 4)));
		dnow.setMonth(parseInt(nowDate.substr(5, 2)-1));
		dnow.setDate(parseInt(nowDate.substr(8, 2)));
		dnow.setHours(parseInt(nowDate.substr(11, 2)));
		dnow.setMinutes(parseInt(nowDate.substr(14, 2)));
		dnow.setSeconds(parseInt(nowDate.substr(17, 2)));
		alert("hours: "+parseInt(nowDate.substr(11, 2)));
		alert("minutes: "+parseInt(nowDate.substr(14, 2)));
		alert("seconds: "+parseInt(nowDate.substr(17, 2)));
		putspan();
		var dthen = new Date(TargetDate);
		
		if(this.CountStepper>0)
			ddiff = new Date(dnow-dthen);
		else
			ddiff = new Date(dthen-dnow);
		gsecs = Math.floor(ddiff.valueOf()/1000);
		
		this.CountBack(gsecs);
	}
	
	function calcage(secs, num1, num2) {
	  	s = ((Math.floor(secs/num1))%num2).toString();
	 	if (LeadingZero && s.length < 2)
			s = "0" + s;
	  	return "<b>" + s + "</b>";
	}
	
	function CountBack(secs) {
	  	if (secs < 0) {
			document.getElementById("cntdwn").innerHTML = FinishMessage;
			document.getElementById("btnpaypal").style.display = "none";
			return;
	  	}
	  	DisplayStr = DisplayFormat.replace(/%%D%%/g, calcage(secs,86400,100000));
	  	DisplayStr = DisplayStr.replace(/%%H%%/g, calcage(secs,3600,24));
	  	DisplayStr = DisplayStr.replace(/%%M%%/g, calcage(secs,60,60));
	  	DisplayStr = DisplayStr.replace(/%%S%%/g, calcage(secs,1,60));
	
	  	document.getElementById("cntdwn").innerHTML = DisplayStr;
	  	if (CountActive)
			setTimeout("CountBack(" + (secs+this.CountStepper) + ")", this.SetTimeOutPeriod);
	}
	
	function putspan(backcolor, forecolor) {
	 	document.write("<span id='cntdwn' style='color:red;'></span>");
	
	}
// JavaScript Document