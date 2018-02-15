<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>

<div class="admin-header">
	<div class="header-top">
		<h1>Administrator Panel</h1>
		<a href="javascript:void(0);" onclick="javascript:self.close();"><img src="${img_src }/stm/btn/btn_admin_close.png" width="48" height="48" alt="close" /></a>
	</div>
	<div class="menu">
		<ul>
			<li><a href="/back/user/officers/list.do" <c:if test="${fn:contains(url,'/user/officers/list.do')}">class="on"</c:if>>Officers</a></li>
			<li class="divider">|</li>
			<li><a href="/back/user/list.do" <c:if test="${fn:contains(url,'/user/list.do')}">class="on"</c:if>>Users</a></li>
			<li class="divider">|</li>
			<li><a href="/back/order/list.do" <c:if test="${fn:contains(url,'/order/list.do')}">class="on"</c:if>>Order Management</a></li>
			<li class="divider">|</li>
			<li><a href="/back/order/complete/list.do" <c:if test="${fn:contains(url,'/order/complete/list.do')}">class="on"</c:if>>Completed Orders</a></li>
			<li class="divider">|</li>
			<li><a href="/back/order/unconfirmed/list.do" <c:if test="${fn:contains(url,'/order/unconfirmed/list.do')}">class="on"</c:if>>Unconfirmed Orders</a></li>
			<li class="divider">|</li>
			<li><a href="/back/user/writers/payment.do" <c:if test="${fn:contains(url,'/writer/payment.do')}">class="on"</c:if>>Writer's Payment</a></li>
			<li class="divider">|</li>
			<li><a href="/back/sales/figure.do" <c:if test="${fn:contains(url,'/sales/figure.do')}">class="on"</c:if>>Sales Figure</a></li>
			
		</ul>
		<ul class="nob">
			<li><a href="/back/sales/graph.do" <c:if test="${fn:contains(url,'/sales/graph.do')}">class="on"</c:if>>Sales Graph</a></li>
			<li class="divider">|</li>
			<li><a href="/back/sentmail/listadd.do" <c:if test="${fn:contains(url,'/user/email.do')}">class="on"</c:if>>Email</a></li>
			<li class="divider">|</li>
			<li><a href="/back/user/register/figure.do" <c:if test="${fn:contains(url,'/user/list_figure.do')}">class="on"</c:if>>Registration Figure</a></li>
			<li class="divider">|</li>
			<li><a href="/back/user/register/graph.do" <c:if test="${fn:contains(url,'/user/list_graph.do')}">class="on"</c:if>>Registration Graph</a></li>
			<li class="divider">|</li>
			<li><a href="/back/sentmail/list.do" <c:if test="${fn:contains(url,'/sentmail/list.do') || fn:contains(url, '/sentmail/view.do')}">class="on"</c:if>>Sent Items</a></li>
			<li class="divider">|</li>
			<li><a href="/back/prices/list.do" <c:if test="${fn:contains(url,'/price/manage.do')}">class="on"</c:if>>Price Management</a></li>
			<li class="divider">|</li>
			<li><a href="/back/user/virtualmoney.do" <c:if test="${fn:contains(url,'/user/virtualmoney.do')}">class="on"</c:if>>Virtual Money</a></li>
		</ul>
	</div>
</div>