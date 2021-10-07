<%@page import="dto.AccountDto"%>
<%@page import="dto.BoardDto"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt( request.getParameter("seq"));

BoardDao dao = BoardDao.getInstance();
BoardDto info = dao.getBoard(seq);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글</title>
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
AccountDto acc = (AccountDto)session.getAttribute("login");
if(acc == null){
%>
	<script type="text/javascript">
	alert("로그인 해 주십시오");
	location.href = "login.jsp";
	</script>
<%
}
%>
<h2 style="text-align:center;">원글</h2>

<div align="center">

<table>
<col width="200"><col width="570">
<tr>
	<th>작성자</th>
	<td><%=info.getId() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><%=info.getTitle() %></td>
</tr>
<tr>
	<th>작성일</th>
	<td><%=info.getWdate() %></td>
</tr>
<tr>
	<th>조회수</th>
	<td><%=info.getReadcount() %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea style="background-color:MistyRose;" rows="20" cols="52px" readonly="readonly"><%=info.getContent() %></textarea>
	</td>
</tr>
</table>	
</div>

<br><br>

<h2 style="text-align:center;">답글</h2>
<div align="center">
<form action="boardAnswerAf.jsp" method="post">
<input type="hidden" name="seq" value="<%=info.getSeq() %>">

<table border="1">
<col width="200"><col width="570">

<tr>
	<th>아이디</th>
	<td>
		<input style="background-color:MistyRose;" type="text" name="id" size="50" readonly="readonly" value="<%=acc.getId() %>">
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
</div>
</body>
</html>