<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../stm/com/sys/taglibs.jspf"%>
<%@ include file="../../../../stm/com/sys/setCodes.jspf"%>
<%
 /**
  * @Class Name : EgovPasswordUpdt.jsp
  * @Description : 암호수정 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.02    조재영          최초 생성
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.04.02
  *  @version 1.0
  *  @see
  *  
  */
%>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.passwordChgVO.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.passwordChgVO.submit();
}
function fnUpdate(){
    if(validatePasswordChgVO(document.passwordChgVO)){
        if(document.passwordChgVO.newPassword.value != document.passwordChgVO.newPassword2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.passwordChgVO.submit();
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>

<!-- content start -->
        <form name="passwordChgVO" method="post" 
              action="<c:url value="${'/uss/umt/EgovUserPasswordUpdt.do'}"/>" >
              <!-- onsubmit="javascript:return FormValidation(document.passwordChgVO);" >  -->
        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
        <input name="checkedIdForDel" type="hidden" />
        <!-- 검색조건 유지 -->
        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
        <!-- 우편번호검색 -->
        <input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
        
        <table class="subgridview">
        	<colgroup>
        		<col width="200px" />
        		<col />
        	</colgroup>
            <tr>
                <th align="left">
                사용자아이디<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td>
                    <input name="emplyrId" id="emplyrId" title="사용자아이디" type="text" size="20" value="<c:out value='${userManageVO.emplyrId}'/>"  maxlength="20" readonly/>
                    <input name="uniqId" id="uniqId" title="uniqId" type="hidden" size="20" value="<c:out value='${userManageVO.uniqId}'/>"/>
                    <input name="userTy" id="userTy" title="userTy" type="hidden" size="20" value="<c:out value='${userManageVO.userTy}'/>"/>
                </td>
            </tr>
            <tr> 
                <th align="left">
                기존 비밀번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td><input name="oldPassword" id="oldPassword" title="기존 비밀번호" type="password" size="20" value=""  maxlength="100" /></td>
            </tr>
            <tr> 
                <th align="left">
                비밀번호<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td><input name="newPassword" id="newPassword" title="비밀번호" type="password" size="20" value=""  maxlength="100" /></td>
            </tr>
            <tr>
                <th align="left">
                비밀번호확인<img src="<c:url value='/images/egovframework/com/cmm/icon/required.gif' />" width="15" height="15" alt="필수입력표시" />
                </th>
                <td><input name="newPassword2" id="newPassword2" title="비밀번호확인" type="password" size="20" value=""  maxlength="100" /></td>
            </tr>
        </table>
        <div class="buttons button-align-center mTop15">
	        <button type="submit" class="base-blue2 save-text" onclick="fnUpdate(); return false;">
	    		<span>&nbsp;</span>
	    		<spring:message code="button.update" />
	        </button>
	        <!-- 목록 -->
	        <button type="button" class="base-white2 cancel-text" onclick="location.href='<c:url value='/uss/umt/EgovUserManage.do'/>'" >
	        	<span>&nbsp;</span>
	        	<spring:message code="button.list" />
	        </button>
		</div>
        </form>

