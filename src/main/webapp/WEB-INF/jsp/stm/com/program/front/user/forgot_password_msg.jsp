<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Password Retrieval</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<span class="pwd-error">
		<c:if test="${found eq 'yes' }">
			Your password has been sent to your email address!<br>Please check it!
		</c:if>
		<c:if test="${found eq 'no'}">
		This email address is not in our database! Try to check the spelling!
		</c:if>
		</span>
	</span>
	
	</span>
</div>
						