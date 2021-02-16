<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 엔코딩
	request.setCharacterEncoding("utf-8");
	//pageNum 읽기
	//int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	String pageNum=request.getParameter("pageNum");
%>
<!-- useBean dto,dao 선언 new로 생성하는 것과 같다 -->
<jsp:useBean id="dto" class="data.dto.AnswerDto"/>
<jsp:useBean id="dao" class="data.dao.AnswerDao"/>

<!-- dto 에 데이타 읽어서 넣기 : setProperty -->
<jsp:setProperty property="*" name="dto"/>
<%
	//insert 메서드 호출
	dao.insertAnswer(dto);
	//guestlist 로 가는데 보던 데이지로 이동해야한다
	String go="../index.jsp?main=guest/guestlist.jsp?pageNum="+pageNum;
	response.sendRedirect(go);
	/* response.sendRedirect("../index.jsp?main=guest/guestlist.jsp?pageNum="+pageNum); */
%>