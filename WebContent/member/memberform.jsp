<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		/* $("#id").focus();
		
		$("#id").focusout(function() {
			inputid=$("#id").val();
			//alert(inputid);
			$.ajax({
				type: "get",
				dataType:"xml",
				url:"idcheckxml.jsp",
				data:{"id":inputid},
				success:function(data){
					//alert($(data).text());
					$(data).find("data").each(function(i, element) {
						var info = $(this).text();
						if(info == yes){
							$(".idcheck").html("<span style="color:green;">사용가능한 아이디입니다</span>");
						}
						else{
							$(".idcheck").html("<span style="color:red;">이미 등록된 아이디입니다</span>");
							$(".idcheck").blur;
						}
					});
				}
			});
		}); */
		
		//아이디 입력시 메세지 지우기
		$("#id").keydown(function(){
			$("b.idcheck").html("");
		});
		
		//아이디 입력후 포커스가 벗어날때 아이디 체크하기
		$("#id").blur(function(){
			var id=$(this).val();//앞뒤공백제거
			if(id.trim().length==0){
				//alert("공백제거");
				$(this).val('');
				return;
			}
			$.ajax({
				type: "get",
				url:"member/idcheckxml.jsp",
				dataType:"xml",
				data:{"id":id},
				success:function(data){
					//alert($(data).text());
					if($(data).text()=='yes'){
						$("b.idcheck").html("이미 등록된 아이디입니다");
						$("b.idcheck").css({
							"color":"red",
							"font-size":"14px"
						});
						$("#id").val("");
					}
					else{
						$("b.idcheck").html("사용가능한 아이디입니다");
						$("b.idcheck").css({
							"color":"green",
							"font-size":"14px"
						});
					}
				}
			});
		});
		
		//주소검색파일 오픈
		$("#btnpost").click(function(){
			window.open("member/postsearch.jsp","","left=100px,top=100px,width=400px,height=250px");
		});
	});
</script>
</head>
<body>
<form action="member/insertaction.jsp" method="post"
	class="form-inline" name="memberform" id="myfrm">
<table class="table table-bordered" style="width: 500px;">
	<caption><h3>회원 가입</h3></caption>
	<tr>
		<td align="center" width="100"><b>아이디</b></td>
		<td>
			<input type="text" name="id" id="id" class="form-control"
				style="width: 100px;" autofocus="autofocus"
				required="required">
			<b class="idcheck"></b>
		</td>
	</tr>
	<tr>
		<td align="center" width="100"><b>비밀번호</b></td>
		<td>
			<input type="password" name="pass" class="form-control"
				style="width: 100px;"
				<%--
				pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
  title="Must contain at least one  number and one uppercase and lowercase letter, and at least 8 or more characters"
  				--%>
  			required="required">
		</td>
	</tr>
	<tr>
		<td align="center" width="100"><b>이 름</b></td>
		<td>
			<input type="text" name="name" class="form-control"
				style="width: 100px;" required="required">
		</td>
	</tr>
	<tr>
		<td align="center" width="100"><b>핸드폰</b></td>
		<td>
			<div class="form-group">
				<select name="hp1" class="form-control">
					<option value="02">02</option>
					<option value="010" selected="selected">010</option>
					<option value="019">019</option>
				</select>
				<input type="text" name="hp2" id="hp2"
					class="form-control"
					maxlength="4" style="width: 80px;" required="required">
				<input type="text" name="hp3" id="hp3"
					class="form-control"
					maxlength="4" style="width: 80px;" required="required">
			</div>
		</td>
	</tr>
	<tr>
		<td align="center" width="100"><b>주소</b></td>
		<td>
			<input type="text" name="address" class="form-control input-sm"
			style="width: 300px;background-color: #eee;"
			readonly="readonly" required="required">
			<button type="button" class="btn btn-danger btn-sm"
			id="btnpost">주소검색</button>
			<br>
			<input type="text" name="addrdetail" 
			class="form-control input-sm"
			style="width: 350px;">
		</td>
	</tr>
	<tr>
		<td align="center" width="100"><b>이메일</b></td>
		<td>
			<div class="form-group">
				<input type="text" name="email1" style="width: 80px;"
				class="form-control" required="required">
				<b>@</b>
				<input type="text" name="email2" id="email2"
				style="width: 100px;"
				class="form-control" required="required">
				
				<select id="email3" class="form-control">
					<option selected disabled hidden="">이메일선택</option>
					<option value="-">직접작성</option>
					<option value="naver.com">네이버</option>
					<option value="nate.com">네이트</option>
					<option value="gamil.com">구글</option>
				</select>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="submit" class="btn btn-danger">
			회원가입</button>
		</td>
	</tr>
</table>
</form>
<script type="text/javascript">
	//1. 핸드폰 4자리 입력시 다음 번호칸으로 이동	
	$("#hp2").keyup(function() {
		var len=$(this).val().length;
		if(len==4)
			$("#hp3").focus();
	});
	/* $("#hp2").keyup(function(e) {
		if($("#hp2").length==4)
			$("#hp3").focus();
	}); */
	//2. 이메일 선택시 앞칸에 이메일주소출력
	//	 직접쓰기일경우 기존 이메일 지우고 포커스주기
	$("#email3").change(function() {
		var s=$(this).val();
		if(s=='-'){
			$("#email2").val("");
			$("#email2").focus();
		}
		else{
			$("#email2").val(s);
		}
	});
</script>
</body>
</html>