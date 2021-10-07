<%@page import="dto.BoardDto"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기Af</title>
</head>
<body>
<%
BoardDao dao = BoardDao.getInstance();

boolean isS = dao.writeBoard(new BoardDto(id, title, content));
if(isS){ 
%>
	<script type="text/javascript">
	alert("글쓰기 성공!");
	location.href = "BoardList.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("글을 다시 확인해주세요");
	location.href = "boardwrite.jsp";
	</script>
<%
}
%>
</body>
</html>