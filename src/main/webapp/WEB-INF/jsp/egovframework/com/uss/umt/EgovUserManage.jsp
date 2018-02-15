<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../../stm/com/sys/taglibs.jspf"%>
<%@ include file="../../../../stm/com/sys/setCodes.jspf"%>

<%

 /**
  * @Class Name : EgovUserManage.jsp
  * @Description : 사용자관리(조회,삭제) JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.02    조재영          최초 생성
  *   2011.09.07    서준식          네비게이션명 변경 (사용자 관리 -> 업무사용자관리)
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.02
  *  @version 1.0
  *  @see
  *
  */
%>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
    	//alert(checkedIds);
        if(confirm("<spring:message code="common.delete.msg" />")){
        	document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/EgovUserDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];
    }
   	document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/EgovUserSelectUpdtView.do'/>";
    document.listForm.submit();

}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/EgovUserInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/uss/umt/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnViewCheck(){
    if(insert_msg.style.visibility == 'hidden'){
    	insert_msg.style.visibility = 'visible';
    }else{
    	insert_msg.style.visibility = 'hidden';
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>
<div class="order">
<!-- content start -->
<form name="listForm" action="<c:url value='/uss/umt/EgovUserManage.do'/>" method="post">
	<input name="selectedId" type="hidden" />
	<input name="checkedIdForDel" type="hidden" />
	<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
	<div>사용자수 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong></div>
	<br/>
	<table class="tbl-subgridlist" summary="사용자 목록을 제공한다.">
		<colgroup>
			<col width="5%" />
			<col width="5%" />
			<col width="12%" />
			<col width="12%" />
			<col width="" />
			<col width="12%" />
			<col width="10%" />
			<col width="12%" />
		</colgroup>
	    <thead>
	        <tr>
	            <th class="title" scope="col">No.</th>
	            <th class="title" scope="col">
	                <input name="checkAll" type="checkbox" title="Check All" onclick="javascript:fnCheckAll();"/>
	           </th>
	           <th class="title" scope="col">아이디</th>
	           <th class="title" scope="col">사용자이름</th>
	           <th class="title" scope="col">사용자이메일</th>
	           <th class="title" scope="col">전화번호</th>
	           <th class="title" scope="col">등록일</th>
	           <th class="title" scope="col">가입상태</th>
	       </tr>
	   </thead>
	   <tbody>
	   <%-- 데이터를 없을때 화면에 메세지를 출력해준다 --%>
	<c:if test="${fn:length(resultList) == 0}">
	<tr>
	<td class="lt_text3" colspan="8">
		<spring:message code="common.nodata.msg" />
	</td>
	</tr>
	</c:if>
	       <c:forEach var="result" items="${resultList}" varStatus="status">
	       <tr>
	           <td class="lt_text3" ><c:out value="${status.count}"/></td>
	           <td class="lt_text3" >
	               <input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
	               <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
	           </td>
	           <td class="lt_text3" style="cursor:pointer;cursor:hand" >
	<span class="link"><a href="<c:url value='/uss/umt/EgovUserSelectUpdtView.do'/>?selectedId=<c:out value="${result.uniqId}"/>"  onclick="javascript:fnSelectUser('<c:out value="${result.userTy}"/>:<c:out value="${result.uniqId}"/>'); return false;"><c:out value="${result.userId}"/></a></span>
	           </td>
	           <td class="lt_text3" ><c:out value="${result.userNm}"/></td>
	           <td class="lt_text3" ><c:out value="${result.emailAdres}"/></td>
	           <td class="lt_text3" ><c:out value="${result.areaNo}"/>)<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/></td>
	           <td class="lt_text3" ><fmt:formatDate value="${result.sbscrbDe}" pattern="YYYY.mm.dd" /></td>
	           <td class="lt_text3" >
	               <c:forEach var="emplyrSttusCode_result" items="${emplyrSttusCode_result}" varStatus="status">
	                   <c:if test="${result.sttus == emplyrSttusCode_result.code}"><c:out value="${emplyrSttusCode_result.codeNm}"/></c:if>
	               </c:forEach>
	           </td>
	       </tr>
	       </c:forEach>
	    </tbody>
	</table>
	
	<div class="button-align-right mTop13">
		<button type="button" class="base-blue2 plus-text" onclick="fnAddUserView();">
			<span>&nbsp;</span>
			<spring:message code="button.create" />
		</button>
		<button type="button" class="base-white2 delete-text" onclick="fnDeleteUser();">
			<spring:message code="button.delete" />
			<span>&nbsp;</span>
		</button>
	</div>		
	<!--  page start -->
	<table width="717">
	    <tr>
	        <td align="center">
	        <div id="pagination">
	        <ui:pagination paginationInfo = "${paginationInfo}"
	            type="image"
	            jsFunction="fnLinkPage"
	            />
	        </div>
	        </td>
	    </tr>
	</table>
	<div class="search-backorderlist">
		 <select name="sbscrbSttus" id="sbscrbSttus" class="select98" title="검색조건선택1" >
			<option value="0" <c:if test="${empty userSearchVO.sbscrbSttus || userSearchVO.sbscrbSttus == '0'}">selected="selected"</c:if> >상태(전체)</option>
			<option value="A" <c:if test="${userSearchVO.sbscrbSttus == 'A'}">selected="selected"</c:if> >가입신청</option>
			<option value="D" <c:if test="${userSearchVO.sbscrbSttus == 'D'}">selected="selected"</c:if> >삭제</option>
			<option value="P" <c:if test="${userSearchVO.sbscrbSttus == 'P'}">selected="selected"</c:if> >승인</option>
		</select>
		<select name="searchCondition" id="searchCondition" class="select98" title="검색조건선택2">
		   <option value="0" <c:if test="${userSearchVO.searchCondition == '0'}">selected="selected"</c:if> >ID</option>
		   <option value="1" <c:if test="${empty userSearchVO.searchCondition || userSearchVO.searchCondition == '1'}">selected="selected"</c:if> >Name</option>
		</select>
		
		<input name="searchKeyword" type="text" value="<c:out value="${userSearchVO.searchKeyword}"/>" title="검색단어입력" />
	    <div class="btn-holder">
	    	<button type="submit" onclick="fnSearch(); return false;" class="btn-searchbackorderlist"><spring:message code="button.search" /></button>
	    </div>
	 </div>
</form>
</div>