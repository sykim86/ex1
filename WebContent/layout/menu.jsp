<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Grandstander:wght@100&family=Indie+Flower&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<style type="text/css">
	div.mymenu{
		width: 100%;
	}
	div.mymenu ul{
		list-style: none;
		margin: 0 auto;
		display: flex;
	}
	div.menu ul li{
		width: 130px;
		height: 70px;
		line-height: 70px;
		border: 2px solid #db7093;
		margin-right: 20px;
		border-radius: 20px;
		background-color: aqua;
	}
	
	div.mymenu ul li:hover{
		background-color: #ffb6c1;
		color: #483d8b;
		cursor: pointer;
	}
	
	div.mymenu ul li.bottom{
		border-bottom: 5px solid #333;
		border-right: 5px solid #333;
	}
	div.mymenu a{
		font-family: 'Gamja Flower';
	}
</style>
<script type="text/javascript">
	$(function(){
		if(sessionStorage.menu!=null){
			$("div.mymenu ul li").each(function(i, element) {
				if(sessionStorage.menu==$(this).attr("menu")){
					$(this).addClass("bottom");
					$(this).next().click();//해당 메뉴의 a태그 이벤트 호출
				}
			});
		}
		else{
			$("div.mymenu ul li").eq(0).addClass("bottom");
		}
		
		$("div.mymenu ul li a").click(function(e){
			//기본 이벤트 무효화
			e.preventDefault();
			//href 값을 얻어서 해당 url 로 이동
			var href=$(this).attr("href");
			location.href=href;
			var menu=$(this).parent().attr("menu");
			sessionStorage.menu=menu;
		});
	});
</script>
</head>
<body>
<%
	//프로젝트의 경로 구하기
	String url=request.getContextPath();
	System.out.println(url);
	//세션 로그인 상태
	String loginok=(String)session.getAttribute("loginok");
	//세션에 저장된 아이디
	String myid=(String)session.getAttribute("myid");
%>
<div class="mymenu">
	<ul>
		<li menu="menu1">
			<a href="<%=url%>/index.jsp">Home</a>
		</li>
		<li menu="menu2">
			<a href="<%=url%>/index.jsp?main=member/memberlist.jsp">회원목록</a>
		</li>
		<li menu="menu3">
			<%
			if(loginok!=null && myid.equals("admin")){%>
				<a href="<%=url%>/index.jsp?main=shop/addform.jsp">상품등록</a>
			<%}
			else{%>
				<a href="<%=url%>/index.jsp?main=shop/shoplist.jsp">상품목록</a>
			<%}
			%>
		</li>
		<li menu="menu4">
			<a href="<%=url%>/index.jsp?main=guest/guestlist.jsp">방명록</a>
		</li>
		<li menu="menu5">
			<a href="<%=url%>/index.jsp?main=board/boardlist.jsp">게시판</a>
		</li>
		<li menu="menu6">
			<a href="<%=url%>/index.jsp?main=money/moneylist.jsp">금전출납부</a>
		</li>
	</ul>
</div>
</body>
</html>