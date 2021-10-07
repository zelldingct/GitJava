<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign up 창</title>
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
</head>
<body style= "background-color:LightPink;">
<h2 style="text-align:center;">회원가입!</h2>
<form action="signUpAf.jsp" method="post">
<!-- action 속성은 폼 데이터(form data)를 서버로 보낼 때 해당 데이터가 도착할 URL을 명시합니다. -->
<table border="1">
	<tr>
		<th>아이디</th>
		<td>
		<Input style="border:inset" type="text" id="id" name="id">
		<p id="idcheck" style="font-size: 8px"></p>
		<input type="button" id="btn" value="id확인">
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td>
		<Input style="border:inset" type="password" id="pwd" name="pwd">
		</td>
	</tr>
		<tr>
		<th>이름</th>
		<td>
		<Input style="border:inset" type="text" id="name" name="name">
		</td>
	</tr>
		<tr>
		<th>이메일</th>
		<td>
		<Input style="border:inset" type="text" id="email" name="email">
		</td>
	</tr>
	<tr>
		<td colspan="2">
		<Input  type="submit" value="Done">
		</td>
	</tr>
</table>
</form>

<script type="text/javascript">
$(document).ready(function() {//해당 문서를 다 읽고 나서 함수를 실행하라
	
	$("#btn").click(function () {//id="btn" 클릭시
		
		$.ajax({//ajax최신 src가 필요하다.
			url:"getId.jsp",
			type:"post",
			data:{ id:$("#id").val() },
			success:function(resp){
			//	alert('success');
			//	alert(resp.trim());
				
				if(resp.trim() == "YES"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").html("이 ID는 사용할 수 있습니다");
				}
				else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").html("사용 중인 ID입니다");
					$("#id").val("");//id="id"인 곳 blank로 만들어라
					$("#id").focus();//커서위치는 id="id"인 곳
				}
			},
			error:function(){
				alert('error');
			}
		});
		
	});
	
});
</script>

</body>
</html>