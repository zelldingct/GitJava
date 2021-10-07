<%@page import="dto.AccountDto"%>
<%@page import="dao.AccountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
AccountDao dao = AccountDao.getInstance();

AccountDto acc = dao.login(id,pwd); 

if(acc != null){// 로그인 성공! =>갖고 온 값이 있다.
	//session에 로그인 정보를 저장
	/*
	session : java -> server 회원정보, 방문회수 = Object
	cookie : javascript -> client id저장 = String
	*/
	session.setAttribute("login", acc);
	session.setMaxInactiveInterval(60*60*2);
%>
<script type="text/javascript">
	alert("환영합니다 <%acc.getName();%>님");
	location.href = "BoardList.jsp"; 
</script>
<% 
}else{
%>
<script type="text/javascript">
	alert("ID나 Password를 확인해주세요");
	location.href = "login.jsp";
</script>
<%
}
%>
</body>
</html>