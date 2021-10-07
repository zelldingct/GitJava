<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
<%
BoardDao dao = BoardDao.getInstance();
boolean isS = dao.deleteBoard(seq);

if(isS){
%>
	<script type="text/javascript">
	alert('삭제되었습니다');
	location.href = "BoardList.jsp";
	</script>
<%
}else{
%>
	<script type="text/javascript">
	alert('삭제되지 않았습니다');
	location.href = "BoardList.jsp";
	</script>
<%
}
%>


</body>
</html>