<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8" http-equiv="Content-Type" content="text/html">
<title>Insert title here</title>
<link rel="shortcut icon" href="#">
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Grandstander:wght@100&family=Indie+Flower&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	a{
		color: black;
		text-decoration: none;
	}
	a:visited{
		color: black;
	}
	a:hover{
		color: gray;
		cursor: pointer;
	}
	div.layout{
		width: 100%;
		display: grid;
	}
	div.layout div.title{
		height: 130px;
		line-height: 130px;
		font-size: 43px;
		text-align: center;
		font-family: 'Nanum Pen Script';
		margin: 0 auto;
	}
	
	div.layout div.menu{
		text-align: center;
		font-size: 25px;
		font-family: 'Gamja Flower';
		top: 300px;
		margin: 0 auto;
	}
	
	div.layout div.info{
		position: absolute;
		left: 20px;
		top: 400px;
		width: 180px;
		height: 200px;
		border: 2px solid gray;
		border-radius: 30px;
		font-size: 17px;
		padding: 20px;
		font-family: 'Gamja Flower';
		text-align: left;
	}
	
	div.layout div.login{
		position: absolute;
		left: 20px;
		top: 100px;
		width: 270px;
		/* height: 250px; */
		border: 2px solid gray;
		border-radius: 30px;
		font-size: 20px;
		padding: 20px;
		font-family: 'Gamja Flower';
	}
	
	div.layout div.main{
		position: absolute;
		left: 450px;
		top: 200px;
		/* font-family: 'Gamja Flower'; */
		font-size: 20px;
	}
	
	@media all and (max-width: 150px) {
		div.layout div.menu{
			text-align: center;
			font-size: 25px;
			font-family: 'Grandstander:wght@100';
			top: 100px;
			position: absolute;
			left: 10%;
		}
	}
	@media all and (min-width: 321px) and (max-width: 960px) {
        div.layout div.menu{
			text-align: center;
			font-size: 25px;
			font-family: 'Grandstander:wght@100';
			top: 100px;
			position: absolute;
			left: 20%;
		}
	}
	@media all and (min-width: 769px) {
        div.layout div.menu{
			text-align: center;
			font-size: 25px;
			font-family: 'Grandstander:wght@100';
			top: 100px;
			position: absolute;
			left: 30%;
		}
	}
</style>
</head>
<%
	//메인페이지에 들어갈 파일 읽기
	String mainPage="layout/main.jsp";
	if(request.getParameter("main")!=null){
		mainPage=request.getParameter("main");
	}
	else{%>
		<script type="text/javascript">
			sessionStorage.menu="menu1";	
		</script>		
	<%}
	int port=request.getLocalPort();
	String faddr=request.getServerName();
	String maddr=request.getRequestURI();
	String laddr=request.getQueryString();
	System.out.println(faddr+":"+port+maddr+"?"+laddr);
	System.out.println("myid:"+session.getAttribute("myid")+",saveid:"+session.getAttribute("saveid")+",loginok:"+session.getAttribute("loginok"));
%>
<body>
<div class="layout">
	<div class="login item">
		<jsp:include page="login/loginmain.jsp"/>
	</div>
	<div class="title item">
		<jsp:include page="layout/title.jsp"/>
	</div>
	<div class="menu item">
		<jsp:include page="layout/menu.jsp"/>
	</div>
	<div class="main item">
		<jsp:include page="<%=mainPage%>"/>
	</div>
	<div class="info item">
		<jsp:include page="layout/info.jsp"/>
	</div>
</div>
</body>
</html>