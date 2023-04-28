<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@ page import = "Connector.Connector"%> 
    <%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%try{
	Connector db = new Connector();
	Connection con =Connector.conn();
	Statement st = con.createStatement();
// 	st.execute("truncate table cart");
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
         cookie.setMaxAge(0);
         cookie.setValue(null);
         response.addCookie(cookie);
//          out.print("Deleted cookie: " +
//          cookie.getName() + "<br/>");>  
     }
    
//     for (Cookie cookie : cookies){
//     	out.println("*******"+cookie.getValue());
//     }
    response.sendRedirect("./index.jsp");
    con.close();}catch(Exception e){
	out.println(e);
}
%>
</body>
</html>