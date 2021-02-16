<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//idx 읽기
	String idx=request.getParameter("idx");
	//dao 선언
	ShopDao dao = new ShopDao();
	//장바구니 삭제
	dao.deleteCart(idx);
%>