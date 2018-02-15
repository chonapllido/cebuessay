<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>

<c:set var="temp_price" value="${price }" />

<option value="">None</option>
<c:if test="${has_free eq '1'}">
<option value="0" <c:if test="${selected == '0'}">selected="selected"</c:if>>0-${free_pages } pages (free)</option>
</c:if>

<c:forEach var="row" begin="${pages }" end="999" step="${pages }" varStatus="i">
	<option value="${temp_price}" <c:if test="${selected == '0'}">selected="selected"</c:if>>${row+1}-${row+pages} pages (${temp_price } US $)</option>
	<c:set var="temp_price" value="${temp_price + price }" />
</c:forEach>

