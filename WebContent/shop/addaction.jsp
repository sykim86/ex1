<%@page import="data.dto.ShopDto"%>
<%@page import="data.dao.ShopDao"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//업로드할 경로 구하기(shopsave 폴더 생성후 거기에 업로드)
	String uploadPath=getServletContext().getRealPath("/shopsave");
	System.out.println("상품등록에서 업로드할 경로는 "+uploadPath);
	//업로드할 이미지의 사이즈
	int uploadSize=1024*1024*2;//2mb;
	
	MultipartRequest multi=null;
	try{
		multi=new MultipartRequest(request,uploadPath,uploadSize,
				"utf-8",new DefaultFileRenamePolicy());
		String sangpum = multi.getParameter("sangpum");
		String color=multi.getParameter("color");
		String category=multi.getParameter("category");
		String ipgoday=multi.getParameter("ipgoday");
		int price=Integer.parseInt(multi.getParameter("price"));
		//여러개의 이미지명을 가져오는데 여러개일경우 , 로 연결
		String photo="";
		//file 타입인 요소만 name 을 얻는다
		Enumeration en=multi.getFileNames();
		while(en.hasMoreElements())
		{
			String name=(String)en.nextElement();
			//name 에 들어있는 이미지명 가져오기
			String fileName=multi.getFilesystemName(name);
			System.out.println("상품등록에서 선택한 이미지는 "+name+":"+fileName);
			if(fileName!=null)
			{
				if(photo.length()==0)
					photo=fileName;
				else
					photo=photo+","+fileName;				
			}
		}
		System.out.println("db에 저장할 상품등록 사진들은 : "+photo);
		
		//dao 선언
		ShopDao dao=new ShopDao();
		//dto 에 데이타 넣기
		ShopDto dto=new ShopDto();
		dto.setSangpum(sangpum);
		dto.setCategory(category);
		dto.setColor(color);
		dto.setIpgoday(ipgoday);
		dto.setPhoto(photo);
		dto.setPrice(price);
		
		//db 에 추가
		dao.insertShop(dto);
		
		//다시 상품폼으로 이동
		response.sendRedirect("../index.jsp?main=shop/addform.jsp");
	}catch(Exception e){
		System.out.println("업로드 오류 :"+e.getMessage());
	}
%>