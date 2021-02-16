<%@page import="java.io.File"%>
<%@page import="data.dao.GuestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//num,pageNum 읽기
	String num=request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
	//dao 선언
	GuestDao dao=new GuestDao();
	//num 에 해당하는 photo 값 얻기
	String photo=dao.getData(num).getPhoto();
	//save 폴더의 실제 서버에서의 위치를 구한다
	String realPath=getServletContext().getRealPath("/save");
	//실제 업로드된 곳의 이미지에 대한 File 객체 생성
	File file=new File(realPath+"\\"+photo);
	//해당 폴더에서 photo 를 파일삭제
	file.delete();
	//db 에서 데이타 삭제
	dao.deleteGuest(num);
	//다시 보던 페이지로 이동
	response.sendRedirect("../index.jsp?main=guest/guestlist.jsp?pageNum="+pageNum);
%>
