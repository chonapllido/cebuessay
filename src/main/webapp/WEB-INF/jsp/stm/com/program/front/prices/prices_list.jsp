<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnUpdatePrice = function(){
		var f = document.Form_price,
			category = f.category.value,
			ordinary = $("#price-essay-ordinary"),
			masteral = $("#price-essay-masteral"),
			undergrad = $("#price-essay-undergraduate")
			
		if(category == "Dissertation (Undergraduate)" || category == "Thesis (Undergraduate)"){
			ordinary.hide();
			masteral.hide();
			undergrad.show();
			
		} else if(category == "Dissertation (Masteral)" || category == "Thesis (Masteral)" ){
			ordinary.hide();
			masteral.show();
			undergrad.hide();
		
		} else {
			ordinary.show();
			masteral.hide();
			undergrad.hide();
			
			if(category == "Business" || category == "Law"){
				$('#wc, #woc').hide();	
				$('#wcb, #wocb').show();
			} else {
				$('#wc, #woc').show();
				$('#wcb, #wocb').hide();
			}
		}
	}
</script>
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Prices</h2>
		</div>
	</div>
	<p class="main-article">
		<span class="blue"><strong>MS Word Format:</strong></span> 
		Font = <span class="blue">Arial</span>, 
		Size = <span class="blue">12</span>, 
		Line Spacing = <span class="blue">Double</span>, 
		Margin = <span class="blue">1"</span>
	</p>
	<h4 class="process-title blue">ESSAY WRITING</h4>
	<form name="Form_price" method="post" action="">
	<div class="essay-price-list">
		<div class="essay-category-box">
			<label for="category">Category</label>
			<select name="category" id="category" onchange="fnUpdatePrice()">
				<c:forEach var="category" items="${category_list.list}" varStatus="i">
				<option value="${category.title }" <c:if test="${category_selected == category.title}">selected="selected"</c:if>>${category.title}</option>
				</c:forEach> 
			</select>
		</div>
	</div>
	<div id="price-essay-undergraduate">
		<table class="tbl-price">
			<colgroup>
				<col width="20%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
			</colgroup>
			<thead>
			<tr>
				<th>Price Rule</th>
				<th>250 words</th>
				<th>500 words</th>
				<th>750 words</th>
				<th>1000 words</th>
				<th>1250 words</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>15 days or more</td>
				<td>18 US $</td>
				<td>36 US $</td>
				<td>54 US $</td>
				<td>72 US $</td>
				<td>90 US $</td>
			</tr>
			</tbody>
		</table>
	</div>
	<div id="price-essay-masteral">
		<table class="tbl-price">
			<colgroup>
				<col width="20%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
			</colgroup>
			<thead>
			<tr>
				<th>Price Rule</th>
				<th>250 words</th>
				<th>500 words</th>
				<th>750 words</th>
				<th>1000 words</th>
				<th>1250 words</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>15 days or more</td>
				<td>25 US $</td>
				<td>50 US $</td>
				<td>75 US $</td>
				<td>100 US $</td>
				<td>125 US $</td>
			</tr>
			</tbody>
		</table>
	</div>
	<div id="price-essay-ordinary">
		<span class="essay-table-title"><span class="etitle-left">Without Citation</span></span>
		<table class="tbl-price" id="woc">
			<colgroup>
				<col width="20%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
			</colgroup>
			<thead>
			<tr>
				<th>Price Rule</th>
				<th>250 words</th>
				<th>500 words</th>
				<th>750 words</th>
				<th>1000 words</th>
				<th>1250 words</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${essay_prices }" varStatus="i">
			<tr<c:if test="${i.index % 2 eq 0 }"> class="even"</c:if>>
				<td>${row.title}</td>
				<td>${(row.price * 1)} US $</td>
				<td>${(row.price * 2)} US $</td>
				<td>${(row.price * 3)} US $</td>
				<td>${(row.price * 4)} US $</td>
				<td>${(row.price * 5)} US $</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<table class="tbl-price"id="wocb">
			<colgroup>
				<col width="20%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
			</colgroup>
			<thead>
			<tr>
				<th>Price Rule</th>
				<th>250 words</th>
				<th>500 words</th>
				<th>750 words</th>
				<th>1000 words</th>
				<th>1250 words</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${essay_prices }" varStatus="i">
			<tr<c:if test="${i.index % 2 eq 0 }"> class="even"</c:if>>
				<td>${row.title }</td>
				<td>${((row.price + 2) * 1)} US $</td>
				<td>${((row.price + 2) * 2)} US $</td>
				<td>${((row.price + 2) * 3)} ?> US $</td>
				<td>${((row.price + 2) * 4)} ?> US $</td>
				<td>${((row.price + 2) * 5)} ?> US $</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<span class="essay-table-title"><span class="etitle-left">With Citation</span></span>
		<table cellpadding="0" cellspacing="0" border="0" class="tbl-price" width="100%" id="wc">
			<colgroup>
				<col width="20%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
			</colgroup>
			<thead>
			<tr>
				<th>Price Rule</th>
				<th>250 words</th>
				<th>500 words</th>
				<th>750 words</th>
				<th>1000 words</th>
				<th>1250 words</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${essay_prices }" varStatus="i">
			<tr<c:if test="${i.index % 2 eq 0 }"> class="even"</c:if>>
				<td>${row.title }</td>
				<td>${((row.price + 1) * 1)} US $</td>
				<td>${((row.price + 1) * 2)} US $</td>
				<td>${((row.price + 1) * 3)} US $</td>
				<td>${((row.price + 1) * 4)} US $</td>
				<td>${((row.price + 1) * 5)} US $</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		<table class="tbl-price" id="wcb">
			<colgroup>
				<col width="20%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
				<col width="16%" />
			</colgroup>
			<thead>
			<tr>
				<th>Price Rule</th>
				<th>250 words</th>
				<th>500 words</th>
				<th>750 words</th>
				<th>1000 words</th>
				<th>1250 words</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach var="row" items="${essay_prices }" varStatus="i">
			<tr<c:if test="${i.index % 2 eq 0 }"> class="even"</c:if>>
				<td>${row.title }</td>
				<td>${((row.price + 3) * 1)} US $</td>
				<td>${((row.price + 3) * 2)} US $</td>
				<td>${((row.price + 3) * 3)} US $</td>
				<td>${((row.price + 3) * 4)} US $</td>
				<td>${((row.price + 3) * 5)} US $</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<h4 class="process-title blue">REVISION</h4>
	<table class="tbl-price">
		<colgroup>
			<col width="20%" />
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
		</colgroup>
		<thead>
			<tr>
				<th>Price Rule</th>
				<th>${(revision_words * 1)} words</th>
				<th>${(revision_words * 2)} words</th>
				<th>${(revision_words * 3)} words</th>
				<th>${(revision_words * 4)} words</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="row" items="${revision_prices }" varStatus="i">
		<tr class="even">
			<td>${row.title} (${row.days} days)</td>
			<td>${(row.price * 1)} US $</td>
			<td>${(row.price * 2)} US $</td>
			<td>${(row.price * 3)} US $</td>
			<td>${(row.price * 4)} US $</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	</form>
	<div class="slider">
		<span class="slider-txt">Excellent Quality<br/>On Time Delivery<br />Plagiarism Free!</span>
		<a href="/front/order/insert.do"><img src="${img_src }/stm/btn/btn_order_now.png" width="176" height="54" alt="Order Now" /></a>
		<span class="slider-guarantee"><strong>100%</strong> GUARANTEED</span>
	</div>
</div>