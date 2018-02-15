<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnUpdateSalary = function(index, id){
		var salary = document.getElementById("salary_"+index).value;
		
		if(salary == ""){
			alert("Please input a number in salary!");
			document.getElementById("salary_"+index).focus();
			return false;
		} else {
			if(isNaN(salary)){
				alert("Please input a number in salary!");
				document.getElementById("salary_"+index).focus();
				return false;
			}
		}
		
		if(confirm("Are you sure you want to update the salary?")){
			$.ajax({
				url:'/back/user/writer/updateSalary.do',
				type: 'post',
				data:{'salary': salary, 'user_id':id},
				success: function(data){
					location.reload();
				}
			});
		}
	}
	
	fnEnableInput = function(index){
		document.getElementById('r_'+index).style.display = 'none';
		document.getElementById('w_'+index).style.display = '';
	}
</script>
<div class="admin-contents">
	<h2 class="content-title">Writer's Payment List</h2>
	<form:form name="Form_list" method="post" action="${url }?${param}">
		<div class="writer-date-select">
			<select name="from_month">
				<option value="1" <c:if test="${fromMonth eq '1' }">selected="selected"</c:if>>January</option>
				<option value="2" <c:if test="${fromMonth eq '2' }">selected="selected"</c:if>>February</option>
				<option value="3" <c:if test="${fromMonth eq '3' }">selected="selected"</c:if>>March</option>
				<option value="4" <c:if test="${fromMonth eq '4' }">selected="selected"</c:if>>April</option>
				<option value="5" <c:if test="${fromMonth eq '5' }">selected="selected"</c:if>>May</option>
				<option value="6" <c:if test="${fromMonth eq '6' }">selected="selected"</c:if>>June</option>
				<option value="7" <c:if test="${fromMonth eq '7' }">selected="selected"</c:if>>July</option>
				<option value="8" <c:if test="${fromMonth eq '8' }">selected="selected"</c:if>>August</option>
				<option value="9" <c:if test="${fromMonth eq '9' }">selected="selected"</c:if>>September</option>
				<option value="10" <c:if test="${fromMonth eq '10' }">selected="selected"</c:if>>October</option>
				<option value="11" <c:if test="${fromMonth eq '11' }">selected="selected"</c:if>>November</option>
				<option value="12" <c:if test="${fromMonth eq '12' }">selected="selected"</c:if>>December</option>
			</select>
			<select name="from_year">
				<option value="${currentYear-1 }" <c:if test="${fromYear eq (currentYear-1)}">selected="selected"</c:if>>${currentYear-1 }</option>
				<option value="${currentYear }" <c:if test="${fromYear eq (currentYear)}">selected="selected"</c:if>>${currentYear }</option>
			</select> -
			<select name="to_month">
				<option value="1" <c:if test="${toMonth eq '1' }">selected="selected"</c:if>>January</option>
				<option value="2" <c:if test="${toMonth eq '2' }">selected="selected"</c:if>>February</option>
				<option value="3" <c:if test="${toMonth eq '3' }">selected="selected"</c:if>>March</option>
				<option value="4" <c:if test="${toMonth eq '4' }">selected="selected"</c:if>>April</option>
				<option value="5" <c:if test="${toMonth eq '5' }">selected="selected"</c:if>>May</option>
				<option value="6" <c:if test="${toMonth eq '6' }">selected="selected"</c:if>>June</option>
				<option value="7" <c:if test="${toMonth eq '7' }">selected="selected"</c:if>>July</option>
				<option value="8" <c:if test="${toMonth eq '8' }">selected="selected"</c:if>>August</option>
				<option value="9" <c:if test="${toMonth eq '9' }">selected="selected"</c:if>>September</option>
				<option value="10" <c:if test="${toMonth eq '10' }">selected="selected"</c:if>>October</option>
				<option value="11" <c:if test="${toMonth eq '11' }">selected="selected"</c:if>>November</option>
				<option value="12" <c:if test="${toMonth eq '12' }">selected="selected"</c:if>>December</option>
			</select>
			<select name="to_year">
				<option value="${currentYear-1 }" <c:if test="${toYear eq (currentYear-1)}">selected="selected"</c:if>>${currentYear-1 }</option>
				<option value="${currentYear }" <c:if test="${toYear eq (currentYear)}">selected="selected"</c:if>>${currentYear }</option>
			</select>
			</select>
			<button type="submit">Search</button>
		</div>
		<table class="tbl-admin">
			<colgroup>
				<col width="7%" />
				<col width="24%" />
				<col width="25%" />
				<col width="10%" />
				<col width="10%" />
				<col width="15%" />
				<col width="10%"  />
			</colgroup>
			<thead>
			<tr>
				<th>No</th>
				<th>Name</th>
				<th>Email Address</th>
				<th>Total Words</th>
				<th>Total Price</th>
				<th>Salary</th>
				<th class="last">Info</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(cmd.list) gt 0}">
			<c:forEach var="row" items="${cmd.list }" varStatus="i">
				<c:set var="idx" value="${(i.index + 1)}" />
				<tr<c:if test="${i.index % 2 eq 0}"> class="even"</c:if>>
					<td>${idx }</td>
					<td>${row.name }</td>
					<td>${row.email }</td>
					<td>${row.user_total_order * 250 }</td>
					<td>${row.user_total_payment }</td>
					<td>
					<c:if test="${empty row.salary}">
						<span id="w_${i.index+1}">
							<input type="text" name="salary_${i.index+1}" id="salary_${i.index+1 }" value="" class="input_words" />
							<img src="${img_src }/stm/btn/btn_check_small.png" alt="save" onclick="fnUpdateSalary('${i.index+1 }', '${row.user_id }');" class="btn"/>
						</span>
					</c:if>
					<c:if test="${!empty row.salary}">
						<span id="r_${i.index+1 }">
							<span>$&nbsp;${row.salary }</span>
							<img src="${img_src }/stm/btn/btn_edit_small.png" alt="edit" onclick="fnEnableInput('${i.index+1}');" class="btn"/>
						</span>
						<span id="w_${i.index+1 }" style="display:none">
							<input type="text" name="salary_${i.index+1 }" id="salary_${i.index+1 }" value="${row.salary }" class="input_words"/>
							<img src="${img_src }/stm/btn/btn_check_small.png" alt="save" onclick="fnUpdateSalary('${i.index+1 }', '${row.user_id }');" class="btn"/>
						</span>
					</c:if>
					</td>
					<td><a href="productivity.do?user_id=${row.user_id }"><img src="${img_src }/stm/btn/btn_info.png" alt="information" class="btn"/></a></td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${fn:length(cmd.list) le 0 }">
			<tr><td colspan="7">No Records Found!</td>
			</c:if>
			</tbody>
		</table>
	</form:form>
	<div class="legend-box">
		<strong class="legend-title">Legend</strong>
		<ul>
			<li>
				<span class="legend-icon"><img src="${img_src }/stm/btn/btn_info.png" alt="information" /></span>
				<span class="legend-dash">-</span>
				<span class="legend-meaning">Detail button. Click top open detail page.</span>
			</li>
		</ul>
	</div>
</div>