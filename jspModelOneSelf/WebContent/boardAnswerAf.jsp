<%@page import="dto.BoardDto"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>

<%

int seq = Integer.parseInt(request.getParameter("seq"));

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글Af</title>
</head>
<body>
<%
BoardDao dao = BoardDao.getInstance();

boolean isS = dao.answer(seq, new BoardDto(id, title, content));
if(isS){
%>
		<script type="text/javascript">
		alert('답글 입력 성공!');
		location.href = "BoardList.jsp";
		</script>
<%
}else{
%>	
		<script type="text/javascript">
		alert('답글 입력 실패');
		location.href = "BoardList.jsp";
		</script>
<%	
}
%>

</body>
</html>