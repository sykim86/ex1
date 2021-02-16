<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="dao" class="data.dao.MoneyDao"/>
<jsp:useBean id="dto" class="data.dto.MoneyDto"/>
<!-- 전체 데이타 읽어서 dto 에 넣기 -->
<jsp:setProperty property="*" name="dto"/>
<%
	//메서드 호출
	dao.insertDaymoney(dto);
	System.out.println("데이타를 저장했습니다~");
%>