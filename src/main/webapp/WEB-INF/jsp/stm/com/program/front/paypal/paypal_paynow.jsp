<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnPay = function(){
		var f = document.Form_pay,
		 	email = f.email,
			name = f.username,
			amount = f.amount;

		if(email.value == ''){
			alert('Please enter your email address!');
			email.focus();
			return false;
		}

		if(!isValidEmail(email)){
			alert('Please enter a valid email address!');
			email.focus();
			return false;
		}
		
		if(name.value == ''){
			alert('Please enter your name!');
			name.focus();
			return false;
		}
		
		if(amount.value == ''){
			alert('Please enter the amount that you will pay!');
			amount.focus();
			return false;
		} else {
			if(isNaN(amount.value)){
				alert('Please enter a valid amount!');
				amount.focus();
				return false;
			}
		}
		
		return true;
	}
</script>
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
	<form name="Form_pay" method="post" action="/front/paypal/preview.do" onsubmit="return fnPay();">
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Email Address</td>
			<td class="col2"><input type="text" name="email" value="${user.email }" class="ipt"/></td>
		</tr>
		<tr>
			<td class="col1">Name</td>
			<td class="col2"><input type="text" name="username" value="${user.name }" class="ipt" /></td>
		</tr>
		<tr>
			<td class="col1">Amount</td>
			<td class="col2">
				<input type="text" name="amount" class="ipt short" /><span>$ (US dollar)</span>
			</td>
		</tr>
		<tr>
			<td class="col1">Payment Method</td>
			<td class="col2">Paypal</td>
		</tr>
	</table>
	<span class="form-submit">
		<button type="submit" class="btn-img" ><img src="${img_src }/stm/btn/btn_preview.png" alt="preview" /></button></span>
	</form>
</div>