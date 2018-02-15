<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnEditOrderEssay = function(){
		document.Form_essay.action = "/front/order/essay/insertEdit.do";
		document.Form_essay.submit();
	}
</script>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Essay Writing</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<a href="javascript:void(0);"><img src="${img_src }/stm/btn/btn_writing_orange.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="order_form_revision.php"><img src="${img_src }/stm/btn/btn_revision.png" width="255" height="74" alt="Revision" title="Revision" /></a>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
	<form:form name="Form_essay" commandName="orderEssayCommand" action="/front/order/essay/insert.do" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="category" value="<c:out value="${orderEssayCommand.category}" />" />
	<input type="hidden" name="no_pages" value="<c:out value="${orderEssayCommand.no_pages}" />" />
	<input type="hidden" name="level" value="<c:out value="${orderEssayCommand.level}" />" />		
	<input type="hidden" name="days" value="<c:out value="${orderEssayCommand.days}" />" />
	<input type="hidden" name="no_sources" value="<c:out value="${orderEssayCommand.no_sources}" />" />
	<input type="hidden" name="preferred_writer" value="<c:out value="${orderEssayCommand.preferred_writer}" />" />
	<input type="hidden" name="topic" value="<c:out value="${orderEssayCommand.topic}" />" />
	<input type="hidden" name="in_body" value="<c:out value="${orderEssayCommand.in_body}" />" />
	<input type="hidden" name="total_payment" value="<c:out value="${orderEssayCommand.total_payment}" />" />
	<input type="hidden" name="file" value="<c:out value="${orderEssayCommand.file }"/>" />
	<input type="hidden" name="file_upload" value="<c:out value="${orderEssayCommand.file_upload }"/>" />
	<input type="hidden" name="price" value="${price }" />
	<input type="hidden" name="read_material" value="<c:out value="${orderEssayCommand.read_material}" />" />
	<input type="hidden" name="materials_text" value="<c:out value="${materials_text }"/>" />
	<input type="hidden" name="format" value="<c:out value="${orderEssayCommand.format}" />" />
	<input type="hidden" name="deldate" value="<c:out value="${deldate }"/>" />
	<input type="hidden" name="end_date" value="<c:out value="${orderEssayCommand.end_date}" />" />
	<input type="hidden" name="user_id" value="<c:out value="${orderEssayCommand.user_id }" />" />
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Category</td>
			<td class="col3">${orderEssayCommand.category}</td>
			<td class="col1 third">Total Payment</td>
			<td class="col4"><strong class="txt-red">${orderEssayCommand.total_payment} $</strong></td>
		</tr>
		<tr>
			<td class="col1">Writing Format</td>
			<td class="col2" colspan="3">${orderEssayCommand.format}</td>
		</tr>
		<tr>
			<td class="col1">Level</td>
			<td class="col2" colspan="3">${orderEssayCommand.level }</td>
		</tr>
		<tr>
			<td class="col1">Deadline</td>
			<td class="col2" colspan="3">
				<span class="review-date">${orderEssayCommand.days } days&nbsp;&nbsp;-&nbsp;</span>
				<span class="deadline-date">${deldate }</span>
			</td>
		</tr>
		<tr>
			<td class="col1">Number of Pages</td>
			<td class="col2" colspan="3">${orderEssayCommand.no_pages} pages</td>
		</tr>
		<tr>
			<td class="col1">Reading Material</td>
			<td class="col2" colspan="3">${materials_text }</td>
		</tr>
		<tr>
			<td class="col1">Number of Sources</td>
			<td class="col2" colspan="3">${orderEssayCommand.no_sources }</td>
		</tr>
		<tr>
			<td class="col1">Preferred Writer</td>
			<td class="col2" colspan="3">${orderEssayCommand.preferred_writer }</td>
		</tr>
		<tr>
			<td class="col1">Topic</td>
			<td class="col2" colspan="3">${orderEssayCommand.topic }</td>
		</tr>
		<tr class="row-instructions">
			<td class="col1">Instructions</td>
			<td class="col2" colspan="3"><textarea rows="20" cols="10" id="writebody" readonly="readonly" name="body" class="txtarea">${orderEssayCommand.in_body }</textarea></td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3"><span class="file-list-name">${fn:replace(orderEssayCommand.file, ":", "</span><span class='file-list-name'>")}</span></td>
		</tr>
		
	</table>
	<span class="form-submit">
		<button type="button" onclick="fnEditOrderEssay();" class="btn"><img src="${img_src }/stm/btn/btn_edit.png" alt="edit" />&nbsp;&nbsp;
		<button type="submit" class="btn"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit" class="btn" /></button> 
	</span>
	
	</form:form>
	
</div>