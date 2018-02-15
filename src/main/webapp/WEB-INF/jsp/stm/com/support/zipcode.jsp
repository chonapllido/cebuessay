<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ include file="../sys/taglibs.jspf"%>
<%@ include file="../sys/setCodes.jspf"%>
<link rel="stylesheet" type="text/css" href="${css_src }/stm/front/${language}/postcode.css" />
<link rel="stylesheet" type="text/css" href="${css_src }/stm/front/${language}/paging.css" />

<script type="text/javascript">
_proc = function(o) {
	var ret = {'addr' : $(o).closest('tr').find('._addr').html(), 'zipcode' : $(o).closest('tr').find('._zipcode').html()};
	opener._select_zipcode(ret);
	window.close();
};
</script>

			<div class="postcode">
				<div class="postcode-content">
					<div class="content-top">
						<span class="arrow-icon">&nbsp;</span>
						<span class="top-text">도로명, 건물명, 지번에 대해 통합검색이 가능합니다. (예: 반포대로 58, 국립중앙박물관, 삼성동 25) </span>
					</div>
					
					<div class="search-form">
						<input type="text" value="서현동" title="search"/>
						
						<button class="btn-search">검색</button>
						<span class="input-field"></span>
						
						<span class="input-field"></span>
					</div>
					
					<table class="tbl-postcode">
						<colgroup>
							<col width="42px">
							<col width="">
							<col width="63px">
						</colgroup>
					 	<thead>
					 		<tr>
					 			<th>번호</th>
					 			<th>주소</th>
					 			<th>우편번호</th>
					 		</tr>
					 	</thead>
					 	<tbody>
					 		<c:forEach var="row" items="${cmd }" varStatus="i">
					 		<tr>
					 			<td>1</td>
					 			<td class="nopad">
									<ul class="data-holder">
										<li>
											<span class="bluetxt">도로명</span>
											<span class="data-text">${row.ctprvnNm} ${row.signguNm} ${row.rdmn}</span>
										</li>
										<li>
											<span class="bluetxt">지번</span>
											<span class="data-text">${adres }</span>
										</li>
									</ul>
								</td>
					 			<td><a href="#"/>${row.zip }</</td>
					 		</tr>
					 		</c:forEach>
					 		<c:if test="${empty cmd}">
								<tr>
									<td colspan="3">찾는 주소가 없습니다</td>
								</tr>
							</c:if>
					 	</<tbody>
					</table>
					<div class="postcode-paging">
						
					</div>
					<div class="postcode-btn">
						<button class="btn-close">닫기</button>
					</div>	
				</div>	
			</div>
	
<!-- 
		<div class="page-create">
			<div class="search">
				<form name="Form_search" method="post" action="${url }" onsubmit="return doSubmit(this);">
					<fieldset>
						<label>지번/도로명 <span>|</span></label> 
						<input type="text" name="searchKeyword" value="${param.searchKeyword }" class="_req" title="지번 또는 도로명을 입력하세요" />
						<button type="submit">검색<span>&nbsp;</span></button>
					</fieldset>
				</form>
			</div>
			<c:if test="${empty param.searchKeyword }">
				<div class="notice-box">
					<ul>
						<li><span class="bold-text">지번주소 :</span> 동/읍/면/리 이름을 선택하세요.<span class="right-text">예) 서초동, 화도읍, 장유면</span></li>
						<li><span class="bold-text">도로명주소(새주소) :</span> 도로명을 입력하세요.<span class="right-text">예) 안암로, 불정로 432번길</span></li>
					</ul>
				</div>
			</c:if>
			<c:if test="${!empty param.searchKeyword}">
				<div class="table-holder">		
					<table>
						<colgroup>
							<col width=""/>
							<col width="100px"/>
							<col width="50px"/>
						</colgroup>
						<thead>
							<tr>
								<th>주소</th>
								<th>우편번호</th>
								<th>선택</th>
							</tr>
						</thead>
						<c:forEach var="row" items="${cmd }" varStatus="i">
							<tr>
								<td class="_addr">${row.ctprvnNm} ${row.signguNm} ${row.emdNm} ${row.liBuldNm} ${row.lnbrDongHo}</td>				
								<td class="_zipcode">${fn:substring(row.zip, 0, 3) }-${fn:substring(row.zip, 3, 6) }</td>
								<td><a href="javascript:#zipcode" onclick="_proc(this);" class="select">선택</a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty cmd}">
							<tr>
								<td colspan="3">찾는 주소가 없습니다</td>
							</tr>
						</c:if>
					</table>
				</div>
			</c:if>
		</div>
		
		 -->