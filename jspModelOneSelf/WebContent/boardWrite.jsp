<%@page import="dto.AccountDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
table {
	border:none;
	
	margin: auto;
}
td, th{
	border:none;
	background-color:MistyRose;
	text-align: center;
}
</style>
</head>
<body style= "background-color:LightPink;">
<%
AccountDto mem = (AccountDto)session.getAttribute("login");
if(mem == null){
%>
	<script type="text/javascript">
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>
<%
}
%>
<h2 style="text-align:center;">글쓰기</h2>
<form action="boardWriteAf.jsp" method="post">
<table>
<col width="200"><col width="570">

<tr>
	<th>아이디</th>
	<td>
		<input style="background-color:MistyRose;" type="text" name="id" size="50px" value="<%=mem.getId() %>" readonly="readonly">
	</td>
</tr>

<tr>
	<th>제목</th>
	<td>
		<input style="background-color:MistyRose;" type="text" name="title" size="50px">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea style="background-color:MistyRose;" rows="20" cols="52px" name="content"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" value="Done">
	</td>	
</tr>
</table>
</form>
</body>
</html>