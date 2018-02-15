<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../stm/com/sys/taglibs.jspf"%>
<%@ include file="../../../../stm/com/sys/setCodes.jspf"%>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
	if(confirm("<spring:message code="common.delete.msg" />")){
	    document.userManageVO.checkedIdForDel.value=checkedIds;
	    document.userManageVO.action = "<c:url value='/uss/umt/EgovUserDelete.do'/>";
	    document.userManageVO.submit();
	}
}
function fnPasswordMove(){
	document.userManageVO.action = "<c:url value='/uss/umt/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
    if(validateUserManageVO(document.userManageVO)){
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
        <form:form commandName="userManageVO" action="${pageContext.request.contextPath}/uss/umt/EgovUserSelectUpdt.do" name="userManageVO" method="post" >

        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
        <input name="checkedIdForDel" type="hidden" />
        <!-- 검색조건 유지 -->
        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
        <!-- 우편번호검색 -->
        <input type="hidden" name="zip_url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
        <!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
        <input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />
        <!-- for validation -->
	    <input type="hidden" name="password" id="password" value="Test#$123)"/>        
        <table class="subgridview">
        	<colgroup>
        		<col width="123px" />
        		<col />
        	</colgroup>
        	<tbody>
	            <tr>
	                <th align="left">
	                사용자아이디<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
	                </th>
	                <td>
	                    <form:input path="emplyrId" id="emplyrId" cssClass="txaIpUmt" size="20" maxlength="20" readonly="true" title="사용자아이디" />
	                    <form:errors path="emplyrId" cssClass="error"/>
	                    <form:hidden path="uniqId" />
	                </td>
	            </tr>
	            <tr>
	                <th align="left">
	                사용자이름<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
	                </th>
	                <td>
	                    <form:input path="emplyrNm" id="emplyrNm" cssClass="txaIpUmt" size="20"  maxlength="60" title="사용자이름" />
	                    <form:errors path="emplyrNm" cssClass="error" />
	                </td>
	            </tr>
	            <tr>
	                <th align="left">
	                이메일주소<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
	                </th>
	                <td>
	                    <form:input path="emailAdres" id="emailAdres" cssClass="txaIpUmt" size="20" maxlength="50" title="이메일주소"/>
	                    <form:errors path="emailAdres" cssClass="error" />
	                </td>
	            </tr>
	            <tr>
	                <th align="left">Salary&nbsp;&nbsp;</th>
	                <td>
	                    <form:input path="salary" id="salary" cssClass="txaIpUmt" size="20" maxlength="50" title="상세주소"/>
	                    <form:errors path="salary" cssClass="error" />
	                </td>
	            </tr>
            </tbody>
        </table>      
		<div class="button-both mTop15">
			<span class="fLeft">
				<!-- 목록 -->
	            <button type="button" class="base-white2 list-text" onclick="location.href='<c:url value='/uss/umt/EgovUserManage.do'/>'" onclick="fnListPage(); return false;">
	            	<span>&nbsp;</span>
	            	<spring:message code="button.list" />
	            </button>
			</span>
			<span class="fRight">
	            <!-- 수정 -->
	            <button type="submit" class="base-blue2 download-text" onclick="fnUpdate(); return false;">
	            	<span>&nbsp;</span>
	          		<spring:message code="button.update" />
	            </button>	           
	            <!-- 암호변경 -->
	            <button type="button" class="base-white2 modify-text" onclick="location.href='<c:url value='/uss/umt/EgovUserPasswordUpdtView.do'/>'" onclick="fnPasswordMove(); return false;">
	            	<span>&nbsp;</span>
	            	<spring:message code="button.passwordUpdate" />
	            </button>
	            <!-- 삭제 -->
	            <button type="button" class="base-white2 delete-text" onclick="fnDeleteUser('<c:out value='${userManageVO.userTy}'/>:<c:out value='${userManageVO.uniqId}'/>'); return false;">
	            	<span>&nbsp;</span>
	            	<spring:message code="button.delete" />
	            </button>
	            <!-- 취소 -->
	            <%-- 
	            <button type="button" onclick="javascript:document.userManageVO.reset();">
	            	<spring:message code="button.reset" />
	            </button>
	            --%>
	          </span>
		</div>
        </form:form>
        <!-- content end -->

