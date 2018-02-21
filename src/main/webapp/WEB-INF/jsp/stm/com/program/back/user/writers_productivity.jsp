<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnViewPrevMonth = function(){
		var list = $("tr.bgblue");
		
		if(list.is(":visible"))
			list.hide();
		else
			list.show();
	}
	
	fnViewNextMonth = function(){
		var list = $("tr.bgred");
		
		if(list.is(":visible"))
			list.hide();
		else
			list.show();
	}
	
	fnRecalculate = function(){
		var f = document.Form_list;
		var working_days = f.working_days.value;
		var total_words = f.total_words.value;
		var productivity = total_words/working_days;
		
		$("#sum").text(productivity);
	}
	
	fnViewPrintable = function(el){
		if(el == "1"){
			document.getElementById("htmlpage").style.display = "none";
			document.getElementById("printable").style.display = "inline";
		} else {
			document.getElementById("htmlpage").style.display = "inline";
			document.getElementById("printable").style.display = "none";
		}
	}
</script>

<jsp:useBean id="date" class="java.util.Date" />
<fmt:formatDate value="${date }" pattern="yyyy" var="currentYear" />
<c:set var="total_words" value="0" />
<c:set var="total_print_words" value="0" />
<div class="writer-productivity" id="htmlpage">
	<form:form name="Form_list" action="${url }?${params }" method="post">
		<input type="hidden" name="user_id" value="${user_id }" />
		<div class="writer_detail">
			<input type="button" name="btnprintable" value="Printable Version" class="btn_print" onclick="fnViewPrintable('1');" />
			<h1 class="writer_name">${name }</h1>
			<div class="options">
				<div class="date_options">
					<label>Month</label>
					<select name="detail_month">
						<option value="01" <c:if test="${month eq '01'}">selected="selected"</c:if>>January</option>
						<option value="02" <c:if test="${month eq '02'}">selected="selected"</c:if>>February</option>
						<option value="03" <c:if test="${month eq '03'}">selected="selected"</c:if>>March</option>
						<option value="04" <c:if test="${month eq '04'}">selected="selected"</c:if>>April</option>
						<option value="05" <c:if test="${month eq '05'}">selected="selected"</c:if>>May</option>
						<option value="06" <c:if test="${month eq '06'}">selected="selected"</c:if>>June</option> 
						<option value="07" <c:if test="${month eq '07'}">selected="selected"</c:if>>July</option>
						<option value="08" <c:if test="${month eq '08'}">selected="selected"</c:if>>August</option>
						<option value="09" <c:if test="${month eq '09'}">selected="selected"</c:if>>September</option>
						<option value="10" <c:if test="${month eq '10'}">selected="selected"</c:if>>October</option>
						<option value="11" <c:if test="${month eq '11'}">selected="selected"</c:if>>November</option>
						<option value="12" <c:if test="${month eq '12'}">selected="selected"</c:if>>December</option>
					</select>
					<label>Year</label>
					<select name="detail_year">
						<c:forEach var="row" begin="2008" end="${currentYear }">
						${row }
							<option value="${row }" <c:if test="${year eq row }">selected="selected"</c:if>>${row }</option>
						</c:forEach>
					</select>
					<input type="submit" name="changedate" value="Change Date" />
				</div>
				<div class="days_options">
					<label>Working days:</label>
					<input type="text" name="working_days" value="${workdays }">
				</div>
			</div>
			<table class="tbl-productivity">
				<colgroup>
					<col width="4%" />
					<col width="6%" />
					<col width="40%" />
					<col width="14%" />
					<col width="7%" />
					<col width="7%" />
					<col width="7%" />
					<col width="7%" />
					<col width="" />
				</colgroup>
				<thead>
					<tr class="head">
						<th>No</td>
						<th>Order No</td>
						<th>Topic</td>
						<th>Category</td>
						<th>Date</td>
						<th>Deadline</td>
						<th>Finished</td>
						<th>Status</th>
						<th>Total Words</td>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="row" items="${cmd.list }" varStatus="i">
					<c:set var="words" value="${row.no_pages * 250 }" />
					<tr>
						<td>${i.index+1 }</td>
						<td>${row.order_id }</td>
						<td class="colTopic">&nbsp;${row.topic }</td>
						<td>&nbsp;${row.category }</td>
						<td>${row.start_date }</td>
						<td>${row.end_date }</td>
						<td>${row.date_modified }</td>
						<td>Finished</td>
						<td><input type="text" name="totalwords" class="input_words" value="${words }" /></td>
					</tr>
					<c:set var="total_words" value="${total_words + words }" />					
				</c:forEach>
				<c:set var="productivity" value="${total_words/workdays }" />
				<c:forEach var="row" items="${cmd_working.list }" varStatus="i">
				<tr class="bgyellow">
					<td>&nbsp;</td>
					<td>${row.order_id }</td>
					<td class="colTopic">&nbsp;${row.topic }</td>
					<td>&nbsp;${row.category }</td>
					<td>${row.start_date }</td>
					<td>${row.end_date }</td>
					<td>&nbsp;</td>
					<td>Working</td>
					<td>${row.no_pages * 250 }</td>
				</tr>
				</c:forEach>
				<!-- Previous month orders -->
				<c:if test="${fn:length(cmd_prev.list) gt 0 }">
				<c:forEach var="row" items="${cmd_prev.list }" varStatus="i">
					<tr class="bgblue">
						<td>&nbsp;</td>
						<td>${row.order_id }</td>
						<td class="colTopic">&nbsp;${row.topic }</td>
						<td>&nbsp;${row.category }</td>
						<td>${row.start_date }</td>
						<td>${row.end_date }</td>
						<td>${row.date_modified }</td>
						<td>
							<c:if test="${row.status eq '2' }">Working</c:if>
							<c:if test="${row.status eq '3' }">Finished</c:if>
						</td>
						<td>${row.no_pages * 250 }</td>
					</tr>
				</c:forEach>
				</c:if>
				<!-- Next month orders -->
				<c:if test="${fn:length(cmd_next.list) gt 0 }">
				<c:forEach var="row" items="${cmd_next.list }" varStatus="i">
					<tr class="bgred">
						<td>&nbsp;</td>
						<td>${row.order_id }</td>
						<td class="colTopic">&nbsp;${row.topic }</td>
						<td>&nbsp;${row.category }</td>
						<td>${row.start_date }</td>
						<td>${row.end_date }</td>
						<td>${row.date_modified }</td>
						<td>
							<c:if test="${row.status eq '2' }">Working</c:if>
							<c:if test="${row.status eq '3' }">Finished</c:if>
						</td>
						<td>${row.no_pages * 250 }</td>
					</tr>
				</c:forEach>
				</c:if>
				</tbody>					
			</table>
			<%-- <input type="button" name="adjustment" value="Update List" class="btnrecalculate" onclick="JSAdWriter.adjust();"/>--%>
			<div class="summary">Total Words: <span id="sumwords">${total_words }</span></div>
			<div class="summary">Productivity: <span id="sum">${productivity }</span></div>	
			<input type="button" name="prevmonth" value="Last Month" class="btnrecalculate" onclick="fnViewPrevMonth()" />
			<input type="button" name="nextmonth" value="Next Month" class="btnrecalculate" onclick="fnViewNextMonth()" />
			<input type="button" name="calculate" value="Recalculate" class="btnrecalculate" onclick="fnRecalculate()";/>
			<input type="hidden" name="total_words" value="${total_words }" />
		</div>
	</form:form>
</div>
<div class="writer-productivity" id="printable">
	<form:form name="From_print" action="${url }?${params }" method="post">
		<input type="button" name="webpage" value="<< Web Page" class="btn_print" onclick="fnViewPrintable('0');" />
		<input type="button" name="print" value="PRINT" class="btn_print" onclick="window.print();"/>
		<%--<input type="submit" name="submit" value="Download" class="btn_print" /> --%>
		<h1 class="writer_name">${name }</h1>
		<span class="title"><strong>Date:&nbsp;&nbsp;</strong>${month }-${year }</span>
		<span class="title"><strong>Working days:&nbsp;&nbsp;</strong>${workdays }</span>
		<table class="tbl-productivity">
			<colgroup>
				<col width="4%" />
				<col width="6%" />
				<col width="40%" />
				<col width="14%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="7%" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th>No</td>
					<th>Order No</td>
					<th>Topic</td>
					<th>Category</td>
					<th>Date</td>
					<th>Deadline</td>
					<th>Finished</td>
					<th>Total Words</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${cmd.list }" varStatus="i">
			<tr>
				<td>${i.index+1 }</td>
				<td>${row.order_id }</td>
				<td class="colTopic">&nbsp;${row.topic }</td>
				<td>&nbsp;${row.category }</td>
				<td>${row.start_date }</td>
				<td>${row.end_date }</td>
				<td>${row.date_modified }</td>
				<td>${row.no_pages * 250 }</td>
			</tr>
			<c:set var="total_print_words" value="${total_print_words + (row.no_pages*250) }" />
			</c:forEach>
			</tbody>					
		</table>
		<div class="summary">Total Words: <span id="sumwords">${total_words }</span></div>
		<div class="summary">Productivity: <span id="sum">${productivity }</span></div>	
	</form:form>
</div>
