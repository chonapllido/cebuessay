<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<validator:javascript formName="userCommand" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">

$(function(){
	fnDrawCaptcha();
});
	fnIdCheck = function(){
	    var email = document.Form_register.email.value,
	    	userid = document.Form_register.user_id.value,
	    	url = "<c:url value='/front/user/idcheck.do?email="+email+"&userid="+userid+"'/>",
	        left = (screen.width/2)-(480/2),
	    	top = (screen.height/2)-(500/2),
	   	 	param = "width=600,height=500,left="+left+",top="+top+",scrollbar=no,status=no,resizable=yes";
	   
	   	 	window.open(url, "myWindow", param);
	}
	
	fnDrawCaptcha = function(){
		var a = Math.ceil(Math.random() * 10)+ '',
          b = Math.ceil(Math.random() * 10)+ '',       
          c = Math.ceil(Math.random() * 10)+ '',  
          d = Math.ceil(Math.random() * 10)+ '',
          code = a+' '+b+' '+c+' '+d;
		document.Form_register.captcha_confirm.value = a+b+c+d;
		$('#captcha-text').text(code);
	}
	
	doPreSubmit = function(f){
		if(! f.accept_terms.checked){
			alert('You have to accept the terms and conditions!')
			f.accept_terms.focus();
			return false;			
		}
		
		if(f.idChecked.value == 'N'){
			alert('Please verify your email address!')
			f.email.focus();
			return false;
		}
		if(f.email.value != f.email2.value){
			alert('Your emails are not the same!');
			f.email.focus();
			return false;
		}

		if(f.password.value != f.repassword.value){
			alert('Your passwords are not the same!');
			f.password.focus();
			return false;
		}
		if(f.captcha.value != f.captcha_confirm.value){
			alert('Wrong content! Please enter the content again!');
			f.captcha.focus();
			return false;
		}
		
		return true;
	}
	
	fnPromptEmail = function(){
		alert("Please click Check Duplicate button to enter your email address!");
	}
</script>

<div class="content-center">
	<div class="article-center">
		<div class="article-center-inner">
			<h2 class="article-title">Registration</h2>
		</div>
	</div>
	<span class="order-spacer">&nbsp;</span>
	<form:form name="Form_register" commandName="userCommand" action="${url}?${param}" method="post" enctype="multipart/form-data" onsubmit="return doSubmit(this, 'UserCommand');" >
	<input type="hidden" name="user_id" value="${userCommand.user_id }" />
	<input type="hidden" name="idChecked" id="idChecked" value="N"/>	
	<input type="hidden" name="captcha_confirm" value="" />
	<input type="hidden" name="position_id" value="3" />
	<table class="tbl-order-form">
		<tr>
			<td class="col1">Email Address</td>
			<td class="col2">
				<input type="text" name="email" value="${userCommand.email }" class="ipt" readonly="true" onKeypress="fnPromptEmail()"/>&nbsp;
				<button type="button" onclick="fnIdCheck();">Check Duplicate</button>
			</td>
		</tr>
		<tr>
			<td class="col1">Confirm Email Address</td>
			<td class="col2">
			<input type="text" name="email2" value="${userCommand.email}" class="ipt" />&nbsp;
			</td>
		</tr>
		<tr>
			<td class="col1">Name</td>
			<td class="col2"><input type="text" name="name" value="${userCommand.name}" class="ipt" />
			</td>
		</tr>
		<tr>
			<td class="col1">Password</td>
			<td class="col2"><input type="password" name="password" value="${userCommand.password}" maxlength="20" class="ipt" /></td>
		</tr>
		<tr>
			<td class="col1">Repeat Password</td>
			<td class="col2"><input type="password" name="repassword" value="${userCommand.password}" maxlength="20" class="ipt" /></td>
		</tr>
		<tr>
			<td class="col1">Gender</td>
			<td class="col2">
				<input type="radio" name="gender" value="male" <c:if test="${userCommand.gender == 'male'}">checked="checked"</c:if>/><label for="male">Male</label>
				<input type="radio" name="gender" value="female" <c:if test="${userCommand.gender != 'male'}">checked="checked"</c:if> /><label for="female">Female</label>
			</td>
		</tr>
		<tr>
			<td class="col1">Telephone</td>
			<td class="col2"><input type="text" name="telephone" value="${userCommand.telephone}" maxlength="25" class="ipt" /></td>
		</tr>
		<tr>
			<td class="col1">Country</td>
			<td class="col2">
				<select name="country" id="country-selector" autofocus="autofocus" autocorrect="off" autocomplete="off" class="ipt">
					<option value="" selected="selected">Select Country</option>
					<option value="Afganistan" <c:if test="${userCommand.country == 'Afganistan' }">selected="selected"</c:if>>Afghanistan</option>
					<option value="Albania" <c:if test="${userCommand.country == 'Albania' }">selected="selected"</c:if>>Albania</option>
					<option value="Algeria" <c:if test="${userCommand.country == 'Algeria' }">selected="selected"</c:if>>Algeria</option>
					<option value="American Samoa" <c:if test="${userCommand.country == 'American Samoa' }">selected="selected"</c:if>>American Samoa</option>
					<option value="Andorra" <c:if test="${userCommand.country == 'Andorra' }">selected="selected"</c:if>>Andorra</option>
					<option value="Angola" <c:if test="${userCommand.country == 'Angola' }">selected="selected"</c:if>>Angola</option>
					<option value="Anguilla" <c:if test="${userCommand.country == 'Anguilla' }">selected="selected"</c:if>>Anguilla</option>
					<option value="Antigua &amp; Barbuda" <c:if test="${userCommand.country == 'Antigua &amp; Barbuda' }">selected="selected"</c:if>>Antigua &amp; Barbuda</option>
					<option value="Argentina" <c:if test="${userCommand.country == 'Argentina' }">selected="selected"</c:if>>Argentina</option>
					<option value="Armenia" <c:if test="${userCommand.country == 'Armenia' }">selected="selected"</c:if>>Armenia</option>
					<option value="Aruba" <c:if test="${userCommand.country == 'Aruba' }">selected="selected"</c:if>>Aruba</option>
					<option value="Australia" <c:if test="${userCommand.country == 'Australia' }">selected="selected"</c:if>>Australia</option>
					<option value="Austria" <c:if test="${userCommand.country == 'Austria' }">selected="selected"</c:if>>Austria</option>
					<option value="Azerbaijan" <c:if test="${userCommand.country == 'Azerbaijan' }">selected="selected"</c:if>>Azerbaijan</option>
					<option value="Bahamas" <c:if test="${userCommand.country == 'Bahamas' }">selected="selected"</c:if>>Bahamas</option>
					<option value="Bahrain" <c:if test="${userCommand.country == 'Bahrain' }">selected="selected"</c:if>>Bahrain</option>
					<option value="Bangladesh" <c:if test="${userCommand.country == 'Bangladesh' }">selected="selected"</c:if>>Bangladesh</option>
					<option value="Barbados" <c:if test="${userCommand.country == 'Barbados' }">selected="selected"</c:if>>Barbados</option>
					<option value="Belarus" <c:if test="${userCommand.country == 'Belarus' }">selected="selected"</c:if>>Belarus</option>
					<option value="Belgium" <c:if test="${userCommand.country == 'Belgium' }">selected="selected"</c:if>>Belgium</option>
					<option value="Belize" <c:if test="${userCommand.country == 'Belize' }">selected="selected"</c:if>>Belize</option>
					<option value="Benin" <c:if test="${userCommand.country == 'Benin' }">selected="selected"</c:if>>Benin</option>
					<option value="Bermuda" <c:if test="${userCommand.country == 'Bermuda' }">selected="selected"</c:if>>Bermuda</option>
					<option value="Bhutan" <c:if test="${userCommand.country == 'Bhutan' }">selected="selected"</c:if>>Bhutan</option>
					<option value="Bolivia" <c:if test="${userCommand.country == 'Bolivia' }">selected="selected"</c:if>>Bolivia</option>
					<option value="Bonaire" <c:if test="${userCommand.country == 'Bonaire' }">selected="selected"</c:if>>Bonaire</option>
					<option value="Bosnia &amp; Herzegovina" <c:if test="${userCommand.country == 'Bosnia &amp; Herzegovina' }">selected="selected"</c:if> >Bosnia &amp; Herzegovina</option>
					<option value="Botswana" <c:if test="${userCommand.country == 'Botswana' }">selected="selected"</c:if>>Botswana</option>
					<option value="Brazil" <c:if test="${userCommand.country == 'Brazil' }">selected="selected"</c:if>>Brazil</option>
					<option value="Brunei" <c:if test="${userCommand.country == 'Brunei' }">selected="selected"</c:if>>Brunei</option>
					<option value="Bulgaria" <c:if test="${userCommand.country == 'Bulgaria' }">selected="selected"</c:if>>Bulgaria</option>
					<option value="Burkina Faso" <c:if test="${userCommand.country == 'Burkina Faso' }">selected="selected"</c:if>>Burkina Faso</option>
					<option value="Burundi" <c:if test="${userCommand.country == 'Burundi' }">selected="selected"</c:if>>Burundi</option>
					<option value="Cambodia" <c:if test="${userCommand.country == 'Cambodia' }">selected="selected"</c:if>>Cambodia</option>
					<option value="Cameroon" <c:if test="${userCommand.country == 'Cameroon' }">selected="selected"</c:if>>Cameroon</option>
					<option value="Canada" <c:if test="${userCommand.country == 'Canada' }">selected="selected"</c:if>>Canada</option>
					<option value="Canary Islands" <c:if test="${userCommand.country == 'Canary Islands' }">selected="selected"</c:if>>Canary Islands</option>
					<option value="Cape Verde" <c:if test="${userCommand.country == 'Cape Verde' }">selected="selected"</c:if>>Cape Verde</option>
					<option value="Cayman Islands" <c:if test="${userCommand.country == 'Cayman Islands' }">selected="selected"</c:if>>Cayman Islands</option>
					<option value="Central African Republic" <c:if test="${userCommand.country == 'Central African Republic' }">selected="selected"</c:if>>Central African Republic</option>
					<option value="Chad" <c:if test="${userCommand.country == 'Chad' }">selected="selected"</c:if>>Chad</option>
					<option value="Channel Islands" <c:if test="${userCommand.country == 'Channel Islands' }">selected="selected"</c:if>>Channel Islands</option>
					<option value="Chile" <c:if test="${userCommand.country == 'Chile' }">selected="selected"</c:if>>Chile</option>
					<option value="China" <c:if test="${userCommand.country == 'China' }">selected="selected"</c:if>>China</option>
					<option value="Christmas Island" <c:if test="${userCommand.country == 'Christmas Island' }">selected="selected"</c:if>>Christmas Island</option>
					<option value="Cocos Island" <c:if test="${userCommand.country == 'Cocos Island' }">selected="selected"</c:if>>Cocos Island</option>
					<option value="Colombia" <c:if test="${userCommand.country == 'Colombia' }">selected="selected"</c:if>>Colombia</option>
					<option value="Comoros" <c:if test="${userCommand.country == 'Comoros' }">selected="selected"</c:if>>Comoros</option>
					<option value="Congo" <c:if test="${userCommand.country == 'Congo' }">selected="selected"</c:if>>Congo</option>
					<option value="Cook Islands" <c:if test="${userCommand.country == 'Cook Islands' }">selected="selected"</c:if>>Cook Islands</option>
					<option value="Costa Rica" <c:if test="${userCommand.country == 'Costa Rica' }">selected="selected"</c:if>>Costa Rica</option>
					<option value="Cote DIvoire" <c:if test="${userCommand.country == 'Cote DIvoire' }">selected="selected"</c:if>>Cote D'Ivoire</option>
					<option value="Croatia" <c:if test="${userCommand.country == 'Croatia' }">selected="selected"</c:if>>Croatia</option>
					<option value="Cuba" <c:if test="${userCommand.country == 'Cuba' }">selected="selected"</c:if>>Cuba</option>
					<option value="Curaco" <c:if test="${userCommand.country == 'Curaco' }">selected="selected"</c:if>>Curacao</option>
					<option value="Cyprus" <c:if test="${userCommand.country == 'Cyprus' }">selected="selected"</c:if>>Cyprus</option>
					<option value="Czech Republic" <c:if test="${userCommand.country == 'Czech Republic' }">selected="selected"</c:if>>Czech Republic</option>
					<option value="Denmark" <c:if test="${userCommand.country == 'Denmark' }">selected="selected"</c:if>>Denmark</option>
					<option value="Djibouti" <c:if test="${userCommand.country == 'Djibouti' }">selected="selected"</c:if>>Djibouti</option>
					<option value="Dominica" <c:if test="${userCommand.country == 'Dominica' }">selected="selected"</c:if>>Dominica</option>
					<option value="Dominican Republic" <c:if test="${userCommand.country == 'Dominican Republic' }">selected="selected"</c:if>>Dominican Republic</option>
					<option value="East Timor" <c:if test="${userCommand.country == 'East Timor' }">selected="selected"</c:if>>East Timor</option>
					<option value="Ecuador" <c:if test="${userCommand.country == 'Ecuador' }">selected="selected"</c:if>>Ecuador</option>
					<option value="Egypt" <c:if test="${userCommand.country == 'Egypt' }">selected="selected"</c:if>>Egypt</option>
					<option value="El Salvador" <c:if test="${userCommand.country == 'El Salvador' }">selected="selected"</c:if>>El Salvador</option>
					<option value="Equatorial Guinea" <c:if test="${userCommand.country == 'Equatorial Guinea' }">selected="selected"</c:if>>Equatorial Guinea</option>
					<option value="Eritrea" <c:if test="${userCommand.country == 'Eritrea' }">selected="selected"</c:if>>Eritrea</option>
					<option value="Estonia" <c:if test="${userCommand.country == 'Estonia' }">selected="selected"</c:if>>Estonia</option>
					<option value="Ethiopia" <c:if test="${userCommand.country == 'Ethiopia' }">selected="selected"</c:if>>Ethiopia</option>
					<option value="Falkland Islands" <c:if test="${userCommand.country == 'Falkland Islands' }">selected="selected"</c:if>>Falkland Islands</option>
					<option value="Faroe Islands" <c:if test="${userCommand.country == 'Faroe Islands' }">selected="selected"</c:if>>Faroe Islands</option>
					<option value="Fiji" <c:if test="${userCommand.country == 'Fiji' }">selected="selected"</c:if>>Fiji</option>
					<option value="Finland" <c:if test="${userCommand.country == 'Finland' }">selected="selected"</c:if>>Finland</option>
					<option value="France" <c:if test="${userCommand.country == 'France' }">selected="selected"</c:if>>France</option>
					<option value="French Guiana" <c:if test="${userCommand.country == 'French Guiana' }">selected="selected"</c:if>>French Guiana</option>
					<option value="French Polynesia" <c:if test="${userCommand.country == 'French Polynesia' }">selected="selected"</c:if>>French Polynesia</option>
					<option value="French Southern Ter" <c:if test="${userCommand.country == 'French Southern Ter' }">selected="selected"</c:if>>French Southern Ter</option>
					<option value="Gabon" <c:if test="${userCommand.country == 'Gabon' }">selected="selected"</c:if>>Gabon</option>
					<option value="Gambia" <c:if test="${userCommand.country == 'Gambia' }">selected="selected"</c:if>>Gambia</option>
					<option value="Georgia" <c:if test="${userCommand.country == 'Georgia' }">selected="selected"</c:if>>Georgia</option>
					<option value="Germany" <c:if test="${userCommand.country == 'Germany' }">selected="selected"</c:if>>Germany</option>
					<option value="Ghana" <c:if test="${userCommand.country == 'Ghana' }">selected="selected"</c:if>>Ghana</option>
					<option value="Gibraltar" <c:if test="${userCommand.country == 'Gibraltar' }">selected="selected"</c:if>>Gibraltar</option>
					<option value="Great Britain" <c:if test="${userCommand.country == 'Great Britain' }">selected="selected"</c:if>>Great Britain</option>
					<option value="Greece" <c:if test="${userCommand.country == 'Greece' }">selected="selected"</c:if>>Greece</option>
					<option value="Greenland" <c:if test="${userCommand.country == 'Greenland' }">selected="selected"</c:if>>Greenland</option>
					<option value="Grenada" <c:if test="${userCommand.country == 'Grenada' }">selected="selected"</c:if>>Grenada</option>
					<option value="Guadeloupe" <c:if test="${userCommand.country == 'Guadeloupe' }">selected="selected"</c:if>>Guadeloupe</option>
					<option value="Guam" <c:if test="${userCommand.country == 'Guam' }">selected="selected"</c:if>>Guam</option>
					<option value="Guatemala" <c:if test="${userCommand.country == 'Guatemala' }">selected="selected"</c:if>>Guatemala</option>
					<option value="Guinea" <c:if test="${userCommand.country == 'Guinea' }">selected="selected"</c:if>>Guinea</option>
					<option value="Guyana" <c:if test="${userCommand.country == 'Guyana' }">selected="selected"</c:if>>Guyana</option>
					<option value="Haiti" <c:if test="${userCommand.country == 'Haiti' }">selected="selected"</c:if>>Haiti</option>
					<option value="Hawaii" <c:if test="${userCommand.country == 'Hawaii' }">selected="selected"</c:if>>Hawaii</option>
					<option value="Honduras" <c:if test="${userCommand.country == 'Honduras' }">selected="selected"</c:if>>Honduras</option>
					<option value="Hong Kong" <c:if test="${userCommand.country == 'v' }">selected="selected"</c:if>>Hong Kong</option>
					<option value="Hungary" <c:if test="${userCommand.country == 'Hungary' }">selected="selected"</c:if>>Hungary</option>
					<option value="Iceland" <c:if test="${userCommand.country == 'Iceland' }">selected="selected"</c:if>>Iceland</option>
					<option value="India" <c:if test="${userCommand.country == 'India' }">selected="selected"</c:if>>India</option>
					<option value="Indonesia" <c:if test="${userCommand.country == 'Indonesia' }">selected="selected"</c:if>>Indonesia</option>
					<option value="Iran" <c:if test="${userCommand.country == 'Iran' }">selected="selected"</c:if>>Iran</option>
					<option value="Iraq" <c:if test="${userCommand.country == 'Iraq' }">selected="selected"</c:if>>Iraq</option>
					<option value="Ireland" <c:if test="${userCommand.country == 'Ireland' }">selected="selected"</c:if>>Ireland</option>
					<option value="Isle of Man" <c:if test="${userCommand.country == 'Isle of Man' }">selected="selected"</c:if>>Isle of Man</option>
					<option value="Israel" <c:if test="${userCommand.country == 'v' }">selected="selected"</c:if>>Israel</option>
					<option value="Italy" <c:if test="${userCommand.country == 'Italy' }">selected="selected"</c:if>>Italy</option>
					<option value="Jamaica" <c:if test="${userCommand.country == 'Jamaica' }">selected="selected"</c:if>>Jamaica</option>
					<option value="Japan" <c:if test="${userCommand.country == 'Japan' }">selected="selected"</c:if>>Japan</option>
					<option value="Jordan" <c:if test="${userCommand.country == 'Jordan' }">selected="selected"</c:if>>Jordan</option>
					<option value="Kazakhstan" <c:if test="${userCommand.country == 'Kazakhstan' }">selected="selected"</c:if>>Kazakhstan</option>
					<option value="Kenya" <c:if test="${userCommand.country == 'Kenya' }">selected="selected"</c:if>>Kenya</option>
					<option value="Kiribati" <c:if test="${userCommand.country == 'Kiribati' }">selected="selected"</c:if>>Kiribati</option>
					<option value="North Korea" <c:if test="${userCommand.country == 'North Korea' }">selected="selected"</c:if>>North Korea</option>
					<option value="South Korea" <c:if test="${userCommand.country == 'South Korea' }">selected="selected"</c:if>>South Korea</option>
					<option value="Kuwait" <c:if test="${userCommand.country == 'Kuwait' }">selected="selected"</c:if>>Kuwait</option>
					<option value="Kyrgyzstan" <c:if test="${userCommand.country == 'Kyrgyzstan' }">selected="selected"</c:if>>Kyrgyzstan</option>
					<option value="Laos" <c:if test="${userCommand.country == 'Laos' }">selected="selected"</c:if>>Laos</option>
					<option value="Latvia" <c:if test="${userCommand.country == 'Latvia' }">selected="selected"</c:if>>Latvia</option>
					<option value="Lebanon" <c:if test="${userCommand.country == 'Lebanon' }">selected="selected"</c:if>>Lebanon</option>
					<option value="Lesotho" <c:if test="${userCommand.country == 'Lesotho' }">selected="selected"</c:if>>Lesotho</option>
					<option value="Liberia" <c:if test="${userCommand.country == 'Liberia' }">selected="selected"</c:if>>Liberia</option>
					<option value="Libya" <c:if test="${userCommand.country == 'Libya' }">selected="selected"</c:if>>Libya</option>
					<option value="Liechtenstein" <c:if test="${userCommand.country == 'Liechtenstein' }">selected="selected"</c:if>>Liechtenstein</option>
					<option value="Lithuania" <c:if test="${userCommand.country == 'Lithuania' }">selected="selected"</c:if>>Lithuania</option>
					<option value="Luxembourg" <c:if test="${userCommand.country == 'Luxembourg' }">selected="selected"</c:if>>Luxembourg</option>
					<option value="Macau" <c:if test="${userCommand.country == 'Macau' }">selected="selected"</c:if>>Macau</option>
					<option value="Macedonia" <c:if test="${userCommand.country == 'Macedonia' }">selected="selected"</c:if>>Macedonia</option>
					<option value="Madagascar" <c:if test="${userCommand.country == 'Madagascar' }">selected="selected"</c:if>>Madagascar</option>
					<option value="Malaysia" <c:if test="${userCommand.country == 'Malaysia' }">selected="selected"</c:if>>Malaysia</option>
					<option value="Malawi" <c:if test="${userCommand.country == 'Malawi' }">selected="selected"</c:if>>Malawi</option>
					<option value="Maldives" <c:if test="${userCommand.country == 'Maldives' }">selected="selected"</c:if>>Maldives</option>
					<option value="Mali" <c:if test="${userCommand.country == 'Mali' }">selected="selected"</c:if>>Mali</option>
					<option value="Malta" <c:if test="${userCommand.country == 'Malta' }">selected="selected"</c:if>>Malta</option>
					<option value="Marshall Islands" <c:if test="${userCommand.country == 'Marshall Islands' }">selected="selected"</c:if>>Marshall Islands</option>
					<option value="Martinique" <c:if test="${userCommand.country == 'Martinique' }">selected="selected"</c:if>>Martinique</option>
					<option value="Mauritania"> <c:if test="${userCommand.country == 'Mauritania' }">selected="selected"</c:if>Mauritania</option>
					<option value="Mauritius" <c:if test="${userCommand.country == 'Mauritius' }">selected="selected"</c:if>>Mauritius</option>
					<option value="Mayotte" <c:if test="${userCommand.country == 'Mayotte' }">selected="selected"</c:if>>Mayotte</option>
					<option value="Mexico" <c:if test="${userCommand.country == 'Mexico' }">selected="selected"</c:if>>Mexico</option>
					<option value="Midway Islands" <c:if test="${userCommand.country == 'Midway Islands' }">selected="selected"</c:if>>Midway Islands</option>
					<option value="Moldova" <c:if test="${userCommand.country == 'Moldova' }">selected="selected"</c:if>>Moldova</option>
					<option value="Monaco" <c:if test="${userCommand.country == 'Monaco' }">selected="selected"</c:if>>Monaco</option>
					<option value="Mongolia" <c:if test="${userCommand.country == 'Mongolia' }">selected="selected"</c:if>>Mongolia</option>
					<option value="Montserrat" <c:if test="${userCommand.country == 'Montserrat' }">selected="selected"</c:if>>Montserrat</option>
					<option value="Morocco" <c:if test="${userCommand.country == 'Morocco' }">selected="selected"</c:if>>Morocco</option>
					<option value="Mozambique" <c:if test="${userCommand.country == 'Mozambique' }">selected="selected"</c:if>>Mozambique</option>
					<option value="Myanmar" <c:if test="${userCommand.country == 'Myanmar' }">selected="selected"</c:if>>Myanmar</option>
					<option value="Nambia" <c:if test="${userCommand.country == 'Nambia' }">selected="selected"</c:if>>Nambia</option>
					<option value="Nauru" <c:if test="${userCommand.country == 'Nauru' }">selected="selected"</c:if>>Nauru</option>
					<option value="Nepal" <c:if test="${userCommand.country == 'Nepal' }">selected="selected"</c:if>>Nepal</option>
					<option value="Netherland Antilles" <c:if test="${userCommand.country == 'Netherland Antilles' }">selected="selected"</c:if>>Netherland Antilles</option>
					<option value="Netherlands" <c:if test="${userCommand.country == 'Netherlands' }">selected="selected"</c:if>>Netherlands (Holland, Europe)</option>
					<option value="Nevis" <c:if test="${userCommand.country == 'Nevis' }">selected="selected"</c:if>>Nevis</option>
					<option value="New Caledonia" <c:if test="${userCommand.country == 'New Caledonia' }">selected="selected"</c:if>>New Caledonia</option>
					<option value="New Zealand" <c:if test="${userCommand.country == 'New Zealand' }">selected="selected"</c:if>>New Zealand</option>
					<option value="Nicaragua" <c:if test="${userCommand.country == 'Nicaragua' }">selected="selected"</c:if>>Nicaragua</option>
					<option value="Niger" <c:if test="${userCommand.country == 'Niger' }">selected="selected"</c:if>>Niger</option>
					<option value="Nigeria" <c:if test="${userCommand.country == 'Nigeria' }">selected="selected"</c:if>>Nigeria</option> 
					<option value="Niue" <c:if test="${userCommand.country == 'Niue' }">selected="selected"</c:if>>Niue</option>
					<option value="Norfolk Island" <c:if test="${userCommand.country == 'Norfolk Island' }">selected="selected"</c:if>>Norfolk Island</option>
					<option value="Norway" <c:if test="${userCommand.country == 'Norway' }">selected="selected"</c:if>>Norway</option>
					<option value="Oman" <c:if test="${userCommand.country == 'Oman' }">selected="selected"</c:if>>Oman</option>
					<option value="Pakistan" <c:if test="${userCommand.country == 'Pakistan' }">selected="selected"</c:if>>Pakistan</option>
					<option value="Palau Island" <c:if test="${userCommand.country == 'Palau Island' }">selected="selected"</c:if>>Palau Island</option>
					<option value="Palestine" <c:if test="${userCommand.country == 'Palestine' }">selected="selected"</c:if>>Palestine</option>
					<option value="Panama" <c:if test="${userCommand.country == 'Panama' }">selected="selected"</c:if>>Panama</option>
					<option value="Papua New Guinea" <c:if test="${userCommand.country == 'Papua New Guinea' }">selected="selected"</c:if>>Papua New Guinea</option>
					<option value="Paraguay" <c:if test="${userCommand.country == 'Paraguay' }">selected="selected"</c:if>>Paraguay</option>
					<option value="Peru" <c:if test="${userCommand.country == 'Peru' }">selected="selected"</c:if>>Peru</option>
					<option value="Philipines" <c:if test="${userCommand.country == 'Philipines' }">selected="selected"</c:if>>Philippines</option>
					<option value="Pitcairn Island" <c:if test="${userCommand.country == 'Pitcairn Island' }">selected="selected"</c:if>>Pitcairn Island</option>
					<option value="Poland" <c:if test="${userCommand.country == 'Poland' }">selected="selected"</c:if>>Poland</option>
					<option value="Portugal" <c:if test="${userCommand.country == 'Portugal' }">selected="selected"</c:if>>Portugal</option>
					<option value="Puerto Rico" <c:if test="${userCommand.country == 'Puerto Rico' }">selected="selected"</c:if>>Puerto Rico</option>
					<option value="Qatar" <c:if test="${userCommand.country == 'Qatar' }">selected="selected"</c:if>>Qatar</option>
					<option value="Republic of Montenegro" <c:if test="${userCommand.country == 'Republic of Montenegro' }">selected="selected"</c:if>>Republic of Montenegro</option>
					<option value="Republic of Serbia" <c:if test="${userCommand.country == 'Republic of Serbia' }">selected="selected"</c:if>>Republic of Serbia</option>
					<option value="Reunion" <c:if test="${userCommand.country == 'Reunion' }">selected="selected"</c:if>>Reunion</option>
					<option value="Romania" <c:if test="${userCommand.country == 'Romania' }">selected="selected"</c:if>>Romania</option>
					<option value="Russia" <c:if test="${userCommand.country == 'Russia' }">selected="selected"</c:if>>Russia</option>
					<option value="Rwanda" <c:if test="${userCommand.country == 'Rwanda' }">selected="selected"</c:if>>Rwanda</option>
					<option value="Saipan" <c:if test="${userCommand.country == 'Saipan' }">selected="selected"</c:if>>Saipan</option>
					<option value="Samoa" <c:if test="${userCommand.country == 'Samoa' }">selected="selected"</c:if>>Samoa</option>
					<option value="Samoa American" <c:if test="${userCommand.country == 'Samoa American' }">selected="selected"</c:if>>Samoa American</option>
					<option value="San Marino" <c:if test="${userCommand.country == 'San Marino' }">selected="selected"</c:if>>San Marino</option>
					<option value="Saudi Arabia" <c:if test="${userCommand.country == 'Saudi Arabia' }">selected="selected"</c:if>>Saudi Arabia</option>
					<option value="Senegal" <c:if test="${userCommand.country == 'Senegal' }">selected="selected"</c:if>>Senegal</option>
					<option value="Serbia" <c:if test="${userCommand.country == 'Serbia' }">selected="selected"</c:if>>Serbia</option>
					<option value="Seychelles" <c:if test="${userCommand.country == 'Seychelles' }">selected="selected"</c:if>>Seychelles</option>
					<option value="Sierra Leone" <c:if test="${userCommand.country == 'Sierra Leone' }">selected="selected"</c:if>>Sierra Leone</option>
					<option value="Singapore" <c:if test="${userCommand.country == 'Singapore' }">selected="selected"</c:if>>Singapore</option>
					<option value="Slovakia" <c:if test="${userCommand.country == 'Slovakia' }">selected="selected"</c:if>>Slovakia</option>
					<option value="Slovenia" <c:if test="${userCommand.country == 'Slovenia' }">selected="selected"</c:if>>Slovenia</option>
					<option value="Solomon Islands" <c:if test="${userCommand.country == 'Solomon Islands' }">selected="selected"</c:if>>Solomon Islands</option>
					<option value="Somalia" <c:if test="${userCommand.country == 'Somalia' }">selected="selected"</c:if>>Somalia</option>
					<option value="South Africa" <c:if test="${userCommand.country == 'South Africa' }">selected="selected"</c:if>>South Africa</option>
					<option value="Spain" <c:if test="${userCommand.country == 'Spain' }">selected="selected"</c:if>>Spain</option>
					<option value="Sri Lanka" <c:if test="${userCommand.country == 'Sri Lanka' }">selected="selected"</c:if>>Sri Lanka</option>
					<option value="Sudan" <c:if test="${userCommand.country == 'Sudan' }">selected="selected"</c:if>>Sudan</option>
					<option value="Suriname" <c:if test="${userCommand.country == 'Suriname' }">selected="selected"</c:if>>Suriname</option>
					<option value="Swaziland" <c:if test="${userCommand.country == 'Swaziland' }">selected="selected"</c:if>>Swaziland</option>
					<option value="Sweden" <c:if test="${userCommand.country == 'Sweden' }">selected="selected"</c:if>>Sweden</option>
					<option value="Switzerland" <c:if test="${userCommand.country == 'Switzerland' }">selected="selected"</c:if>>Switzerland</option>
					<option value="Syria" <c:if test="${userCommand.country == 'Syria' }">selected="selected"</c:if>>Syria</option>
					<option value="Tahiti" <c:if test="${userCommand.country == 'Tahiti' }">selected="selected"</c:if>>Tahiti</option>
					<option value="Taiwan" <c:if test="${userCommand.country == 'Taiwan' }">selected="selected"</c:if>>Taiwan</option>
					<option value="Tajikistan" <c:if test="${userCommand.country == 'Tajikistan' }">selected="selected"</c:if>>Tajikistan</option>
					<option value="Tanzania" <c:if test="${userCommand.country == 'Tanzania' }">selected="selected"</c:if>>Tanzania</option>
					<option value="Thailand" <c:if test="${userCommand.country == 'Thailand' }">selected="selected"</c:if>>Thailand</option>
					<option value="Togo" <c:if test="${userCommand.country == 'Togo' }">selected="selected"</c:if>>Togo</option>
					<option value="Tokelau" <c:if test="${userCommand.country == 'Tokelau' }">selected="selected"</c:if>>Tokelau</option>
					<option value="Tonga" <c:if test="${userCommand.country == 'Tonga' }">selected="selected"</c:if>>Tonga</option>
					<option value="Trinidad &amp; Tobago" <c:if test="${userCommand.country == 'Trinidad &amp; Tobago' }">selected="selected"</c:if>>Trinidad &amp; Tobago</option>
					<option value="Tunisia" <c:if test="${userCommand.country == 'Tunisia' }">selected="selected"</c:if>>Tunisia</option>
					<option value="Turkey" <c:if test="${userCommand.country == 'Turkey' }">selected="selected"</c:if>>Turkey</option>
					<option value="Turkmenistan" <c:if test="${userCommand.country == 'Turkmenistan' }">selected="selected"</c:if>>Turkmenistan</option>
					<option value="Turks &amp; Caicos Is" <c:if test="${userCommand.country == 'Turks &amp; Caicos Is' }">selected="selected"</c:if>>Turks &amp; Caicos Is</option>
					<option value="Tuvalu" <c:if test="${userCommand.country == 'Tuvalu' }">selected="selected"</c:if>>Tuvalu</option>
					<option value="Uganda" <c:if test="${userCommand.country == 'Uganda' }">selected="selected"</c:if>>Uganda</option>
					<option value="Ukraine" <c:if test="${userCommand.country == 'Ukraine' }">selected="selected"</c:if>>Ukraine</option>
					<option value="United Arab Erimates" <c:if test="${userCommand.country == 'United Arab Erimates' }">selected="selected"</c:if>>United Arab Emirates</option>
					<option value="United Kingdom" <c:if test="${userCommand.country == 'United Kingdom' }">selected="selected"</c:if>>United Kingdom</option>
					<option value="United States of America" <c:if test="${userCommand.country == 'United States of America' }">selected="selected"</c:if>>United States of America</option>
					<option value="Uraguay" <c:if test="${userCommand.country == 'Uraguay' }">selected="selected"</c:if>>Uruguay</option>
					<option value="Uzbekistan" <c:if test="${userCommand.country == 'Uzbekistan' }">selected="selected"</c:if>>Uzbekistan</option>
					<option value="Vanuatu" <c:if test="${userCommand.country == 'Vanuatu' }">selected="selected"</c:if>>Vanuatu</option>
					<option value="Vatican City State" <c:if test="${userCommand.country == 'Vatican City State' }">selected="selected"</c:if>>Vatican City State</option>
					<option value="Venezuela" <c:if test="${userCommand.country == 'Venezuela' }">selected="selected"</c:if>>Venezuela</option>
					<option value="Vietnam" <c:if test="${userCommand.country == 'Vietnam' }">selected="selected"</c:if>>Vietnam</option>
					<option value="Virgin Islands (Brit)" <c:if test="${userCommand.country == 'Virgin Islands (Brit)' }">selected="selected"</c:if>>Virgin Islands (Brit)</option>
					<option value="Virgin Islands (USA)" <c:if test="${userCommand.country == 'Virgin Islands (USA)' }">selected="selected"</c:if>>Virgin Islands (USA)</option>
					<option value="Wake Island" <c:if test="${userCommand.country == 'Wake Island' }">selected="selected"</c:if>>Wake Island</option>
					<option value="Wallis &amp; Futana Is" <c:if test="${userCommand.country == 'Wallis &amp; Futana Is'}" >selected="selected"</c:if>>Wallis &amp; Futana Is</option>
					<option value="Yemen" <c:if test="${userCommand.country == 'Yemen' }">selected="selected"</c:if>>Yemen</option>
					<option value="Zaire" <c:if test="${userCommand.country == 'Zaire' }">selected="selected"</c:if>>Zaire</option>
					<option value="Zambia" <c:if test="${userCommand.country == 'Zambia' }">selected="selected"</c:if>>Zambia</option>
					<option value="Zimbabwe" <c:if test="${userCommand.country == 'Zimbabwe' }">selected="selected"</c:if>>Zimbabwe</option>
				</select>
			</td>
		</tr>
	</table>
	<div class="captcha-box">
		<label class="lbl-captcha">Enter the contents of the image</label>
		<input type="text" name="captcha" id="captcha" />
		<span id="captcha-text" class="captcha-text"></span>
		<input type="button" name="refresh" value="refresh" onclick="fnDrawCaptcha();" />
	</div>
	<span class="register-lbl-terms">Terms and Conditions</span>
	<table cellpadding="0" cellspacing="0" class="tbl-register-terms">
		<tr>
			<td>
			<p>You are responsible to study and learn the materials of your assignment.All the works done by Cebu Essay are solely for research or reference purposesonly. We only hire highly-skilled English Major professionals to meet your requirements and satisfy your needs but Cebu Essay will not be responsible for any losses you acquired as a result of using our services.</p>
			<p>Cebu Essay knows the rules to avoid plagiarism so we can assure you that all our works are safe. As soon as we have given the confirmation for you to download the file from our website, that file is totally owned by you. You will become the copyright owner of that material.</p>
			<p>In the event that inevitable situation will cause the delay of your order beyond the timeframe given, Cebu Essay will fully refund your money as soon as possible. We will also refund your money if in case you can show to us all the necessary markings proving that your model materials failed the passing criteria of your instructor and that there is no other chance for revision. If there is a chance to revise the material, then we will do it for you for free but make it sure that it has all the necessary guidelines from your instructor to meet his passing criteria. However, if the reason of the failure is due to incomplete or wrong instructions, then we cannot be held responsible. If the instructions had been changed after work has begun, then we will consider it as another order.</p>
			<p>Cebu Essay has the right to cite other materials such as books, magazines, journals and online publications unless specified not to do so.</p></td>
		</tr>
		
	</table>
	<span class="register-terms">
		<input type="checkbox" name="accept_terms" id="accept_terms" /><label for="accept_terms">I agree to the terms and conditions</label>
	</span>
	<input type="hidden" name="capcode" value=""/>
	<span class="form-submit"><input type="image" src="${img_src }/stm/btn/btn_submit.png" alt="submit" /></span>

	</form:form>
	
</div>