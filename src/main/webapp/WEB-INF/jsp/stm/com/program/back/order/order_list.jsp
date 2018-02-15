<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnUpdateManager = function(manager, order_id, type){
		
		var f 			= document.Form_manage,
			order_type	= "Essay",
			sel_manager = document.getElementById(manager),
			manager_id 	= sel_manager.options[sel_manager.selectedIndex].value;
		
		if(type == '2'){
			order_type = "Revision";
		}

		$.ajax({
			url:'/back/order/updateManager.do',
			type: 'get',
			data:{'order_id': order_id, 'manager_id':manager_id, 'type':order_type},
			success: function(data){
				location.reload();
			}
		});
	}
	
	fnEditManager = function(id){
		document.getElementById('managerSelect_'+id).style.display = '';
		document.getElementById('managerBox_'+id).style.display = 'none';
	}
	
	fnUpdateWriter = function(writer, order_id, type){
		
		var f 			= document.Form_manage,
			order_type	= "Essay",
			sel_writer 	= document.getElementById(writer),
			writer_id 	= sel_writer.options[sel_writer.selectedIndex].value;
		
		if(type == '2')
			order_type = "Revision";

		$.ajax({
			url:'/back/order/updateWriter.do',
			type: 'get',
			data:{'order_id': order_id, 'writer_id':writer_id, 'type':order_type},
			success: function(data){
				location.reload();
			}
		});
	}
	
	fnEditWriter = function(id){
		document.getElementById('s_'+id).style.display = '';
		document.getElementById('w_'+id).style.display = 'none';
	}
	
	fnUpdateStatus = function(action, cnt, order_id, type, email, topic){
		var f 			= document.Form_manage,
			order_type 	= "Essay",
			manager 	= document.getElementById('manager_'+cnt).value,
			writer 		= document.getElementById('writer_'+cnt).value,
			status		= "2";

			if(!confirm('Are you sure you want to update the order status?')){
				return false;
			}
			if(type == '2')
				order_type = "Revision";
			
			if(manager == '0'){
				alert('Please choose a manager!');
				return;
			}
			if(action == "finish"){
				status = "3";
			}
			
			$.ajax({
				url:'/back/order/updateStatus.do',
				type: 'get',
				data:{
					'do':action,
					'order_id':order_id, 
					'type':order_type,
					'status':status,
					'email':email,
					'topic':topic
				},
				success: function(data){
					location.reload();
				}
			});	
	}
	
	fnUploadResult = function(el, order_id, type){
		
		var f = document.Form_manage;
			f.order_id.value = order_id;
			f.type_id.value = type;
			f.result.value = el;
			$('input[type=file]').not("input[name="+el+"]").prop('disabled', true);
		 	
			document.Form_manage.action = "/back/order/uploadResult.do?"+"<c:out value='${param}' />";
		 	document.Form_manage.submit();
	}
	
	fnDownloadResult = function(type_id, filename){
		var f = document.Form_manage;
			f.type_id.value = type_id;
			f.result.value = filename;
		
			document.Form_manage.action = "/back/order/downloadResult.do";
			document.Form_manage.submit();
	}
	
	fnCancelOrder = function(order_id, type, email){
		
		var f 		= document.Form_manage,
			order_type= "Essay";
		
		if(!confirm('Are you sure you want to cancel this order?')){
			return false;
		}
		if(type == '2')
			order_type = "Revision";
		
		$.ajax({
			url:'/back/order/cancelOrder.do',
			type: 'get',
			data:{
				  'order_id':order_id, 
				  'type':order_type,
				  'email':email
			},
			success: function(data){
				location.reload();
			}
		});	
	}
	
</script>

<div class="admin-contents">
	<h2 class="content-title">Order Management</h2>
	<form:form name="Form_manage" id="Form_manage" commandName="orderCommand" method="post" action="${url }?${param }" enctype="multipart/form-data">		
	<input type="hidden" name="type_id"  />
	<input type="hidden" name="order_id" />	
	<input type="hidden" name="file" />
	<input type="hidden" name="email" />
	<input type="hidden" name="result" value="" />
	<div>
		<table class="tbl-admin">
			<colgroup>
				<col width="3%" />
				<col width="6%" />
				<col width="13%" />
				<col width="8%" />
				<col width="4%" />
				<col width="5%" />
				<col width="5%" />
				<col width="6%" />
				<col width="7%" />
				<col width="4%" />
				<col width="5%" />
				<col width="18%" />
				<col width="4%" />
				<col width="4%" />
				<col width="4%" />
				<col width="4%" />
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>Order No</th>
					<th>User Email</th>
					<th>Name</th>
					<th>Type</th>
					<th>Date</th>
					<th>Deadline</th>
					<th>Manager</th>
					<th>Writer</th>
					<th>Price</th>
					<th>Status</th>
					<th>Upload</th>
					<th>Result</th>
					<th>Confirm</th>
					<th>Finish</th>
					<th class="last">Process</th>
				</tr>
			</thead>
			<c:if test="${fn:length(cmd.list) gt 0 }">
			<tbody>
			<c:forEach var="row" items="${cmd.list}" varStatus="i">
			<c:set var="idx" value="${(i.index + 1)}" />
			<tr<c:if test="${i.index % 2 eq 0}"> class="even"</c:if>>
				<td>${idx}</td>
				<td>${row.order_id }</td>
				<td>${fn:substring(row.user_email,0,27)}</td>
				<td>${fn:substring(row.user_name,0,16)}</td>
				<td>
					<c:if test="${row.type_id eq 1 }">Essay</c:if>
					<c:if test="${row.type_id ne 1 }">Revision</c:if>
				</td>
				<td>${row.date }</td>
				<td>${row.end_date }</td>
				<td>
				<c:if test="${!empty row.manager_id}">
					<span id="managerBox_${idx}">
						${fn:substring(row.manager_id,0,10)}
						<button type="button" class="btn-img" onclick="fnEditManager('${idx }')"><img src="${img_src}/stm/btn/btn_edit_small.png" alt="edit" /></button>
					</span>
					<span id="managerSelect_${idx}" style="display:none;">
						<select id="manager_${idx}" name="manager_${idx}" class="manager-select">
							<option value="0">Please Select</option>
							<c:forEach var="manager" items="${managers.list }" varStatus="i">
							<option value="${manager.user_id }" <c:if test="${row.manager_id eq manager.name }">selected="selected"</c:if>>${manager.name }</option>
							</c:forEach>
						</select>
						<button type="button" onclick="fnUpdateManager('manager_${idx}', '${row.order_id }', '${row.type_id }');" class="btn-img"><img src="${img_src}/stm/btn/btn_check_small.png" alt="check" class="btn" /></button>
					</span>
				</c:if>
				<c:if test="${empty row.manager_id}">
					<select id="manager_${idx}" name="manager_${idx}" class="manager-select">
						<option value="0">Please Select</option>
						<c:forEach var="manager" items="${managers.list }" varStatus="i">
						<option value="${manager.user_id }" <c:if test="${row.manager_id eq manager.name }">selected="selected"</c:if>>${manager.name }</option>
						</c:forEach>
					</select>
					<button type="button" onclick="fnUpdateManager('manager_${idx}', '${row.order_id }', '${row.type_id }');" class="btn-img"><img src="${img_src}/stm/btn/btn_check_small.png" alt="check" class="btn" /></button>
				</c:if>
				</td>
				<td>
				
				<c:if test="${!empty row.writer_id}">
					<span id="w_${idx}" style="display:;">
						<span>${row.writer_id }</span>
						<button type="button" onclick="fnEditWriter('${idx}')" class="btn-img"><img src="${img_src}/stm/btn/btn_edit_small.png" alt="change writer" class="btn" /></button>
					</span>
					<span id="s_${idx}" style="display:none">
						<span>
							<select id="writer_${idx}" name="writer_${idx}" class="manager-select">
								<option value="0">Please Select</option>
								<c:forEach var="writer" items="${writers.list }" varStatus="i">
								<option value="${writer.user_id }" <c:if test="${row.writer_id eq writer.name }">selected="selected"</c:if>>${writer.name }</option>
								</c:forEach>
							</select>
						</span>
						<button type="button" class="btn-img" onclick="fnUpdateWriter('writer_${idx}', '${row.order_id }', '${row.type_id }');"><img src="${img_src}/stm/btn/btn_check_small.png" alt="" /></button>
					</span>
				</c:if>
				<c:if test="${empty row.writer_id}">
					<c:if test="${row.status eq 'Working' && !empty(row.manager_id)}" >
						<span id="s_${idx}">
					</c:if>
						<span>
							<select id="writer_${idx}" name="writer_${idx }" class="manager-select">
							<option value="0">Please Select</option>
							<c:forEach var="writer" items="${writers.list }" varStatus="i">
							<option value="${writer.user_id }" <c:if test="${row.writer_id eq writer.name }">selected="selected"</c:if>>${writer.name }</option>
							</c:forEach>
							</select>
						</span>
						<button type="button" class="btn-img" onclick="fnUpdateWriter('writer_${idx}', '${row.order_id }', '${row.type_id }');"><img src="${img_src}/stm/btn/btn_check_small.png" alt="" /></button>
					<c:if test="${row.status eq 'Working' && !empty(row.manager_id)}" >
						</span>
					</c:if>
				</c:if>
				</td>
				<td>${row.total_payment } $</td>
				<td>${row.status }</td>
				<td>
					<input type="file" name="ufile${idx }" value="Browse" class="admin-upload">
					<button type="button" onclick="fnUploadResult('ufile${idx }', '${row.order_id }', '${row.type_id }')" >Upload</button>
				</td>
				<td>
					<c:if test="${!empty row.result }">
						<button type="button" class="btn-img" onclick="fnDownloadResult('${row.type_id }', '<c:out value="${row.result}" />');" ><img src="${img_src}/stm/btn/btn_download_small.png" name="result${idx }" id="result${idx }" class="btn"/></button>
					</c:if>
				<td> 
					<c:if test="${row.status == 'Pending' || row.status == 'Paid' }">
					<button type="button" class="btn-img" onclick="fnUpdateStatus('confirm','${idx}','${row.order_id}','${row.type_id }','${row.user_email }', '${row.topic }')"><img src="${img_src}/stm/btn/btn_confirm_small.png" alt="confirm" /></button>
					</c:if>
				</td>
				<td>
					<c:if test="${! empty row.result }">
					<button type="button" class="btn-img" onclick="fnUpdateStatus('finish','${idx}','${row.order_id}','${row.type_id }','${row.user_email }', '${row.topic }')"><img src="${img_src}/stm/btn/btn_finish_small.png" class="btn" alt="finish"  /></button>
					</c:if>
				</td>
				<td>
					<c:if test="${row.type_id eq '1' }">
						<a href="/back/order/essay/view.do?order_id=${row.order_id }">
					</c:if>
					<c:if test="${row.type_id eq '2' }">
						<a href="/back/order/revision/view.do?order_id=${row.order_id }">
					</c:if>
					<img src="${img_src}/stm/btn/btn_info.png" alt="info" class="btn"/></a>
					<button type="button" class="btn-img" onclick="fnCancelOrder('${row.order_id}', '${row.type_id }', '${row.user_email}')"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="cancel" class="btn"/></button>
				</td>
			</tr>
			</c:forEach>
			</c:if>
			<c:if test="${fn:length(cmd.list) lt 1 }">
			<tr>
				<td colspan="17">No Records Found!</td>
			</tr>
			</c:if>
			</tbody>
		</table>
		<div class="admin-paging full">
			<stmfn:paging1 />
			<c:if test="${(cmd.total_record_count / cmd.record_count_per_page) > 1 }">
			<span class="admin-gopage">
				<label for="gotopage">Go to Page:</label>
				<input type="text" name="page_no" id="page_no" value="" />
				<button type="button" onclick="goToPage('Form_manage');">GO</button>
			</span>
			</c:if>
			<strong class="tot"> 
				<c:set var="total_amt" value="0" />
				<c:forEach var="row" items="${pending_total.list }" varStatus="i">
					<c:set var="total_amt" value="${(total_amt + row.total_payment) }" />
					${row.date }=<span class="red">${row.total_payment } $</span>
				</c:forEach>
				Total:<span class="red"> ${total_amt } $</span>
			</strong>
		</div>
	</div>
	</form:form>
	<form:form name="Form_manage_search" commandName="orderCommand" action="${url }?${param }" method="post">
	<div class="admin-search-bottom">
		<select name="search_field">
			<option value="email" <c:if test="${orderCommand.search_field eq 'email' }">selected="selected"</c:if>>Email Address</option>
			<option value="order_id" <c:if test="${orderCommand.search_field eq 'order_id' }">selected="selected"</c:if>>Order ID</option>
		</select>
		<input type="text" name="search_keyword" title="search" value="${orderCommand.search_keyword }"/>
		<button type="submit" id="btn_search" class="admin-btn">SEARCH</a>
	</div>
	</form:form>
	<div class="legend-box">
		<strong class="legend-title">Legend</strong>
		<ul>
			<li>
				<span class="legend-icon"><img src="${img_src}/stm/btn/btn_download_small.png" alt="result" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Download result</span>
			</li>
			<li>
				<span class="legend-icon"><img src="${img_src}/stm/btn/btn_confirm_small.png" alt="confirm" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Confirm button. Click to update order to Working status.</span>
			</li>
			<li>
				<span class="legend-icon"><img src="${img_src}/stm/btn/btn_finish_small.png" alt="finish" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Finish button. Click to update order to Finished status.</span>
			</li>
			<li>
				<span class="legend-icon"><img src="${img_src}/stm/btn/btn_info.png" alt="info" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Information button. Click to view the order details.</span>
			</li>
			<li>
				<span class="legend-icon"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="cancel" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Cancel button. Click to cancel the order.</span>
			</li>
		</ul>
	</div>
</div>