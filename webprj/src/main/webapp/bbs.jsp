<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
    <nav class="navbar navbar-default">
        <div class="navbar-header">
             <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
        </div>
       <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"
       				aria-expanded="false">
           <ul class="nav navbar-nav">
                   <li><a href="main.jsp">메인</a></li>
                   <li class="active"><a href="bbs.jsp">게시판</a></li>
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
		<div class="row">
			<form method="get" name="search" action="searchBbs.jsp">
				<table class="pull-right">
					<tr>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>

				</table>
			</form>
			<table class="table table-striped" style="text-align: cetner; board: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td style="text-align: center;"><%= list.get(i).getBbsID() %></td>
						<td style="text-align: center;"><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td style="text-align: center;"><%= list.get(i).getUserID() %></td>
						<td style="text-align: center;"><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
						<td style="text-align: center;"><%= list.get(i).getBbsHitCount() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%					
				}
				if (bbsDAO.nextPage(pageNumber + 1)){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
     <script src="https://code.jquery.com-3.1.1.min.js"></script>
     <script src="js/bootstrap.min.js"></script>
</body>
</html>