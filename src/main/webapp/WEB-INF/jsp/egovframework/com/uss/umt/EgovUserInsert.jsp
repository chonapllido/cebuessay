<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../stm/com/sys/taglibs.jspf"%>
<%@ include file="../../../../stm/com/sys/setCodes.jspf"%>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/sym/ccm/zip/EgovZipPopup.js' />" ></script>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnIdCheck(){
    var retVal;
    var url = "<c:url value='/uss/umt/EgovIdDplctCnfirmView.do'/>";
    var varParam = new Object();
    varParam.checkId = document.userManageVO.emplyrId.value;
    var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
    retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.userManageVO.emplyrId.value = retVal;
    }
}
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnInsert(){
    if(validateUserManageVO(document.userManageVO)){
    	if(document.userManageVO.password.value != document.userManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.userManageVO.submit();
    }
}
function fn_egov_inqire_cert() {
	var url = "<c:url value='/uat/uia/EgovGpkiRegist.do' />";
	var popupwidth = '500';
	var popupheight = '400';
	var title = '인증서';

	Top = (window.screen.height - popupheight) / 3;
	Left = (window.screen.width - popupwidth) / 2;
	if (Top < 0) Top = 0;
	if (Left < 0) Left = 0;
	Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,	scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
	PopUpWindow = window.open(url, title, Future)
	PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
	var frm = document.userManageVO;

	frm.subDn.value = dn;
}

/*
if (typeof(opener.fn_egov_dn_info_setting) == 'undefined') {
	alert('메인 화면이 변경되거나 없습니다');
	this.close();
} else {
	opener.fn_egov_dn_info_setting(dn);
	this.close();
}
*/

//-->
</script>

<!-- content start -->
	<form:form commandName="userManageVO" action="${pageContext.request.contextPath}/uss/umt/EgovUserInsert.do" name="userManageVO" method="post" >
        <!-- 우편번호검색 -->
        <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
        <table class="subgridview">
        	<colgroup>
        		<col width="200px" />
				<col/>
			</colgroup>
            <tr>
                <th align="left">사용자아이디<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" /></th>
                <td>
                    <form:input path="emplyrId" id="emplyrId" title="사용자아이디" size="20" maxlength="20" readonly="true" />
                    <a href="#LINK" onclick="fnIdCheck();">
                        <img src="<c:url value='/images/egovframework/com/cmm/icon/search.gif' />" alt="" />(중복아이디 검색)
                    </a>
                    <div><form:errors path="emplyrId" cssClass="error"/></div>
                </td>
            </tr>
            <tr>
                <th align="left">
                    사용자이름<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td>
                    <input name="emplyrNm" id="emplyrNm" title="사용자이름" type="text" value="" maxlength="60" />
                    <div><form:errors path="emplyrNm" cssClass="error" /></div>
                </td>
            </tr>

            <tr>
                <th align="left">
                    비밀번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td>
                    <form:password path="password" id="password" title="비밀번호" size="20" maxlength="20" />
                    <div><form:errors path="password" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th align="left">
                    비밀번호확인<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td>
                    <input name="password2" id="password2" title="비밀번호확인" type="password" size="20" maxlength="20" />
                </td>
            </tr>
            
            <tr>
                <th align="left">
                    이메일주소<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td>
                    <form:input path="emailAdres" id="emailAdres" title="이메일주소" size="20" maxlength="50" />
                    <div><form:errors path="emailAdres" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th align="left">Salary</th>
                <td>
                    <input name="salary" id="salary" title="Salary" type="text" size="20" maxlength="20" />
                </td>
            </tr>
        </table>
        <div class="button-align-center mTop15">
        	<button type="submit" class="base-blue2 download-text" onclick="fnInsert(); return false;">
				<span>&nbsp;</span>
				저장
			</button>
			<button class="base-white2 cancel-text" onclick="location.href='<c:url value='/uss/umt/EgovUserManage.do'/>';">
				<span>&nbsp;</span>
				취소
			</button>
          
        </div>
        <!-- 검색조건 유지 -->
        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	</form:form>
	<!-- content end -->


