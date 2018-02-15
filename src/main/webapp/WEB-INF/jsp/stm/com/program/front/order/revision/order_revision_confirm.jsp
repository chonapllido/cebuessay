<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnPayVirtualMoney = function(){

		var f 		= document.form_pay,
			total 	= parseInt(f.vm_total.value),
			vm 		= parseInt(f.vm_amt.value),
			pay 	= 0, 
			new_total = 0, 
			new_vm 	= 0;
			
			if(vm > total){
				pay = total;
			} else {
				pay = vm;
			}
			new_total = total - pay;
			new_vm = vm - pay;

			f.vm_pay.value = pay;
			f.new_total.value = new_total;
	
			if(new_vm <= 0 || new_total == 0){
				$('#vmpay').hide();
			}
			$.ajax({
				type: "POST",
				url: "/front/order/revision/payVirtualMoney.do",
				data: $('#form_pay').serialize(),
				success: function(data){
					$('.total-box span').text('US $'+new_total);
					$('.data .amt').text("$"+new_vm);
					document.formpaypal.PAYMENTREQUEST_0_AMT.value = new_total;
					if(new_total == 0){
						$('.submitted-pay').hide();
					}
				}
			});			
	}
</script>
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Revision Order Confirmation</h2>
		</div>
	</div>
	<c:if test="${order_id != '0'}">
	
	<div class="order-confirm-msg">
		<p class="highlight">Thank your for your order!</p>
		<p>Your order # is: <strong>${order_id }</strong><br />
		Your order will be processed as soon as we receive your payment.<br />
		You can pay through your available virtual money or through PayPal. <br />
		Orders with $0 total will be processed automatically.</p>
		<div class="total-box">Total: <span>US $${total_payment }</span></div>
		<c:if test="${total_payment > 0 }">	
		<div class="vm-box">
		<form name="form_pay" id="form_pay" action="/front/order/essay/payVirtualMoney.do" method="post">
			<input type="hidden" name="order_id" value="${order_id }" />
			<input type="hidden" name="user_id" value="${user.user_id }" />
			<input type="hidden" name="vm_amt" value="${vm_amt }" />
			<input type="hidden" name="vm_id" value="${user.user_id }" />
			<input type="hidden" name="vm_total" value="${total_payment }" />
			<input type="hidden" name="vm_pay" value="0" />
			<input type="hidden" name="new_total" value="" />
			<input type="hidden" name="otype" value="revision" />
			<input type="hidden" name="do_action" value="pay_vm" />
			<span class="label">Your Virtual Money:</span>
			<span class="data">
				<span class="amt">$ ${vm_amt }</span>
				<c:if test="${vm_amt > 0}"><button type="button" onclick="fnPayVirtualMoney()" class="btn">Use money</button></c:if>
			</span>
		</form>
		</div>
		<div class="submitted-pay">
			<form id="formpaypal" name="formpaypal" action="/paypal/pay.do" method="post" target="_blank">
				<input type="hidden" name="BRANDNAME" value="CebuEssay" />
				<input type="hidden" name="L_PAYMENTREQUEST_0_NAME0" value="Revision Order" />
				<input type="hidden" name="PAYMENTREQUEST_0_AMT" value="${total_payment }" />
				<input type="hidden" name="L_PAYMENTREQUEST_0_QTY0" value="1" />
				<input type="hidden" name="PAYMENTREQUEST_0_ITEMAMT" value="${total_payment }" />
				<input type="hidden" name="currencyCodeType" value="USD" />
				<input type="hidden" name="paymentType" value="Sale" />
				<input type="hidden" name="orderType" value="Revision" />
				<input type="hidden" name="orderId" value="${order_id }" />
				<button type="submit" class="btn-img"><img src="${img_src }/stm/btn/btn_xpressCheckout.gif" border="0" align="top" alt="Check out with PayPal"/></button>
			</form>
		</div>	
		</c:if>
	</div>
	</c:if>
	<c:if test="${order_id == '0' }">
	<div class="order-confirm-msg">
		<p class="red">There was an error in your order.<br/> Please contact CebuEssay!</p>
	</div>
	</c:if>
</div>