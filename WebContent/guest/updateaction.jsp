<%@page import="data.dao.GuestDao"%>
<%@page import="data.dto.GuestDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//업로드할 save 폴더의 실제 서버에서의 위치구하기
	String realPath=getServletContext().getRealPath("/save");
	System.out.println("save 폴더의 실제 서버에서의 위치는 : ");
	System.out.println(realPath);
	//업로드할 이미지의 크기제한
	int uploadSize=1024*1024*2; //2mb;
	
	MultipartRequest multi=null;
	try{
		multi=new MultipartRequest(request,realPath,uploadSize,
				"utf-8",new DefaultFileRenamePolicy());
		
		//업로드한 이미지인데 안할경우 null
		String photo=multi.getFilesystemName("photo");
		System.out.println("photo="+photo);
		String content=multi.getParameter("content");
		
		String num=multi.getParameter("num");
		int pageNum=Integer.parseInt(multi.getParameter("pageNum"));
		
		//dto 에 넣기
		GuestDto dto=new GuestDto();
		dto.setNum(num);
		dto.setPhoto(photo);
		dto.setContent(content);
		
		//dao 선언
		GuestDao dao=new GuestDao();
		//메서드 호출
		dao.updateGuest(dto);
		
		
		//방명록 페이지로 이동
		response.sendRedirect("../index.jsp?main=guest/guestlist.jsp?pageNum="+pageNum);
	}catch(Exception e){
		System.out.println("업로드 오류:"+e.getMessage());
	}
%>