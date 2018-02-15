<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">PAY NOW</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<a href="#" class="btn-paynow"><img src="${img_src }/stm/btn/btn_paynow.png" width="269" height="78" alt="Pay Now" title="Pay Now" /></a>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Email Address</td>
			<td class="col2">${email }</td>
		</tr>
		<tr>
			<td class="col1">Name</td>
			<td class="col2">${username }</td>
		</tr>
		<tr>
			<td class="col1">Amount</td>
			<td class="col2">${amount } $ (US dollar)</td>
		</tr>
		<tr>
			<td class="col1">Payment Method</td>
			<td class="col2">Paypal</td>
		</tr>
	</table>
	<div class="form-submit">
		<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
		<input type="hidden" name="cmd" value="_xclick" />
		<input type="hidden" name="business" value="tamura198@gmail.com" />
		<input type="hidden" name="item_name" value="Order" />
		<input type="hidden" name="item_number" value="1" />
		<input type="hidden" name="quantity" value="1" />
		<input type="hidden" name="amount" value="${amount }" />
		<input type="hidden" name="no_shipping" value="0" />
		<input type="hidden" name="return" value="https://www.cebuessay.com/" />
		<input type="hidden" name="no_note" value="3" />
		<input type="hidden" name="currency_code" value="USD" />
		<input type="hidden" name="lc" value="EN" />
		<input type="hidden" name="bn" value="PP-BuyNowBF" />
		<input type="hidden" name="image_url" value="https://www.cebuessay.com/images/tit/tit_cebuessay.png" />
		<input type="image" src="${img_src }/stm/btn/btn_paynow.gif" name="submit" alt="PayPal - The safer, easier way to pay online!" />
		</form>
	</div>
</div>