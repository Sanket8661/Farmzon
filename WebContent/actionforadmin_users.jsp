<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@page import="javax.servlet.http.Part" %>
<%@page import="java.util.Collection"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%>
<%
String fname = null;
String lname = null;
String email = null;
String address = null;
String password=null;
String submit=null;
String email2=null;
%>
<%
  fname=request.getParameter("fname");
lname=request.getParameter("lname");
email=request.getParameter("email");
email2=request.getParameter("email2");
address=request.getParameter("address");
password=request.getParameter("password");
submit=request.getParameter("submit");
%>
<% 
try{
	Connector db = new Connector();
Connection con =Connector.conn();
if(submit.equals("insert")){
PreparedStatement ps =con.prepareStatement("insert into registration values(?,?,?,?,?)");
out.println();
ps.setString(1,fname); 
ps.setString(2,lname);  
ps.setString(3,email);  
ps.setString(4,address);  
ps.setString(5,password);  
ps.executeUpdate();
response.sendRedirect("./admin.jsp#form");
con.close();
}
else if(submit.equals("update")){
	PreparedStatement ps =con.prepareStatement("update registration set fname=?,lname=?,email=?, address=? , password=?  where email='"+email+"'");
	out.println();
	ps.setString(1,fname); 
	ps.setString(2,lname);  
	ps.setString(3,email2);
	ps.setString(4,address);  
	ps.setString(5,password); 
	ps.executeUpdate();
	out.println("updated");
	con.close();
	response.sendRedirect("./admin.jsp#form");
	}
else if(submit.equals("delete")){
	PreparedStatement ps =con.prepareStatement("delete from registration where email='"+email+"'");
	ps.executeUpdate();
	ps =con.prepareStatement("delete from product_registration where email='"+email+"'");
	ps.executeUpdate();
	out.println("deleted");
	response.sendRedirect("./admin.jsp#form");	
	con.close();
	}
}
catch(Exception e){
	out.println(e);
}

%>