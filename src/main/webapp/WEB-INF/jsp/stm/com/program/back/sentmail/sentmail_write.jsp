<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnCheckAll = function(el){
		var checked = ($(el).prop("checked")) ? true : false;
		
		$("#Form_list tbody").find("input[type=checkbox]").each(function(){
			$(this).prop("checked", checked);
		});
		
	}
	
	fnDoSearch = function(){
		document.Form_list.action = "/back/sentmail/listadd.do";
		document.Form_list.submit();
	}
	fnDoMailSubmit = function(){
		var form = document.Form_list,
			subject = form.subject,
			content = form.content,
			len = $('#Form_list tbody').find('input[type=checkbox]:checked').length;

		if( len < 1){
			alert("Please select at least 1 email!");
			return false;
		}
		if(subject.value == ""){
			alert("Please enter the subject!");
			subject.focus();
			return false;
		}
		
		if(content.value == ""){
			alert("Please enter the content!");
			content.focus();
			return false;
		}
		
		form.submit();
	}
</script>
<div class="admin-contents">
	<h2 class="content-title">Users List</h2>
	<form:form name="Form_list" id="Form_list" method="post" action="insertList.do" enctype="multipart/form-data">
		<div class="box-tbl-email">
			<table class="tbl-admin">
				<colgroup>
					<col width="7%" />
					<col width="7%" />
					<col width="22%" />
					<col width="20%" />
					<col width="7" />
					<col width="15%" />
					<col width="12%" />
					<col width="9%" />
				</colgroup>
				<thead>
					<tr>
						<th><input name="id_checks" type="checkbox" onclick="fnCheckAll(this);" /></th>
						<th>No</th>
						<th>User Email</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Contact Number</th>
						<th>Country</th>
						<th class="last">Date</th>
					</tr>		
				</thead>		
				<tbody>
				<c:if test="${fn:length(users.list) gt 0 }">
				<c:forEach var="row" items="${users.list }" varStatus="i">
					<tr>
						<td>
							<input type="hidden" name="ids" value="${row.email }" />
							<input type="checkbox" name="id_checks" value="${row.email }" />
						</td>
						<td>${i.index+1 }</td>
						<td>${row.email }</td>
						<td>${row.name }</td>
						<td>${row.gender }</td>
						<td>${row.telephone }</td>
						<td>${row.country }</td>
						<td>${row.date }</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${fn:length(users.list) lt 1 }">
					<tr><td colspan="8">No Records Found!</td></tr>
				</c:if>
				</tbody>
			</table>
		</div>
		<input type="hidden" name="search_field" value="email" />
		<div class="admin-search-bottom">
			<label for="search_txt">Email Address:</label>
			<input type="text" name="search_keyword" alt="search" value="${users.search_keyword }" />
			<button type="button" onclick="fnDoSearch();" class="admin-btn">SEARCH</button>
		</div>
		<table class="tbl-order-form">
			<tr>
				<td class="col1">Subject</td>
				<td class="col2"><input type="text" name="subject" class="ipt"/></td>
			</tr>
			<tr class="row-instructions">
				<td class="col1">Body</td>
				<td class="col2"><textarea name="content" rows="10" cols="10" class="txtarea"></textarea></td>
			</tr>
			<tr>
				<td class="col1">Attachment</td>
				<td class="col2"><input type="file" name="file" value="Browse" /></td>
			</tr>
		</table> 
		<span class="form-submit">
			<button type="button" onclick="fnDoMailSubmit()" class="btn-img"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit" /></button>
		</span>
		
	</form:form>
	<span class="admin_spacer">&nbsp;</span>
</div>