<%@page import="dto.BoardDto"%>
<%@page import="dao.BoardDao"%>
<%@page import="dto.AccountDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String seq1 =request.getParameter("seq");
int seq = Integer.parseInt(seq1);

BoardDao dao = BoardDao.getInstance();
// readcount를 증가
dao.readcount(seq);

// seq로 BoardDto를 취득
BoardDto dto = dao.getBoard(seq);
%>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글보기</title>
<style>
table {
	border:none;
	
	margin: auto;
}
td, th{
	border:none;
	background-color: MistyRose;
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
<h2 style="text-align:center;">상세 글보기</h2>
<table>
<col width="200"><col width="570">
<tr>
	<th>작성자</th>
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><input type="text" value="<%=dto.getTitle().replaceAll("\"", "&#34;") %>" size="50"></td>
</tr>

<tr>
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>

<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount() %></td>
</tr>

<tr>
	<th>정보</th>
	<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
</tr>

<tr>
	<th>내용</th>
	<td>
		<textarea rows="15" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>
<br>
<div style="text-align:center;">
<button  type="button" onclick="location.href='BoardList.jsp'">글목록</button>
<button  type="button" onclick="answerPost(<%=dto.getSeq() %>)">답글</button>

<%
if(dto.getId().equals( acc.getId() )){
	%>
	<button type="button" onclick="updatePost(<%=dto.getSeq() %>)">수정</button>	
	<button type="button" onclick="deletePost(<%=dto.getSeq() %>)">삭제</button>
<% 
}
%>

</div>

<script type="text/javascript">
function answerPost(seq) {
	location.href = "boardAnswer.jsp?seq=" + seq;
}
function updatePost(seq) {
	//alert(seq);
	location.href = "boardUpdate.jsp?seq=" + seq;
}
function deletePost(seq) {
	location.href = "boardDelete.jsp?seq=" + seq;
}
</script>

</body>
</html>