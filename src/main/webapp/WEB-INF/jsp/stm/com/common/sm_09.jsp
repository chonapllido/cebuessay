<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../sys/taglibs.jspf"%>
<%@ include file="../sys/setCodes.jspf"%>
<script type="text/javascript">
	fnDownloadSample = function(file){
		document.Form_list.filename.value=file;
		document.Form_list.submit();
	}
</script>
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<div class="project-box">
				<span class="title">PROJECT</span>
				<img src="${img_src}/stm/img_project.jpg" width="100%" height="143" alt="project" class="project-box-img" />
			</div>
			<div class="project-details">
				<p>CebuEssay will do <i>PROGRAMMING</i>, <i>SPSS</i>, <i>POWERPOINT</i> and <i>INTERNET SEARCH</i>.</p>
				<p>The Deadline and Price are flexible. Please use the Online Support to consult about the project before ordering</p>
			</div>
		</div>
	</div>
	<span class="project-samples">
		<strong>SAMPLES:&nbsp;</strong>
		<form name="Form_list" method="post" action="/front/samples/download.do">
			<input type="hidden" name="filename" value="" />
		</form>
		<span class="essay-samples">
			<c:forEach var="row" items="${project_samples.list }" varStatus="i">
			<a href="javascript:void" onclick="fnDownloadSample('${row.file}')" class="txt-red">Sample ${i.index+1 }</a>
			</c:forEach>
		</span>
	</span>
	<table class="tbl-price">
		<tr>
			<th width="20%">Price Rule</th>
			<th width="16%">1 slide</th>
			<th width="16%">2 slides</th>
			<th width="16%">3 slides</th>
			<th width="16%">4 slides</th>
			<th width="16%">5 slides</th>
		</tr>
		<tr>
			<td>Regular (5 days)</td>
			<td>3 US$</td>
			<td>6 US$</td>
			<td>9 US$</td>
			<td>12 US$</td>
			<td>15 US$</td>
		</tr>
	</table>
	<div class="slider">
		<span class="slider-txt">Excellent Quality<br/>On Time Delivery<br />Plagiarism Free!</span>
		<a href="${configs.CONTEXT }/front/order/insert.do"><img src="${img_src }/stm/btn/btn_order_now.png" width="176" height="54" alt="Order Now" /></a>
		<span class="slider-guarantee"><strong>100%</strong> GUARANTEED</span>
	</div>
</div>