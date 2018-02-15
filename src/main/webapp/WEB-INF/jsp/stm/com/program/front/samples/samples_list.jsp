<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnDownloadSample = function(filename){
		var f = document.Form_list;
			document.Form_list.filename.value = filename;
			document.Form_list.submit();
	}
</script>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">SAMPLES</h2>
		</div>
	</div>
	<p class="main-article">You can check our samples below to measure the quality of our work. We create power point, software programming, and others for projects. We correct the grammar of your paper and show you the edited part. Aside from giving you the highest quality paper, we also give the copy of the plagiarism scanner report.</p>
	<form name="Form_list" method="post" action="download.do" >
	<input type="hidden" name="filename" value="" />
	<div class="sample-row">
		<span class="sample-tit">Projects</span>
		<div class="sample-box">
			<span class="sample-box-left">
				<img src="${img_src}/stm/img_projects1.png" width="200" height="129" alt="projects"/>
			</span>
			<div class="sample-box-right">
				<ul class="sample-btns">
					<c:forEach var="row" items="${project_samples.list }" varStatus="i">
					<li>
						<a href="javascript:void(0)" onclick="fnDownloadSample('${row.file}')" class="btn-project">&nbsp;</a>
						<a href="javascript:void(0)" onclick="fnDownloadSample('${row.file}')" class="lbl-sample">Sample ${i.index+1 }</a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div class="sample-row">
		<span class="sample-tit">Revision</span>
		<div class="sample-box">
			<span class="sample-box-left"><img src="${img_src}/stm/img_revision.jpg" width="200px" height="129px" /></span>
			<div class="sample-box-right">
				<ul class="sample-btns">
					<c:forEach var="row" items="${revision_samples.list }" varStatus="i">
					<li>
						<a href="javascript:void(0)" onclick="fnDownloadSample('${row.file}')" class="btn-revision">&nbsp;</a>
						<a href="javascript:void(0)" onclick="fnDownloadSample('${row.file}')" class="lbl-sample">Sample ${i.index+1 }</a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<div class="sample-row">
		<span class="sample-tit">Writing</span>
		<c:forEach var="row" items="${essay_samples.list }" varStatus="i">
		<c:set var="instruct_ext" value="${(i.index == 1) ? 'zip':'doc'}" />
		<c:set var="plag_ext" value="${(i.index == 3) ? 'zip':'jpg'}" />
		<div class="write-row">
			<span class="bgleft">&nbsp;</span>
			<span class="bgright">&nbsp;</span>
			<span class="write-img"><img src="${img_src}/stm/icon/icon_writing.png" width="70" height="67" alt="file" /></span>
			<div class="write-details">
				<span class="essay-title"><strong>Title:</strong> <span>${row.title }</span></span>
				<ul class="sample-btns writing">
				<li>
					<li><a href="javascript:void(0)" onclick="fnDownloadSample('Sample ${name_list[i.index]} Instruction.${instruct_ext}')" class="btn-instructions">Instructions</a></li>
					<li><a href="javascript:void(0)" onclick="fnDownloadSample('${row.file}')" class="btn-paper">Paper</a></li>
					<li><a href="javascript:void(0)" onclick="fnDownloadSample('Sample ${name_list[i.index]} Plagiarism Report.${plag_ext }')" class="btn-plagiarism">Plagiarism Report</a></li>
				</ul>
			</div>
		</div>
		</c:forEach>
	</div>
	</form>
	<div class="slider">
		<span class="slider-txt">Excellent Quality<br/>On Time Delivery<br />Plagiarism Free!</span>
		<a href="order.php"><img src="${img_src}/stm/btn/btn_order_now.png" width="176" height="54" alt="Order Now" /></a>
		<span class="slider-guarantee"><strong>100%</strong> GUARANTEED</span>
	</div>
</div>