<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script type="text/javascript">
	$("aclass").click(function(){
		sessionStorage.menu="menu1";
	});
</script> -->
</head>
<body>
<a class="home">Jsp+jQuery+Ajax Mini Project</a>
<script type="text/javascript">
	$("a.home").click(function(e){
		e.preventDefault();
		sessionStorage.menu="menu1";
		location.href="index.jsp";
	});
</script>
</body>
</html>