<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>JSP 게시판 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null){
	%>
			<script>alert('로그인을 하세요');location.href='login.jsp';</script>
	<%
		}
	%>
    <nav class="navbar navbar-default">
        <div class="navbar-header">
             <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
       <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"
       				aria-expanded="false">
           <ul class="nav navbar-nav">
                   <li class="active"><a href="main.jsp">메인</a></li>
                   <li><a href="bbs.jsp">게시판</a></li>
           </ul>
           <%
           	if(userID == null){
           %>
           	<ul class="nav navbar-nav navbar-right">
	           	<li><a href="login.jsp">로그인</a></li>
	           	<li><a href="join.jsp">회원가입</a></li>
       		</ul>
           <%
           	} else {
           %>
           	<ul class="nav navbar-nav navbar-right">
	           	<li><a href="logoutAction.jsp">로그아웃</a></li>
       		</ul>
           <%
           	}
           %>
           
       </div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>Welcome</h1>
				<p>Penetration Test</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
				<img src="images/1-3.png" style="max-width: 100%; height: auto;">
			</div>
		</div>
	</div>
	
	
	<!-- 
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/1-3.png">
				</div>
				<div class="item">
					<img src="images/1-2.png">
				</div>
				<div class="item">
					<img src="images/1-3.png">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div> 
	 -->
	 
     <script src="https://code.jquery.com-3.1.1.min.js"></script>
     <script src="js/bootstrap.min.js"></script>
</body>
</html>