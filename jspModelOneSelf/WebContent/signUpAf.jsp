<%@page import="dto.AccountDto"%>
<%@page import="dao.AccountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
String name = request.getParameter("name");
String email = request.getParameter("email");
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

AccountDto dto = new AccountDto(id, pwd, name, email, 0);
boolean isS = dao.addAccount(dto);
if(isS == true){
%>

<script type="text/javascript">
	alert("성공적으로 가입되었습니다!");
	location.href = "login.jsp";
</script>

<%
}else{
%>

<script type="text/javascript">
	alert("다시 기입해 주십시오");
	location.href = "signUp.jsp";
</script>

<%
}
%>


%>
</body>
</html>