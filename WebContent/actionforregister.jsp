<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="Connector.Connector" %>
    <%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 

String fname= request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String address = request.getParameter("address");
String pass = request.getParameter("pass");
out.println(fname + lname + email + address + pass);
try{
	Connector db = new Connector();
Connection con =Connector.conn();
PreparedStatement ps =con.prepareStatement("insert into registration values(?,?,?,?,?)");
ps.setString(1,fname);  
ps.setString(2,lname);  
ps.setString(3,email);  
ps.setString(4,address);  
ps.setString(5,pass);
ps.executeUpdate();
con.close();
response.sendRedirect("login.jsp");}
catch(Exception e){
	out.println(e);
}

%>
</body>
</html>