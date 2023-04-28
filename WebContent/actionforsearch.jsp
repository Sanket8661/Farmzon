<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String product_name= request.getParameter("search");
// out.println(product_name);
response.sendRedirect("./product-page.jsp?product_name="+product_name+"");
%>
</body>
</html>