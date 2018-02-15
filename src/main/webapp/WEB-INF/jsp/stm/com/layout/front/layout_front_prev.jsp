<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>PSD KITCHEN - <tiles:insertAttribute name="title" /></title>
<%@include file="../../sys/metalibs.jspf" %>
<%@include file="../../sys/csslibs.jspf" %>
<%@include file="../../sys/jslibs.jspf" %>
</head>

<body class="bg-on-footer">
<!-- header -->
	<div id="preview-header">
		<div class="wrapper">
			<div class="header-information">
				<div class="header-left">
					<div class="logo"><img src="${img_src }/stm/front/ko/logo_psd_kitchen.png" alt="PSD KITCHEN"/></div>				
					<div class="tab-holder">
						<span class="tab1"><span>${order.order_code }</span></span>
						<span class="tab2">HTML PREVIEW</span>
					</div>
				</div>
				<div class="header-right">
					<div class="pre-holder">
						<span class="tab3">JSP PREVIEW</span> 
						<span class="tab4">GO</span> 
					</div>
				</div>
			</div>
		</div>
	</div>
<!--//header -->
<!-- content -->
	<div id="preview-content">
		<div class="wrapper">
			<div class="prev-content-area">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
	</div>
<!--//content -->
<!-- footer -->
<div id="preview-footer">
	<div class="wrapper">
		<span class="copyright">Copyright (c) 2016 PSD KITCHEN All rights reserved.</span>
		
		<div class="bottom-links">
			<a href="#" class="top" id="back-to-top">&nbsp;</a>
		</div>
	</div>
</div>
<!--//footer -->
</body>
</body>
</html>