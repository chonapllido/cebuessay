<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<%@ page import="java.util.Date" %>
<script src="${js_src }/stm/timer.js"></script>
<script type="text/javascript">
	fnDownloadFile = function(filenameOrig, filenameNew){
		var f = document.Form_order_revision;
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
	<form:form name="Form_order_revision"  action="${url}?${param }" method="post" enctype="multipart/form-data">
		<input type="hidden" name="type_id" value="2" />
		<input type="hidden" name="file" value="" />
		<input type="hidden" name="file_upload" value="" />
		<table  class="tbl-order-form">
			<tr>
				<td class="col1">Topic</td>
				<td class="col3"><c:out value="${cmd.topic }" /></td>
				<td class="col1 third">Total Payment</td>
				<td class="col2"><strong class="txt-red">${cmd.total_payment } $</strong></td>
			</tr>
			<tr>
				<td class="col1">Level</td>
				<td class="col2" colspan="3">${cmd.level }</td>
			</tr>
			<tr>
				<td class="col1">Deadline</td>
				<td class="col2" colspan="3">
					<span class="review-date">${cmd.days } days&nbsp;&nbsp;-&nbsp;&nbsp;</span>
					<span class="deadline-date" id="del_date_rev"><fmt:formatDate pattern="MMM dd" value="${deadline}" /> 7pm (GMT + 9 Asian Time)</span>
				</td>
			</tr>
			
			<tr class="row-instructions">
				<td class="col1">Type or paste the file below that need to be revised</td>
				<td class="col2" colspan="3">
					<textarea name="content" id="pasteinfo" rows="10" cols="10" class="txtarea" readonly="readonly"><c:out value="${content }" /></textarea>
				</td>
			</tr>
			<tr class="row-files">
				<td class="col1">Files</td>
				<td class="col2" colspan="3">
					<c:if test="${! empty cmd.file_upload }">
					<button type="button" onclick="fnDownloadFile('${cmd.file_upload}', '${cmd.file_upload_tmp}')">
					${cmd.file_upload}
					</button>
					</c:if>
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
					<input type="hidden" name="L_PAYMENTREQUEST_0_NAME0" value="Revision Order" />
					<input type="hidden" name="PAYMENTREQUEST_0_AMT" value="${cmd.total_payment }" />
					<input type="hidden" name="L_PAYMENTREQUEST_0_QTY0" value="1" />
					<input type="hidden" name="PAYMENTREQUEST_0_ITEMAMT" value="${cmd.total_payment }" />
					<input type="hidden" name="currencyCodeType" value="USD" />
					<input type="hidden" name="paymentType" value="Sale" />
					<input type="hidden" name="orderType" value="Revision" />
					<input type="hidden" name="orderId" value="${cmd.order_id }" />
					<button type="submit" class="btn-img"><img src="${img_src}/stm/btn/btn_paynow_SM.gif" alt="Pay with PayPal"/></button>
				</form>
				</c:if>
			</span>
		</span>
		<span class="form-submit">
			<a href="/back/order/revision/update.do?order_id=${cmd.order_id }"><img src="${img_src }/stm/btn/btn_edit.png" alt="edit" /></a>
			<a href="/back/order/list.do"><img src="${img_src }/stm/btn/btn_close.png" width="120" height="35" alt="close" /></a>
		</span>
	<div class="admin_spacer">&nbsp;</div>
</div>