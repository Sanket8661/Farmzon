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
<%
try{
String function=request.getParameter("function");
Connector db = new Connector();
Connection con =Connector.conn();
Statement st = con.createStatement();
String product_name=request.getParameter("product_name");
String buy;
String type=request.getParameter("type");
try{
buy=request.getParameter("buy");
if(buy.equals("yes")){
	out.println(buy);
	response.sendRedirect("./bill.jsp");
}
}
catch (Exception e){
buy="no";
out.println(buy);
}
//  function = request.getParameter("function");
// 	Boolean checker= st.execute("select product_name from cart where product_name = '"+product_name+"'");
	if(function.equals("new")){
// 		function="inc";
		ResultSet checker;
	 	checker= st.executeQuery("select * from cart where product_name = '"+product_name+"'");
// 	 	out.println(checker.next());
	 	if(checker.next()){
	 		function="inc";
	 	}
	 	else{
	 		out.println("!checker");
	 		ResultSet rs = st.executeQuery("select * from product_registration where product_name='"+product_name+"'");
			rs.next();
			Cookie[] c =request.getCookies();
			String email;
			try{
			email=c[2].getValue();
			}
			catch(Exception e){
			email ="";
			}
			int product_price=Integer.parseInt(rs.getString("product_price"));
// 			out.println("checker");
			st.execute("insert into cart (email,product_name,price,quantity,total_price) values ('"+email+"','"+product_name+"',"+product_price+",1,"+product_price+");");
			if(type.equals("index")){
				response.sendRedirect("./index.jsp");
			}
			response.sendRedirect("./product-gallery.jsp?type="+type+"");
	 	}
	}	

if(function.equals("inc")){
	ResultSet rs1 = st.executeQuery("select * from cart where product_name='"+product_name+"'");
	rs1.next();
	int quantity=rs1.getInt("quantity");
	int total_price=rs1.getInt("total_price");
	Statement st2 = con.createStatement();
	ResultSet rs2 = st2.executeQuery("select * from product_registration where product_name='"+product_name+"'");
	rs2.next();
	
	int product_price=rs2.getInt("product_price");
	total_price= total_price+product_price;
// 	out.println(total_price);
	st.executeUpdate("update cart set quantity='"+(++quantity)+"',total_price='"+total_price+"' where product_name='"+product_name+"'");
	response.sendRedirect("./cart.jsp");
}
else if(function.equals("dec")){
	ResultSet rs1 = st.executeQuery("select * from cart where product_name='"+product_name+"'");
	rs1.next();
	int quantity=rs1.getInt("quantity");
	int total_price=rs1.getInt("total_price");
	Statement st2 = con.createStatement();
	ResultSet rs2 = st2.executeQuery("select * from product_registration where product_name='"+product_name+"'");
	rs2.next();
	
	int product_price=rs2.getInt("product_price");
	total_price= total_price-product_price;
// 	out.println(total_price);
	st.executeUpdate("update cart set quantity='"+(--quantity)+"',total_price='"+total_price+"' where product_name='"+product_name+"'");
	response.sendRedirect("./cart.jsp");
	if(quantity==0){
		st.execute("DELETE FROM cart WHERE product_name='"+product_name+"'");
	}
}
	out.println("hii");
con.close();}
catch(Exception e){
	out.println(e);
}
%>
</body>
</html>