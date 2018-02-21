<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<%@ page import="java.util.Date" %>
<validator:javascript formName="orderEssayCommand" staticJavascript="false" xhtml="true" cdata="false"/>
<script src="${js_src}/stm/program/essay.js"></script>
<script type="text/javascript">
	
	doPreSubmit = function(f){
		return JSEssay.validateForm();
	}
	
</script>

<jsp:useBean id="current_date" class="java.util.Date" />
<c:set var="temp_price" value="${price}" />
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Essay Writing</h2>
			<span class="order-guide">Guidelines When Ordering an Essay:</span>
			<ul class="guide-list">
				<li>1. If category is Dissertion or Thesis, the customer should provide the quantitative and qualitative data.</li>
				<li>2. Saturday and Sunday are not included in the working days.</li>
				<li>3. <?php echo NOTE_CON; ?></li>
			</ul>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<div class="order-buttons-box">
		<span class="bg-left">&nbsp;</span>
		<div>
			<a href="javascript:void(0);"><img src="${img_src }/stm/btn/btn_writing_orange.png" width="258" height="76" alt="Writing" title="Writing" /></a>
			<a href="/front/order/revision/insert.do"><img src="${img_src }/stm/btn/btn_revision.png" width="255" height="74" alt="Revision" title="Revision" /></a>
		</div>
		<span class="bg-right">&nbsp;</span>
	</div>
	<form:form name="Form_essay" commandName="orderEssayCommand" action="/front/order/essay/review.do?${params }" method="post" enctype="multipart/form-data" onsubmit="return doSubmit(this, 'OrderEssayCommand')">
	<input type="hidden" name="total_payment" value="${total}" />
	<input type="hidden" name="price" value="" />
	<input type="hidden" name="session_lang" id="session_lang" value="EN" />
	<input type="hidden" name="materials_text" value="" />
	<input type="hidden" name="deldate" value="<fmt:formatDate pattern="MMM dd" value="${deadline}" /> 7pm (GMT + 9 Asian Time)"/>
	<input type="hidden" name="end_date" id="end_date" value="<fmt:formatDate pattern="yyyy-MM-dd H:m:s" value="${deadline}" />" />
	<input type="hidden" name="category_flag" value="1" />
	<input type="hidden" name="hasorder" value="${hasorder}" />
	<input type="hidden" name="default_price" value="${default_price}" />
	<input type="hidden" name="def_days" value="${default_days}" />
    <input type="hidden" name="user_price" value="${user.user_price }" />
    <input type="hidden" name="user_id" value="${user.user_id }" />
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Category</td>
			<td class="col3">
				<select name="category" id="category" class="ipt" onchange="JSEssay.updatePriceByCategory('<fmt:formatDate pattern="yyyy-MM-dd" value="${current_date}" />');" >
					<c:forEach var="category" items="${category_list.list}" varStatus="i">
					<option value="${category.title }" <c:if test="${orderEssayCommand.category == category.title}">selected="selected"</c:if>>${category.title}</option>
					</c:forEach> 
				</select> 	
			</td>
			<td class="col1 third">Total</td>
			<td class="col4"><span class="txt-total" id="total_text">
				<c:if test="${!empty orderEssayCommand.total_payment}"><fmt:formatNumber value="${orderEssayCommand.total_payment}" type="number"/> $</c:if>
				<c:if test="${empty orderEssayCommand.total_payment}"><fmt:formatNumber value="${total }" type="number"/> $</c:if>
			</span></td>
		</tr>
		<tr>
			<td class="col1">Writing Format</td>
			<td class="col2" colspan="3">
				<select class="ipt" name="format" id="format" onchange="JSEssay.enableSources(); JSEssay.calcTotal();">
					<option value="">None</option>
					<c:forEach var="format" items="${format_list.list}" varStatus="i">
					<option value="${format.title }" <c:if test="${orderEssayCommand.format == format.title}">selected="selected"</c:if>>${format.title}</option>
					</c:forEach> 
				</select>
				<span class="format-opt">
					<input type="checkbox" name="etcformatcheck" onclick="JSEssay.etcFormatOn();"/>
					<label>Etc:</label>
				</span>
				<input type="text" name="etc_format" id="etc_format"  value="" maxlength="50" class="ipt iptetc" disabled="disabled"/>
			</td>
		</tr>
		<tr>
			<td class="col1">Level</td>
			<td class="col2" colspan="3">
				<select name="level" id="level" class="ipt">
					<c:forEach var="level" items="${level_list.list}" varStatus="i">
					<option value="${level.title }" <c:if test="${orderEssayCommand.level == level.title}">selected="selected"</c:if>>${level.title}</option>
					</c:forEach> 
				</select>
			</td>
		</tr>
		<tr>
			<td class="col1">Deadline</td>
			<td class="col2" colspan="3">
				<select class="ipt" name="days" id="due" onchange="JSEssay.update_materials();JSEssay.set_date('<fmt:formatDate pattern="yyyy-MM-dd" value="${current_date}" />');JSEssay.checkPageByType();">
					<c:forEach var="i" begin="${min_days}" end="30">
					<option value="${i}" 
						<c:if test="${orderEssayCommand.days == i}">selected="selected"</c:if>
						<c:if test="${empty(orderEssayCommand.days) && i==10 }">selected="selected"</c:if>
					>${i*24} hrs (${i} days)</option>
					</c:forEach> 
				</select>
				<span id="del_date" class="deadline-date"><fmt:formatDate pattern="MMM dd" value="${deadline}" /> 7pm (GMT + 9 Asian Time)</span>
			</td>
		</tr>
		<tr>
			<td class="col1">Number of Pages</td>
			<td class="col2" colspan="3">
				<select class="ipt" name="no_pages" id="no_pages" onchange="JSEssay.calcTotal();">
					<c:forEach var="i" begin="1" end="${maxpage}">
						<option value="${i}" <c:if test="${orderEssayCommand.no_pages == i}">selected="selected"</c:if>>
							${i} page<c:if test="${i > 1}">s</c:if> (${words} words)
						</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="col1">Required Reading</td>
			<td class="col2" id="select_materials" colspan="3">
				<select class="ipt" name="read_material" id="reqread" onchange="JSEssay.calcTotal();" >
					<option value="">None</option>
					<c:if test="${has_free == '1'}">
					<option value="0" <c:if test="${orderEssayCommand.read_material == '0'}">selected="selected"</c:if>>0-${free_pages} pages (free)</option>
					</c:if>
					<c:forEach var="i" begin="${pages}" end="999" step="${pages}">
						<option value="${temp_price}" <c:if test="${orderEssayCommand.read_material == temp_price}">selected="selected"</c:if>>
						${i+1} - ${i+pages} pages (${temp_price} US $)
						</option>
						<c:set var="temp_price" value="${temp_price + price }" />
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="col1">Number of Sources</td>
			<td class="col2" colspan="3">
				<select name="no_sources" class="ipt" disabled="disabled">
					<c:forEach var="i" begin="0" end="20">
					<option value="${i}" <c:if test="${orderEssayCommand.no_sources == i}">selected="selected"</c:if>>
					${i}
					</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="col1">Preferred Writer</td>
			<td class="col2" colspan="3"><input type="text" name="preferred_writer" value="${orderEssayCommand.preferred_writer }" class="ipt" /></td>
		</tr>
		<tr>
			<td class="col1">Topic</td>
			<td class="col2" colspan="3"><input type="text" name="topic" value="${orderEssayCommand.topic }" class="ipt" /></td>
		</tr>
		<tr class="row-instructions">
			<td class="col1">Instructions</td>
			<td class="col2" colspan="3">
				<span class="lbl-instruct">Special Instructions <span>(Optional)</span></span>
				<textarea name="in_body" rows="10" cols="10" class="txtarea">${orderEssayCommand.in_body }</textarea>
			</td>
		</tr>
		<tr class="row-files">
			<td class="col1">Files</td>
			<td class="col2" colspan="3">
				<div class="file-box">
					<input type="file" name="upload[]" id="upload" value="Browse" class="multi" maxlength="10"/>
					<span class="file-note">You can select upto 10 files</span>
				</div>
			</td>
		</tr>
		<tr class="row-refund">
			<td class="col1">Refund Policy</td>
			<td class="col2" colspan="3">
				<span class="refund-msg">
				1. Double Refund for Plagiarism<br/>
				2. Free Unlimited Revision.<br/><br/>
				Note: The 2 cases above are the only things subject for refund. Please take time to read the essay and make us revise the essay if there are any mistakes since we might misinterpret the instruction or it is not following according to your school's standard.
				</span>
				<span class="refund-inputs">
					<input type="checkbox" id="chkplagiarism" name="chkplagiarism" value="1"/>
					<label for="chkplagiarism">Agree</label>
				</span>
			</td>
		</tr>
	</table>
	<span class="form-submit"><button type="submit" class="btn-preview"><img src="${img_src}/stm/btn/btn_preview.png" alt="preview"/></button></span>
	
	</form:form>
	
</div>