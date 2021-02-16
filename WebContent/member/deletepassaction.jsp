<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//id와 pass 를 읽는다
	/* request.setCharacterEncoding("utf-8"); */
	String id=request.getParameter("id");
	String pass=request.getParameter("pass");
	//dao 선언
	MemberDao dao = new MemberDao();
	//비번이 맞는지 isIdPassCheck 호출(변수 find)
	boolean find=dao.isIdPassCheck(id, pass);
	//find가 false면 스크립트로 '비밀번호가 틀렸습니다' 경고후 이전페이지 이동
	//true면 삭제메서드 호출후 멤버목록으로 이동
	if(find)
	{
		//비번이 맞는 경우 삭제
		dao.deleteMember(id);
		response.sendRedirect("../index.jsp?main=member/memberlist.jsp");//여기는 action파일이라 member폴더안에 있어서 인덱스로 가려면 상위폴더로 가야한다
	}
	else
	{%>
		<script type="text/javascript">
			alert("비밀번호가 틀렸습니다");
			history.back();
		</script>	
	<%}
%>