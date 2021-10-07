<%@page import="dao.BoardDao"%>
<%@page import="dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
int seq = Integer.parseInt(request.getParameter("seq"));

String title = request.getParameter("title");
String content = request.getParameter("content");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정Af</title>
</head>
<body>
<%
BoardDao dao = BoardDao.getInstance();

boolean isS = dao.updateBoard(seq, new BoardDto(title, content));
if(isS){
%>
	<script type="text/javascript">
	alert('수정 성공!');
	location.href = "BoardList.jsp";
	</script>
<%
}else{
%>	
	<script type="text/javascript">
	alert('수정 실패');
	location.href = "BoardList.jsp";
	</script>
<%	
}
%>

</body>
</html>