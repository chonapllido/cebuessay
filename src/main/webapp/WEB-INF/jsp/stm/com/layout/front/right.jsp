<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>
<%@ page import="stm.com.support.util.ApplicationHelper" %>
<%@ page import="stm.com.program.ordcomplete.web.OrderCompleteCommand" %>
<%@ page import="stm.com.program.ordcomplete.service.OrderCompleteService" %>
<%
	OrderCompleteCommand cmd = new OrderCompleteCommand();
	OrderCompleteService service = (OrderCompleteService) ApplicationHelper.getService("ordercompleteService", request.getSession().getServletContext());
	
	OrderCompleteCommand order_cmd = service.getList(cmd, request, response);
	request.setAttribute("total_orders", order_cmd.getTotal_record_count());

%>
<script type="text/javascript">
$(function(){
	$('#glowing').rainbow();
});
</script>
<div class="content-right">
	<span class="bg-shadow">&nbsp;</span>
	<div class="side-section">
		<div class="side-section-title"><h5>TOTAL ORDERS</h5></div>
		<span class="total-figure" id="glowing">${total_orders} essays</span>
	</div>
	<div class="side-section">
		<div class="ads" id="ads">
			<span class="first"><big>FREE</big> One Page</span>
			<span class="second">for New Customer!</span> 
		</div>
	</div>
	<div class="side-section">
		<div class="tutorial-box">
			<a href="/front/user/tutorial.do" id="tutorial-order" target="_blank">Tutorial for Ordering</a>
		</div>
	</div>
	<div class="side-section">
		<div class="side-section-title"><h5>Online Support</h5></div>
		<span class="online-support">
			<script type="text/javascript" src="http://www.skypeassets.com/i/scom/js/skype-uri.js"></script>
			<div id="SkypeButton_Chat_cebuessay_1">
			  <script type="text/javascript">
			   Skype.ui({
			     "name": "chat",
			     "element": "SkypeButton_Chat_cebuessay_1",
			     "participants": ["cebuessay"],
			     "imageSize": 32
			   });
			 </script>
			</div>
		</span>
	</div>
	<div class="side-section">
		<div class="side-section-title"><h5>Get a Quote</h5></div>
		<a href="prices.do" class="btn-quote"><img src="${img_src}/stm/img_quote.jpg" width="163" height="88" alt="get a quote" title="get a quote" /></a>
	</div>
	<div class="side-section">
		<div class="side-section-title"><h5>Our Goals are</h5></div>
		<ul class="focus-list">
			<li>* Excellent Quality Paper</li>
			<li>* Free from Plagiarism Essay</li>
			<li>* On Time Delivery of Work</li>
			<li>* Following the Instructions</li>
			<li>* Gain Trust from Customers</li>
			<li>* Earn Loyalty from Students</li>
		</ul>
		<big class="focus-slogan">WE EXTREMELY VALUE<br />YOUR TRUST <br />AND LOYALTY</big>
	</div>
	<div class="side-section">
		<div class="side-section-title"><h5>How to Pay</h5></div>
		<img src="${img_src}/stm/img_paypal_jpg.jpg" width="151" height="158" title="paypal" class="img-paypal"/>
		<a href="/front/paypal/paynow.do" class="btn-paynow"><img src="${img_src}/stm/btn/btn_paypal.png" width="162" height="45" alt="pay now" title="paynow" /></a>
	</div>
</div>