<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat"%>  
<%@ page import="java.util.Date"%>
<%@ page import = "Connector.Connector"%> 
<%@ page import = "java.sql.*"%>
  <%  
  try{
	  Cookie[] c =request.getCookies();
	    String logged="false";
	    String email;
	    try{
	    c[2].getValue();
	    email=c[2].getValue();
	    }
	    catch (Exception e){%>
	    	<h1>you are not logged in </h1>
	    <% email=null; 
	    response.sendRedirect("./login.jsp?login_status=not_logged");}
// 	    email=c[2].getValue();
	ResultSet rs = null;
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
<body id="ls1">
    <!-- <div class="bg"></div> -->
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
                <%
					try{
						logged=c[0].getValue();
                		if(logged.equals("true") || c[0].getValue()!=null){
                %>
                <li><a href="./logout.jsp">
                Logout</a></li>
                <%
                }
                }
					catch(Exception e){%>
					
						<li><a href="./login.jsp">Login</a></li>
					<%} %>
                
               
                <li><a href='./product-gallery.jsp?type=12'>Marketplace</a></li>
                <li><a href="./product-registration.jsp">Be a Merchant</a></li>
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
<%
try{
if(logged.equals("true") || c[0].getValue()!=null){%>
<section class="bill_page">
    <div class="bill_main">
    <h1 class="invoice">INVOICE</h1>
    <% rs = st.executeQuery("select * from registration where email='"+email+"'");
   	while(rs.next()){ %>
    <p class="doi">Date Of Issue : <%
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
    Date date = new Date();  
    out.println(formatter.format(date));   %></p>
    <p>billed to:</p>
    <p><%=rs.getString("fname")%>,</p>
    <p class="billed_to">
    <%=rs.getString("address")%>
<!--         Lorem, ipsum dolor sit amet consectetur adipisicing elit. Repudiandae aspernatur architecto vel.</p> -->
</div>
<%} %>
    <div class="bill_components" style="padding-top:18px ;">
        <div class="bill_heading">
        <p>PRODUCT</p>
        <p style="text-align: right;">COST</p>
        <p style="text-align: right;">QTY</p>
        <p style="text-align: right;">AMOUNT</p>
    </div>
    <hr style="height: 4px; background-color: black;margin: 0;">
    </div>
    <% rs = st.executeQuery("select * from cart where email = '"+email+"'");
    int final_amount=0;
   	while(rs.next()){%>
    <div class="bill_components">
        <div class="bill_heading">
        <p><%=rs.getString("product_name")%></p>
        <p style="text-align: right;"><%=rs.getString("price")%></p>
        <p  style="text-align: right;"><%=rs.getString("quantity")%></p>
        <p style="text-align: right;"><%=rs.getInt("total_price")%></p>
    </div>
    <hr style="margin:0;">
    </div>
    <% final_amount = final_amount + rs.getInt("total_price");} %>
    <div class="bill_components">
        <div class="bill_heading">
        <p></p>
        <p style="text-align: right;"></p>
        <p  style="text-align: right;">Tax</p>
        <p style="text-align: right;">0</p>
    </div>
    </div>
    <div class="bill_components">
        <div class="bill_heading">
        <p></p>
        <p style="text-align: right;"></p>
        <p  style="text-align: right;">Shipping</p>
        <p style="text-align: right;">40</p>
    </div>
    </div>
    <div class="total">
        <p class="total_heading">Invoice total</p>
        <p class="total_amount">rs <%=final_amount+40%></p>
    </div>
</section>
<%}
}catch(Exception e){
	out.println	("jiii");
}   
con.close();}
   	catch(Exception e){
   	out.println(e);	
   	}
   	

%>

    <br>
    <br>
    <br>
    <footer style="font-size: medium;position: absolute;left: 0;width: 100%;margin-top: 30px;">
        <p>Have a complaint? report it by <a href="mailto:pratikra2001@gmail.com" style=" color: white;">mail</a> or call us at +911234567890. Want to know <a href="./aboutus.jsp" style="color: white;">about us ?</a></p>
        <div class="f13">
            <a href="" class="facebook"></a>
            <a href="" class="twitter"></a>
            <a href="" class="inst"></a>
        </div>
        
    </footer>
</body>
</html>