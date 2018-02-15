<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../sys/taglibs.jspf"%>
<%@ include file="../sys/setCodes.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Callback!!</title>
</head>
<body>
	<center>
		<c:choose>
			<c:when test="${fn:contains(value, 'parent.refresh')}">
				<script type="text/javascript">
					parent.location.reload();
				</script>
			</c:when>
			<c:when test="${fn:contains(url, '/cmm/fms/deleteFileInfs')}">
				<script type="text/javascript">
					parent.$('#file${param.fileSn}').remove();
					alert('<stmfn:msg key="msg.file.delete"/>');
				</script>
			</c:when>
			<c:when test="${fn:contains(value, 'validator')}">
				<script type="text/javascript">
					alert('<stmfn:msg key="errors.validator"/>');
					history.back();
				</script>
			</c:when>
			<c:when test="${fn:contains(url, '/order/pageadd')}">
				<script type="text/javascript">
					alert('신청이 완료 되었습니다.');
					opener.location.reload();
					window.close();
				</script>
			</c:when>
			<c:when test="${fn:contains(url, '/order/domain/') || fn:contains(url, '/order/hosting/')}">
				<script type="text/javascript">
					<c:if test="${empty value}">
						alert('신청이 완료 되었습니다.');
						top.location.reload();
					</c:if>
					<c:if test="${value == 'cancel'}">
						alert('신청이 취소 되었습니다.');
						top.location.reload();
					</c:if>
					<c:if test="${value == 'change'}">
						alert('변경 되었습니다.');
						top.location.reload();
					</c:if>
				</script>
			</c:when>
			<c:otherwise>
				Callback!!
			</c:otherwise>
		</c:choose>
	</center>
</body>
</html>