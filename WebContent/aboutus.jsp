<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%>
    <%
//     try{
    Cookie[] c =request.getCookies();
    String logged="false";
    String email;
	 ResultSet rs;
	Connector db = new Connector();
	Connection con =Connector.conn();
	Statement st = con.createStatement();
	%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon">
    <title>Farmzon</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
        <header>
        <div class="left_header">
            <a href="./index.jsp"><div class="img1"></div></a>
            <form >
            <input type="text" name="search" id="" list="search" placeholder="      Search for product">
            <datalist id ="search"><% 
            ResultSet rs2 = st.executeQuery("select * from product_registration");
           	while(rs2.next()){%>	
			<option value="<%=rs2.getString("product_name")%>">
           	<%}%>
            </datalist>
            </form>
        </div>
        <div class="right_header">
            <ul>
                <%
					try{
						logged=c[1].getValue();
// 						out.println(logged);
                		if(logged.equals("true")){
                %>
                <li><a href="./logout.jsp">
                Logout</a></li>
                <%
                }
                else if(logged.equals("false")||logged.equals(null)){
                	out.println(" <li><a href='./logout.jsp'>Login</a></li>");
                	}
                }
					catch(Exception e){%>
					
						<li><a href="./login.jsp">Login</a></li>
					<%} %>
                
               
                <li><a href='./product-gallery.jsp?type=12'>Marketplace</a></li>
                <li><a href="./product-registration.jsp">Be a Merchant</a></li>
                	<%try{
			email=c[2].getValue();
			rs= st.executeQuery("select * from registration where email='"+email+"'");
			rs.next();
		 String fname=rs.getString("fname");
		 if(fname.equals("admin")){%>
			 <li><a href="./admin.jsp">Admin</a></li> 
		 <%}
   }
		catch(Exception e){}%>
               <li><a href="./cart.jsp">
                   <div class="basket">
                       <div style="display: flex;">
                        <img src="./images/cart.svg" alt="">
                        <h5>Basket</h5>
                        <div class="cart_counter">
                        <%try{
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
        <div class="last-second ls">
        <!-- <a href="mailto:webmaster@example.com">Jon Doe</a> -->
        <div class="last-second-left">
            <p style="margin-top:25px ;"><b> We are the students of the New College kolhapur.This is our final year project.</b></p>
        </div>
        <div class="last-second-right lsr">
        </div>
    </div>
    <div class="sec1">
        <img src="./images/59d54d9065597f0001129e43_TheTeachersGuild_Logo_Primary_MoreBackground-01.png" id="icon"
            alt="">
        <h1>Farmzon is the revolution, farmers has been waiting for.</h1>
        <p>Making our website to solve problem of farmers</p>
    </div>
    <div class="sec2">
        <img src="" alt="" width="100%">
        <div class="img_overlay">
            <h1>Welcome to Farmzon</h1>
            <p>We are students that tried to solve the problem of
                farmers and small farming buisness. In our project we introduce the ecommerce website for farmers, where we sell the essentials farming products. It helps farmers by saving time, money and efforts.</p>
            <a href="./index.jsp" style="text-decoration: none;"><button>TO OUR WEBSITE</button></a>
        </div>
    </div>
    <div class="last-second">
        <div class="last-second-left">
            <p style="margin-top:0 ;">In carrying out e-commerce, the most important thing is to keep doing what you are doing right now with passion, to keep it up.</p>
        </div>
        <div class="last-second-right">
        </div>
    </div>
  <footer style="margin-top: 0;">
    <p>Have a complaint? report it by <a href="mailto:pratikra2001@gmail.com" style=" color: white;">mail</a> or call us at +911234567890. Want to know <a href="./aboutus.jsp" style="color: white;">about us ?</a></p>
    <div class="f13">
        <a href="" class="facebook"></a>
        <a href="" class="twitter"></a>
        <a href="" class="inst"></a>
    </div>
    
</footer>
</body>
</html>