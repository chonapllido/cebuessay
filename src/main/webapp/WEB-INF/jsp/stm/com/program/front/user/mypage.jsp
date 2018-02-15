<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<script type="text/javascript">
	fnDownloadResult = function(type_id, filename){
		var f = document.Form_order;
			f.type_id.value = type_id;
			f.result.value = filename;
		
			f.action = "/front/order/downloadResult.do";
			f.submit();
	}
	fnPromptDelete = function(order_id, type_id){
		if(confirm("Are you sure you want to delete this order?")){
			var f = document.Form_order;
			f.order_id.value = order_id;
			f.type_id.value = type_id;
			f.action = "/front/order/deleteOrder.do";
			f.submit();
		}
	}
</script>
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">My Page</h2>
		</div>
	</div>
	<span class="mypage-vm">Your Virtual Money: <span>US $${virtual_money }</span></span>
	<form:form name="Form_order" commandName="orderCommand" action="${url}?${param}" method="post" >
	<input type="hidden" name="type_id"  value="" />
	<input type="hidden" name="order_id" value="" />
	<input type="hidden" name="result" value="" />
	<table class="tbl-forum">
		<tr>
			<th width="8%">No</th>
			<th width="10%">Order No</th>
			<th width="10%">Type</th>
			<th width="11%">Date</th>
			<th width="11%">Deadline</th>
			<th width="11%">Writer</th>
			<th width="9%">Price</th>
			<th width="8%">Result</th>
			<th width="11%">Status</th>
			<th width="11%" class="last">Action</th>
		</tr>
		<c:if test="${fn:length(cmd.list) gt 0 }">
		<c:forEach var="row" items="${cmd.list }" varStatus="i">
			<c:choose>
				<c:when test="${row.status eq 'Pending'}">
					<c:set var="cc" value="txt-blue" />
				</c:when>
				<c:when test="${row.status eq 'Paid'}">
					<c:set var="cc" value="txt-orange" />
				</c:when>
				<c:when test="${row.status eq 'Working'}">
					<c:set var="cc" value="txt-green" />
				</c:when>
				<c:when test="${row.status eq 'Finished'}">
					<c:set var="cc" value="txt-pink" />
				</c:when>
				<c:otherwise>
					<c:set var="cc" value="txt-red" />
				</c:otherwise>
			</c:choose>
			<c:if test="${row.type_id eq '1' }">
				<c:set var="dest" value="/front/order/essay/view.do?order_id=${row.order_id }" />
			</c:if>
			<c:if test="${row.type_id eq '2' }">
				<c:set var="dest" value="/front/order/revision/view.do?order_id=${row.order_id }" />
			</c:if>
		<tr>
			<td>${(i.index + 1)}</td>
			<td>${row.order_id }</td>
			<td>${(row.type_id eq "1") ? "Essay":"Revision" }</td>
			<td>${row.date }</td>
			<td>${row.end_date }</td>
			<td>${row.writer_id }</td>
			<td>${row.total_payment } $</td>
			<td>
			<c:if test="${!empty row.result && row.status eq 'Finished'}">
			<button type="button" class="btn-img" onclick="fnDownloadResult('${row.type_id}', '${row.result }')"><img src="${img_src }/stm/btn/btn-download.png" alt="Download" /></button>
			</c:if>
			</td>
			<td><span class="<c:out value="${cc}" />">${row.status }</span></td>
			<td>
				<a href="/front/order/${row.type_id eq '1' ? 'essay' : 'revision' }/view.do?order_id=${row.order_id}"><img src="${img_src }/stm/btn/btn_info.png" width="16" height="16" alt="information" /></a>&nbsp;&nbsp;
				<c:if test="${row.status eq 'Finished' || row.status eq 'Cancelled'}">
				<button type="button" class="btn-img" onclick="fnPromptDelete('${row.order_id}', '${row.type_id }')"><img src="${img_src }/stm/btn/btn_remove.png" alt="delete" /></button>
				</c:if>
			 </td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(cmd.list) eq 0 }">
		<tr>
			<td colspan="10">No Orders Found!</td>
		</tr>
		</c:if>
	</table>
	<div class="paging"><stmfn:paging1/></div>
	</form:form>	
	<form:form name="Form_mypage_search" commandName="orderCommand" method="post" action="${url }?${param}" >
	<input type="hidden" name="search_field" value="order_id" />
	<div class="list-search">
		<label for="order_no">Order No:</label>
		<input type="text" name="search_keyword" value="${orderCommand.search_keyword }" />
		<button type="submit" class="btn-img"><img src="${img_src }/stm/btn/btn_search.png" alt="Search" /></button>
	</div>
	</form:form>
	
	<div class="faq">
		<big class="essay-type-title">Legend</big>
		<ul class="faq-list">
			<li>
				<span class="faq-question">Type</span>
			<span class="faq-answer">The type of order. It could be essay or revision.</span>
		</li>
		<li>
			<span class="faq-question">Date</span>
			<span class="faq-answer">The date it has been ordered</span>
		</li>
		<li>
			<span class="faq-question">Deadline</span>
			<span class="faq-answer">The deadline of the order to be submitted.</span>
		</li>
		<li>
			<span class="faq-question">Result</span>
			<span class="faq-answer">The finished essay or revision. The file CebuEssay uploaded</span>
		</li>
		<li>
			<span class="faq-question">Status</span>
			<span class="faq-answer">The status of the order. It could be pending, paid, working, finished or cancelled.</span>
		</li>
		<li>
	
			<span class="faq-question">Action</span>
			<span class="faq-answer">The Process column has two buttons, the information button and delete button. Click the information button&nbsp;&nbsp;<img src="images/btn/btn_info.png" width="16" height="16" alt="information" />&nbsp;&nbsp;to show the order details. Click the delete button&nbsp;&nbsp;<img src="images/btn/btn_remove.png" width="16" height="16" alt="delete" />&nbsp;&nbsp;if you want to delete the order.</span>
		</li>
		</ul>
	</div>
</div>