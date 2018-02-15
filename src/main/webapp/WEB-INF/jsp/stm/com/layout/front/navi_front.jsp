<%@page import="stm.com.support.util.Functions"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../sys/taglibs.jspf"%>
<%@ include file="../../sys/setCodes.jspf"%>

	<c:set var="navi_params" value="${stmfn:params('') }" />
	<c:set var="title">포트폴리오 관리</c:set>
	<c:set var="depth1" value="" />
	<c:set var="depth2" value="" />
	<c:set var="depth3" value="" />
	
	<c:choose>
		<c:when test="${fn:contains(url, '/user/') || fn:contains(url, '/uat/uia')}">
			<c:if test="${fn:contains(url, '/login') || fn:contains(url, '/actionLogin') }">
				<c:set var="depth1">INDEX PAGE</c:set>
				<c:set var="depth2">로그인</c:set>
				<c:set var="title">로그인</c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/step1') }">
				<c:set var="depth1">INDEX PAGE</c:set>
				<c:set var="depth2">회원가입</c:set>
				<c:set var="title">회원가입</c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/insert') }">
				<c:set var="depth1">INDEX PAGE</c:set>
				<c:set var="depth2">회원가입</c:set>
				<c:set var="title">회원가입 </c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/findid') || fn:contains(url, '/findpw')}">
				<c:set var="depth1">INDEX PAGE</c:set>
				<c:set var="depth2">아이디/비밀번호 찾기 </c:set>
				<c:set var="title">아이디/비밀번호 찾기</c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/findpwd') }">
				<c:set var="depth1">INDEX PAGE</c:set>
				<c:set var="depth2">아이디/비밀번호 찾기 </c:set>
				<c:set var="title">아이디/비밀번호 찾기</c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/update') }">
				<c:set var="depth1">MY PAGE</c:set>
				<c:set var="depth2">회원정보 </c:set>
				<c:set var="depth3">회원정보 수정</c:set>
				<c:set var="title">회원정보 수정</c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/secede') }">
				<c:set var="depth1">MY PAGE</c:set>
				<c:set var="depth2">회원정보 </c:set>
				<c:set var="depth3">회원 탈퇴</c:set>
				<c:set var="title">회원 탈퇴</c:set>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(url, '/portfolio/') }">
			<c:set var="depth1">PORTFOLIO</c:set>
			<c:if test="${fn:contains(navi_params, 'search_sep_code=P') }">
				<c:set var="depth2">WEB PUBLISHING</c:set>
				<c:set var="title">WEB PUBLISHING</c:set>
			</c:if>
			<c:if test="${fn:contains(navi_params,'search_sep_code=D') }">
				<c:set var="depth2">WEB DEVELOPMENT</c:set>
				<c:set var="title">WEB DEVELOPMENT</c:set>
			</c:if>
			<c:if test="${!fn:contains(navi_params, 'search_sep_code') }">
				<c:set var="depth2">ALL PORTFOLIO</c:set>
				<c:set var="title">ALL PORTFOLIO</c:set>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(url, '/faq') }">
			<c:set var="depth1">SUPPORT</c:set>
			<c:if test="${fn:contains(url, '/faq') }">
				<c:set var="depth2">자주묻는 질문</c:set>
				<c:set var="title">자주묻는 질문</c:set>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(url, '/order/self') || fn:contains(navi_params, 'page=m5.m4') }">
			<c:set var="depth1">SUPPORT</c:set>
			<c:if test="${fn:contains(url, '/order/self/insert') }">
				<c:set var="depth2">SELF 견적</c:set>
				<c:set var="title">SELF 견적</c:set>
			</c:if>
			<c:if test="${fn:contains(navi_params, 'page=m5.m4') }">
				<c:set var="depth2">코딩 가이드</c:set>
				<c:set var="title">코딩 가이드</c:set>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m0.m0') }">
			<c:set var="title">사이트 맵</c:set>
			<c:set var="depth1">INDEX</c:set>
			<c:set var="depth2">사이트 맵</c:set>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m0.m1') }">
			<c:set var="title">이용약관</c:set>
			<c:set var="depth1">INDEX</c:set>
			<c:set var="depth2">이용약관</c:set>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m0.m2') }">
			<c:set var="title">개인정보처리방침</c:set>
			<c:set var="depth1">INDEX</c:set>
			<c:set var="depth2">개인정보처리방침</c:set>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m0.m4') }">
			<c:set var="title">이메일주소 무단수집거부</c:set>
			<c:set var="depth1">INDEX</c:set>
			<c:set var="depth2">이메일주소 무단수집거부</c:set>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m1.m1') }">
			<c:set var="title">WEB PUBLISHING</c:set>
			<c:set var="depth1">SERVICE</c:set>
			<c:set var="depth2">WEB PUBLISHING</c:set>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m1.m2') }">
			<c:set var="title">WEB DEVELOPMENT</c:set>
			<c:set var="depth1">SERVICE</c:set>
			<c:set var="depth2">WEB DEVELOPMENT</c:set>
		</c:when>
		<c:when test="${fn:contains(navi_params, 'page=m2') }">
			<c:set var="title">서비스 가격표</c:set>
			<c:set var="depth1">PRICE</c:set>
			<c:set var="depth2">서비스 가격표</c:set>
		</c:when>
		<c:when test="${fn:contains(url, '/order/insert') }">
			<c:set var="depth1">ORDER NOW</c:set>
			<c:if test="${fn:contains(navi_params,'sep_code=P') }">
				<c:set var="title">WEB PUBLISHING</c:set>
				<c:set var="depth2">WEB PUBLISHING</c:set>
			</c:if>
			<c:if test="${fn:contains(navi_params,'sep_code=D') }">
				<c:set var="title">WEB DEVELOPMENT</c:set>
				<c:set var="depth2">WEB DEVELOPMENT</c:set>
			</c:if>
		</c:when>
		<c:when test="${fn:contains(url, '/order/list') || fn:contains(url, '/actionMain')}">
			<c:set var="depth1">MY PAGE</c:set>
			<c:set var="depth2">주문내역</c:set>
			<c:set var="title">주문내역</c:set>
		</c:when>
		<c:when test="${fn:contains(url, '/order/view')}">
			<c:set var="depth1">MY PAGE</c:set>
			<c:set var="depth2">주문내역</c:set>
			<c:set var="title">주문내역</c:set>
		</c:when>
		<c:when test="${fn:contains(url, '/project') || fn:contains(url, '/contact')}">
			<c:set var="depth1">MY PAGE</c:set>
			<c:if test="${fn:contains(url, '/project') }">
				<c:set var="depth2">프로젝트 게시판</c:set>
				<c:set var="title">프로젝트 게시판</c:set>
			</c:if>
			<c:if test="${fn:contains(url, '/contact') }">
				<c:set var="depth2">1:1 문의</c:set>
				<c:set var="title">1:1 문의</c:set>
			</c:if>
		</c:when>
	</c:choose>
	
<div class="breadcrumbs">
	<ul>
		<li><a href="#">HOME</a></li>
		<c:if test="${! empty depth1}"><li><a href="#">${depth1 }</a></li></c:if>
		<c:if test="${! empty depth2}"><li<c:if test="${! empty depth3}"> class="withsubs"</c:if>><a href="#">${depth2 }</a></li></c:if>
		<c:if test="${! empty depth3}"><li class="last"><a href="#">${depth3 }</a></li></c:if>
	</ul>
</div>

<span class="content-title">${title }</span>