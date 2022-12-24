<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 다운로드 페이지</title>
</head>
<%
String fileName = request.getParameter("file_name");

String savePath = "uploadFile";
String sDownPath = request.getRealPath(savePath);

System.out.println("다운로드 폴더 절대 경로 위치 : " + sDownPath);
System.out.println("fileName1 : " + fileName);
String sFilePath = sDownPath + "/" + fileName;
System.out.println("sFilePath : " + sFilePath);

File outputFile = new File(sFilePath);
byte[] temp = new byte[1024*1024*1024];
FileInputStream in = new FileInputStream(outputFile);
String sMimeType = getServletContext().getMimeType(sFilePath);
System.out.println("유형 : " + sMimeType);

if ( sMimeType == null ){
sMimeType = "application.octec-stream"; // 일련된 8bit 스트림 형식
}

response.setContentType(sMimeType);

String sEncoding = new String(fileName.getBytes("euc-kr"),"8859_1");
String AA = "Content-Disposition";
String BB = "attachment;filename="+sEncoding;
response.setHeader(AA,BB);

ServletOutputStream out2 = response.getOutputStream();
int numRead = 0;

while((numRead = in.read(temp,0,temp.length)) != -1){
out2.write(temp,0,numRead);
}
out2.flush();
out2.close();
in.close();
%>