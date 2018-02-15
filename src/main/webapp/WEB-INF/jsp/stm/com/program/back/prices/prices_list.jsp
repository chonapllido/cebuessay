<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">

	fnOpenView = function(el){
		
		var form = $(el).closest('.section-price');
		form.find('.form-list').show();
		form.find('.form-add').hide();
		
		$(el).addClass('on').siblings('button').removeClass('on');
	}
	
	fnOpenAdd = function(el){
		
		var form = $(el).closest('.section-price');
		form.find('.form-add').show();
		form.find('.form-list').hide();
		
		$(el).addClass('on').siblings('button').removeClass('on');
	}
	
	fnDeleteList = function(el){
		var form = $(el).closest('form');
		var len = form.find("input[type=checkbox]:checked").length;
		if(confirm("Are you sure you want to delete?")){
			if(len < 1){
				alert("Please select at least 1 item to delete!")
				return false;
			} else {
				form.submit();
			}
		}
	}
	
	fnSubmitCategory = function(el){
		var form = $(el).closest('form[name=Form_write]'),
			input = form.find('input[name=title]');
			
		if(input.val() == ""){
			alert("Please enter the category!");
			input.focus();
			return false;
		}
		
		form.submit();
	}
	
	fnSubmitEt = function(el){
		var form = $(el).closest('form[name=Form_write]'),
			input_name = form.find('input[name=name]'),
			input_desc = form.find('textarea[name=description]');
			
		if(input_name.val() == ""){
			alert("Please enter the essay type!");
			input_name.focus();
			return false;
		}
		
		if(input_desc.val() == ""){
			alert("Please enter the description!");
			input_desc.focus();
			return false;
		}
		form.submit();
	}
	
	fnSubmitRm = function(el, type){
		
		var form = $(el).closest('form[name=Form_write]'),
			input_desc, input_pages, input_days, input_price;
		
		if(type == "add"){
			input_desc = form.find('input[name=description]');
			input_pages = form.find('input[name=pages]');
			input_days = form.find('input[name=days]');
			input_price = form.find('input[name=price]');
		}
		
		if(type == "edit"){
			var f = $(el).closest('tr');
			form = $(el).closest('form[name=Form_list]');
			input_desc = f.find('input[name*=description_]');
			input_pages = f.find('input[name*=pages_]');
			input_days = f.find('input[name*=days_]');
			input_price = f.find('input[name*=price_]');
			var input_id = f.find('input[name*=id_]');
		}
			
		if(input_desc.val() == ""){
			alert("Please enter the description!");
			input_desc.focus();
			return false;
		}
		
		if(input_pages.val() == ""){
			alert("Please enter the pages!");
			input_pages.focus();
			return false;
		} else {
			if(isNaN(input_pages.val())){
				alert("Please enter a number for pages!");
				input_pages.focus();
				return false;
			}
		}
		
		if(input_pages.val() == ""){
			alert("Please enter the pages!");
			input_pages.focus();
			return false;
		} else {
			if(isNaN(input_pages.val())){
				alert("Please enter a number for pages!");
				input_pages.focus();
				return false;
			}
		}
		
		if(input_days.val() == ""){
			alert("Please enter the days!");
			input_days.focus();
			return false;
		} else {
			if(isNaN(input_days.val())){
				alert("Please enter a number for days!");
				input_days.focus();
				return false;
			}
		}
		
		if(input_price.val() == ""){
			alert("Please enter the price!");
			input_price.focus();
			return false;
		} else {
			if(isNaN(input_price.val())){
				alert("Please enter a number for price!");
				input_price.focus();
				return false;
			}
		}
		
		if(type == "edit"){
			form.attr("action", "/back/readmaterial/update.do");
			var myForm = $(el).closest('#Form_rm');
			myForm.find('input[name=description]').val(input_desc.val());
			myForm.find('input[name=days]').val(input_days.val());
			myForm.find('input[name=price]').val(input_price.val());
			myForm.find('input[name=pages]').val(input_pages.val());
			myForm.find('input[name=id]').val(input_id.val());
		}

		form.submit();
	}
	
	fnSubmitEf = function(el){
		var form = $(el).closest('form[name=Form_write]'),
			input = form.find('input[name=title]');
			
		if(input.val() == ""){
			alert("Please enter the writing format!");
			input.focus();
			return false;
		}
		
		form.submit();
	}
	
	fnSubmitLevel = function(el){
		var form = $(el).closest('form[name=Form_write]'),
			input = form.find('input[name=title]');
			
		if(input.val() == ""){
			alert("Please enter the level!");
			input.focus();
			return false;
		}
		
		form.submit();
	}
	
	fnUpdatePe = function(el){
		var par = $(el).closest('tr'),
		input_title = par.find('input[name*=title_]'),
		input_days = par.find('input[name*=days_]'),
		input_price = par.find('input[name*=price_]'),
		input_maxpage = par.find('select[name*=maxpage_]'),
		input_priceid = par.find('input[name*=priceid_]');
		
		
		if(input_title.val() == ""){
			alert("Please enter the title!");
			input_title.focus();
			return false;
		}
		
		if(input_days.val() == ""){
			alert("Please enter the days!");
			input_days.focus();
			return false;
		} else {
			if(isNaN(input_days.val())){
				alert("Please enter a valid number for days!");
				input_days.focus();
				return false;
			}
		}
		
		if(input_price.val() == ""){
			alert("Please enter the price!");
			input_price.focus();
			return false;
		} else {
			if(isNaN(input_price.val())){
				alert("Please enter a valid number for price!");
				input_price.focus();
				return false;
			}
		}
		
		var form = $(el).closest('form[name=Form_list]');
		form.attr("action", "/back/price/essay/update.do");
		form.find('input[name=title]').val(input_title.val());
		form.find('input[name=days]').val(input_days.val());
		form.find('input[name=price]').val(input_price.val());
		form.find('input[name=maxpage]').val(input_maxpage.val());
		form.find('input[name=price_id]').val(input_priceid.val());
		
		form.submit();
		
	}
	
	fnClose = function(el){
		$(el).closest('[class*=form-]').hide();
		$(el).closest('.section-price').find('.section-top')
			.children('button').removeClass('on');
	}
	
	fnRmEdit = function(el){
		$('#matview_'+el).hide();
		$('#matedit_'+el).show();
	}
	
	fnRmDelete = function(id){
		if(confirm("Are you sure you want to delete this?")){
			document.getElementById("Form_rm").id.value = id;
			document.getElementById("Form_rm").submit();
		}
	}
	
	fnPeEdit = function(el, type){
		if(type == "normal"){
			$('#pview_'+el).hide();
			$('#priceed_'+el).show();
		} else {
			$('#spview_'+el).hide();
			$('#spriceed_'+el).show();
		}
	}
	
	fnSubmitPe = function(){
		var form = document.getElementById("Form_priceessay");
		
		if(form.title.value == ""){
			alert("Please enter the title!");
			form.title.focus();
			return false;
		}
		
		if(form.days.value == ""){
			alert("Please enter the days!");
			form.days.focus();
			return false;
		} else {
			if(isNaN(form.days.value)){
				alert("Please enter a number for days!");
				form.days.focus();
				return false;
			}
		}
		
		if(form.price.value == ""){
			alert("Please enter the price!");
			form.price.focus();
			return false;
		} else {
			if(isNaN(form.price.value)){
				alert("Please enter a number for price!");
				form.price.focus();
				return false;
			}
		}
		
		form.submit();
	}
	
	fnDeletePe = function(id){
		if(confirm("Are you sure you want to delete this item?")){
			document.getElementById("Form_list_pe").price_id.value = id;
			document.getElementById("Form_list_pe").submit();
		}
	}
	
	fnEditWords = function(){
		$('#wordview').hide();
		$('#wordedit').show();
	}
	
	fnEditRpWords = function(){
		$('#rwordview').hide();
		$('#rwordedit').show();
	}
	
	fnUpdatewords = function(){
		var form = document.getElementById("Form_list_pe");
		if(form.words.value == ""){
			alert("Please enter the words!");
			form.words.focus();
			return false;
		} else {
			if(isNaN(form.words.value)){
				alert("Please enter a valid number for words!");
				form.words.focus();
				return false;
			}
		}
		
		form.action = "/back/price/essay/updateWords.do";
		form.submit();
	}
	
	fnUpdatewordsRp = function(){
		var form = document.getElementById("Form_list_rp");
		if(form.words.value == ""){
			alert("Please enter the words!");
			form.words.focus();
			return false;
		} else {
			if(isNaN(form.words.value)){
				alert("Please enter a valid number for words!");
				form.words.focus();
				return false;
			}
		}
		
		form.action = "/back/price/revision/updateWords.do";
		form.submit();
	}
	
	fnSubmitRp = function(){
		var form = document.getElementById("Form_pricerevision");
		
		if(form.title.value == ""){
			alert("Please input the title!");
			form.title.focus();
			return false;
		}
		
		if(form.days.value == ""){
			alert("Please input the days!");
			form.days.focus();
			return false;
		} else {
			if(isNaN(form.days.value)){
				alert("Please input a valid number for days!");
				form.days.focus();
				return false;
			}
		}
		
		if(form.price.value == ""){
			alert("Please input the price!");
			form.price.focus();
			return false;
		} else {
			if(isNaN(form.price.value)){
				alert("Please input a valid number for price!");
				form.price.focus();
				return false;
			}
		}
		
		form.submit();
	}
	fnRpEdit = function(el){
		$('#rpview_'+el).hide();
		$('#rpriceed_'+el).show();
	}
	
	fnUpdateRp = function(el){
		var par = $(el).closest('tr'),
		input_title = par.find('input[name*=title_]'),
		input_days = par.find('input[name*=days_]'),
		input_price = par.find('input[name*=price_]'),
		input_priceid = par.find('input[name*=priceid_]');
		
		
		if(input_title.val() == ""){
			alert("Please enter the title!");
			input_title.focus();
			return false;
		}
		
		if(input_days.val() == ""){
			alert("Please enter the days!");
			input_days.focus();
			return false;
		} else {
			if(isNaN(input_days.val())){
				alert("Please enter a valid number for days!");
				input_days.focus();
				return false;
			}
		}
		
		if(input_price.val() == ""){
			alert("Please enter the price!");
			input_price.focus();
			return false;
		} else {
			if(isNaN(input_price.val())){
				alert("Please enter a valid number for price!");
				input_price.focus();
				return false;
			}
		}
		
		var form = $(el).closest('form[name=Form_list]');
		form.attr("action", "/back/price/revision/update.do");
		form.find('input[name=title]').val(input_title.val());
		form.find('input[name=days]').val(input_days.val());
		form.find('input[name=price]').val(input_price.val());
		form.find('input[name=price_id]').val(input_priceid.val());
		
		form.submit();
		
	}
	
	fnDeleteRp = function(id){
		if(confirm("Are you sure you want to delete this?")){
			document.getElementById("Form_list_rp").price_id.value = id;
			document.getElementById("Form_list_rp").submit();
		}
	}
	
	fnEditSample = function(name, el){
		
		$('#'+name+'view_'+el).hide();
		$('#'+name+'edit_'+el).show();
	}
	
	fnSampleDelete = function(id){
		if(confirm("Are you sure you want to delete this sample?")){
			document.getElementById("File_list_sample").sample_id.value = id;
			document.getElementById("File_list_sample").submit();
		}
	}
	fnDownloadSample = function(file){
		var form = document.getElementById("File_list_sample");
		form.filename.value = file;
		form.action = "/back/samples/download.do";
		form.submit();
	}
</script>
<div class="admin-contents">
	<h2 class="content-title">Price Management</h2>
	<!-- Start of Category -->
	<h3 class="price-mgm-category">Essay</h3>
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Category</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<form:form name="Form_list" action="/back/category/deleteList.do" method="post">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<c:if test="${fn:length(category.list) lt 1}">
					<div><span class="pmEmpty"> No Categories</span></div>
				</c:if>
				<c:if test="${fn:length(category.list) gt 0}">
					<ul class="category-list">
					<c:forEach var="row" items="${category.list }" varStatus="i">
						<li><input type="checkbox" name="id_checks" value="${row.category_id }">${row.title }</li>					
					</c:forEach>
					</ul>
				</c:if>
				<div class="del">
					<button type="button" class="btn-img" onclick="fnDeleteList(this)"><img src="${img_src}/stm/btn/btn_admin_delete.jpg" alt="delete" /></button>
				</div>
			</div>
			</form:form>
		</div>
		<div class="form-add">
			<form:form name="Form_write" commandName="categoryCommand" action="/back/category/insert.do" method="post" enctype="multipart/form-data" >
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Category</td>
					<td class="col2"><input type="text" name="title" value="" class="ipt" /></td>
				</tr>
			</table>
			<div class="form-submit">
				 <button type="button" class="btn-img" onclick="fnSubmitCategory(this)"><img src="${img_src}/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Category -->
	
	<!-- Start of Essay Type -->
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Essay Type</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<form:form name="Form_list" action="/back/essaytype/deleteList.do" method="post">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<c:if test="${fn:length(essaytype.list) lt 1}">
					<div>
						<span class="pmEmpty"> No Essay Types</span>	
					</div>
				</c:if>
				<c:if test="${fn:length(essaytype.list) gt 0}">
					<ul class="category-list">
					<c:forEach var="row" items="${essaytype.list }" varStatus="i">
						<li><input type="checkbox" name="id_checks" value="${row.type_id }">${row.name }</li>
					</c:forEach>
					</ul> 
				</c:if>
				<button type="button" class="btn-img" onclick="fnDeleteList(this)"><img src="${img_src}/stm/btn/btn_admin_delete.jpg" alt="delete" /></button>
			</div>	
			</form:form>
		</div>
		<div class="form-add">
			<form:form name="Form_write" commandName="essaytypeCommand" action="/back/essaytype/insert.do" method="post" enctype="multipart/form-data" >
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Type of Essay: </td>
					<td class="col2"><input type="text" name="name" value="" class="ipt"/></td>
				</tr>
				<tr class="row-instructions">	
					<td class="col1">Description: </td>
					<td class="col2"><textarea name="description" class="txtarea"></textarea></td>
				</tr>
			</table>
			<div class="form-submit">
				 <button type="button" class="btn-img" onclick="fnSubmitEt(this)"><img src="${img_src}/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
		
	</div>
	<!-- End of Essay Type -->
	
	<!-- Start of Writing Format -->
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Writing Format</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<form:form name="Form_list" action="/back/writingformat/deleteList.do" method="post">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<c:if test="${fn:length(format.list) lt 1}">
					<div>
						<span class="pmEmpty"> No Essay Format</span>	
					</div>
				</c:if>
				<c:if test="${fn:length(format.list) gt 0}">
					<ul class="category-list">
					<c:forEach var="row" items="${format.list }" varStatus="i">
						<li><input type="checkbox" name="id_checks" value="${row.format_id }">${row.title }</li>
					</c:forEach>
					</ul> 
				</c:if>
				<button type="button" class="btn-img" onclick="fnDeleteList(this)"><img src="${img_src}/stm/btn/btn_admin_delete.jpg" alt="delete" /></button>
			</div>	
			</form:form>
		</div>
		<div class="form-add">
			<form:form name="Form_write" commandName="writingformatCommand" action="/back/writingformat/insert.do" method="post" enctype="multipart/form-data" >
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Writing Format: </td>
					<td class="col2"><input type="text" name="title" value="" class="ipt"/></td>
				</tr>
			</table>
			<div class="form-submit">
				 <button type="button" class="btn-img" onclick="fnSubmitEf(this)"><img src="${img_src}/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Writing Format -->
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Level</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<form:form name="Form_list" action="/back/level/deleteList.do" method="post">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<c:if test="${fn:length(level.list) lt 1}">
					<div>
						<span class="pmEmpty"> No Level</span>	
					</div>
				</c:if>
				<c:if test="${fn:length(level.list) gt 0}">
					<ul class="category-list">
					<c:forEach var="row" items="${level.list }" varStatus="i">
						<li><input type="checkbox" name="id_checks" value="${row.level_id }">${row.title }</li>
					</c:forEach>
					</ul> 
				</c:if>
				<button type="button" class="btn-img" onclick="fnDeleteList(this)"><img src="${img_src}/stm/btn/btn_admin_delete.jpg" alt="delete" /></button>
			</div>	
			</form:form>
		</div>
		<div class="form-add">
			<form:form name="Form_write" commandName="levelCommand" action="/back/level/insert.do" method="post" enctype="multipart/form-data" >
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Level: </td>
					<td class="col2"><input type="text" name="title" value="" class="ipt"/></td>
				</tr>
			</table>
			<div class="form-submit">
				 <button type="button" class="btn-img" onclick="fnSubmitLevel(this)"><img src="${img_src}/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Level -->
	
	<!-- Start of Reading Material -->
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Reading Material</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<form:form name="Form_list" id="Form_rm" action="/back/readmaterial/delete.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="description" id="description" value="" />
			<input type="hidden" name="pages" id="pages" value="" />
			<input type="hidden" name="days" id="days" value="" />
			<input type="hidden" name="price" id="price" value="" />
			<input type="hidden" name="id" id="id" value="" />
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<i class="note">* For free pages, days and price should be set to 0</i>
				<table class="tbl-admin">
					<colgroup>
						<col width="25%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th>Description</th>
							<th>Pages</th>
							<th>Days</th>
							<th>Price</th>
							<th>Edit</th>
							<th class="last">Delete</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${readmaterial.list }" varStatus="i">				
						<tr id="matview_${i.index+1 }">
							<td>${row.description }</td>
							<td>${row.pages }</td>
							<td>${row.days }</td>
							<td>${row.price } $</td>
							<td>
								<button type="button" onclick="fnRmEdit('${i.index+1}');" class="btn-img" ><img src="${img_src }/stm/btn/btn_edit_admin.png" alt="edit"/></button>
							</td>
							<td>
								<button type="button" onclick="fnRmDelete('${row.id}')" class="btn-img" ><img src="${img_src }/stm/btn/btn_delete.png" alt="delete" /></button>
							</td>
						 </tr>
						 
						 <tr id="matedit_${i.index+1 }" class="hide">
							<td><input type="text" name="description_${i.index+1 }" value="<c:out value="${row.description }" />"/></td>
							<td><input type="text" name="pages_${i.index+1 }" value="${row.pages }" class="input_words"/></td>
							<td><input type="text" name="days_${i.index+1 }" value="${row.days }" class="input_words"/></td>
							<td><input type="text" name="price_${i.index+1 }" value="${row.price }" class="input_words"/></td>
							<td>
								<button type="button" onclick="fnSubmitRm(this, 'edit')" class="btn-img"><img src="${img_src }/stm/btn/btn_admin_submit.png" alt="submit" /></button></td>
							<td>&nbsp;<input type="hidden" name="id_${i.index+1 }" id="material_id${i.index+1 }" value="${row.id }" /></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>	
			</form:form>
		</div>
		<div class="form-add">
			<form:form name="Form_write" commandName="readmaterialCommand" action="/back/readmaterial/insert.do" method="post" enctype="multipart/form-data" >
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<i class="note">* For free pages, days and price should be set to 0</i>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Description:</td>
					<td class="col2"><input type="text" name="description" value="" /></td>
				</tr>
				<tr>
					<td class="col1">Pages:</td>
					<td class="col2"><input type="text" name="pages" value="" /></td>
				</tr>
				<tr>	
					<td class="col1">Days:</td>
					<td class="col2"><input type="text" name="days" value="" /></td>
				</tr>
				<tr>	
					<td class="col1">Price:</td>
					<td class="col2"><input type="text" name="price" value="" /></td>
				</tr>
			</table>
			<div class="form-submit">
				 <button type="button" class="btn-img" onclick="fnSubmitRm(this, 'add')"><img src="${img_src}/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Reading Material -->
	
	<!-- Start of Price -->
	<div class="section-price catBox type1">
		<div class="section-top catButtons">
			<span>Price</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<form:form name="Form_list" id="Form_list_pe" action="/back/price/essay/delete.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="title" value="" />
					<input type="hidden" name="days" value="" />
					<input type="hidden" name="price" value="" />
					<input type="hidden" name="maxpage" value="" />
					<input type="hidden" name="price_id" value="" />
					<div class="addtable" id="wordview">
						<span><strong>Words Per Page: ${priceessay.get(0).words }</strong></span>
						<span>
							<button type="button" class="btn-img" onclick="fnEditWords()"><img src="${img_src }/stm/btn/btn_admin_edit.png" alt="Edit"/></button>
						</span>
					</div>
					<div class="addtable hide" id="wordedit">
						<span>Words Per Page: <input type="text" name="words" value="${priceessay.get(0).words }" class="input_words" /></span>
						<span>
							<button type="button" class="btn-img" onclick="fnUpdatewords()"><img src="${img_src }/stm/btn/btn_admin_submit.png" alt="submit"/></button>
						</span>
					</div>
					
					<div class="price-title-box">
						<h3>Normal Price</h3>
						<h3>Special Price</h3>
					</div>
					<table class="tbl-admin type1">
						<colgroup>
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="10%" />
							<col width="12%" />
							<col width="12%" />
							<col width="10%" />
							<col width="10%"  />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>Title</th>
								<th>Page</th>
								<th>Days</th>
								<th>Price</th>
								<th>Maximum Pages</th>
								<th>Edit</th>
								<th class="last">Delete</th>					
							</tr>
						</thead>
						<tbody>
							<c:forEach var="row" items="${priceessay}" varStatus="i">
							<tr id="pview_${i.index+1 }">
								<td>${i.index+1 }</td>
								<td>${row.title }</td>
								<td>${row.page }</td>
								<td>${row.days }</td>
								<td>${row.price } $</td>
								<td>
									<c:if test="${empty row.maxpage }">No Limit</c:if>
									<c:if test="${!empty row.maxpage }">${row.maxpage }</c:if>
								</td>
								<td>
									<button type="button" class="btn-img" onclick="fnPeEdit('${i.index+1}', 'normal');"><img src="${img_src }/stm/btn/btn_edit_admin.png" alt="edit"/></button>
								</td>
								<td>
									<button type="button" class="btn-img" onclick="fnDeletePe('${row.price_id }')"><img src="${img_src }/stm/btn/btn_delete.png" /></button>
								</td>
							</tr>
							
							<tr id="priceed_${i.index+1 }" class="hide">
								<td>${i.index+1 }</td>
								<td><input type="text" name="title_${i.index+1 }" value="<c:out value="${row.title }" />" class="input_words"/></td>
								<td>${row.page }</td>
								<td><input type="text" name="days_${i.index+1 }"  value="${row.days }" class="input_words"/></td>
								<td><input type="text" name="price_${i.index+1 }" value="${row.price }" class="input_words"/></td>
								<td>
									<select name="maxpage_${i.index+1 }">
										<option value="" <c:if test="${empty row.maxpage }">selected="selected"</c:if>>No Limit</option>
										<c:forEach var="pg" begin="1" end="15">
										<option value="${pg }" <c:if test="${row.maxpage eq pg }">selected="selected"</c:if>>${pg }</option>
										</c:forEach>
									</select>
								</td>
								<td colspan="2">
									<button type="button" class="btn-img" onclick="fnUpdatePe(this)" ><img src="${img_src }/stm/btn/btn_admin_submit.png" alt="submit"/></button>
									<input type="hidden" name="priceid_${i.index+1 }" value="${row.price_id }" />
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- Special Price Table -->
					<table class="tbl-admin type1">
						<colgroup>
						 	<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="10%" />
							<col width="12%" />
							<col width="12%" />
							<col width="10%" />
							<col width="10%" />	
						 </colgroup>
					  	<thead>
						 	<tr>
						  		<th>No.</th>
								<th>Title</th>
								<th>Page</th>
								<th>Days</th>
								<th>Price</th>
								<th>Maximum Pages</th>
								<th>Edit</th>
								<th class="last">Delete</th>					
						 	</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(priceessayspecial) gt 0 }">
							<c:forEach var="row" items="${priceessayspecial }" varStatus="i">
							<tr id="spview_${i.index+1 }">
								<td>${i.index+1 }</td>
								<td>${row.title }</td>
								<td>${row.page }</td>
								<td>${row.days }</td>
								<td>${row.price } $</td>
								<td>
									<c:if test="${empty row.maxpage }">No Limit</c:if>
									<c:if test="${!empty row.maxpage }">${row.maxpage }</c:if>
								</td>
								<td><button type="button" class="btn-img" onclick="fnPeEdit('${i.index+1}', 'special');"><img src="${img_src }/stm/btn/btn_edit_admin.png" alt="edit"/></button></td>
								<td>
									<button type="button" class="btn-img" onclick="fnDeletePe('${row.price_id }')"><img src="${img_src }/stm/btn/btn_delete.png" /></button>
								</td>
							</tr>
							
							<tr id="spriceed_${i.index+1 }" class="hide">
								<td>${i.index+1 }</td>
								<td><input type="text" name="title_${i.index+1 }" value="<c:out value="${row.title }" />" class="input_words"/></td>
								<td>${row.page }</td>
								<td><input type="text" name="days_${i.index+1 }" value="${row.days }" class="input_words"/></td>
								<td><input type="text" name="price_${i.index+1 }" value="${row.price }" class="input_words"/></td>
								<td>
									<select name="maxpage_${i.index+1 }" id="maxpage_${i.index+1 }">
										<option value="" <c:if test="${empty row.maxpage }">selected="selected"</c:if>>No Limit</option>
										<c:forEach var="pg" begin="1" end="15">
										<option value="${pg }" <c:if test="${row.maxpage eq pg }">selected="selected"</c:if>>${pg }</option>
										</c:forEach>
									</select>
								</td>
								<td colspan="2">
									<button type="button" class="btn-img" onclick="fnUpdatePe(this)" ><img src="${img_src }/stm/btn/btn_admin_submit.png" alt="submit"/></button>
									<input type="hidden" name="priceid_${i.index+1 }" value="${row.price_id }" />
								</td>
							</tr>
						</c:forEach>
						</c:if>
						<c:if test="${fn:length(priceessayspecial) lt 1}">
						<tr><td colspan="8">No Records</td></tr>
						</c:if>
						</tbody>
					</table>
				</form:form>
			</div>
		</div>
		<div class="form-add">
			<form:form name="Form_write" id="Form_priceessay" action="/back/price/essay/insert.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="page" value="1" />
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Title:</td>
					<td class="col2"><input type="text" name="title" value="" /></td>
				</tr>	
				<tr>
					<td class="col1">Days:</td>
					<td class="col2"><input type="text" name="days" value=""/></td>
				</tr>
				<tr>
					<td class="col1">Price:</td>
					<td class="col2"><input type="text" name="price" value="" /></td>
				</tr>
				<tr>
					<td class="col1">Maximum Pages:</td>
					<td class="col2">
						<select name="maxpage">
							<option value="">No Limit</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
						</select>
					</td>
				</tr>				
				<tr>
					<td class="col1">Special Price</td>
					<td class="col2">
						<input type="radio" name="special" value="0" checked="checked"/><label for="sp1">No</label>
						<input type="radio" name="special" value="1" /><label for="sp2">Yes</label>
					</td>
				</tr>
				<input type="hidden" name="words" value="${priceessay.get(0).words }" />
			</table>
			<div class="form-submit">
				<button type="button" class="btn-img" onclick="fnSubmitPe();"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Price -->
	
	<!-- Start of Revision Price -->
	<h3 class="price-mgm-category">Revision</h3>
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Price</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<form:form name="Form_list" id="Form_list_rp" action="/back/price/revision/delete.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="price_id" value=""/>
					<input type="hidden" name="title" value=""/>
					<input type="hidden" name="days" value=""/>
					<input type="hidden" name="price" value=""/>
					<div class="addtable" id="rwordview">
						<span><strong>Words Per Page: ${pricerevision.list.get(0).words }</strong></span>
						<span><button type="button" class="btn-img" onclick="fnEditRpWords()"><img src="${img_src }/stm/btn/btn_admin_edit.png" alt="Edit"/></button></span>
					</div>
					<div class="addtable hide" id="rwordedit">
						<span>Words Per Page: <input type="text" name="words" value="${pricerevision.list.get(0).words }" /></span>
						<span>
							<button type="button" class="btn-img" onclick="fnUpdatewordsRp()"><img src="${img_src }/stm/btn/btn_admin_submit.png" alt="submit" /></button>
						</span>
					</div>
					<table class="tbl-admin">
						<colgroup>
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>Title</th>
								<th>Page</th>
								<th>Days</th>
								<th>Price</th>
								<th>Edit</th>
								<th class="last">Delete</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="row" items="${pricerevision.list }" varStatus="i">
							<tr id="rpview_${i.index+1 }">
								<td>${i.index+1 }</td>
								<td>${row.title }</td>
								<td>${row.page }</td>
								<td>${row.days}</td>
								<td>${row.price } $</td>
								<td>
									<button type="button" class="btn-img" onclick="fnRpEdit('${i.index+1}')"><img src="${img_src }/stm/btn/btn_edit_admin.png" alt="edit" /></button>
								</td>
								<td>
									<button type="button" class="btn-img" onclick="fnDeleteRp('${row.price_id}')"><img src="${img_src }/stm/btn/btn_delete.png" alt="delete"/></button>
								</td>
							</tr>
							<tr id="rpriceed_${i.index+1 }" class="hide">
								<td>${i.index+1 }</td>
								<td><input type="text" name="title_${i.index+1 }" value="<c:out value="${row.title }" />" /></td>
								<td>${row.page }</td>
								<td><input type="text" name="days_${i.index+1 }" value="${row.days }" class="input_words"/></td>
								<td><input type="text" name="price_${i.index+1 }" value="${row.price }" class="input_words"/></td>
								<td colspan="2">
									<button type="button" class="btn-img" onclick="fnUpdateRp(this)"><img src="${img_src }/stm/btn/btn_admin_submit.png" /></button>
									<input type="hidden" name="priceid_${i.index+1 }" value="${row.price_id }" />
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</form:form>
			</div>
		</div>
		
		<div class="form-add">
			<form:form name="Form_write" action="/back/price/revision/insert.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="page" value="1" />
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat"/></button>
			</div>
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Title:</td>
					<td class="col2"><input type="text" name="title" id="title" value=""/></td>
				</tr>	
				<tr>
					<td class="col1">Days:</td>
					<td class="col2"><input type="text" name="days" id="days" value=""/></td>
				</tr>
				<tr>
					<td class="col1">Price:</td>
					<td class="col2"><input type="text" name="price" id="price" value="" /></td>
				</tr>
				<input type="hidden" name="words" value="${pricerevision.list.get(0).words }" />
			</table>
			<div class="form-submit">
				<button type="button" class="btn-img" onclick="fnSubmitRp()"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit" /></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Revision Price -->
	<!-- Start of Samples -->
	<h3 class="price-mgm-category">Samples</h3>
	<div class="section-price catBox">
		<div class="section-top catButtons">
			<span>Samples</span>
			<button type="button" onclick="fnOpenView(this)" class="btn-img">View</button>
			<button type="button" onclick="fnOpenAdd(this)" class="btn-img">Add</button>
		</div>
		<div class="form-list">
			<div class="button_close">
				<button type="button" class="btn-img" onclick="fnClose(this)"><img src="${img_src}/stm/btn/btn_blacklist.png" alt="close" id="hideCat" /></button>
			</div>
			<div class="catWrap">
				<div class="addtable"><strong>Writing</strong></div>
				<form:form name="Form_list" id="File_list_sample" action="/back/samples/delete.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="sample_id" value="" />
				<input type="hidden" name="filename" value="" />
				<table class="tbl-admin">
					<colgroup>
						<col width="10%" />
						<col width="35%" />
						<col width="35%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>No.</th>
							<th>Title</th>
							<th>File</th>
							<th class="last">Delete</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="row" items="${samples_essay.list }" varStatus="i">
					<tr id="esampleview_${i.index+1 }">
						<td>${i.index+1 }</td>
						<td>${row.title }</td>
						<td><a href="javascript:void(0)" onclick="fnDownloadSample('<c:out value="${row.file }" />')">${row.file }</a></td>
						<td>
							<button type="button" onclick="fnSampleDelete('<c:out value="${row.sample_id}" />')" class="btn-img"><img src="${img_src }/stm/btn/btn_delete.png" alt="delete" /></button>
						</td>
					 </tr>
					</c:forEach>
					</tbody>
				</table>
				<span class="admin-price-spacer">&nbsp;</span>
				<div class="addtable"><strong>Revision</strong></div>
				<table class="tbl-admin">
					<colgroup>
						<col width="10%" />
						<col width="35%" />
						<col width="35%" />
						<col width="10%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>Title</th>
						<th>File</th>
						<th>Delete</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="row" items="${samples_revision.list }" varStatus="i">
					<tr id="rsampleview_${i.index+1 }">
						<td>${i.index+1 }</td>
						<td>${row.title }</td>
						<td><a href="javascript:void(0)" onclick="fnDownloadSample('<c:out value="${row.file }" />')">${row.file }</a></td>
						<td>
							<button type="button" onclick="fnSampleDelete('<c:out value="${row.sample_id}" />')" class="btn-img"><img src="${img_src }/stm/btn/btn_delete.png" alt="delete" /></button>
						</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
				<span class="admin-price-spacer">&nbsp;</span>
				<div class="addtable"><strong>Project</strong></div>
				<table class="tbl-admin">
					<colgroup>
						<col width="10%" />
						<col width="35%" />
						<col width="35%" />
						<col width="10%" />
					</colgroup>
					<thead>
					<tr>
						<th>No.</th>
						<th>Title</th>
						<th>File</th>
						<th>Delete</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="row" items="${samples_project.list}" varStatus="i">
					<tr id="matview_${i.index+1 }">
						<td>${i.index+1 }</td>
						<td>${row.title }</td>
						<td><a href="javascript:void(0)" onclick="fnDownloadSample('<c:out value="${row.file }" />')">${row.file }</a></td>
						<td>
							<button type="button" onclick="fnSampleDelete('<c:out value="${row.sample_id}" />')" class="btn-img"><img src="${img_src }/stm/btn/btn_delete.png" alt="delete" /></button>
						</td>
					 </tr>
					</tbody>
					</c:forEach>
				</table>
			</div>
			</form:form>
		</div>
		
		<div class="form-add">
			<form:form name="Form_write" action="/back/samples/insert.do" method="post" enctype="multipart/form-data">
			<table class="tbl-order-form">
				<tr>
					<td class="col1">Type</td>
					<td class="col2">
						<select name="type" id="type">
							<option value="essay">Essay</option>
							<option value="revision">Revision</option>
							<option value="project">Project</option>
						</select>
					</td>
				</tr>	
				<tr>
					<td class="col1">Title</td>
					<td class="col2"><input type="text" name="title" id="title" value="" class="ipt" /></td>
				</tr>
				<tr>
					<td class="col1">File</td>
					<td class="col2"><input type="file" name="file" id="file" value=""/></td>
				</tr>
			</table>
			<div class="form-submit">
				<button type="submit" class="btn-img"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit"/></button>
			</div>
			</form:form>
		</div>
	</div>
	<!-- End of Samples -->
</div>