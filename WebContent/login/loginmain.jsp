<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//세션에서 로그인상태를 알수 있는 loginok 얻기
	String loginok=(String)session.getAttribute("loginok");
	System.out.println("로그인메인에서 보는 loginok는 " +loginok+" 입니다");
	if(loginok==null)
	{%>
		<jsp:include page="loginform.jsp"/>
	<%}
	else
	{%>
		<jsp:include page="logoutform.jsp"/>
	<%}
%>