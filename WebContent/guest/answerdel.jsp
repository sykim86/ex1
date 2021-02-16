<%@page import="data.dao.AnswerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//idx 읽기
	String idx=request.getParameter("idx");
	//dao 선언
	AnswerDao adao=new AnswerDao();
	//삭제
	adao.deleteAnswer(idx);
%>