<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="../../../sys/taglibs.jspf"%>
<%@ include file="../../../sys/setCodes.jspf"%>
<link rel="stylesheet" href="${css_src}/stm/front/ko/user.css" />
<style type="text/css">

	.content-top{
		padding:10px 0;
		margin-bottom:20px;
		background:#4C9DBD;
		color:#003452;
		font-weight:bold;
		font-size:18px;
	}
	.search-form input[type=text]{
		width:200px;
		border:1px solid #ccc;
	}
	.postcode-btn{
		text-align:center;
		padding-top:15px;
		margin-top:20px;
		border-top:1px solid #dddddd;
	}
	.result{
		margin-top:20px;
	}
	.result span{
		font-weight:bold;
	}
</style>
<script type="text/javascript">
function fnUseId(){
	
    if (document.checkForm.usedCnt.value == 0){
	    checkId = document.checkForm.resultId.value;
	    
	    var browser=navigator.appName;
	    var parentPanel = null;

	    if(browser == "Microsoft Internet Explorer"){
	    	parentPanel = parent.window.document;
	    }else{
	    	parentPanel = opener.document;
	    }

		parentPanel.Form_register.email.value = checkId;
	    parentPanel.Form_register.idChecked.value = "Y";
        window.close();
        
    }else if (document.checkForm.usedCnt.value > 0){
        alert("Your email address is already taken. Please use a different one!");
        return;
    }else{
    	alert("Please run duplicate verification!");
        return;
    }
}

</script>

<form name="checkForm" action="${url }" method="post">
	<input type="hidden" name="usedCnt" value="${usedCnt }" />
	<input type="hidden" name="resultId" value="${checkId }" />
	<input type="hidden" name="userId" value="${userId }" />
	<div>
		<div class="content-top">
			<span class="arrow-icon">&nbsp;</span>
			<span class="top-text">Email Duplication Check</span>
		</div>
		
		<div class="search-form">
			<input type="text" name="checkId" value="${checkId }" title="search"/>
			<button type="submit" class="btn-search">Search</button>
			<span class="input-field"></span>
			
			<span class="input-field"></span>
			
		</div>
		<div class="result">
			<c:if test="${not empty checkId }">
				<span>Result:</span>
				<c:choose>
	                <c:when test="${usedCnt eq -1}">
	                    &nbsp; Run duplicate verification
	                </c:when>
	                <c:when test="${usedCnt eq 0}">
	                    Email Address is available &nbsp;<button type="button" onclick="fnUseId();">Use Email</button>
	                </c:when>
	                <c:otherwise>
	                    Email Address is already in use. Use a different one.
	                </c:otherwise>
                </c:choose>
			</c:if>
			<c:if test="${empty checkId }">
				<span>Result:</span> Run Duplicate Verification
			</c:if>
		</div>
		<div class="postcode-btn">
			<button type="button" onclick="window.close()" class="btn-close">Close</button>
		</div>	
	</div>	
	</form>
</form>