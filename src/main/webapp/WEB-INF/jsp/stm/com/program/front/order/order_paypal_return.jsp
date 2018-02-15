<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<c:if test="${ack.equals('SUCCESS') || ack.equals('SUCCESSWITHWARNING')}">
	<div class="paypalconfirm">
		<p>Payment has been successfully transferred through Paypal!</p>
		<span class="paypalmsg"><a href="/front/mypage.do"><img src="${img_src }/stm/btn/btn_mypage2.png" alt="my page"/></a></span>
	</div>
</c:if>
<c:if test="${!ack.equals('SUCCESS') && !ack.equals('SUCCESSWITHWARNING')}">
	<div class="hero-unit">
<!-- Display the Transaction Details-->
		<h4> There is a Funding Failure in your account. You can modify your funding sources to fix it and make purchase later. </h4>	
		<h3> Click <a href='https://www.paypal.com/'>here </a> to go to PayPal site.</h3> <!--Change to live PayPal site for production-->
	</div>
</c:if>	
		