<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div.colors {
		margin-bottom: 10px;
	}
	
	div.colors div.selcolor {
		width: 30px;
		height: 30px;
		border: 1px solid black;
		border-radius: 100px;
		float: left;
		margin-left: 5px;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	var n=2;
	/* cnt=1; */
	$(function(){
		$("span.photo").click(function(){
			/* cnt=cnt+1;	
			if(cnt<=5){
				var s="";
				s=s+"<input type='file' name='photo"+cnt+"' style='width: 300px;' class='form-control'><br>";
				$("div.addfile").append(s);	
			} */
			if(n>5){
				alert("상품 사진은 5개까지만 등록 가능합니다");
				return;
			}			
			var tag="<input type='file' name='photo"+
				(n++)+"' style='width: 300px;' class='form-control'><br>";
			//기존 html 에 추가하는 부분
			$("div.addfile").html(function(idx,html) {
				return html+tag;
			});
		});
		
 		/* $(".colorCircle").click(function(){ */
			/* txtcolor=$(this).css("background-color"); */
			/* alert(txtcolor); */
			/* var colorshow = $("#color").val(); */
			/* colorshow = colorshow + "," + txtcolor; */
			/* if(colorshow.charAt(0)==','){ */
				/* colorshow = colorshow.substring(1,colorshow.length); */
			/* } */
			/* $("#color").val(colorshow); */
			/* $(this).hide(); */
		/* }); */
		
		//색상 선택 이벤트
		$("div.selcolor").click(function(){
			var selcolor=$(this).css("background-color");
			var textColor=$("#color").val();
			if(textColor.length==0)
				$("#color").val(selcolor);
			else{
				$("#color").val(textColor+":"+selcolor);
			}
			//한번 클릭한 색상은 바로 삭제하기
			$(this).remove();
		});
		
	});
</script>
</head>
<body>
<div class="inputform">
	<form action="shop/addaction.jsp" method="post"
	 enctype="multipart/form-data" class="form-inline">
		<table class="table table-bordered" style="width: 600px;">
			<caption><b>상품 등록</b></caption>
			<tr>
				<td style="width: 150px;background-color: #66cdaa;">
				<b>카테고리</b></td>
				<td>
				 <select style="width: 200px;" name="category"
				 	class="form-control">
				 	<option selected disabled hidden>선택하세요</option>
				 	<option value="아우터">아우터</option>
				 	<option value="상의" selected>상의</option>
				 	<option value="하의">하의</option>
				 	<option value="세트">세트</option>
				 	<option value="악세서리">악세서리</option>
				 </select>
				</td>
			</tr>
			<tr>
				<td style="width: 150px;background-color: #66cdaa;">
				<b>상품명</b></td>
				<td>
					<input type="text" name="sangpum" class="form-control"
					style="width: 200px;" placeholder="상품명입력"
					required="required">
				</td>
			</tr>
			<tr>
				<td style="width: 150px;background-color: #66cdaa;">
				<b>상품사진</b></td>
				<td>
					<div class="form-group">
						<input type="file" name="photo1" 
						style="width: 300px;" class="form-control"
						required="required">
						
						<span class="glyphicon glyphicon-plus-sign photo"
						style="margin-left: 20px;font-size: 1.3em;cursor: pointer;"></span>
					</div>
					<div class="addfile"></div>
				</td>
			</tr>
			<tr>
				<td style="width: 150px;background-color: #66cdaa;">
				<b>상품색상</b></td>
				<td>
				<%
					String []colors={"#ff69b4","#3cb371","#ffffff",
							"#ffc0cb","#8fbc8f","#dc143c","#0000ff",
							"#ffd700","#ff7f50","#afeeee"};
				%>
				<b>상품의 색상들을 선택해주세요</b>
				<div class="colors">
					<%
						for(String co:colors)
						{%>
							<div class="selcolor" style="background-color: <%=co%>"></div>	
						<%}
					%>
				</div>
				<%-- <%
					for(int i=0;i<colors.length;i=i+1)
					{%>
						<div class="colorCircle" style="width: 30px;height: 30px;border: 1px solid black;
						background-color: <%=colors[i]%>;border-radius: 50px;float: left;margin-right: 3px;"></div>	
					<%}
				%> --%>
				<br>
				<input type="text" name="color" class="form-control"
					style="width: 100%;" id="color" 
					placeholder="위에서 추가할 색상을 클릭하세요"
					required="required">
				</td>
			</tr>
			<tr>
				<td style="width: 150px;background-color: #66cdaa;">
				<b>상품가격</b></td>
				<td>
					<input type="text" name="price" class="form-control"
					style="width: 120px;" placeholder="가격입력"
					required="required" pattern="[0-9]{2,7}">
				</td>
			</tr>
			<tr>
				<td style="width: 150px;background-color: #66cdaa;">
				<b>입고일</b></td>
				<td>
				<%
					//현재 날짜 구하기
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					String day=sdf.format(new Date());
				%>
					<input type="date" name="ipgoday" value="<%=day%>"
					required="required">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit" class="btn btn-info"
					style="width: 100px;">상품저장</button>
					
					<button type="button" class="btn btn-info"
					style="width: 100px;"
					onclick="location.href='index.jsp?main=shop/shoplist.jsp'">상품목록</button>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>