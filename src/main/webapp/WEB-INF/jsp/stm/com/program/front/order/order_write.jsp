<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">ORDER</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<c:if test="${!empty user.user_id}">
			<a href="/front/order/essay/insert.do"><img src="${img_src }/stm/btn/btn_writing.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="/front/order/revision/insert.do"><img src="${img_src }/stm/btn/btn_revision.png" width="255" height="74" alt="Revision" title="Revision" /></a>
			</c:if>
			<c:if test="${empty user.user_id}">
			<a href="javascript:void(0);" onclick="javascript:alert('Please log in first!');"><img src="${img_src }/stm/btn/btn_writing.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="javascript:void(0);" onclick="javascript:alert('Please log in first!');"><img src="${img_src }/stm/btn/btn_revision.png" width="255" height="74" alt="Revision" title="Revision" /></a>
			</c:if>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
</div>