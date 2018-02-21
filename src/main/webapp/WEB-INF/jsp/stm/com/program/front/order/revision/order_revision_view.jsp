<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<script src="${js_src }/stm/timer.js"></script>

<jsp:useBean id="current_date" class="java.util.Date" />
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Revision</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<a href="order_form_essay.php"><img src="${img_src}/stm/btn/btn_writing.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="javascript:void(0);"><img src="${img_src}/stm/btn/btn_revision_orange.png" width="255" height="74" alt="Revision" title="Revision" /></a>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
	<form name="form_revision" method="post" enctype="multipart/form-data" action="${url }?${params}">
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Topic</td>
			<td class="col3">${cmd.topic }</td>
			<td class="col1 third">Total Payment</td>
			<td class="col4"><span class="txt-total">${cmd.total_payment } $</span></td>
		</tr>
		<tr>
			<td class="col1">Level</td>
			<td class="col2" colspan="3">${cmd.level }</td>
		</tr>
		<tr class="row-deadline">
			<td class="col1">Deadline</td>
			<td class="col2" colspan="3">
				<span class="review-date">${cmd.days } days&nbsp;&nbsp;-&nbsp;&nbsp;</span>
				<span class="deadline-date" id="del_date_rev"><fmt:formatDate pattern="MMM dd" value="${deadline}" /> 7pm (GMT + 9 Asian Time)</span>
			</td>
		</tr>
		
		<tr class="row-instructions">
			<td class="col1">Contents</td>
			<td class="col2" colspan="3">
				<textarea name="content" id="pasteinfo" rows="10" cols="10" class="txtarea" readonly="readonly"><c:out value="${content }" /></textarea>
			</td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3">${cmd.file_upload }</td>
		</tr>
	</table>
	</form>
	<span class="order-note-timer">
		<span class="order-note"><strong><?php if($targetDate != ''){ ?>Time Remaining:<?php } ?></strong></span>
		<span class="order-timer">
			<c:if test="${! empty cancelTime }">		
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
		<a href="/front/user/mypage.do"><img src="${img_src}/stm/btn/btn_close.png" width="120" height="35" alt="close" /></a>
	</span>
	
</div>