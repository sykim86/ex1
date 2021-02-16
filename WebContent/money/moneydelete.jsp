<%@page import="data.dao.MoneyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
<%
	String num=request.getParameter("num");
	
	MoneyDao dao=new MoneyDao();
	dao.deleteDaymoney(num);
	RequestDispatcher rd = request.getRequestDispatcher("../index.jsp?main=money/moneylist.jsp");
	rd.forward(request,response);
%>			
		
		


