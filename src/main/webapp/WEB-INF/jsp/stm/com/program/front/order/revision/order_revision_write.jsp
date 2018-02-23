<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<script src="${js_src}/stm/program/revision.js"></script>
<script type="text/javascript">
	
	doPreSubmit = function(f){
		return JSRevision.validateForm();
	}
	
</script>
<jsp:useBean id="current_date" class="java.util.Date" />
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
	<form:form name="Form_revision" command="orderRevisionCommand" action="/front/order/revision/review.do" method="post" enctype="multipart/form-data" onsubmit="return doSubmit(this, 'OrderRevisionCommand')">
	<input type="hidden" name="total_payment" value="${orderRevisionCommand.total_payment }" />
	<input type="hidden" name="price" />
	<input type="hidden" name="no_pages" value=""/>
	<input type="hidden" name="session_lang" value="EN"/>
	<input type="hidden" name="total" value=""/>
	<input type="hidden" name="deldate" value="<fmt:formatDate pattern="MMM dd" value="${deadline }" /> 7pm (GMT +9 Asian Time)"/>
	<input type="hidden" name="end_date" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${deadline }" />" />
	<input type="hidden" name="rate" value="${prices }" />
	<input type="hidden" name="hasorder" value="${hasorder}" />
	<input type="hidden" name="user_id" value="${user.user_id }" />
	<input type="hidden" name="deldaterev" value="<fmt:formatDate pattern="MMM dd" value="${deadline }" /> 7pm (GMT +9 Asian Time)" />
	<table cellpadding="0" cellspacing="0" border="0" class="tbl-order-form">
		<tr>
			<td class="col1">Topic</td>
			<td class="col3"><input type="text" name="topic" id="topic" maxlength="100" value="${orderRevisionCommand.topic }" class="ipt" /></td>
			<td class="col1 third">Total Payment</td>
			<td class="col4">
				<span class="txt-total" id="total_text">
				${orderRevisionCommand.total_payment } $
				</span>
			</td>
		</tr>
		<tr>
			<td class="col1">Level</td>
			<td class="col2" colspan="3">
				<select name="level" id="level" class="ipt">
					<c:forEach var="level" items="${level_list.list}" varStatus="i">
					<option value="${level.title }" <c:if test="${orderRevisionCommand.level == level.title}">selected="selected"</c:if>>${level.title}</option>
					</c:forEach> 
				</select>
			</td>
		</tr>
		<tr>
			<td class="col1">Deadline</td>
			<td class="col2" colspan="3">
				<select name="days" onchange="JSRevision.calcTotal(); JSRevision.set_date('<fmt:formatDate pattern="yyyy-MM-dd" value="${current_date}" />');" class="ipt">
					<c:forEach var="i" begin="${min_days}" end="30">
					<option value="${i}" 
						<c:if test="${orderRevisionCommand.days == i}">selected="selected"</c:if>
						<c:if test="${empty(orderRevisionCommand.days) && i==5 }">selected="selected"</c:if>
					>${i*24} hrs (${i} days)</option>
					</c:forEach> 
				</select>
				<span id="del_date_rev" class="deadline-date"><fmt:formatDate pattern="MMM dd" value="${deadline }" /> 7pm (GMT +9 Asian Time)</span>
			</td>
		</tr>
		
		<tr class="row-instructions">
			<td class="col1">Type or paste the file content that needs to be revised</td>
			<td class="col2" colspan="3">
				<textarea name="content" rows="10" cols="10" class="txtarea"><c:out value="${content }" /></textarea>
				<span class="revision-count-words">
					<button type="button" onclick="JSRevision.countWords('${words}');" class="btn-img"><img src="${img_src }/stm/btn/btn_count_words.png" id="btn_countWords" width="108" height="20" alt="count words" /></button>
					<span style="float: left;">No of Words:</span>
					<input type="text" name="no_words" id="no_words" value="${no_words }" onkeydown="return trapEnter(event, 'JSRevision.validateForm()');" class="ipt"/>
					<span>(${words} words is 1 page payment)<?php } ?></span>
				</span>
			</td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3">
				<input type="file" name="upload" id="upload" value="Browse" />
				<span class="file-names">&nbsp;</span>
			</td>
		</tr>
	</table>
	<span class="form-submit"><button type="submit" class="btn-img"><img src="${img_src }/stm/btn/btn_preview.png" alt="preview" /></button></span>
	
	</form:form>
</div>