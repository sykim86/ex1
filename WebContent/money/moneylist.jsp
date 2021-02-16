<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.MoneyDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MoneyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function showPopup(){
		window.open("money/moneyform.jsp","","width=400, height=200, left=100, top=50, resizable = no, scrollbars = no");
	}
</script>
</head>
<%
	MoneyDao dao=new MoneyDao();

	List<MoneyDto> list=dao.getAllMoneys();
%>
<body>
<iframe name="framepop" style="display: none;"></iframe>
<button type="button" id="btnadd"
onclick="showPopup();">추가</button>
<table class="table table-bordered" style="width: 1400px;">
	<caption><b>금전출납부</b></caption>
	<tr bgcolor="#ffdd22">
		<td style="width: 100px;" align="center"><b>번호</b></td>
		<td style="width: 500px;" align="center" colspan="2"><b>품목</b></td>
		<td style="width: 400px;" align="center"><b>가격</b></td>
		<td style="width: 300px;" align="center"><b>날짜</b></td>
		<td style="width: 200px;" align="center"><b>관리</b></td>
	</tr>
	<%
		int sum=0;
		for(MoneyDto dto:list)
		{
			sum = sum + dto.getPrice();
	%>
			<tr>
				<td align="center">
					<%=dto.getNum()%>
				</td>
				<td align="center" style="width: 500px;" colspan="2">
					<%=dto.getPummok()%>
				</td>
				<td align="center">
					<%=dto.getPrice()%>
				</td>
				<td align="center">
					<%=dto.getDay()%>
				</td>
				<td align="center">
					<button type="button" class="btn btn-info btn-xs"
					onclick="location.href='index.jsp?main=money/moneyupdateform.jsp?num=<%=dto.getNum()%>'">정보수정</button>&nbsp;
					<button type="button" class="btn btn-danger btn-xs"
					onclick="location.href='index.jsp?main=money/moneydelete.jsp?num=<%=dto.getNum()%>'">
					정보삭제</button>
				</td>
			</tr>	
		<%}
		
			String total = NumberFormat.getCurrencyInstance().format(sum);
	%>
			<tr>
				<td colspan="6" align="center">총 금액의 합계 : <%=total%></td>
			</tr>
</table>
</body>
</html>