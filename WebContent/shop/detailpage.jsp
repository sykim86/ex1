<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	img.large {
		width: 470px;
		height: 570px;
	}
	
	img.small {
		cursor: pointer;
		width: 80px;
		height: 90px;
		border: 1px solid gray;
		margin-right: 5px;
	}
	
	img.select {
		border: 4px solid magenta;
		border-radius: 20px;
	}
	
	div.colors {
		float: right;
		width: 30px;
		height: 30px;
		border: 1px solid black;
		margin-right: 5px;
		cursor: pointer;
	}
	
	div.mycolor {
		width: 50px;
		height: 50px;
		border: 1px solid black;
		margin-left: 100px;
	}
	
	div#answer {
		margin-left: 150px;
		margin-top: 30px;
	}
	
	#content {
		width: 400px;
		height: 50px;
		float: left;
	}
	
	#addanswer {
		width: 80px;
		height: 50px;
		line-height: 50px;
		margin-left: 5px;
		padding: 0px;
	}
	
	.answernav ul, .answernav li {
		list-style: none;
		padding: 20px 120px;
	}
	
	div.adminanswer {
		border: 1px double gray;
		background-color: #dfdfdf;
		width: 400px;
	}
</style>
<script type="text/javascript">
<%
	String myid=(String)session.getAttribute("myid");
%>
	$(function(){
		//처음 상품디테일 출력시 기존 댓글도 출력하기
		answerlist();
		
		$("img.small").first().addClass("select");
		
		$("img.small").click(function(){
			/* var imgSrc=$(this).attr("src");
			
			$("img.small").removeClass("select");
			
			$(this).addClass("select");
			
			$("img.large").attr("src", imgSrc); */
			//클릭한 이미지를 제외한 나머지 작은 이미지에 있는 클래스 제거
			$(this).siblings().removeClass("select");
			//클릭한 이미지에서 src값 얻기
			var imgsrc=$(this).attr("src");
			//얻은 src 를 큰 이미지에 적용
			$("img.large").attr("src",imgsrc);
			//클릭한 작은이미지에 select 클래스 추가
			$(this).addClass("select");
		});
		
		//색상 클릭시 이벤트
		$("div.colors").click(function(){
			//alert("확인");
			var mycolor=$(this).css("background-color");
			$("div.mycolor").css("background-color",mycolor);
			//hidden 폼태그에도 같이 넣어준다
			$("#mycolor").val(mycolor);
		});
		
		//댓글 추가버튼 이벤트
		$("#addanswer").click(function(){
			//ajax 함수로 처리
			//readanswer.jsp 로 myid,shopnum,content 3개를 보내서
			//해당 jsp 파일에서 db 에 insert 한다
			//성공하면 사용자함수 answerlist() 를 호출하고
			//입력창의 값들은 지워주세요
			var myid=$("#myid").val();
			var shopnum=$("#shopnum").val();
			var content = $("#content").val();
			$.ajax({
				type:"post",
				dataType:"html",
				url:"shop/readanswer.jsp",
				data:{"myid":myid,"shopnum":shopnum,"content":content},
				success:function(data){
					answerlist();
					$("#content").val("");
				}
				
			});
		});
		
		$(document).on("click","#delans",function(){
			var delidx=$(this).attr("idx");
			//alert(delidx);
			$.ajax({
				type:"get",
				url:"shop/deleteanswer.jsp",
				data:{"idx":delidx},
				dataType:"html",
				success:function(data){
					answerlist();
				}
			});
		});
		
		$(document).on("click",".replybtn:button",function(){
				var txtreply = $(this).next();
				//alert(cf);
				$(this).hide();
				txtreply.css("display", "block");
		});
		
		$(document).on("click",".btncancel:button",function(){
			$(this).parent().css("display", "none");
			$(this).parent().prev().show();
		});
		
		$(document).on("click",".btnsave:button",function(){
			var idx=$(this).parent().attr("idx");
			var answer=$(this).prev().val().replace(/ /g, "&nbsp");
			alert(answer);
			//alert(answer);
			//alert(idx);
			$.ajax({
				type:"post",
				url:"shop/addshopanswer.jsp",
				data:{"idx":idx,"answer":answer},
				dataType:"html",
				success:function(data){
					answerlist();
				}
			});
		});
	});//function
	
	//사용자함수 추가
	function answerlist()
	{
		var shopnum=$("#shopnum").val();
		$.ajax({
			type:"get",
			dataType:"xml",
			url:"shop/answerlist.jsp",
			data:{"shopnum":shopnum},
			success:function(data){
				var s="";
				s=s+"<nav class='answernav'>";
				s=s+"<ul>";
				
				$(data).find("answer").each(function(i, element) {
					var n = $(this);
					s=s+"<li class='answerli'>";
					s=s+"<h4>";
					s=s+"이름 : "+n.find("name").text()+"</h4><h4 style='float: right;'>작성일 : "+n.find("writeday").text();
					s=s+"</h4>";
					s=s+"<h3>";
					s=s+n.find("content").text().replace(/(?:\r\n|\r|\n)/g, "<br>");
					s=s+"<b class='glyphicon glyphicon-trash' style='font-size: 12px;' id='delans' idx='"+n.find("idx").text()+"'></b>";
					imsiId = "<%=myid%>";
					if(n.find("shopanswer").text()=="no" && imsiId == "admin"){
						s=s+"<h5>";
						s=s+"<button type='button' class='replybtn' style='float: right;background-color: #efffff;'>답글달기</button>";
						s=s+"<span class='txtreply' idx='"+n.find("idx").text()+"' style='float: right;display: none;'>";
						s=s+"<textarea style='width: 400px;height: 80px;'></textarea>";
						s=s+"<button type='button' class='btn btn-danger btnsave'>저장</button>";
						s=s+"<button type='button' class='btn btncancel'>취소</button>";
						s=s+"</span>";
						s=s+"</h5>";
					}
					else if(n.find("shopanswer").text()!="no"){
						s=s+"<ul>";
						s=s+"<li>";
						s=s+"<div class='adminanswer'>";
						s=s+"[샵주인]";
						s=s+"<div>";
						s=s+n.find("shopanswer").text().replace(/(?:\r\n|\r|\n)/g, "<br>");
						s=s+"</div>";
						s=s+"</div>";
						s=s+"</li>";
						s=s+"</ul>";
					}
					s=s+"</h3>";
					s=s+"</li>";
				});
				
				s=s+"</ul>";
				s=s+"</nav>";
				
				$("#answerlist").html(s);
			}
		});
		
	}
</script>
</head>
<%
	String shopnum=request.getParameter("shopnum");
	//로그인상태
	String loginok=(String)session.getAttribute("loginok");
	//로그인한 아이디
	//String myid=(String)session.getAttribute("myid");
	//아이디에 해당하는 멤버 테이블의 시퀀스번호
	MemberDao mdao=new MemberDao();
	String num=mdao.getNum(myid);
	
	//해당 상품에 대한 데이타 가져오기
	ShopDao sdao=new ShopDao();
	ShopDto dto=sdao.getData(shopnum);
	//사진들 배열타입으로 얻기
	String []photo=dto.getPhoto().split(",");
	//색상들 배열타입으로 얻기
	String []color=dto.getColor().split(":");
%>
<body>
<form id="frm">
	<!-- hidden : 장바구니 db 에 넣어야할 값들 -->
	<input type="hidden" name="shopnum" value="<%=shopnum%>">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="mycolor" id="mycolor" 
	value="<%=color[color.length-1]%>">
	
	<table style="width: 800px;">
		<tr>
			<td style="width: 500px;">
				<div id="photo">
					<img alt="" src="shopsave/<%=photo[0]%>"
						class="large img-thumbnail">
					<div>
					<%
					//사진이 여러개일경우만 반복문으로 처리
					if(photo.length>1)
					{
						for(int i=0;i<photo.length;i=i+1)
						{%>
							<img alt="" src="shopsave/<%=photo[i]%>"
								class="small">	
						<%}
					}
					%>
					</div>
				</div>
			</td>
			<td style="width: 300px;" valign="top">
				<h3>카테고리 : <%=dto.getCategory()%></h3>
				<h3>상품명 : <%=dto.getSangpum()%></h3>
				<%
				NumberFormat nf=NumberFormat.getCurrencyInstance();
				%>
				<h3>가 격 : <%=nf.format(dto.getPrice())%></h3>
				<h3>색 상 : 
				<%
				for(String co:color)
				{%>
					<div class="colors"
						style="background-color: <%=co%>"></div>	
				<%}
				%>
				</h3>
				<h3>선택한 색상 : 
				<div class="mycolor"
					style="background-color: <%=color[color.length-1]%>"></div>
				</h3>
				<%-- </h3><% for(String colorE:color)
					{%>
						<div class="colorCircle" style="background-color: <%=colorE%>"></div>
					<%}
					%>
					<div class="showSelectColor"></div> --%>
				
				<!-- 갯수 선택 -->
				<h3>갯 수 : 
					<input type="number" min="1" max="10" value="1"
					step="1" name="cnt">
				</h3>	
				
				<div style="margin-top: 100px;margin-left: 60px;">
					<button type="button"
					class="btn btn-success"
					style="width: 100px;"
					id="btncart">장바구니</button>
					
					<button type="button"
					class="btn btn-info btn-lg"
					style="width: 100px;"
					onclick="location.href='index.jsp?main=shop/shoplist.jsp'">상품목록</button>
				</div>
			</td>
		</tr>
	</table>
</form>
<%
//댓글 입력창은 로그인을 해야만 보인다
	if(loginok!=null)
	{
%>
<div id="answer">
	<form id="answerfrm">
		<input type="hidden" id="myid" value="<%=myid%>">
		<input type="hidden" id="shopnum" value="<%=dto.getShopnum()%>">
		
		<textarea id="content" class="form-control"></textarea>
		<button type="button" id="addanswer" class="btn btn-warning">추가</button>
	</form>
</div>
<%} %>
<div id="answerlist">
	댓글목록
</div>
<script type="text/javascript">
	$("#btncart").click(function(){
		var login="<%=loginok%>";
		if(login=="null"){
			alert("먼저 로그인을 해주세요");
			return;
		}
		
		//form 태그의 모든값을 가져오기
		var formdata=$("#frm").serialize();
		alert(formdata);
		$.ajax({
			type: "post",
			dataType: "html",
			data:formdata,
			url: "shop/detailprocess.jsp",
			success:function(data){
				var a=confirm("장바구니에 저장하였습니다\n장바구니로 이동하려면 [확인]을 눌러주세요");
				if(a){
					location.href="index.jsp?main=shop/mycart.jsp";
				}
			}
		});
	});
</script>
</body>
</html>