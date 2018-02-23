<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<%@ page import="java.util.Date" %>
<script src="${js_src }/stm/timer.js"></script>

<jsp:useBean id="current_date" class="java.util.Date" />
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Essay Writing</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<a href="javascript:void(0);"><img src="${img_src}/stm/btn/btn_writing_orange.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="/front/order/revision/write.do"><img src="${img_src}/stm/btn/btn_revision.png" width="255" height="74" alt="Revision" title="Revision" /></a>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
	<form:form name="Form_essay" method="post" action="${url}?${params}">
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Category</td>
			<td class="col3">${cmd.category }</td>
			<td class="col1 third">Total Payment</td>
			<td class="col4"><strong class="txt-red">${cmd.total_payment } $</strong></td>
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
			<td class="col1">Reading Material</td>
			<td class="col2" colspan="3">${cmd.read_material }</td>
		</tr>
		<tr>
			<td class="col1">Number of Sources</td>
			<td class="col2" colspan="3">${cmd.no_sources }</td>
		</tr>
		<tr>
			<td class="col1">Preferred Writer</td>
			<td class="col2" colspan="3">${cmd.preferred_writer }</td>
		</tr>
		<tr>
			<td class="col1">Topic</td>
			<td class="col2" colspan="3">${cmd.topic }</td>
		</tr>
		<tr class="row-instructions">
			<td class="col1">Instructions</td>
			<td class="col2" colspan="3"><textarea rows="20" cols="10" id="writebody" readonly="readonly" name="body" class="txtarea">${cmd.in_body }</textarea></td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3">
			<div class="file-list-name">
				<ul>
					<li>
						${fn:replace(cmd.file, ":", "</li><li>")}
					</li>
				</ul>	
			</div>				
			</td>
		</tr>
		
	</table>
	</form:form>
	<span class="order-note-timer">
		<span class="order-note"><strong><c:if test="${! empty cancelTime}">Time Remaining:</c:if></strong></span>
		
		<span class="order-timer">
			<c:if test="${! empty cancelTime }">		
			 <span id="timer">
			 <script type="text/javascript">
			 	startTimer('${cancelTime}', '<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${current_date}" timeZone="Asia/Seoul"/>');
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
		<a href="/front/user/mypage.do"><img src="${img_src}/stm/btn/btn_close.png" alt="close" /></a>
	</span>
</div>