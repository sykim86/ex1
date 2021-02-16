<%@page import="data.dto.ZipcodeDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주소검색</title>
<style type="text/css">
	table.tbsearch *{
		font-size: 12px;
	}
</style>
<script type="text/javascript">
	function select(addr){
		//부모창의 주소있는곳에 보낸다
		opener.memberform.address.value=addr;
		//디테일주소를 쓸수 있게 포커스
		opener.memberform.addrdetail.focus();
		//현재창닫기
		window.close();
	}
</script>
</head>
<body>
<%
	String key=request.getParameter("key");
	if(key==null)
	{
		//검색폼
	%>
		<form action="postsearch.jsp" method="get">
			<b>검색할 동을 입력해주세요</b><br><br>
			<img alt="" src="../image/s10.JPG" width="130" align="left" hspace="20">
			<input type="text" name="dong" required="required" autofocus="autofocus" size="8">
			<br><br>
			<input type="hidden" name="key" value="result">
			<button type="submit" style="width: 100px;">검색하기</button>
		</form>
	<%}
	else
	{//결과테이블
		String dong=request.getParameter("dong");
		//dao 선언
		MemberDao dao=new MemberDao();
		
		//메서드 호출
		List<ZipcodeDto> list=dao.getSearchDong(dong);
		
		//출력
		
	%>
		<table border="1" class="tbsearch">
			<caption><b>검색 결과</b></caption>
			<tr bgcolor="#ccc">
				<th width="300">주 소</th>
				<th>선택</th>
			</tr>
				<%
				for(ZipcodeDto dto:list)
				{
					//보일때는 번지까지
					String addr1="("+dto.getZipcode()+")"
							+dto.getSido()+" "+dto.getGugun()
							+" "+dto.getDong()+" "+dto.getRi()
							+" "+dto.getBunji();
					//실제 적용은 번지 제외
					String addr2="("+dto.getZipcode()+")"
							+dto.getSido()+" "+dto.getGugun()
							+" "+dto.getDong()+" "+dto.getRi();
				%>
			<tr>
				<td><%=addr1%></td>
				<td align="center">
					<button type="button" onclick="select('<%=addr2%>')">선택</button>
				</td>
			</tr>
				<%}
				%>
		</table>
		<button type="button" style="width: 100px;margin-left: 100px;" onclick="location.href='postsearch.jsp'">다시검색</button>
	<%}
%>
</body>
</html>