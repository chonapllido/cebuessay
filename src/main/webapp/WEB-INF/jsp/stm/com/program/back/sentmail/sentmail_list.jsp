<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnDownload = function(file){
		var f = document.Form_list;
		f.file.value = file;
	
		f.action = "/back/sentmail/downloadAttach.do";
		f.submit();
	}
	
	fnDeleteList = function(){
		var checked = $('#Form_list').find('input:checkbox:checked').length;
		
		if(confirm("Are you sure you want to delete?")){
			if(checked == 0){
				alert("Please select at least 1 item to delete!")
				return false;
			} else {
				document.Form_list.submit();
			}
		}
	}
</script>
<div class="admin-contents">
	<h2 class="content-title">Sent Emails</h2>
	<form:form name="Form_list" id="Form_list" action="deleteList.do?${params }" method="post" >
	<input type="hidden" name="file" value="" />
	<table class="tbl-admin">
		<colgroup>
			<col width="3%" />
			<col width="7%" />
			<col width="18%" />
			<col width="18%" />
			<col width="30%" />
			<col width="8%" />
			<col width="16%" />
		</colgroup>
		<thead>
			<tr>
				<th>&nbsp;</th>
				<th>No</th>
				<th>User Email</th>
				<th>Name</th>
				<th>Subject</th>
				<th>Date</th>
				<th class="last">Attachment</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(cmd.list) gt 0}">
		<c:forEach var="row" items="${cmd.list }" varStatus="i">
		<tr>
			<td><input type="checkbox" name="id_checks" value="${row.item_id }"/></td>
			<td>${i.index+1 }</td>
			<td>${row.email }</td>
			<td>${row.name }</td>
			<td><a href="view.do?item_id=${row.item_id }">${row.subject }</a></td>
			<td>${row.date }</td>
			<td>
				<c:if test="${!empty row.attachment }">
				<a href="javascript:void(0)" onclick="fnDownload('<c:out value="${row.attachment}" />')">${row.attachment }</a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(cmd.list) lt 1}">
		<tr>
			<td colspan="6">No Records Found!</td>
		</tr>
		</c:if>
		</tbody>
	</table>
	<div class="admin-paging">
		<stmfn:paging1 />
		<c:if test="${(cmd.total_record_count / cmd.record_count_per_page) > 1 }">
		<span class="admin-gopage">
			<label for="gotopage">Go to Page:</label>
			<input type="text" name="page_no" id="page_no" value="" />
				<button type="button" onclick="goToPage('Form_list');">GO</button>
		</span>
		</c:if>
	</div>
	<div class="admin-bottom-btns">
		<button type="button" onclick="fnDeleteList()" class="admin-btn">DELETE</button>
	</div>
	</form:form>
	<form:form name="Form_search" action="${url}?${params}" method="post">
	<input type="hidden" name="search_field" value="email" />
	<div class="admin-search-bottom">
		<label for="search_txt">Email Address:</label>
		<input type="text" name="search_keyword" alt="search" value="${cmd.search_keyword }" />
		<button type="submit" class="admin-btn">SEARCH</button>
	</div>
	</form:form>
</div>