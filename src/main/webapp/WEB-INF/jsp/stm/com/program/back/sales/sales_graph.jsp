<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="stm.com.program.sales.service.SalesService" %>
<%@ page import="stm.com.program.sales.web.SalesCommand" %>
<%@ page import="stm.com.program.order.essay.service.OrderEssayService" %>
<%@ page import="stm.com.program.order.essay.web.OrderEssayCommand" %>
<%@ page import="stm.com.support.util.ApplicationHelper" %>

<script type="text/javascript" src="${js_src }/stm/back/highcharts.js"></script>
<script type="text/javascript" src="${js_src }/stm/back/exporting.js"></script>
<%

	Calendar now = Calendar.getInstance();
	int thisyear = now.get(Calendar.YEAR);
	
	ArrayList<HashMap<String, String>> arr_sales = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_cash = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_sales_vm = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_saleperpage = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_list = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_pagelist = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_yearly_sales = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_yearly_cash = new ArrayList<HashMap<String,String>>();
	ArrayList<HashMap<String, String>> arr_yearly_vm = new ArrayList<HashMap<String,String>>();

	SalesService service = (SalesService) ApplicationHelper.getService("salesService", request.getSession().getServletContext());
	String email = request.getAttribute("user_email").toString();
	
	int startYear = 2008; //start of sales;
	for(int str=0,yr=startYear; yr <= thisyear; str++,yr++){
		HashMap<String, String> sales = new HashMap<String, String>();
		sales.put("year", yr+"");
		sales.put("amounts", "");
		
		HashMap<String, String> cash = new HashMap<String, String>();
		cash.put("year", yr+"");
		cash.put("amounts", "");

		HashMap<String, String> sales_vm = new HashMap<String, String>();
		sales_vm.put("year", yr+"");
		sales_vm.put("amounts", "");
		
		HashMap<String, String> saleperpage = new HashMap<String, String>();
		saleperpage.put("year", yr+"");
		saleperpage.put("amounts", "");
		
		HashMap<String, String> list = new HashMap<String, String>();
		list.put("year", yr+"");
		list.put("total", "");
		
		HashMap<String, String> pagelist = new HashMap<String, String>();
		pagelist.put("year", yr+"");
		pagelist.put("total", "");

		arr_sales.add(sales);
		arr_cash.add(cash);
		arr_sales_vm.add(sales_vm);
		arr_saleperpage.add(saleperpage);
		arr_list.add(list);
		arr_pagelist.add(pagelist);
	}
	
	String m;
	for(int i = 1; i <= 12; i++){
		switch(i){
			case 12:	
				m = ""+1;
				break;
			case 11:
				m = ""+(i+1);
				break;
			default:
				m = "0"+(i+1);
		}	
		
		String month = (i <10) ? "0"+i : ""+i;
		String saleInMonth;
		String saleInMonthCash;
		String saleInMonthVm;
		int pagesInMonth;
		
		for(int j=0; j<arr_sales.size(); j++){
			HashMap<String, String> mysales = (HashMap<String, String>) arr_sales.get(j);
			HashMap<String, String> mycash = (HashMap<String, String>) arr_cash.get(j);
			HashMap<String, String> mysales_vm = (HashMap<String, String>) arr_sales_vm.get(j);
			HashMap<String, String> mysaleperpage = (HashMap<String, String>) arr_saleperpage.get(j);
			String aveTotalPerPage = "0";
			
			String year = mysales.get("year");
			String arr_sales_amount = mysales.get("amounts");
			String arr_cash_amount = mycash.get("amounts");
			String arr_sales_vm_amount = mysales_vm.get("amounts");
			String arr_saleperpage_amount = mysaleperpage.get("amounts");
			
			SalesCommand cmd = new SalesCommand();
			String mydate = year+"-"+month; 
			cmd.setDate(mydate);
			cmd.setUser_email(email);
			cmd.setSearch_field("email");
			cmd.setSearch_keyword(email);
			saleInMonth = service.getTotalOrderAmount(cmd, request, response)+"";
			cmd.setRefunded("0");
			saleInMonthCash = service.getTotalMonthly(cmd, request, response)+""; // total sales minus the virtual money
			cmd.setRefunded("1");
			saleInMonthVm = service.getTotalMonthly(cmd, request, response)+"";  //total virtual money per month
			pagesInMonth = service.getTotalPagesByMonth(cmd, request, response);
			if(!saleInMonth.equals("0.0")){
				aveTotalPerPage = (Float.parseFloat(saleInMonth)/pagesInMonth)+"";
			}

			if(i != 12){
				saleInMonth = saleInMonth + ",";
				saleInMonthCash = saleInMonthCash + ",";
				saleInMonthVm = saleInMonthVm + ",";
				aveTotalPerPage = aveTotalPerPage + ",";
			}
			arr_sales_amount += saleInMonth;
			arr_cash_amount += saleInMonthCash;
			arr_sales_vm_amount += saleInMonthVm;
			arr_saleperpage_amount += aveTotalPerPage;

			mysales.put("amounts", arr_sales_amount+"");
			mycash.put("amounts", arr_cash_amount+"");
			mysales_vm.put("amounts", arr_sales_vm_amount+"");
			mysaleperpage.put("amounts", arr_saleperpage_amount+"");
		}
	}

	int sum_pagelist = 0;
	int sum_list = 0;
	String totalOrderByPage;
	String totalOrderByDeadline;
	
	for(int k = 1; k <= 20; k++){
	
		for(int j=0; j<arr_pagelist.size(); j++){
			HashMap<String,String> pagelist = arr_pagelist.get(j);
			HashMap<String,String> list = arr_list.get(j);
			
			String year = pagelist.get("year");
			String mytotal = pagelist.get("total");
			String listtotal = list.get("total");
			
			SalesCommand sales_cmd = new SalesCommand();
			sales_cmd.setDate(year);
			sales_cmd.setUser_email(email);
			sales_cmd.setSearch_field("email");
			sales_cmd.setSearch_keyword(email);
			sales_cmd.setNo_pages(k+"");
			totalOrderByPage = service.getTotalOrderByPages(sales_cmd, request, response)+"";
			sales_cmd.setDays(k+"");
			totalOrderByDeadline = service.getTotalOrderByDeadline(sales_cmd, request, response)+"";
			
			sum_pagelist = sum_pagelist + Integer.parseInt(totalOrderByPage);
			sum_list = sum_list + Integer.parseInt(totalOrderByDeadline);
			
			if(k != 20){
				totalOrderByPage = totalOrderByPage + ",";
				totalOrderByDeadline = totalOrderByDeadline + ",";
			}
			mytotal += totalOrderByPage;
			listtotal += totalOrderByDeadline;
			
			pagelist.put("total", mytotal);
			list.put("total", listtotal);
			
		}
	}
	
	for(int l=0; l<arr_sales.size(); l++){
		HashMap<String, String> mysale = arr_sales.get(l);
		String year = mysale.get("year");
		
		SalesCommand new_cmd = new SalesCommand();
		new_cmd.setDate(year);
		new_cmd.setUser_email(email);
		
		HashMap<String,String> yearly_sales = new HashMap<String,String>();
		yearly_sales.put("year", year+"");
		yearly_sales.put("amount", service.getTotalOrderAmountByYear(new_cmd, request, response)+"");
		
		HashMap<String,String> yearly_cash = new HashMap<String,String>();
		yearly_cash.put("year", year+"");
		yearly_cash.put("amount", service.getTotalCashByYear(new_cmd, request, response)+"");
		
		HashMap<String,String> yearly_vm = new HashMap<String,String>();
		yearly_vm.put("year", year+"");
		yearly_vm.put("amount", service.getTotalVmByYear(new_cmd, request, response)+"");
		
		arr_yearly_sales.add(yearly_sales);
		arr_yearly_cash.add(yearly_cash);
		arr_yearly_vm.add(yearly_vm);
		
	}
	OrderEssayCommand essay_cmd = new OrderEssayCommand();
	essay_cmd.setUser_id(email);
	OrderEssayService essay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService",request.getSession().getServletContext());
	OrderEssayCommand cat_cmd = essay_service.getTotalOrderByCategory(essay_cmd, request, response);
	List cat_list = cat_cmd.getList();
	
%>
<script type="text/javascript">
	var chart;
	var cashchart;
	var vmchart;
	var ymchart;
	var yearchart;
	var yearcash;
	var yearvm;
	var deadlinechart;
	var pagechart;
	var categorychart;
	
	$(document).ready(function() {
		chart = new Highcharts.Chart({
			chart: {
				renderTo: 'graph',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: { text: 'Monthly Total Sales'},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: ['Jan','Feb','March','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 2500,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
					return ''+
					this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [
			<%
				for(int yrcount=0; yrcount <arr_sales.size(); yrcount++){
					HashMap<String,String> mysale = arr_sales.get(yrcount);
					%>{ name: <%=mysale.get("year")%>,
					   data: [<%=mysale.get("amounts")%>]
					 }
					<% if(yrcount != ( arr_sales.size()-1)){ %>,<% }
				}
			%>
			]
		});
		
		/** Monthly Sales minus virtual money **/
		 cashchart = new Highcharts.Chart({
			chart: {
				renderTo: 'cashgraph',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Monthly Cash'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: ['Jan','Feb','March','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 2500,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [
				<%
				for(int yrcount=0; yrcount <arr_cash.size(); yrcount++){
					HashMap<String,String> mycash = arr_cash.get(yrcount);
					%>{ name: <%=mycash.get("year")%>,
					   data: [<%=mycash.get("amounts")%>]
					 }
					<% if(yrcount != ( arr_cash.size()-1)){ %>,<% }
				}
				%>
			]
		});
		
		// Virtual Money Chart or Refunded Order Sales 
		vmchart = new Highcharts.Chart({
			chart: {
				renderTo: 'vmgraph',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Monthly Virtual Money'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: ['Jan','Feb','March','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 2500,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [
				<%
				for(int yrcount=0; yrcount <arr_sales_vm.size(); yrcount++){
					HashMap<String,String> mysales_vm = arr_sales_vm.get(yrcount);
					%>{ name: <%=mysales_vm.get("year")%>,
					   data: [<%=mysales_vm.get("amounts")%>]
					 }
					<% if(yrcount != ( arr_sales_vm.size()-1)){ %>,<% }
				}
				%>
			]
		});
		
		avesaleperpage = new Highcharts.Chart({
			chart: {
				renderTo: 'avegraph',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Monthly Average Price Per Page'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: ['Jan','Feb','March','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 2500,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [
			<%
			for(int yrcount=0; yrcount <arr_saleperpage.size(); yrcount++){
				HashMap<String,String> mysale = arr_saleperpage.get(yrcount);
				%>{ name: <%=mysale.get("year")%>,
				   data: [<%=mysale.get("amounts")%>]
				 }
				<% if(yrcount != ( arr_saleperpage.size()-1)){ %>,<% }
			}
			%>
			]
		});
		
		deadlinechart = new Highcharts.Chart({
			chart: {
				renderTo: 'deadlinegraph',
				defaultSeriesType: 'column',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Total Orders Per Deadline'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: [
					'1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
					'11', '12', '13', '14', '15', '16', '17', '18',	'19', '20',
				],
				plotBands: [{ // visualize the weekend
					from: 10,
					to: 500,
				}]
			},
			yAxis: {
				title: {
					text: 'Total No. of Orders'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +'days: '+ this.y +' orders';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
				
					fillOpacity: 0.5
				}
			},
			series: [
				<%
				for(int yrcount=0; yrcount <arr_list.size(); yrcount++){
					HashMap<String,String> mysale = arr_list.get(yrcount);
					%>{ name: <%=mysale.get("year")%>,
					   data: [<%=mysale.get("total")%>]
					 }
					<% if(yrcount != ( arr_list.size()-1)){ %>,<% }
				}
				%>
			]
		});
		
		pagechart = new Highcharts.Chart({
			chart: {
				renderTo: 'pagegraph',
				defaultSeriesType: 'column',
				margin: [100, 50, 100, 100]
			},
			colors:['#DB843D','#F15C80','#8085E9','#90ED7D','#E4D354','#7CB5EC','#2B908F'],
			title: {
				text: 'Total Orders Per No. of Pages'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10',
					'11', '12', '13', '14', '15', '16', '17', '18',	'19','20'],
				plotBands: [{ // visualize the weekend
					from: 10,
					to: 500,
				}]
			},
			yAxis: {
				title: {
					text: 'Total No. of Orders'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +'pages: '+ this.y +' orders';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
				
					fillOpacity: 0.5
				}
			},
			series: [
			    <%
				for(int yrcount=0; yrcount <arr_pagelist.size(); yrcount++){
					HashMap<String,String> mysale = arr_pagelist.get(yrcount);
					%>{ name: <%=mysale.get("year")%>,
					   data: [<%=mysale.get("total")%>]
					 }
					<% if(yrcount != ( arr_pagelist.size()-1)){ %>,<% }
				}
				%>
			]
		});
		
		// Yearly Sales Graph 
		yearchart = new Highcharts.Chart({
			chart: {
				renderTo: 'yeargraph',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Yearly Total Sales'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: [
				<%
					for(int yrcount=0; yrcount<arr_yearly_sales.size(); yrcount++){
						HashMap<String,String> mysale = arr_yearly_sales.get(yrcount);
						%><%=mysale.get("year")%>
						<%	if(yrcount != (arr_yearly_sales.size()-1)){ %>,<% }
					}
				%>
				],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 50000,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [{
				name: 'sales per year',
				data: [
				<%
				for(int cnt=0; cnt<arr_yearly_sales.size(); cnt++){
					HashMap<String,String> mysale = arr_yearly_sales.get(cnt); 
				%>	<%=mysale.get("amount")%>
				<%	if(cnt != (arr_yearly_sales.size()-1)){ %>,<% }
				}%>]
			}]
		});
		
		// Yearly Cash Graph
		yearcash = new Highcharts.Chart({
			chart: {
				renderTo: 'yearcash',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Yearly Cash'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: [
				<%
				for(int yrcount=0; yrcount<arr_yearly_cash.size(); yrcount++){
					HashMap<String,String> mysale = arr_yearly_cash.get(yrcount);
					%><%=mysale.get("year")%>
					<%	if(yrcount != (arr_yearly_cash.size()-1)){ %>,<% }
				}
				%>
				],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 50000,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [{
				name: 'sales per year',
				data: [
					<%
					for(int cnt=0; cnt<arr_yearly_cash.size(); cnt++){
						HashMap<String,String> mysale = arr_yearly_cash.get(cnt); 
					%>	<%=mysale.get("amount")%>
					<%	if(cnt != (arr_yearly_cash.size()-1)){ %>,<% }
					}%>]
			}]
		});
		
		// Yearly Virtual Money 
		yearvm = new Highcharts.Chart({
			chart: {
				renderTo: 'yearvm',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Yearly Virtual Money'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: [
				<%
				for(int yrcount=0; yrcount<arr_yearly_vm.size(); yrcount++){
					HashMap<String,String> mysale = arr_yearly_vm.get(yrcount);
					%><%=mysale.get("year")%>
					<%	if(yrcount != (arr_yearly_vm.size()-1)){ %>,<% }
				}
				%>
				],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 50000,
					color: 'rgba(68, 170, 213, .2)'
				}]
			},
			yAxis: {
				title: {
					text: 'Amount in $'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y +' $';
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [{
				name: 'sales per year',
				data: [
					<%
					for(int cnt=0; cnt<arr_yearly_vm.size(); cnt++){
						HashMap<String,String> mysale = arr_yearly_vm.get(cnt); 
					%>	<%=mysale.get("amount")%>
					<%	if(cnt != (arr_yearly_vm.size()-1)){ %>,<% }
					}%>]
			}]
		});
	
		categorychart = new Highcharts.Chart({
			chart: {
				renderTo: 'categorygraph',
				defaultSeriesType: 'areaspline',
				margin: [100, 50, 100, 100]
			},
			title: {
				text: 'Total Order Per Category'
			},
			legend: {
				layout: 'vertical',
				align: 'left',
				verticalAlign: 'top',
				x: 0,
				y: 0,
				borderWidth: 1,
				backgroundColor: '#FFFFFF'
			},
			xAxis: {
				categories: 
				[
					<%
					for(int c=0; c<cat_list.size(); c++){ 
						OrderEssayCommand mycmd = (OrderEssayCommand) cat_list.get(c);
					%>
						'<%=mycmd.getCategory()%>'
						<%
						if(c != (cat_list.size()-1)){ %>,<%}
					}
					%>
				],
				plotBands: [{ // visualize the weekend
					from: 500,
					to: 50000,
					color: 'rgba(68, 170, 213, .2)'
				}],
				labels: {
					rotation: 90,
					align: 'left'
		
				}
			},
			yAxis: {
				title: {
					text: 'Total No. of Orders'
				}
			},
			tooltip: {
				formatter: function() {
						return ''+
						this.x +': '+ this.y;
				}
			},
			credits: {
				enabled: false
			},
			plotOptions: {
				areaspline: {
					fillOpacity: 0.5
				}
			},
			series: [{
				name: 'total orders',
				data: 
					[
					<% 
					for(int cnt=0; cnt<cat_list.size(); cnt++){
						OrderEssayCommand mycmd = (OrderEssayCommand) cat_list.get(cnt);
					%>
						<%=mycmd.getSubtotal()%>
						<%
						if(cnt != (cat_list.size()-1)){ %>,<%}
					}
					%>
					]
			}]
		}); 
		
	});
</script>

<div class="admin-contents">
	<h2 class="content-title">Sales Graphs</h2>
	<div id="admincon" class="sales-graph-box">
		<form:form name="Form_sales" action="${url }?${params}" method="post">
		<input type="hidden" name="search_field" value="email" />
		<div class="graph_search">
			<label><strong>Email Address:</strong></label>
			<input type="text" name="search_keyword" value="${cmd.search_keyword}" />
			<input type="submit" value="Search" />
		</div>
		</form:form>
		<div id="graph">
		
		</div>	
		<div id="cashgraph">
		
		</div>	
		<div id="vmgraph">
		
		</div>	
		<!--
		<div id="ymgraph">
		
		</div>	
		-->
		<div id="avegraph">
		
		</div>
		<div id="pagegraph">
		</div>
		<span class="total-label">Total Orders: <%=sum_pagelist%></span>
		
		<div id="deadlinegraph">
			
		</div>
		<span class="total-label">Total Orders: <%=sum_list%></span>
		<div id="yeargraph">
	
		</div>
		<div id="yearcash">
	
		</div>
		<div id="yearvm">
	
		</div>
		
		<div id="categorygraph">
		
		</div>
	</div>
</div>