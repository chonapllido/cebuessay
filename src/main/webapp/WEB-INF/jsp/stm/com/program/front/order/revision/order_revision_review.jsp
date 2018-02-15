<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<script src="${js_src}/stm/program/revision.js"></script>
<script type="text/javascript">
	fnEditOrderRevision = function(){
		document.Form_revision.action = "/front/order/revision/insertEdit.do";
		document.Form_revision.submit();
	}
</script>
<!-- Middle Contents -->
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Revision</h2>
			<span class="order-guide">Guidelines When Ordering a Revision:</span>
			<ul class="guide-list">
				<li>1. Failure to pay within 12 hours will automatically result to cancellation.</li>
			</ul>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<a href="/front/order/essay/insert.do"><img src="${img_src }/stm/btn/btn_writing.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="javascript:void(0);"><img src="${img_src }/stm/btn/btn_revision_orange.png" width="255" height="74" alt="Revision" title="Revision" /></a>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
	<form:form name="Form_revision" commandName="orderRevisionCommand" action="/front/order/revision/insert.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="topic" value="<c:out value="${orderRevisionCommand.topic }" />"/>
	<input type="hidden" name="days" value="<c:out value="${orderRevisionCommand.days }" />"/>
	<input type="hidden" name="level" value="<c:out value="${orderRevisionCommand.level }" />"/>											
	<input type="hidden" name="content" value="<c:out value="${content }" />" />
	<input type="hidden" name="no_pages" value="<c:out value="${orderRevisionCommand.no_pages }" />"/>
	<input type="hidden" name="total_payment" value="<c:out value="${orderRevisionCommand.total_payment }" />"/>
	<input type="hidden" name="file_upload" value="<c:out value="${orderRevisionCommand.file_upload }" />"/>
	<input type="hidden" name="file_upload_tmp" value="<c:out value="${orderRevisionCommand.file_upload_tmp }" />"/>
	<input type="hidden" name="end_date" value="<c:out value="${orderRevisionCommand.end_date }" />" />
	<input type="hidden" name="no_words" value="${no_words }" />
	<input type="hidden" name="user_id" value="${user.user_id }" />
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Topic</td>
			<td class="col3"><c:out value="${orderRevisionCommand.topic }" /></td>
			<td class="col1 third">Total Payment</td>
			<td class="col4"><strong class="txt-red"><c:out value="${orderRevisionCommand.total_payment }" /> $</strong></td>
		</tr>
		<tr>
			<td class="col1">Level</td>
			<td class="col2" colspan="3"><c:out value="${orderRevisionCommand.level }" /></td>
		</tr>
		<tr>
			<td class="col1">Deadline</td>
			<td class="col2" colspan="3">
				<span class="review-date">${orderRevisionCommand.days } days&nbsp;&nbsp;-&nbsp;&nbsp;</span>
				<span class="deadline-date" id="del_date_rev">${deldate }</span>
			</td>
		</tr>
		
		<tr class="row-instructions">
			<td class="col1">Contents that need to be revised</td>
			<td class="col2" colspan="3">
				<textarea name="content" id="pasteinfo" rows="10" cols="10" class="txtarea" readonly="readonly"><c:out value="${content }" /></textarea>
			</td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3">${orderRevisionCommand.file_upload}</td>
		</tr>
	</table>
	<span class="form-submit">
		<button type="button" onclick="fnEditOrderRevision()" class="btn-img"><img src="${img_src }/stm/btn/btn_edit.png" alt="edit" /></button>
		<button type="submit" class="btn-img"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit" /></button> 
	</span>
	
	</form:form>
</div>