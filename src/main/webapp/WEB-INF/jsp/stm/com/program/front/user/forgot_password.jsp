<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>

<script type="text/javascript">
	fnSubmitEmail = function(){
		var f = document.Form_write;
		if(f.email.value == ""){
			alert("Please enter your email address!")
			f.email.focus();
			return false;
		} else {
			if(!isValidEmail(f.email)){
				alert("Please enter a valid email address!");
				f.email.focus();
				return false;
			}
		}
		
		f.submit();
	}
</script>
<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Password Retrieval</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<form:form name="Form_write" action="${url }?${param }" method="post" >
	<span class="process-title"><strong>Please enter your email address below to retrieve your password:</strong></span>
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Email Address</td>
			<td class="col2">
			<input type="text" name="email" class="ipt" />&nbsp;
			</td>
		</tr>
		
	</table>
	<span class="form-submit">
		<button type="button" class="btn-img" onclick="fnSubmitEmail()"><img src="${img_src }/stm/btn/btn_submit.png" alt="submit" /></button></span>
	</form:form>
</div>
						