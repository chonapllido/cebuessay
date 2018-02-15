<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>

<script type="text/javascript">
saveid = function() {
    var expdate = new Date();
    var form = document.Form_login;
    
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.remember.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.email.value, expdate);
}

fnWithdraw = function(){
	if(confirm('Are you sure you want to remove your account?')){
		document.Form_mypage.submit();
	}
}

</script>
<div id="header">
	<div class="header-top">&nbsp;</div>
	<div class="top-menu">
		<ul>
			<li><a href="/front/main.do">Home</a></li>
			<li><a href="${configs.CONTEXT }/front/common.do?page=mm_01">About Us</a></li>
			<li><a href="${configs.CONTEXT }/front/common.do?page=mm_02">Services</a></li>
			<li><a href="${configs.CONTEXT }/front/common.do?page=mm_03">Process</a></li>
			<li><a href="${configs.CONTEXT }/front/prices.do">Prices</a></li>
			<li><a href="${configs.CONTEXT }/front/common.do?page=mm_04">FAQ</a></li>
			<li><a href="${configs.CONTEXT }/front/common.do?page=mm_05">Subjects</a></li>
			<li>
				<c:if test="${!empty user }">
				<a href="/front/order/insert.do">Order</a>
				</c:if>
				<c:if test="${empty user }">
				<a href="javascript:void(0);" onclick="javascript:alert('Please login first!');">Order</a>
				</c:if> 
			<li><a href="${configs.CONTEXT }/front/samples/list.do">Samples</a></li>
			<li><a href="${configs.CONTEXT }/front/common.do?page=mm_07">Beware</a></li>
			<!-- <li><a href="${configs.CONTEXT }/front/forum.do">Forum</a></li> -->
			<li class="last-child"><a href="${configs.CONTEXT }/front/common.do?page=mm_08">Contact Us</a></li>
		</ul>
		<div id="google_translate_element"></div>
	</div>
	<div class="header-middle">
		<div class="login">
			<c:if test="${!empty user }"> 
			<form name="Form_mypage" action="/front/user/withdraw.do" method="post" >
			<input type="hidden" name="user_id" value="${user.user_id }" />
			<input type="hidden" name="email" value="${user.email }" />
			<span class="login-title">Welcome!</span>
			<span class="login-username">${user.name}</span>
			<a href="/front/user/logout.do" class="btn-logout"><img src="${img_src}/stm/btn/btn-logout.png" width="41" height="18" alt="logout" /></a>
			<div class="login-buttons">
				<a href="/front/user/update.do?user_id=${user.user_id}"><img src="${img_src}/stm/btn/btn_edit_profile.png" width="159" height="33" alt="edit profile" /></a>
				<a href="javascript:void(0);" onclick="fnWithdraw();"><img src="${img_src}/stm/btn/btn_withdraw.png" width="159" height="33" alt="withdraw" /></a>
				<c:if test="${user.position_id eq '1' }">
				<a href="/back/order/list.do" target="_blank"><img src="${img_src}/stm/btn/btn_management.png" width="159" height="33" alt="management" /></a>
				</c:if>
				<c:if test="${user.position_id eq '2'}">
				<a href="javascript:open_writer();" onclick="javascript:open_writer();"><img src="${img_src}/stm/btn/btn_management.png" width="159" height="33" alt="management" /></a>
				</c:if>
				<c:if test="${user.position_id eq '3' }">
				<a href="/front/user/mypage.do"><img src="${img_src}/stm/btn/btn_mypage.png" width="159" height="33" alt="mypage" /></a>
				</c:if>
			</div>
			</form>
			</c:if>
	
			<c:if test="${empty user}"> 
			<big class="login-title">Log In</big>
			<form:form name="Form_login" commandName="userCommand" action="/front/user/login.do" method="post">
				<c:if test="${(!empty param.loginFail) && (param.loginFail == 'Y')}">
				<span class="login-error-msg">Incorrect email or password!</span>
				</c:if>				
				<label for="email" class="login-lbl">-Enter Your Email Address-</label>
				<input type="text" name="email" value="" class="login-ipt"/>
				<label for="password" class="login-lbl">-Enter Your Password-</label>
				<input type="password" name="password" value="" class="login-ipt"/>
				<div class="login-form-bottom">
					<div class="login-opts">
						<span>
							<input type="checkbox" name="remember" id="remember" class="chk"/>
							<label for="remember">Remember Me</label>
						</span>
						<a href="/front/user/forgot_password.do" class="forgot-pwd">Forgot Password</a>
					</div>
					<button type="submit" class="btn-img"><img src="${img_src}/stm/btn/btn_login.png" alt="Login" class="btn-login"/></button>
				</div>
			</form:form>
			<a href="/front/user/insert.do" class="btn-registration"><img src="${img_src}/stm/btn/btn_registration.png" alt="free registration" title="free registration" /></a>	
			</c:if>
		</div>
		<div class="logo">
			<h1><a href="/front/main.do"><img src="${img_src}/stm/tit/tit_logo_complete.png" alt="Cebu Essay" title="Cebu Essay" /></a></h1>
		</div>
		<div class="main-menu">
			<ul>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_01">Admission Essay</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_02">Essay</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_03">Term Paper</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_04">Research Paper</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_05">Thesis</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_06">Dissertation</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_07">Coursework</a></li>
				<li><a href="${configs.CONTEXT}/front/common.do?page=sm_08">Editing</a></li>
				<li class="last"><a href="${configs.CONTEXT}/front/common.do?page=sm_09">Project</a></li>
			</ul>
		</div>
	</div>
</div>
