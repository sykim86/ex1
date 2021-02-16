<%@page import="data.dto.CartDto"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	/* String shopnum=request.getParameter("shopnum");
	String num=request.getParameter("num");
	String mycolor=request.getParameter("mycolor");
	String cnt=request.getParameter("cnt");
	
	CartDto dto=new CartDto();
	dto.setShopnum(shopnum);
	dto.setNum(num);
	dto.setMycolor(mycolor);
	dto.setCnt(Integer.parseInt(cnt));
	
	ShopDao dao=new ShopDao();
	
	dao.insertCart(dto); */
%>
<jsp:useBean id="dao" class="data.dao.ShopDao"/>
<jsp:useBean id="dto" class="data.dto.CartDto"/>
<jsp:setProperty property="*" name="dto"/>
<%
	dao.insertCart(dto);
%>