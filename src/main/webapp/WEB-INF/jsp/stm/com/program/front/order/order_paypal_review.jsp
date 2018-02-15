<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<div class="paypal-review">
	<h1 class="prh">PayPal Payment Review</h1>
	<form name="form_paypal" method="post" action="/paypal/review.do?page=return">
	<table cellpadding="0" cellspacing="0" border="0" class="tbl-forum">
		<tr class="head">
			<th width="20%">Item</th>
			<th width="50%">Email</th>
			<th width="30%" class="last">Price</th>
		</tr>
		<tr>
			<td>${result.get("L_NAME0") }</td>
			<td>${result.get("EMAIL") }</td>
			<td>${result.get("CURRENCYCODE")} ${result.get("PAYMENTREQUEST_0_AMT")}</td>
		</tr>
	</table>
	<div class="paypal-bottom">
		<span class="paypal-line"><strong>Total:</strong>&nbsp;<span class="txt-red">${result.get("CURRENCYCODE")} ${result.get("PAYMENTREQUEST_0_AMT")}</span></span>
		<span class="paypal-line"><button type="submit" class="btn-img"><img src="${img_src }/stm/btn/btn_paynow_SM.gif" name="submit"" /></button></span>
	</div>
	</form>
</div>
		