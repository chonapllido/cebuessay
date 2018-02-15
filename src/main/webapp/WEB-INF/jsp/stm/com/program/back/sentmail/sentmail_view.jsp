<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<div class="admin-contents">
	<h2 class="content-title">Sent Email Details</h2>
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Subject</td>
			<td class="col2">${cmd.subject }</td>
		</tr>
		<tr class="row-instructions">
			<td class="col1">Body</td>
			<td class="col2">${cmd.content }</td>
		</tr>
		<tr>
			<td class="col1">Attachment</td>
			<td class="col2">${cmd.attachment }</td>
		</tr>
	</table>
	<div class="form-submit">
		<a href="list.do"><img src="${img_src }/stm/btn/btn_close.png" alt="close" /></a>
	</div>
</div>