<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<validator:javascript formName="userCommand" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javascript">
	doPreSubmit = function(f){
		var form = document.Form_officer;
	
		if(f.email.value != ''){
			if(!isValidEmail(f.email)){
				alert('Please enter a valid email address!');
				f.email.focus();
				return false;
			}
		} else {
			alert('Please enter the email address!');
			f.email.focus();
			return false;
		}
		if(f.password.value != f.repassword.value){
			alert('Your passwords are not the same!');
			f.password.focus();
			return false;
		}
		
		return true;
	}
	
	fnCancel = function(){
		location.href = "/back/user/officers/list.do";
	}
</script>

<div class="admin-contents">
	<h2 class="content-title">Officer Update</h2>
	<form:form name="Form_officer" commandName="userCommand" action="${url }?${params }" method="post" enctype="multipart/form-data" onsubmit="return doSubmit(this, 'UserCommand');">
	<input type="hidden" name="user_id" value="${userCommand.user_id }" />
	<table class="tbl-admin-form">
		<tr>
			<td class="col1">Email Address</td>
			<td class="col2"><input type="text" name="email" value="${userCommand.email }" class="ipt"/></td>
		</tr>
		<tr>
			<td class="col1">Name</td>
			<td class="col2"><input type="text" name="name" value="${userCommand.name }" class="ipt" /></td>
		</tr>
		<tr>
			<td class="col1">Password</td>
			<td class="col2"><input type="password" name="password" value="" class="ipt"/></td>
		</tr>
		<c:if test="${empty userCommand.password }">
		<tr>
			<td class="col1">Repeat Password</td>
			<td class="col2"><input type="password" name="repassword" value="" class="ipt"/></td>
		</tr>
		</c:if>
		<tr>
			<td class="col1">Gender</td>
			<td class="col2">
				<input type="radio" name="gender" value="male" id="male" <c:if test="${userCommand.gender eq 'male'  }">checked="checked"</c:if>/><label for="male">Male</label>
				<input type="radio" name="gender" value="female" id="female" <c:if test="${userCommand.gender eq 'female'  }">checked="checked"</c:if>/><label for="female">Female</label>
			</td>
		</tr>
		<tr>
			<td class="col1">Country</td>
			<td class="col2"><input type="text" name="country" value="${userCommand.country }" class="ipt"/></td>
		</tr>
		<tr>
			<td class="col1">Contact Number</td>
			<td class="col2"><input type="text" name="telephone" value="${userCommand.telephone }" class="ipt"/></td>
		</tr>
		<tr>
			<td class="col1">Position</td>
			<td class="col2">
				<select name="position_id" class="ipt">
					<option value="1" <c:if test="${userCommand.position_id eq '1' }">selected="selected"</c:if>>Manager</option>
					<option value="2" <c:if test="${userCommand.position_id eq '2' }">selected="selected"</c:if>>Writer</option>
				</select>
			</td>
		</tr>
	</table>
	<div class="admin-form-btns">
		<input type="button" value="Cancel" onclick="fnCancel()"/>
		<input type="submit" value="Submit" />
	</div>
	</form:form>
</div>