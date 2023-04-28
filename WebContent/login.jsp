<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%>
<%try{
Cookie[] c =request.getCookies();
ResultSet rs;
Connector db = new Connector();
Connection con =Connector.conn();
Statement st = con.createStatement(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
    <title>Farmzon</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>

    <header>
        <div class="left_header">
            <a href="./index.jsp"><div class="img1"></div></a>
           <form action="./actionforsearch.jsp">
            <input type="text" name="search" id="" list="search" placeholder="      Search for product">
            <datalist id ="search"><% 
            ResultSet rs2 = st.executeQuery("select * from product_registration");
           	while(rs2.next()){%>	
			<option value="<%=rs2.getString("product_name")%>">
           	<%}
            %>
            </datalist>
            </form>
        </div>
        <div class="right_header">
            <ul>
                <li><a href="./product-gallery.jsp?type=12">Marketplace</a></li>
                <li><a href="#">About Us</a></li>
               <li><a href="./cart.jsp">
                   <div class="basket">
                       <div style="display: flex;">
                        <img src="./images/cart.svg" alt="">
                        <h5>Basket</h5>
                        <div class="cart_counter">
                        <%
                   	 
                        try{
                            rs= st.executeQuery("select * from cart where email='"+c[2].getValue()+"'");
                            }
                            catch(Exception e){
                            	rs= st.executeQuery("select * from cart where email=''");
                            }
int overall_quantity=0;
while(rs.next()){
	overall_quantity= overall_quantity+rs.getInt("quantity");
}
out.println(overall_quantity);
        %>
                            
                        </div>
                    </div>
                </div>
            </a>
            </li>         
            </ul>
        </div>
</header>
<section class="category" id="ls2">
    <ul>
        <li> <a href="./product-gallery.jsp?type=crops">Crops</a> 
        </li>
        <li>
           <a href="./product-gallery.jsp?type=fertilizers">Fertilizers</a> 
        </li>
        <li>
            <a href="./product-gallery.jsp?type=pesticides">Pesticides</a> 
        </li>
        <li>
            <a href="./product-gallery.jsp?type=equipments">Equipments</a>    
        </li>
        <li>
            <a href="./product-gallery.jsp?type=machinery">Machinery</a>
        </li>
       
    </ul>
</section>

<form class="ls2" action = "actionforlogin.jsp">
<%
    String message;
    try{
    message=request.getParameter("message");
    if(message.equals("Invalid")){
    	
//     	out.println(message);
    out.println("<p style='color:red; margin:0'>" +message +" Username or Password Please Enter valid credentials<p>");
    }
    else{ 
    }
    }catch(Exception e){
    	
    }
    %>
    <p style="font-size:x-large;">Login to your Account</p>
     <input type="email" name="email" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder="Email" value=<% %>>
    <input type="password" name="pass" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder="Password">
    <input type="submit" value="Login" class="bt1" style="height: 45px;"> 
    <a href="./product-gallery.jsp" style="margin: 8% 0%;">Forgot your password</a>
        <!-- <button class="bt1"style="background-color:transparent;color:black; border:1px solid gray; color:gray"> -->
            <a href="./register.jsp" class="bt1" style="background-color:#788402;color:white; border:1px solid gray; text-align: center; display:flex; align-items: center;justify-content: center;"> Create your new Farmkart account</a>
        <!-- </button> -->

</form>
<br>
<br>
<br>
<footer>
    <p>Have a complaint? report it by <a href="mailto:pratikra2001@gmail.com" style=" color: white;">mail</a> or call us at +911234567890. Want to know <a href="./aboutus.jsp" style="color: white;">about us ?</a></p>
    <div class="f13">
        <a href="" class="facebook"></a>
        <a href="" class="twitter"></a>
        <a href="" class="inst"></a>
    </div>
    
</footer>
</body>
</html>
<% 
con.close();}catch(Exception e){
	out.println(e);
}
%>