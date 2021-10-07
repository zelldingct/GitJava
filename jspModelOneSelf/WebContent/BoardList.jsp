<%@page import="dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.AccountDto"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");
if(search == null || choice == null || search.equals("")){
	search = "";
	choice = "";
}

BoardDao dao = BoardDao.getInstance();

//page 부분
//글의 총수 
int len = dao.getAllBoard(choice, search);
System.out.println("글의 총수:" + len);

//페이지 수
int boardPage = len / 10;		// 29 / 10 -> 2
if((len % 10) > 0){
	boardPage = boardPage + 1;
}

//현재 페이지
String pageNumber1 = request.getParameter("pageNumber");
int pageNumber = 0;
if(pageNumber1 != null){
	pageNumber = Integer.parseInt(pageNumber1);
}

//List<BoardDto> list = dao.getBoardList();
List<BoardDto> list = dao.getBoardPagingList(choice, search, pageNumber);
%>

<%!
// 댓글 깊이와 image를 추가하는 함수
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";			
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0 ? "":ts + rs;
}
// 제목의 문자열의 길이가 28자를 넘을 때 ...으로 표현
public String dot3(String title){
	String str = "";
	if(title.length() >= 30){
		str = title.substring(0, 30);
		str += "...";
	}else{
		str = title;
	}	
	return str;
}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
<h2 style="text-align:center;">게시판</h2>
<table border="1">
<col width="70px"><col width="500px"><col width="100px"><col width="100px">
<tr>
	<th>번호</th><th>제목</th><th>정보</th><th>작성자</th>
</tr>
<%
if(list == null || list.size() == 0){
%>
	<tr>
		<td colspan="4">작성된 글이 없습니다</td>
	</tr>
<%
}else{
	
	for(int i = 0;i < list.size(); i++){
		BoardDto board = list.get(i);
%>
	<tr>
		<th><%=(i + 1) %></th>
		
		<td>
		<%if(board.getDel() == 0){%>
		<%=arrow(board.getDepth()) %>
		<a href= " BoardDetail.jsp?seq=<%=board.getSeq()%> "> <%=dot3(board.getTitle()) %></a>
		<%}else{%>
		<font color="#ff0000">****이 글은 작성자에 의해서 삭제되었습니다****</font>
		<%}%>
		</td>
		
		<td><%=board.getRef() %>-<%=board.getStep() %>-<%=board.getDepth() %></td>
		
		<td><%=board.getId() %></td>	
	</tr>
<%
	}
}
%>


</table>
<br>
<div align="center">
<% 
for(int i = 0;i < boardPage; i++){
	if(pageNumber == i){	// 현재 페이지		1 [2] [3]
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i + 1 %>
		</span>&nbsp;
		<%
	}
	else{					// 그 외의 페이지
		%>
		<a href="#none" title="<%=i + 1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt;color: #000; font-weight: bold; text-decoration: none;">
			[<%=i + 1 %>]
		</a>&nbsp;
		<%
	}
}
%>
</div>
<br>
<div align="center">

<select id="choice">
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="id">작성자</option>
</select>

<input type="text" id="search" value="<%=search %>">

<button type="button" onclick="searchBoard()">검색</button>

</div>
<br>
<div style="text-align:center;">
<Input  type="button" value="글쓰기" onclick="location.href='boardWrite.jsp';">	
<script type="text/javascript">

</script>
</div>

<script type="text/javascript">
function searchBoard() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
//	alert(choice);
//	alert(search);
	location.href = "BoardList.jsp?choice=" + choice + "&search=" + search;
}


function goPage( pageNum ) {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	location.href = "BoardList.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNum;
}


</script>
</body>
</html>