<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alret('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
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
			<table class="table table-striped" style="text-align: cetner; board: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%; text-align: center;">글 제목</td>
						<td colspan="2" style="width: 20%; text-align: center;"><%=bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td style="text-align: center;">작성자</td>
						<td colspan="2" style="text-align: center;"><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td style="text-align: center;">작성일자</td>
						<td colspan="2" style="text-align: center;"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td style="text-align: center;">내용</td>
						<td colspan="2"><%=bbs.getBbsContent() %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
     <script src="https://code.jquery.com-3.1.1.min.js"></script>
     <script src="js/bootstrap.min.js"></script>
</body>
</html>