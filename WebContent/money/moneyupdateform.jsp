<%@page import="data.dao.MoneyDao"%>
<%@page import="data.dto.MoneyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//num 읽기
	String num=request.getParameter("num");

	//db로부터 getData 호출후 폼안에 값 넣어주기
	MoneyDao dao=new MoneyDao();
	MoneyDto dto=dao.getData(num);
%>
<body>
<form action="money/moneyupdateaction.jsp" method="post"
		class="form-inline" name="moneyupForm" id="myfrmUp">
	<input type="hidden" name="num" value="<%=dto.getNum()%>">
	<table class="table table-bordered" style="width: 500px;">
		<caption>
			<h3>금전출납부수정</h3>
		</caption>
		<tr>
			<td align="center" width="100"><b>품목</b></td>
			<td><input type="text" name="pummok" class="form-control"
					style="width: 300px;" value="<%=dto.getPummok()%>"></td>
		</tr>
		<tr>
			<td align="center"><b>가격</b></td>
			<td><input type="text" name="price" class="form-control"
					value="<%=dto.getPrice()%>"></td>
		</tr>
		<tr>
			<td align="center"><b>날짜</b></td>
			<td><input type="text" name="day" class="form-control"
					value="<%=dto.getDay()%>"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="btn btn-warning">
				금전출납부수정</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>