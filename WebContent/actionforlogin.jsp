<%@page import="java.util.concurrent.CopyOnWriteArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.sql.*"%>
    <%@ page import = "Connector.Connector"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

try{
	ResultSet rs = null;
	String email=request.getParameter("email");
	String pass= request.getParameter("pass");
	Connector db = new Connector();
Connection con =Connector.conn();
Statement st = con.createStatement();
String sql = "select * from registration where email='"+ email +"'and password='"+ pass +"'";
rs = st.executeQuery(sql);
	 if(rs.next()==true){
		 Cookie c2 = new Cookie("islogged","true");
		 Cookie c3 = new Cookie("email",email);
		response.addCookie(c2);
		response.addCookie(c3);
		st.execute("delete from cart where email=''");
			response.sendRedirect("index.jsp");
	
	 }
	 else{
		 Cookie c2 = new Cookie("islogged","false");
		 RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=Invalid");
		 rd.include(request, response);
	 }
	 con.close();}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>