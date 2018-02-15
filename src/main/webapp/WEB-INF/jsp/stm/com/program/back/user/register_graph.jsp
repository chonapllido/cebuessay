<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<%@ page import="stm.com.program.user.service.UserService" %>
<%@ page import="stm.com.program.user.web.UserCommand" %>
<%@ page import="stm.com.support.util.ApplicationHelper" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>

<script type="text/javascript" src="${js_src }/stm/back/highcharts.js"></script>
<script type="text/javascript" src="${js_src }/stm/back/exporting.js"></script>
<% 
	Calendar now = Calendar.getInstance();
	int thisyear = now.get(Calendar.YEAR);
	UserService service = (UserService) ApplicationHelper.getService("userService", request.getSession().getServletContext());
	
	ArrayList<HashMap<String, String>> arr_register = new ArrayList<HashMap<String,String>>();
	
	int startYear = 2008; //start of company;
	for(int str=0,yr=startYear; yr <= thisyear; str++,yr++){
		HashMap<String, String> register = new HashMap<String, String>();
		register.put("year", yr+"");
		register.put("amounts", "");
		
		arr_register.add(register);
	}
	
	for(int i=1; i<=12; i++){
		String month = (i <10) ? "0"+i : ""+i;
		
		String total = "";
		for(int j=0; j<arr_register.size(); j++){
			HashMap<String, String> register = arr_register.get(j);
			String year = register.get("year");
			String total_amount = register.get("amounts");
			String mydate = year+"-"+month;
			
			UserCommand cmd = new UserCommand();
			cmd.setDate(mydate);
			total = service.getRegisterByMonth(cmd, request, response)+"";
			if(i != 12){
				total = total + ",";
			}
			
			total_amount = total_amount + total;
			register.put("amounts", total_amount+"");
		}
	}
	%>
<script type="text/javascript">

var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'graph',
			defaultSeriesType: 'areaspline',
			margin: [100, 50, 50, 100]
		},
		title: {
			text: 'Registration Graph'
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
			categories: ['Jan','Feb', 'March','Apr','May', 'June','July','Aug','Sept','Oct','Nov','Dec'],
			plotBands: [{ // visualize the weekend
				from: 500,
				to: 2500,
				color: 'rgba(68, 170, 213, .2)'
			}]
		},
		yAxis: {
			title: {
				text: 'No of Users'
			}
		},
		tooltip: {
			formatter: function() {
					return ''+
					this.x +': '+ this.y +' users';
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
		series: 
		[
			<%
			for(int yrcount=0; yrcount <arr_register.size(); yrcount++){
				HashMap<String,String> register = arr_register.get(yrcount);
				%>{ name: <%=register.get("year")%>,
				   data: [<%=register.get("amounts")%>]
				 }
				<% if(yrcount != ( arr_register.size()-1)){ %>,<% }
			}
			%>
		]
	});
	
	
});
	
</script>
<div class="admin-contents">
	<h2 class="content-title">Registration Graph</h2>
	<div id="admincon" class="sales-graph-box">	
		<div id="graph">
	
		</div><!--end right page-->			
	</div>
</div>