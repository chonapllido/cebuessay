<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnFilter = function(){
		var f = document.Form_list;
		var price = document.getElementById("filter_price").value;

		if(price != ""){
			f.user_price.value = price;
		}
		
		f.action = "/back/user/list.do";
		f.submit();
	}
	
	fnSortByOrder = function(){
		var f = document.Form_list;
		
		f.user_total_order.value = 1;
		f.action = "/back/user/list.do";
		f.submit();
	}
	
	fnDeleteList = function(){
		var checked = $('#Form_list').find('input:checkbox:checked').length;
		
		if(confirm("Are you sure you want to delete the user/s?")){
			if(checked == 0){
				alert("Please select at least 1 user to delete!")
				return false;
			} else {
				document.Form_list.submit();
			}
		}
	}
	
	fnUpdateList = function(price){
		var checked = $('#Form_list').find('input:checkbox:checked').length;
		
		if(confirm("Are you want to change the user price?")){
			if(checked == 0){
				alert("Please select at least 1 user to change!")
				return false;
			} else {
				document.Form_list.user_price.value = price;
				document.Form_list.action = 'updateList.do?<c:out value="${param}" />';
				document.Form_list.submit();
			}
		}
	}
	
	fnBlacklist = function(user_id, blacklist){
		var f = document.Form_list;
		var msg = (blacklist == "1") ? "Are you sure you want to blacklist this user?" : "Are you sure you want to unblacklist this user?";
		
		if(confirm(msg)){
			f.user_id.value = user_id;
			f.blacklist.value = blacklist;
			f.action = "blacklist.do";
			f.submit();
		}
	}
	
</script>
<c:set var="total_with_order" value="0" />
<c:set var="total_withno_order" value="0" />
<div class="admin-contents">
	<h2 class="content-title">Users List</h2>
	<form:form name="Form_list" id="Form_list" action="deleteList.do?${param }" method="post">
	<input type="hidden" name="user_price" value="" />
	<input type="hidden" name="user_id" value="" />
	<input type="hidden" name="blacklist" value="" />
	<input type="hidden" name="user_total_order" value="" />
	<table class="tbl-admin">
		<colgroup>
			<col width="3%" />
			<col width="4%" />
			<col width="6%" />
			<col width="6%" />
			<col width="19%" />
			<col width="15%" />
			<col width="5%" />
			<col width="12%" />
			<col width="10%" />
			<col width="8%" />
			<col width="5" />
			<col width="7%" />
		</colgroup>
		<thead>
			<tr>
				<th>&nbsp;</th>
				<th>No</th>
				<th>Orders</th>
				<th>Total Sales</th>
				<th>User Email</th>
				<th>Name</th>
				<th>Gender</th>
				<th>Contact Number</th>
				<th>Country</th>
				<th>Date</th>
				<th>Pricing</th>
				<th class="last">Blacklist</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(cmd.list) gt 0 }">
		<c:forEach var="row" items="${cmd.list }" varStatus="i">
			<c:set var="idx" value="${i.index+1 }" />
			<c:if test="${row.user_total_order ne '0' }">
				<c:set var="total_with_order" value="${total_with_order + 1 }" />
			</c:if>
			<c:if test="${row.user_total_order eq '0' }">
				<c:set var="total_withno_order" value="${total_withno_order + 1 }" />
			</c:if>
			<tr<c:if test="${i.index % 2 eq 0}"> class="even"</c:if>>
				<td>
					<input type="hidden" name="ids" value="${row.user_id }" />
					<input type="checkbox" name="id_checks" value="${row.user_id }" />
				</td>
				<td>${idx }</td>
				<td>${row.user_total_order }</td>
				<td>${row.user_total_payment }</td>
				<td>${row.email }</td>
				<td>${row.name }				
					<c:if test="${row.blacklist eq '1'}"><sup class='red'><strong>x</strong></sup></c:if>
				</td>	
				<td>${row.gender }</td>
				<td>${row.telephone }</td>
				<td>${row.country }</td>
				<td>${row.date }</td>
				<td>
					<c:if test="${row.user_price eq '0'}">
					Normal
					</c:if>
					<c:if test="${row.user_price ne '0'}">
					<span class="txt-green">Special</span>
					</c:if>
				</td>
				<td>
					<c:if test="${row.blacklist eq '1' }">
						<a href="javascript:void(0)" onclick="fnBlacklist('${row.user_id}','0')">
						<img src="${img_src }/stm/btn/btn_blacklist.png" alt="blacklist" />
						</a>
					</c:if>
					<c:if test="${row.blacklist ne '1' }">
						<a href="javascript:void(0)" onclick="fnBlacklist('${row.user_id}', '1')" class="blacklist">Blacklist</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(cmd.list) lt 1 }">
		<tr>
			<td colspan="12">No Records Found!</td>
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
		<button type="button" onclick="fnSortByOrder()" class="admin-btn">SORT BY ORDERS</button>
		<strong class="hasorder">With NO Orders: <span class="red">${total_withno_order }</span></strong>
		<strong class="hasorder">With Orders: <span class="red">${total_with_order }</span></strong>
	</div>
	<div class="admin-bottom-btns">
		<button type="button" onclick="fnUpdateList(1)" class="admin-btn">CHANGE TO SPECIAL PRICE</button>
		<button type="button" onclick="fnUpdateList(0)" class="admin-btn">CHANGE TO NORMAL PRICE</a>
	</div>
	<div class="admin-bottom-box">
		<label>USER TYPE:</label>
		<select id="filter_price" name="filter_price">
			<option value="">All</option>
			<option value="0" <c:if test="${user_price eq '0' }">selected="selected"</c:if>>Normal Price Users</option>
			<option value="1" <c:if test="${user_price eq '1' }">selected="selected"</c:if>>Special Price Users</option>
		</select>
		<button type="button" onclick="fnFilter();">Filter</button>
	</div>
	</form:form>
	<form:form name="Form_manage_search" action="${url }?${param }" method="post">
	<div class="admin-search-bottom">
		<select name="search_field">
			<option value="email">Email Address</option>
		</select>
		<input type="text" name="search_keyword" title="search" value="${cmd.search_keyword }"/>
		<button type="submit" id="btn_search" class="admin-btn">SEARCH</a>
	</div>
	</form:form>
	
	<div class="legend-box">
		<strong class="legend-title">Legend</strong>
		<ul>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_blacklist.png" alt="blacklist" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Blacklisted</span>
			</li>
		</ul>
	</div>
</div>