<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<jsp:setProperty name="bbs" property="bbsFileName" />

<!DOCTYPE html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 사이트</title>
</head>
<body>
	<%
		String uploadPath = request.getRealPath("/uploadFile");
		String encType = "utf-8";
		int maxSize = 1024*1024*1024;
		
		ServletContext context = request.getServletContext();
		System.out.println(uploadPath);
		
		try{
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, uploadPath, maxSize, encType, new DefaultFileRenamePolicy());
			Enumeration params = multi.getParameterNames();
			
			bbs.setBbsTitle(multi.getParameter("bbsTitle"));
			bbs.setBbsContent(multi.getParameter("bbsContent"));
			
			while(params.hasMoreElements()){
				String name = (String) params.nextElement();
				String value = multi.getParameter(name);
			}
			
			Enumeration files = multi.getFileNames();
			
		    while(files.hasMoreElements()) {
		        String name = (String)files.nextElement();
		        String filename = multi.getFilesystemName(name);
		        String original = multi.getOriginalFileName(name);
		        String type = multi.getContentType(name);
		        File file = multi.getFile(name);
		        bbs.setBbsFileName(multi.getFilesystemName(name));
		    }
		} catch (Exception ex) {
			System.out.println(ex);
		}
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alret('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			if (bbs.getBbsTitle() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('제목을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else if (bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), bbs.getBbsFileName());
				System.out.println(bbs.getBbsTitle());
				System.out.println(bbs.getBbsContent());
				System.out.println(bbs.getBbsFileName());
				if (result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs.jsp'");
					script.println("</script>");
				}	
			}
		}
	%>
</body>
</html>