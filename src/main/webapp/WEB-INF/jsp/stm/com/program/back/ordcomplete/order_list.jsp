<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnDownloadResult = function(type_id, filename){
		var f = document.Form_list;
			f.type_id.value = type_id;
			f.result.value = filename;
		
			document.Form_list.action = "/back/order/downloadResult.do";
			document.Form_list.submit();
	}
	
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
				document.Form_list.action = 'updateList.do?<c:out value="${params}" />';
				document.Form_list.submit();
			}
		}
	}
	
	fnRefundOrder = function(order_id, user_id, total){
		if(confirm("Are you sure you want to refund this order?")){
			$.ajax({
				url: '/back/order/complete/refund.do',
				type: 'post',
				data: {order_id: order_id, user_id: user_id, total: total},
				success: function(data){
					location.reload();
				}
			});
		}
	}
	
	fnSearchByDate = function(){
		var f = document.Form_list;
		
		f.action = "list.do?<c:out value='${params}' />";
		f.search_field.value = "date";
		f.search_keyword.value = f.search_year.value + "-" + f.search_month.value;		
		
		f.submit();
	}
	
</script>

<jsp:useBean id="current_date" class="java.util.Date" />
<fmt:formatDate value="${current_date }" pattern="yyyy" var="current_year" />
<div class="admin-contents">
	<h2 class="content-title">Completed Orders List</h2>
	<form:form name="Form_list" id="Form_list" method="post" action="deleteList.do?${params }">
		<input type="hidden" name="type_id" value="" />
		<input type="hidden" name="result" value="" />
		<input type="hidden" name="status" value="" />
		<input type="hidden" name="search_field" value="" />
		<input type="hidden" name="search_keyword" value="" />
		<div class="search-by-month">
		<select name="search_month">
			<option value="01">January</option>
			<option value="02">February</option>
			<option value="03">March</option>
			<option value="04">April</option>
			<option value="05">May</option>
			<option value="06">June</option>
			<option value="07">July</option>
			<option value="08">August</option>
			<option value="09">September</option>
			<option value="10">October</option>
			<option value="11">November</option>
			<option value="12">December</option>
		</select>
		<select name="search_year">
		<c:forEach var="year" items="${years }" varStatus="i">
			<option value="${year }">${year }</option>
		</c:forEach>
		</select>
		<button type="button" onclick="fnSearchByDate()" class="admin-btn">SEARCH</button>
	</div>
	<table class="tbl-admin">
		<colgroup>
			<col width="3%" />
			<col width="4%" />
			<col width="7%" />
			<col width="14%" />
			<col width="12" />
			<col width="6%" />
			<col width="9%" />
			<col width="11%" />
			<col width="6%" />
			<col width="6%" />
			<col width="6%" />
			<col width="4%" />
			<col width="4%" />
			<col width="4%" />
			<col width="4%" />
		</colgroup>
		<tr>
			<th>&nbsp;</th>
			<th>No</th>
			<th>Order No</th>
			<th>User Email</th>
			<th>Name</th>
			<th>Type</th>
			<th>Manager</th>
			<th>Writer</th>
			<th>Date</th>
			<th>Deadline</th>
			<th>Finished</th>
			<th>Price</th>
			<th>Result</th>
			<th>Info</th>
			<th class="last">Refund</th>
		</tr>
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
			<td>${fn:substring(row.user_email,0,20)}</td>
			<td>${fn:substring(row.user_name,0,17)}</td>
			<td>
				<c:if test="${row.type_id eq 1 }">Essay</c:if>
				<c:if test="${row.type_id ne 1 }">Revision</c:if>
			</td>
			<td>${fn:substring(row.manager_id,0,17)}</td>
			<td>${fn:substring(row.writer_id,0,17)}</td>
			<td>${row.date }</td>
			<td>${row.end_date }</td>
			<td>${row.date_modified }</td>
			<td>${row.total_payment } $</td>
			<td>
				<c:if test="${!empty row.result}">
				<button type="button" class="btn-img" onclick="fnDownloadResult('${row.type_id }', '<c:out value="${row.result}" />')"><img src="${img_src }/stm/btn/btn_download_small.png" alt="download" onclick="JSAdComplete.download_result('<?php echo $arr_info[$i]['type']; ?>', '<?php echo $arr_info[$i]['result']; ?>');" class="btn"/></button>
				</c:if>
			</td>
			<td>
				<c:if test="${row.type_id eq '1' }">
					<a href="/back/order/essay/view.do?order_id=${row.order_id }">
				</c:if>
				<c:if test="${row.type_id eq '2' }">
					<a href="/back/order/revision/view.do?order_id=${row.order_id }">
				</c:if>
				<img src="${img_src }/stm/btn/btn_info.png" alt="information" class="btn"/>
				</a>
			</td>
			<td>
				<c:if test="${row.refunded eq '0' }">
				<button type="button" class="btnrefund" onclick="fnRefundOrder('${row.order_id }', '${row.user_id }', '${row.total_payment }');">Refund</button>
				</c:if>
			</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(cmd.list) lt 1 }">
		<tr>
			<td colspan="14">No Records Found!</td>
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
	
	<form:form name="Form_manage_search" action="/back/order/complete/list.do?${params }" method="post">
	<div class="admin-search-bottom">
		<select name="search_field">
			<option value="email" <c:if test="${cmd.search_field eq 'email' }">selected="selected"</c:if>>Email Address</option>
			<option value="order_id" <c:if test="${cmd.search_field eq 'order_id' }">selected="selected"</c:if>>Order ID</option>
			<option value="writer" <c:if test="${cmd.search_field eq 'order_id' }">selected="selected"</c:if>>Writer</option>
		</select>
		<input type="text" name="search_keyword" title="search" value="<c:if test="${cmd.search_field ne 'date'}">${cmd.search_keyword }</c:if>"/>
		<button type="submit" id="btn_search" class="admin-btn">SEARCH</a>
	</div>
	</form:form>
	<div class="legend-box">
		<strong class="legend-title">Legend</strong>
		<ul>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_download_small.png" alt="download result" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Download button. Click to download result file.</span>
			</li>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_info.png" alt="information" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Information button. Click to view order details.</span>
			</li>
		</ul>
	</div>
</div>