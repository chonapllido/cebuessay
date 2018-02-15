<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<%@ page import="java.util.Date" %>
<script src="${js_src }/stm/timer.js"></script>
<script type="text/javascript">
fnDownloadFile = function(filenameOrig, filenameNew){
	var f = document.Form_order_essay;
		f.file.value = filenameOrig;
		f.file_upload.value = filenameNew;
	
		f.action = "/back/order/downloadFile.do";
		f.submit();
}
</script>

<jsp:useBean id="current_date" class="java.util.Date" />
<div class="admin-contents">
	<h2 class="content-title">Order Management</h2>
	<h3 class="orderno-title">Order No: ${cmd.order_id }</h3>
	<form:form name="Form_order_essay" method="post" action="${url }?${param}">
	<input type="hidden" name="type_id" value="1" />
	<input type="hidden" name="file" value="" />
	<input type="hidden" name="file_upload" value="" />
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Category</td>
			<td class="col3">${cmd.category }</td>
			<td class="col1 third">Total Payment</td>
			<td class="col2"><strong class="txt-red">${cmd.total_payment } $</strong></td>
		</tr>
		<tr>
			<td class="col1">Writing Format</td>
			<td class="col2" colspan="3">${cmd.format }</td>
		</tr>
		<tr>
			<td class="col1">Level</td>
			<td class="col2" colspan="3">${cmd.level }</td>
		</tr>
		<tr>
			<td class="col1">Deadline</td>
			<td class="col2" colspan="3">
				<span class="review-date">${cmd.days } days&nbsp;&nbsp;-&nbsp;</span>
				<span class="deadline-date"><fmt:formatDate pattern="MMM dd" value="${deadline}" /> 7pm (GMT + 9 Asian Time)</span>
			</td>
		</tr>
		<tr>
			<td class="col1">Number of Pages</td>
			<td class="col2" colspan="3">${cmd.no_pages } page/s</td>
		</tr>
		<tr>
			<td class="col1">Required Reading</td>
			<td class="col2" colspan="3">${cmd.read_material }</td>
		</tr>
		<tr>
			<td class="col1">Number of Sources</td>
			<td class="col2" colspan="3">${cmd.no_sources }</td>
		</tr>
		<tr>
			<td class="col1">Preferred Writer</td>
			<td class="col2" colspan="3">${cmd.preferred_writer}</td>
		</tr>
		<tr>
			<td class="col1">Topic</td>
			<td class="col2" colspan="3"><c:out value="${cmd.topic}" /></td>
		</tr>
		<tr class="row-instructions">
			<td class="col1">Instructions</td>
			<td class="col2" colspan="3"><textarea rows="20" cols="10" id="writebody" readonly="readonly" name="body" class="txtarea"><c:out value="${cmd.in_body }" /></textarea></td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3">
				<div class="file-list-name">
				<c:set var="filenameOrig" value="${fn:split(cmd.file,':')}" />
				<c:set var="filenameNew" value="${fn:split(cmd.file_upload,':')}" />
				<ul>
				<c:forEach var="file" items="${filenameOrig }" varStatus="i">
				<li>
					<button type="button" onclick="fnDownloadFile('${file}', '${filenameNew[i.index]}')">
					${file}
					</button>
				</li>
				</c:forEach>
				</ul>
				<div>
			</td>
		</tr>
	</table>
	</form:form>
	<span class="order-note-timer">
		<span class="order-note"><strong><c:if test="${(! empty cancelTime) and (cancelTime le current_date)}">Time Remaining:</c:if></strong></span>
		<span class="order-timer">
			<c:if test="${(! empty cancelTime) and (cancelTime le current_date)}">		
			 <span id="timer">
			 <script type="text/javascript">
				startTimer('${cancelTime}', '<fmt:formatDate pattern="yyyy/MM/dd H:m:s" value="${current_date}" />');
			  </script>
			 </span>
			 <form id="formpaypal" name="formpaypal" action="/paypal/pay.do" method="post" target="_blank">
				<input type="hidden" name="BRANDNAME" value="CebuEssay" />
				<input type="hidden" name="L_PAYMENTREQUEST_0_NAME0" value="Essay Order" />
				<input type="hidden" name="PAYMENTREQUEST_0_AMT" value="${cmd.total_payment }" />
				<input type="hidden" name="L_PAYMENTREQUEST_0_QTY0" value="1" />
				<input type="hidden" name="PAYMENTREQUEST_0_ITEMAMT" value="${cmd.total_payment }" />
				<input type="hidden" name="currencyCodeType" value="USD" />
				<input type="hidden" name="paymentType" value="Sale" />
				<input type="hidden" name="orderType" value="Essay" />
				<input type="hidden" name="orderId" value="${cmd.order_id }" />
				<button type="submit" class="btn-img"><img src="${img_src}/stm/btn/btn_paynow_SM.gif" alt="Pay with PayPal"/></button>
			</form>
			</c:if>
		</span>
	</span>
	<span class="form-submit">
		<a href="/back/order/essay/update.do?order_id=${cmd.order_id }"><img src="${img_src }/stm/btn/btn_edit.png" alt="edit" /></button>
		<a href="/back/order/list.do"><img src="${img_src }/stm/btn/btn_close.png" alt="close" /></a>
	</span>
	<div class="admin_spacer">&nbsp;</div>
</div>