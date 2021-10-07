<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login창</title>
<style>
table {
	border:none;
	width: 300px;
	height: 100px;
	margin: auto;
}
td, th{
	border:none;
	background-color: MistyRose;
	text-align: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
</head>
<body style= "background-color:LightPink;">
<h2 style="text-align:center;">로그인!</h2>
<form action="loginAf.jsp" method="post">
<!-- action 속성은 폼 데이터(form data)를 서버로 보낼 때 해당 데이터가 도착할 URL을 명시합니다. -->
<table border="1">
	<tr>
		<th>아이디</th>
		<td>
		<Input style="border:inset" type="text" id="id" name="id">
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td>
		<Input style="border:inset" type="password" id="pwd" name="pwd">
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<Input  type="submit" value="login">
		<Input  type="button" value="sign up" onclick="account()">
		<input type="checkbox" id="check">Save ID
		</td>
	</tr>

</table>
</form>
<script type="text/javascript">
function account() {
	location.href = "signUp.jsp";
}
/*
session : java -> server 회원정보, 방문회수 = Object
cookie : javascript -> client id저장 = String
*/
let Accid = $.cookie("userId");//userId쿠키생성
if(Accid != null){
	$("#id").val( Accid );//"id"에 Accid값 입력 및 checkbox에 check
//	$("#check").attr("checked", "checked");
	$("#check").prop("checked", true);
}

$("#check").click(function() {
//	alert('check click');	
	if( $("#check").is(":checked") ){
		
		if( $("#id").val().trim() == "" ){//#id가 비어있는 상태에서 박스클릭시
			alert('id를 입력해 주십시오');
			$("#check").prop("checked", false);
		}
		else{//"id" 값이 있는 상태에서 박스클릭시 userID라는 쿠키에 저장하고 파기는 7일 경로는 현재위치
			$.cookie("userId", $("#id").val().trim(), { expires:7, path:'./' });	
		}		
	}
	else{//checkbox에 check되어있지 않으면 cookie 삭제
		$.removeCookie("userId", { path:'./' });
	}
});
</script>

</body>
</html>