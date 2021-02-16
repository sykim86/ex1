<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	String url=request.getContextPath();
	//System.out.println("팝업창에서는 url이 "+url+" 입니다~");
%>
<script type="text/javascript">
	function moneySubmit(){
		document.moneyform.target="framepop";
		document.moneyform.submit();

		//opener.parent.location.reload();
		opener.parent.location.href="<%=url%>/index.jsp?main=money/moneylist.jsp";
		window.open('','_self').close();
	}
</script>
</head>
<body>
<form action="moneyaction.jsp" method="post"
	class="form-=inline" name="moneyform" id="myfrm">
<label for="txtpummok">품목 : </label>
<input type="text" name="pummok" required="required" autofocus="autofocus" size="30" id="txtpummok">
<br><br>
<label for="txtprice">가격 : </label>
<input type="text" name="price" size="20" id="txtprice">
<br><br>
<label for="txtday">사용한 날짜 : </label>
<input type="text" name="day" size="20" id="txtday">
<br><br>
<button type="button" onclick="moneySubmit()">저장하기</button>
</form>
</body>
</html>