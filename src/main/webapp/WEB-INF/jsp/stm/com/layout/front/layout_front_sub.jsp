<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>CebuEssay</title>
<%@include file="../../sys/metalibs.jspf" %>
<%@include file="../../sys/csslibs.jspf" %>
<%@include file="../../sys/jslibs.jspf" %>

<body>
	<div id="wrapper">
		<!-- Header -->
		<tiles:insertAttribute name="header" />
		<!-- //Header -->
		<!-- Contents -->
		<div id="contents">
			<table cellpadding="0" cellspacing="0" width="100%" class="content-table">
				<tr>
					<td class="tbl-left-column">
						<!-- Left Contents -->
						<tiles:insertAttribute name="left" />
						<!-- //Left Contents -->
					</td>
					<td>
						<!-- Middle Contents -->
						<tiles:insertAttribute name="content" />
						<!-- //Middle Contents -->
					</td>
					<td class="tbl-right-column">
						<!-- Right Contents -->
						<tiles:insertAttribute name="right" />
					</td>
				</tr>
			</table>							
		</div>
		<!-- //Contents -->
		<!-- Footer -->
		<tiles:insertAttribute name="footer" />
	</div>
</body>
</html>

