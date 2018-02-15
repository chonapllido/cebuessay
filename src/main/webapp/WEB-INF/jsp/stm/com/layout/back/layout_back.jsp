<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>CebuEssay</title>
<%@include file="../../sys/metalibs.jspf" %>
<%@include file="../../sys/csslibs_back.jspf" %>
<%@include file="../../sys/jslibs_back.jspf" %>
</head>
<body>
	<div id="admin-wrapper">
		<!-- Header -->
		<tiles:insertAttribute name="header" />
		<!-- //Header -->
		<tiles:insertAttribute name="content" />
	</div>

</body>
</html>