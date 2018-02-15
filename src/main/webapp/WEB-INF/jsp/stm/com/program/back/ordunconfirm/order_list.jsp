<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<script type="text/javascript">
fnDeleteList = function(){
	var checked = $('#Form_list').find('input:checkbox:checked').length;
	
	if(confirm("Are you sure you want to delete the order/s?")){
		if(checked == 0){
			alert("Please select at least 1 order to delete!")
			return false;
		} else {
			document.Form_list.submit();
		}
	}
}

fnUpdateList = function(){
	var checked = $('#Form_list').find('input:checkbox:checked').length;
	
	if(confirm("Are you sure you want to move the order/s?")){
		if(checked == 0){
			alert("Please select at least 1 order to move!")
			return false;
		} else {
			document.Form_list.status.value = 2;
			document.Form_list.action = 'updateList.do?<c:out value="${param}" />';
			document.Form_list.submit();
		}
	}
}

</script>
<div class="admin-contents">
	<h2 class="content-title">Cancelled Orders List</h2>
	<form:form name="Form_list" id="Form_list" method="post" action="deleteList.do?${param }">
	<input type="hidden" name="status" value="" />
	<table class="tbl-admin">
		<colgroup>
			<col width="5%" />
			<col width="7%" />
			<col width="9%" />
			<col width="20%" />
			<col width="16" />
			<col width="9%" />
			<col width="9%" />
			<col width="9%" />
			<col width="8%" />
			<col width="8%" />
		</colgroup>
		<thead>
			<tr>
				<th>&nbsp;</th>
				<th>No</th>
				<th>Order No</th>
				<th>User Email</th>
				<th>Name</th>
				<th>Type</th>
				<th>Date</th>
				<th>Deadline</th>
				<th>Price</th>
				<th class="last">Info</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(cmd.list) gt 0 }">
		<c:forEach var="row" items="${cmd.list}" varStatus="i">
		<c:set var="idx" value="${(i.index + 1)}" />
		<tr<c:if test="${i.index % 2 eq 0}"> class="even"</c:if>>
			<td>
				<input type="hidden" name="ids" value="${row.order_id }" />
				<input type="checkbox" name="id_checks" value="${row.order_id }" />
			</td>
			<td>${idx }</td>
			<td>${row.order_id }</td>
			<td>${row.user_email }</td>
			<td>${row.user_name }</td>
			<td>
				<c:if test="${row.type_id eq 1 }">Essay</c:if>
				<c:if test="${row.type_id ne 1 }">Revision</c:if>
			</td>
			<td>${row.date }</td>
			<td>${row.end_date }</td>
			<td>${row.total_payment }$</td>
			<td>
				<c:if test="${row.type_id eq '1' }">
					<a href="/back/order/essay/view.do?order_id=${row.order_id }">
				</c:if>
				<c:if test="${row.type_id eq '2' }">
					<a href="/back/order/revision/view.do?order_id=${row.order_id }">
				</c:if>
				<img src="${img_src }/stm/btn/btn_info.png" alt="information" />
				</a>
			</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(cmd.list) lt 1 }">
		<tr>
			<td colspan="10">No Records Found!</td>
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
		<button type="button" onclick="fnDeleteList()" class="admin-btn">DELETE</button>
		<button type="button" onclick="fnUpdateList()" class="admin-btn">MOVE TO ORDER</button>
	</div>
	<form:form name="Form_manage_search" action="/back/order/unconfirmed/list.do?${param }" method="post">
	<div class="admin-search-bottom">
		<select name="search_field">
			<option value="email" <c:if test="${cmd.search_field eq 'email' }">selected="selected"</c:if>>Email Address</option>
			<option value="order_id" <c:if test="${cmd.search_field eq 'order_id' }">selected="selected"</c:if>>Order ID</option>
		</select>
		<input type="text" name="search_keyword" title="search" value="${cmd.search_keyword }"/>
		<button type="submit" id="btn_search" class="admin-btn">SEARCH</a>
	</div>
	</form:form>
	<div class="legend-box">
		<strong class="legend-title">Legend</strong>
		<ul>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_info.png" alt="information" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Information button. Click to view order details.</span>
			</li>
		</ul>
	</div>
</div>