<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 엔코딩
	request.setCharacterEncoding("utf-8");
%>
<%-- dto,dao usebean --%>
<jsp:useBean id="dao" class="data.dao.MoneyDao"/>
<jsp:useBean id="dto" class="data.dto.MoneyDto"/>
<%-- setproperty : 전체 데이타 읽기 --%>
<jsp:setProperty property="*" name="dto"/>
<%
	dao.updateDaymoney(dto);
	response.sendRedirect("../index.jsp?main=money/moneylist.jsp");
%>