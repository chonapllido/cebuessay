<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>

<!-- Thesis or Dissertation 
	 default deadline is 15 days 
-->

<c:if test="${category_type eq 2}">
	<c:forEach var="i" begin="15" end="40">
	<option value="${i}" <c:if test="${i eq 15}">selected=selected</c:if>>${i * 24} hrs (${i} days)</option>
	</c:forEach> 
</c:if>
<!-- Ordinary Category
	 default deadline is 10 days -->

<c:if test="${category_type eq 1}">
	<c:forEach var="i" begin="${min_days}" end="30">
	<option value="${i}" <c:if test="${i eq 10}">selected="selected"</c:if>>${i * 24} hrs (${i} days)</option>
	</c:forEach>
</c:if>
