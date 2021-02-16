<%@page import="data.dto.GuestDto"%>
<%@page import="data.dao.GuestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	span.camera {
		cursor: pointer;
		margin-left: 10px;
		font-size: 22px;
	}
	
	#showimg {
		position: absolute;
		left: 520px;
		max-width: 150px;
	}
</style>
<script type="text/javascript">
	$(function(){
		$(".camera").click(function(e){
			//alert("클릭했습니다");
			//$("#photo").click();
			//#photo 의 클릭 이벤트 강제발생
			$("#photo").trigger("click");
		});
	});
	function readUrl(input){
		if(input.files[0]){
			var reader=new FileReader();
			reader.onload=function(e){
				$("#showimg").attr("src", e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
</script>
</head>
<%
	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
	GuestDao dao=new GuestDao();
	GuestDto dto=dao.getData(num);
%>
<body>
		<!-- 이미지 출력할곳 -->
		<%
			if(dto.getPhoto().equals("no"))
			{%>
				<img alt="" src="" id="showimg">
			<%}
			else
			{%>
				<img alt="" src="save/<%=dto.getPhoto()%>" id="showimg">	
			<%}
		%>
		
		<form action="guest/updateaction.jsp" method="post"
		  enctype="multipart/form-data">
		<!-- hidden -->
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<table class="table table-bordered" style="width: 503x;">
				<caption><h4>방명록수정</h4></caption>
				<tr height="150">
					<td>
						<b>사진은 수정시에만 다시 선택해주세요(1개만 가능)</b>
						<span class="camera glyphicon glyphicon-camera"></span>
						<input type="file" name="photo" id="photo"
						style="display: none;"
						onchange="readUrl(this)">
						<br>
						<textarea rows="" cols="" name="content"
						style="width: 400px;height: 100px;"
						required="required"><%=dto.getContent()%></textarea>
						
						<button type="submit"
						class="btn btn-danger"
						style="float: right;width: 80px;height: 100px;">수정</button>
					</td>
				</tr>
				<tr>
					<td align="center">
						<button type="button" class="btn btn-info"
						onclick="history.back()">목록으로 돌아가기</button>
					</td>
				</tr>
			</table>
		</form>	
</body>
</html>