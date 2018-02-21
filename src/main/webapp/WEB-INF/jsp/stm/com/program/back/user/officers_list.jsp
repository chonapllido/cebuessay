<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnDeleteOfficer = function(id){
		if(confirm("Are you sure you want to delete this officer?")){
			document.Form_list.user_id.value = id;
			document.Form_list.submit();
		}
	}
</script>
<div class="admin-contents">
	<h2 class="content-title">Officers List</h2>
	<form:form name="Form_list" action="delete.do" method="post">
	<input type="hidden" name="user_id" value="" />
	<table class="tbl-admin">
		<colgroup>
			<col width="8%"/>
			<col width="22%"/>
			<col width="20%"/>
			<col width="7"/>
			<col width="17%"/>
			<col width="8%"/>
			<col width="9%"/>
			<col width="9%"/>
		</colgroup>
		<thead>
			<tr>
				<th>No</th>
				<th>User Email</th>
				<th>Name</th>
				<th>Gender</th>
				<th>Contact Number</th>
				<th>Position</th>
				<th>Date</th>
				<th class="last">&nbsp;</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(cmd.list) gt 0 }">
		<c:forEach var="row" items="${cmd.list }" varStatus="i">
		<c:set var="idx" value="${(i.index + 1)}" />
		<tr<c:if test="${i.index % 2 eq 0}"> class="even"</c:if>>
			<td>${idx }</td>
			<td>${row.email }</td>
			<td>${row.name }</td>
			<td>${row.gender }</td>
			<td>${row.telephone }</td>
			<td>${row.position_id }</td>
			<td>${row.date }</td>
			<td>
				<a href="update.do?user_id=${row.user_id }"><img src="${img_src }/stm/btn/btn_edit_admin.png" alt="edit" /></a>&nbsp;&nbsp;
				<button type="button" class="btn-img" onclick="fnDeleteOfficer('${row.user_id }')"><img src="${img_src }/stm/btn/btn_blacklist.png" alt="delete" /></a></button>
			</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(cmd.list) lt 1 }">
		<tr>
			<td colspan="9">No Records Found!</td>
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
	</form:form>
	<div class="admin-bottom-btns">
		<a href="insert.do" class="admin-btn">ADD OFFICER</a>
	</div>
	<form:form name="Form_manage_search" action="${url }?${params }" method="post">
	<div class="admin-search-bottom">
		<select name="search_field">
			<option value="email">Email Address</option>
		</select>
		<input type="text" name="search_keyword" title="search" value="${cmd.search_keyword }"/>
		<button type="submit" id="btn_search" class="admin-btn">SEARCH</a>
	</div>
	</form:form>
	<input type="hidden" name="delete_id" value="" />
	<input type="hidden" name="officer_id" value=""  />
	</form>
	<div class="legend-box">
		<strong class="legend-title">Legend</strong>
		<ul>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_edit_admin.png" alt="edit" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Edit Officer</span>
			</li>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_blacklist.png" alt="delete" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Delete Officer</span>
			</li>
		</ul>
	</div>
</div>