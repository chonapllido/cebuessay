<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	
	$(function(){
		$('.datepicker').datepicker({
			showOn: "button",
			buttonImage:"${img_src}/stm/icon/icon_cal.png",
			buttonImageOnly: true,
			buttonText: "Select date",
			dateFormat: "yy-mm-dd"
		});
	});
	
	fnUpdateVm = function(userid, vm, id, flg){
		 var input = $('input[name="amount_'+id+'"]'),
		 	 amt = input.val();
		 
		 if(amt == ""){
			 alert("Please enter an amount!");
			 input.focus();
			 return false;
		 }
		 if(isNaN(amt)){
			 alert("Please enter a valid number!");
			 input.focus();
			 return false;
		 }
		 
		 if(flg == "minus" && (amt > vm)){
			alert("Amount is bigger than the virtual money!");
			input.focus();
			return false;
		 }
		 
		 $.ajax({
			 url:'/back/user/updatevm.do',
			 type: 'post',
			 data:{
				 user_id: userid,
				 amount: amt,
				 doaction: flg
			 },
			 success: function(data){
				 location.reload();
			 }
		 });
	}
	
	fnCalculateVm = function(){
		var f = document.Form_calc,
		 user = f.user_id,
		 username = user.options[user.selectedIndex].text;
		 
		f.user_name.value = username;
		 
		if(f.date_from.value == ""){
			alert("Please enter the date!");
			f.date_from.focus();
			return false;
		}
		if(f.date_end.value == ""){
			alert("Please enter the date!");
			f.date_end.focus();
			return false;
		}

		$.ajax({
			url: "/back/user/calculateVm.do",
			type: "POST",
			data: $("#Form_calc").serialize(),
			success: function(data){
				document.Form_calc.virtual_money.value = data;
				$("#calc_vm_amount").text("$ "+data);
			}
		});
	}
	
	fnAddVm = function(){
		var f = document.Form_calc;

		if(f.virtual_money.value ==""){
			alert("Please compute first the virtual money!")
			return false;
		}

		if(f.virtual_money.value == 0.0 || f.virtual_money.value == 0){
			alert("Virtual money cannot be 0");
			return false;
		}
		
		f.submit();
	}
</script>
<div class="admin-contents">
	<h2 class="content-title">Users with Virtual Money</h2>
	<form:form name="Form_list" action="${url }?${params }"  method="post" >
	<table class="tbl-admin">
		<colgroup>
			<col width="10%" />
			<col width="20%%" />
			<col width="20%" />
			<col width="20%" />
			<col width="30%"  />
		</colgroup>
		<thead>
			<tr>
				<th>No</th>
				<th>User Email</th>
				<th>Name</th>
				<th>Virtual Money</th>
				<th class="last">Action</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${fn:length(users.list) gt 0 }">
		<c:forEach var="row" items="${users.list }" varStatus="i">
		<tr <c:if test="${i.index % 2 eq 0}"> class="even"</c:if>>
			<c:set var="idx" value="${i.index+1 }" />
			<td>${i.index+1 }</td>
			<td>${row.email }</td>
			<td>${row.name }</td>
			<td>$ ${row.virtual_money }</td>
			<td>
				<input type="text" name="amount_${idx}"  />
				<input type="button" value="Add" onclick="fnUpdateVm('${row.user_id }',${row.virtual_money},'${idx }', 'add');" />
				<input type="button" value="Subtract" onclick="fnUpdateVm('${row.user_id }',${row.virtual_money},'${idx }', 'minus');" />
			</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(users.list) lt 1 }">
		<tr>
			<td colspan="5">No Records Found!</td>
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
	<form:form name="Form_search" action="${url }?${params }" method="post">
	<div class="admin-search-bottom">
		<select name="search_field">
			<option value="email">Email Address</option>
		</select>
		<input type="text" name="search_keyword" title="search" value="${cmd.search_keyword }"/>
		<button type="submit" id="btn_search" class="admin-btn">SEARCH</a>
	</div>
	</form:form>

	
	<div class="vm_calc">
		<h3 class="tit_vmcalc">Virtual Money Calculator</h3>
		<form:form name="Form_calc" id="Form_calc" action="/back/vmlogs/insertVm.do" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="virtual_money" value="" />
		<input type="hidden" name="user_name" value="" />
		<div class="calbox">
			<div>
				<span class="label">User</span>
				<span>
					<select name="user_id">
					<c:forEach var="row" items="${active_users.list }" varStatus="i">
 						<option value="${row.user_id }">${row.name }</option>
					</c:forEach>
					</select>
				</span>
			</div>
			<div>
				<span class="label">Date</span>
				<span><input type="text" name="date_from" class="datepicker" /> ~
				<input type="text" name="date_end" class="datepicker" /></span>
			</div>
			<div>
				<span class="label">Virtual Money</span>
				<strong id="calc_vm_amount">$</strong>
			</div>
			<div class="calc_buttons">
				<button type="button" onclick="fnCalculateVm();">Compute</button>
				<button type="button" onclick="fnAddVm()">Add</button>
			</div>
		</div>
		</form:form>
		<span class="logs_link">Logs</span>
		<table class="tbllogs">
			<thead>
				<tr>
					<th>No</th>
					<th>User Name</th>
					<th>From</th>
					<th>To</th>
					<th>Date Performed</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(vmlogs.list) gt 0 }">
				<c:forEach var="row" items="${vmlogs.list }" varStatus="i">
				<tr>
					<td>${i.index+1 }</td>
					<td>${row.user_name }</td>
					<td>${row.date_from }</td>
					<td>${row.date_end }</td>
					<td>${row.date_performed }</td>
				</tr>
				</c:forEach>
				</c:if>
				<c:if test="${fn:length(vmlogs.list) lt 1 }">
				<tr><td colspan="5">No Records</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>