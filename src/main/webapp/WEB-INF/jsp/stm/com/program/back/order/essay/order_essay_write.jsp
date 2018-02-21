<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../sys/setCodes.jspf"%>
<validator:javascript formName="orderEssayCommand" staticJavascript="false" xhtml="true" cdata="false"/>
<script src="${js_src}/stm/program/essay.js"></script>
<script type="text/javascript">
	
	doPreSubmit = function(f){
		return JSEssay.validateForm();
	}
	
</script>

<jsp:useBean id="current_date" class="java.util.Date" />
<c:set var="temp_price" value="${price}" />

<div class="admin-contents">
	<h2 class="content-title">Order Management</h2>
	<h3 class="orderno-title">Order No: ${orderEssayCommand.order_id }</h3>
	<form:form name="Form_essay" commandName="orderEssayCommand" action="${url}?${params}" method="post" enctype="multipart/form-data" onsubmit="return doSubmit(this, 'OrderEssayCommand')">
		<input type="hidden" name="total_payment" id="total_payment" value="${orderEssayCommand.total_payment }" />
		<input type="hidden" name="price" id="price" value="0" />
		<input type="hidden" name="session_lang" id="session_lang" value="EN" />
		<input type="hidden" name="essay_id" id="essay_id" value="${orderEssayCommand.essay_id }" />
		<input type="hidden" name="order_id" id="order_id" value="${orderEssayCommand.order_id }" />
		<input type="hidden" name="deldate" id="deldate" value=" value="<fmt:formatDate pattern="MMM dd" value="${deadline}" /> 7pm (GMT + 9 Asian Time)"/>
		<input type="hidden" name="end_date" id="end_date" value="${orderEssayCommand.end_date }" />
		<input type="hidden" name="materials_text" id="materials_text" value="" />
		<input type="hidden" name="dbfile" id="dbfile" value="${orderEssayCommand.file }" />
		<input type="hidden" name="category_flag" value="1" />
		<input type="hidden" name="hasorder" value="${hasorder}" />
		<input type="hidden" name="default_price" value="${default_price}" />
		<input type="hidden" name="def_days" value="${default_days}" />
        <input type="hidden" name="user_price" value="${user.user_price }" />
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
				<td class="col1 third">Total Payment</td>
				<td class="col2"><span class="txt-total" id="total_text">${orderEssayCommand.total_payment} $</span></td>
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
					<select class="ipt" name="days" id="due" onchange="JSEssay.update_materials();JSEssay.set_date('${fn:substring(orderEssayCommand.start_date,0,10)}');JSEssay.checkPageByType();">
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
					<c:set var="start" value="${fn:indexOf(orderEssayCommand.read_material, 'pages (')}" />
					<c:set var="end" value="${fn:indexOf(orderEssayCommand.read_material, ' US')}" />
					<c:set var="read_material" value="${fn:substring(orderEssayCommand.read_material, start+7, end)}" />
					<c:set var="temp_price_str" value="${fn:trim(temp_price + '') }" />
					<select class="ipt" name="read_material" id="reqread" onchange="JSEssay.calcTotal();" >
						<option value="">None</option>
						<c:if test="${has_free == '1'}">
						<option value="0" <c:if test="${orderEssayCommand.read_material eq '0-50 pages (free)'}">selected="selected"</c:if>>0-${free_pages} pages (free)</option>
						</c:if>
						<c:forEach var="i" begin="${pages}" end="999" step="${pages}">
							<option value="${temp_price}" <c:if test="${read_material eq temp_price_str}">selected="selected"</c:if>>
							${i+1} - (${i+pages}) pages (${temp_price} US $)
							</option>
							<c:set var="temp_price" value="${temp_price + price }" />
							<c:set var="temp_price_str" value="${fn:trim(temp_price+'') }" />
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
				<td class="col2" colspan="3"><input type="text" name="preferred_writer" id="preferred_writer" value="${orderEssayCommand.preferred_writer }" class="ipt" /></td>
			</tr>
			<tr>
				<td class="col1">Topic</td>
				<td class="col2" colspan="3"><input type="text" name="topic" id="topic" value="<c:out value='${orderEssayCommand.topic }' />" class="ipt" /></td>
			</tr>
			<tr class="row-instructions">
				<td class="col1">Instructions</td>
				<td class="col2" colspan="3">
					<span class="lbl-instruct">Special Instructions <span>(Optional)</span></span>
					<textarea name="in_body" rows="10" cols="10" class="txtarea"><c:out value="${orderEssayCommand.in_body }" /></textarea>
				</td>
			</tr>
			<tr class="row-files">
				<td class="col1">Files</td>
				<td class="col2" colspan="3">
					<div class="file-box">
						<input type="file" name="upload[]" id="upload" value="Browse" class="multi" maxlength="10"/>
						<span class="file-note">You can select up to 10 files</span>
					</div>
				</td>
			</tr>
		</table>
		<span class="order-form-note"><strong>Note:</strong> Failure to pay within 12 hours will automatically result to cancellation.</span>
		<span class="form-submit"><button type="submit" class="btn-img"><input type="image" src="${img_src}/stm/btn/btn_submit.png" alt="submit" /></button></span>
		</form:form>
	<div class="admin_spacer">&nbsp;</div>
</div>