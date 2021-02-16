<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ShopDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ShopDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Tabs - Default functionality</title>
<link rel="stylesheet" href="shop/jquery-ui.css">
<link rel="stylesheet" href="shop/style.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
	.shoptable tr {
		height: 150px;
		font-weight: bold;
		padding: 10px;
	}
	
	img.photo {
		width: 200px;
		height: 230px;
		border: 1px solid black;
		margin-bottom: 10px;
	}
</style>
<script>
$( function() {
  $( "#tabs" ).tabs();
  
  //각 상품 클릭시 발생하는 이벤트 추가
  $("a.godetail").click(function(e){
	 e.preventDefault();//기본 이벤트 무효화
	 
	 //태그에 넣어둔 shopnum 가져오기
	 var shopnum=$(this).attr("shopnum");
	 //디테일 페이지로 이동하기
	 location.href="index.jsp?main=shop/detailpage.jsp?shopnum="+shopnum;
  });
} );
</script>
</head>
<%
	ShopDao dao=new ShopDao();
	List<ShopDto> list=dao.getAllSangpums();
%>
<body>
 
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">전체</a></li>
    <li><a href="#tabs-2">상의</a></li>
    <li><a href="#tabs-3">하의</a></li>
    <li><a href="#tabs-4">세트</a></li>
    <li><a href="#tabs-5">아우터</a></li>
    <li><a href="#tabs-6">악세서리</a></li>
  </ul>
  <div id="tabs-1">
    <p>
    	<table class="shoptable table table-bordered" style="width: 700px;">
    		<caption><b>전체 상품 목록</b></caption>
    		<tr>
    		<%
    		NumberFormat nf=NumberFormat.getCurrencyInstance();
    		//20~50까지 난수 발생
    		int i=0;
    		for(ShopDto dto:list)
    		{
	    		int sale=(int)(Math.random()*31)+20;
    			//첫번째 사진
    			String photo=dto.getPhoto().split(",")[0];
    		%>
    			<td>
    			<a shopnum="<%=dto.getShopnum()%>" 
    			style="cursor: pointer;" class="godetail">
    				<img alt="" src="shopsave/<%=photo%>" class="photo">
    				<br>
    				<%=dto.getSangpum()%><br>
    				<b style="color: red;font-size: 1.3em;">
    				<%=sale%>%</b>
    				<span style="float: right;">
    					<div style="color: gray;font-size: 13px;">
    						<%
    							int price=(int)(dto.getPrice()-(dto.getPrice()*(sale/100.0)));
    						%>
    						<strike><%=nf.format(dto.getPrice())%></strike>
    					</div>
    					<div style="color: black;font-size: 16px;">
    						<%=nf.format(price)%>
    					</div>
    				</span>
    				<%-- <%=sale%>%<span style="float: right;"><%=nf.format(dto.getPrice())%></span><br>
    				<span style="float: right;"><%=nf.format(dto.getPrice()+dto.getPrice()*sale*1/100)%></span> --%>
    			</a>
    			</td>
    			<%
    			if((i+1)%4==0)
    			{%>
    				</tr>
    				<tr>	
    			<%}
    			i=i+1;
    		}
    		%>
    		</tr>
    	</table>
    </p>
  </div>
  <div id="tabs-2">
    <p>
    	<table class="shoptable table table-bordered" style="width: 700px;">
    		<caption><b>상의</b></caption>
    		<tr>
    		<%
    		i=0;
    		for(ShopDto dto:list)
    		{
    			if(dto.getCategory().equals("상의"))
    			{
    			//첫번째 사진
    			String photo=dto.getPhoto().split(",")[0];
	    		//20~50까지 난수 발생
	    		int sale=(int)(Math.random()*31)+20;
    		%>
    			<td>
    			<a shopnum="<%=dto.getShopnum()%>" 
    			style="cursor: pointer;" class="godetail">
    				<img alt="" src="shopsave/<%=photo%>" class="photo">
    				<br>
    				<%=dto.getSangpum()%><br>
    				<b style="color: red;font-size: 1.3em;">
    				<%=sale%>%</b>
    				<span style="float: right;">
    					<div style="color: gray;font-size: 13px;">
    						<%
    							int price=(int)(dto.getPrice()-(dto.getPrice()*(sale/100.0)));
    						%>
    						<strike><%=nf.format(dto.getPrice())%></strike>
    					</div>
    					<div style="color: black;font-size: 16px;">
    						<%=nf.format(price)%>
    					</div>
    				</span>
    				<%-- <%=sale%>%<span style="float: right;"><%=nf.format(dto.getPrice())%></span><br>
    				<span style="float: right;"><%=nf.format(dto.getPrice()+dto.getPrice()*sale*1/100)%></span> --%>
    			</a>
    			</td>
    			<%
    			if((i+1)%4==0)
    			{%>
    				</tr>
    				<tr>	
    			<%}
    			i=i+1;
    			}
    		}
    		%>
    		</tr>
    	</table>
    </p>
  </div>
  <div id="tabs-3">
    <p>
    	<table class="shoptable table table-bordered" style="width: 700px;">
    		<caption><b>하의</b></caption>
    		<tr>
    		<%
    		i=0;
    		for(ShopDto dto:list)
    		{
    			if(dto.getCategory().equals("하의"))
    			{
		   			//첫번째 사진
		   			String photo=dto.getPhoto().split(",")[0];
		    		//20~50까지 난수 발생
		    		int sale=(int)(Math.random()*31)+20;
		   		%>
		   			<td>
		   			<a shopnum="<%=dto.getShopnum()%>" 
		   			style="cursor: pointer;" class="godetail">
		   				<img alt="" src="shopsave/<%=photo%>" class="photo">
		   				<br>
		   				<%=dto.getSangpum()%><br>
		   				<b style="color: red;font-size: 1.3em;">
		   				<%=sale%>%</b>
		   				<span style="float: right;">
		   					<div style="color: gray;font-size: 13px;">
		   						<%
		   							int price=(int)(dto.getPrice()-(dto.getPrice()*(sale/100.0)));
		   						%>
		   						<strike><%=nf.format(dto.getPrice())%></strike>
		   					</div>
		   					<div style="color: black;font-size: 16px;">
		   						<%=nf.format(price)%>
		   					</div>
		   				</span>
		   				<%-- <%=sale%>%<span style="float: right;"><%=nf.format(dto.getPrice())%></span><br>
		   				<span style="float: right;"><%=nf.format(dto.getPrice()+dto.getPrice()*sale*1/100)%></span> --%>
		   			</a>
		   			</td>
		   			<%
		   			if((i+1)%4==0)
		   			{%>
		   				</tr>
		   				<tr>	
		   			<%}
		   			i=i+1;
    			}
    		}
    		%>
    		</tr>
    	</table>
    </p>
  </div>
  <div id="tabs-4">
    <p>
    	<table class="shoptable table table-bordered" style="width: 700px;">
    		<caption><b>세트</b></caption>
    		<tr>
    		<%
    		i=0;
    		for(ShopDto dto:list)
    		{
    			if(dto.getCategory().equals("세트"))
    			{
	    			//첫번째 사진
	    			String photo=dto.getPhoto().split(",")[0];
		    		//20~50까지 난수 발생
		    		int sale=(int)(Math.random()*31)+20;
	    		%>
	    			<td>
	    			<a shopnum="<%=dto.getShopnum()%>" 
	    			style="cursor: pointer;" class="godetail">
	    				<img alt="" src="shopsave/<%=photo%>" class="photo">
	    				<br>
	    				<%=dto.getSangpum()%><br>
	    				<b style="color: red;font-size: 1.3em;">
	    				<%=sale%>%</b>
	    				<span style="float: right;">
	    					<div style="color: gray;font-size: 13px;">
	    						<%
	    							int price=(int)(dto.getPrice()-(dto.getPrice()*(sale/100.0)));
	    						%>
	    						<strike><%=nf.format(dto.getPrice())%></strike>
	    					</div>
	    					<div style="color: black;font-size: 16px;">
	    						<%=nf.format(price)%>
	    					</div>
	    				</span>
	    				<%-- <%=sale%>%<span style="float: right;"><%=nf.format(dto.getPrice())%></span><br>
	    				<span style="float: right;"><%=nf.format(dto.getPrice()+dto.getPrice()*sale*1/100)%></span> --%>
	    			</a>
	    			</td>
	    			<%
	    			if((i+1)%4==0)
	    			{%>
	    				</tr>
	    				<tr>	
	    			<%}
	    			i=i+1;
    			}
    		}
    		%>
    		</tr>
    	</table>
    </p>
  </div>
  <div id="tabs-5">
    <p>
    	<table class="shoptable table table-bordered" style="width: 700px;">
    		<caption><b>아우터</b></caption>
    		<tr>
    		<%
    		i=0;
    		for(ShopDto dto:list)
    		{
    			if(dto.getCategory().equals("아우터"))
    			{
	    			//첫번째 사진
	    			String photo=dto.getPhoto().split(",")[0];
		    		//20~50까지 난수 발생
		    		int sale=(int)(Math.random()*31)+20;
	    		%>
	    			<td>
	    			<a shopnum="<%=dto.getShopnum()%>" 
	    			style="cursor: pointer;" class="godetail">
	    				<img alt="" src="shopsave/<%=photo%>" class="photo">
	    				<br>
	    				<%=dto.getSangpum()%><br>
	    				<b style="color: red;font-size: 1.3em;">
	    				<%=sale%>%</b>
	    				<span style="float: right;">
	    					<div style="color: gray;font-size: 13px;">
	    						<%
	    							int price=(int)(dto.getPrice()-(dto.getPrice()*(sale/100.0)));
	    						%>
	    						<strike><%=nf.format(dto.getPrice())%></strike>
	    					</div>
	    					<div style="color: black;font-size: 16px;">
	    						<%=nf.format(price)%>
	    					</div>
	    				</span>
	    				<%-- <%=sale%>%<span style="float: right;"><%=nf.format(dto.getPrice())%></span><br>
	    				<span style="float: right;"><%=nf.format(dto.getPrice()+dto.getPrice()*sale*1/100)%></span> --%>
	    			</a>
	    			</td>
	    			<%
	    			if((i+1)%4==0)
	    			{%>
	    				</tr>
	    				<tr>	
	    			<%}
	    			i=i+1;
    			}
    		}
    		%>
    		</tr>
    	</table>
    </p>
  </div>
  <div id="tabs-6">
    <p>
    	<table class="shoptable table table-bordered" style="width: 700px;">
    		<caption><b>악세서리</b></caption>
    		<tr>
    		<%
    		i=0;
    		for(ShopDto dto:list)
    		{
    			if(dto.getCategory().equals("악세서리"))
    			{
	    			//첫번째 사진
	    			String photo=dto.getPhoto().split(",")[0];
		    		//20~50까지 난수 발생
		    		int sale=(int)(Math.random()*31)+20;
	    		%>
	    			<td>
	    			<a shopnum="<%=dto.getShopnum()%>" 
	    			style="cursor: pointer;" class="godetail">
	    				<img alt="" src="shopsave/<%=photo%>" class="photo">
	    				<br>
	    				<%=dto.getSangpum()%><br>
	    				<b style="color: red;font-size: 1.3em;">
	    				<%=sale%>%</b>
	    				<span style="float: right;">
	    					<div style="color: gray;font-size: 13px;">
	    						<%
	    							int price=(int)(dto.getPrice()-(dto.getPrice()*(sale/100.0)));
	    						%>
	    						<strike><%=nf.format(dto.getPrice())%></strike>
	    					</div>
	    					<div style="color: black;font-size: 16px;">
	    						<%=nf.format(price)%>
	    					</div>
	    				</span>
	    				<%-- <%=sale%>%<span style="float: right;"><%=nf.format(dto.getPrice())%></span><br>
	    				<span style="float: right;"><%=nf.format(dto.getPrice()+dto.getPrice()*sale*1/100)%></span> --%>
	    			</a>
	    			</td>
	    			<%
	    			if((i+1)%4==0)
	    			{%>
	    				</tr>
	    				<tr>	
	    			<%}
	    			i=i+1;
    			}
    		}
    		%>
    		</tr>
    	</table>
    </p>
  </div>
</div>
 
</body>
</html>