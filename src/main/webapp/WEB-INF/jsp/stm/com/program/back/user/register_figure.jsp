<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<%@ page import="stm.com.program.user.service.UserService" %>
<%@ page import="stm.com.program.user.web.UserCommand" %>
<%@ page import="stm.com.support.util.ApplicationHelper" %>
<%@ page import="java.util.List" %>
<%@ page import="java.lang.Integer" %>

<script type="text/javascript">
	fnChangeYear = function(el){
		var f = document.Form_sales;
		var year = parseInt(f.year.value);
		
		if(el == 0){
			f.year.value = (year-1);
		} else {
			f.year.value = (year+1);
		}
		f.submit();
	}
</script>
<%
	Calendar now = Calendar.getInstance();
	UserService user_service = (UserService) ApplicationHelper.getService("userService", request.getSession().getServletContext());

	int year = Integer.parseInt(request.getAttribute("year").toString());
	int month = Integer.parseInt(request.getAttribute("month").toString());
	
	now.set(year, month,1);
	int week = (now.get(Calendar.DAY_OF_WEEK)-1);
	
	int dd = 0;
	int daye = 1;
	int total_user = 0;
	
	int maxDay = now.getActualMaximum(Calendar.DAY_OF_MONTH);

	String mm = (month+1)+"";
	mm = (mm.length() == 1) ? "0"+mm : mm;
%>

<jsp:useBean id="current_date" class="java.util.Date" />
<fmt:formatDate value="${current_date }" pattern="yyyy-MM-dd" var="now" />

<div class="admin-contents">
	<h2 class="content-title">Sales Figure</h2>
	<form name="Form_sales" method="post" action="${url }?${params}">
	<div class="sales-date-box">
		<button type="button" class="btn-img" onclick="fnChangeYear(0)"><img src="${img_src }/stm/btn/btn_previous.png" alt="previous" /></button>
		<input type="text" name="year" value="${year }" size="4" />
		<button type="button" class="btn-img" onclick="fnChangeYear(1)"><img src="${img_src }/stm/btn/btn_next.png" alt="next" /></button>
		<select name="month" onchange="document.Form_sales.submit();">
			<option value="0" <c:if test="${month eq '0' }">selected="selected"</c:if>>January</option>
			<option value="1" <c:if test="${month eq '1' }">selected="selected"</c:if>>February</option>
			<option value="2" <c:if test="${month eq '2' }">selected="selected"</c:if>>March</option>
			<option value="3" <c:if test="${month eq '3' }">selected="selected"</c:if>>April</option>
			<option value="4" <c:if test="${month eq '4' }">selected="selected"</c:if>>May</option>
			<option value="5" <c:if test="${month eq '5' }">selected="selected"</c:if>>June</option>
			<option value="6" <c:if test="${month eq '6' }">selected="selected"</c:if>>July</option>
			<option value="7" <c:if test="${month eq '7' }">selected="selected"</c:if>>August</option>
			<option value="8" <c:if test="${month eq '8' }">selected="selected"</c:if>>September</option>
			<option value="9" <c:if test="${month eq '9' }">selected="selected"</c:if>>October</option>
			<option value="10" <c:if test="${month eq '10' }">selected="selected"</c:if>>November</option>
			<option value="11" <c:if test="${month eq '11' }">selected="selected"</c:if>>December</option>
		</select>
	</div>
	<table class="tbl-admin">
		<tr>
			<th width="15%">Sunday</th>
			<th width="14%">Monday</th>
			<th width="14%">Tuesday</th>
			<th width="14%">Wednesday</th>
			<th width="14%">Thursday</th>
			<th width="14%">Friday</th>
			<th width="15%" class="last">Saturday</th>
		</tr>
		
		<tr class="row-sales" id="row_sales0">
		<%		
		while(dd < week){
			String bgcolor = "#ffffff";
			if(dd == 0) bgcolor = "e2dff2";
			if(dd == 6) bgcolor = "bfe6fb";
		%>
		<td bgcolor="<%=bgcolor %>">&nbsp;</td>
		<% 	
		dd++; 
		} 
	
		while(dd < 7){
			String bgcolor = "#ffffff";
			if(dd == 0) bgcolor = "e2dff2";
			if(dd == 6) bgcolor = "bfe6fb";

			String day = Integer.toString(daye);
			day = (day.length() == 1) ? "0"+day : day;
			String date = year+"-"+mm+"-"+day;
			
			UserCommand user_cmd = new UserCommand();
			user_cmd.setDate(date);
			int registered = user_service.getRegisterByDate(user_cmd, request, response);
			
		%>	
		
		<td bgcolor="<%=bgcolor%>" class="ff"><%=daye%>
		<%
			if(registered > 0){
		%>
			<br/>
				<span class="cal-count"><%=registered %></span>		
			<br/>
		<%	}
		dd++;
		daye++;
		total_user = total_user + registered;
		}
	
		while(daye <= maxDay){
		%>
		
		<tr class="row-sales" id="row_sales1">
		<%
		int new_dd = 0;
		
		while(new_dd < 7){
			String bgcolor = "#ffffff";
			if(new_dd == 0) bgcolor = "e2dff2";
			if(new_dd == 6) bgcolor = "bfe6fb";
			
			int total = 0; int total_unrefund = 0; int total_refund = 0;
			
			String dday = Integer.toString(daye);
			dday = (dday.length() == 1) ? "0"+dday : dday;
			String my_date = year+"-"+mm+"-"+dday;
			
			UserCommand new_cmd = new UserCommand();
			new_cmd.setDate(my_date);
			int new_registered = user_service.getRegisterByDate(new_cmd, request, response);
			
			if(daye <= maxDay){
		%>		
			<td bgcolor="<%=bgcolor%>"><%=daye%>
				<% if (new_registered > 0){ %>
				<br />
				<span class="cal-count"><%=new_registered %></span>
				<% } %>
				<br />
			</td>
		<% 	} else { %>

			<td bgcolor="<%=bgcolor %>">&nbsp;</td>
		<%
			}
		daye++;
		new_dd++;
		dd++;
		total_user = total_user + new_registered;
		}
		%>
	</tr>
	<% } %>
	</table>

	</form>
	<div class="legend-box">
		<strong class="legend-title">Summary</strong>
		<ul>
			<li>
				<span class="legend-label">Total</span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning txt-red"><strong><%=total_user %></strong></span>
			</li>
		</ul>
	</div>
</div>