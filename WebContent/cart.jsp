<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
       <%@ page import = "Connector.Connector"%> 
    <%@ page import = "java.sql.*"%>
  <% 
  try{
	int quantity=0;
	 ResultSet rs;
	Connector db = new Connector();
	Connection con =Connector.conn();
	Statement st = con.createStatement();
	Cookie[] c =request.getCookies();
	String logged="false";
    String email;

// 	String product_name=request.getParameter("product_name");
// 	ResultSet rs = st.executeQuery("select * from product_registration");
// 	rs.next();
// 	int product_price=Integer.parseInt(rs.getString("product_price"));
// 	out.println(rs.getString("product_name"));
%>
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
            <%
	%>
               <%
					try{
						logged=c[1].getValue();
                		if(logged.equals("true") || c[1].getValue()!=null){
                %>
                <li><a href="./logout.jsp">
                Logout</a></li>
                <%
                }
                }
					catch(Exception e){%>
					
						<li><a href="./login.jsp">Login</a></li>
					<%} %>
                <li><a href="./product-gallery.jsp?type=12">Marketplace</a></li>
                <li><a href="#">About Us</a></li>
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
<section class="ps1">
    <p>Hi Guest, Here is your Cart</p>
    <div>
        <section class="ps1-left">
        <%
        ResultSet rs1;
        try{
        rs1 = st.executeQuery("select * from cart where email='"+c[2].getValue()+"';");
        }
        catch(Exception e){
        rs1 = st.executeQuery("select * from cart where email=''");}
        %>
        <% 
        try{
        while(rs1.next()){ 
        	try{
        		Statement st1 = con.createStatement();
		quantity=rs1.getInt("quantity");
        String product_name=rs1.getString("product_name");
       rs = st1.executeQuery("select * from product_registration where product_name='"+product_name+"'");
        rs.next();
		%>
            <div class="payment-product">
                <img src="./images/<%=rs.getString("image_name")%>" alt="product Picture">
                <div class="product-disc">
                    <p><%=rs.getString("product_name")%></p>
                </div>
                <div class="product-price">
                    <p>rs <%=rs1.getInt("total_price")%>.00</p>
                    <div class="quantity-counter">
                        <a href="./actionforcart.jsp?product_name=<%=rs.getString("product_name")%>&function=dec"><button id="counter-changer">-</button></a>
                        <div class="display-quantity">
                            <p><%=quantity%></p>
                        </div>
                       <a href="./actionforcart.jsp?product_name=<%=rs.getString("product_name")%>&function=inc"><button id="counter-changer">+</button></a>
                    </div>
                </div>
            </div>
        <%}catch(Exception e){
        	out.println(e);
        }} 
        }catch(Exception e){out.println(e);}  
        %>
        </section>
        <section class="ps1-right">
            <div class="payment-calculator">
<%  rs = st.executeQuery("select * from cart");
int overall_price=0;
while(rs.next()){
	overall_price= overall_price+rs.getInt("total_price");
}
        %>
                <div class="pc1">
                    <div class="labels">
                        <p>Price</p>
                    </div>
                    <div class="values">
                        <p>rs <%=overall_price%></p>
                    </div>
                </div>
                <div class="pc1">
                    <div class="labels">
                        <p>Taxes</p>
                    </div>
                    <div class="values">
                        <p>rs 0.0</p>
                    </div>
                </div>
                <div class="pc1">
                    <div class="labels">
                        <p>Shipping</p>
                    </div>
                    <div class="values">
                        <p>rs 40.00</p>
                    </div>
                </div>
                <hr>
                <div class="pc1">
                    <div class="labels">
                        <p>Total Amount</p>
                    </div>
                    <div class="values">
                        <p>rs <%=overall_price+40%></p>
                    </div>
                </div>
                <a href="./bill.jsp"><button type="submit" value="Place Your Order" class="bt1 place-order-btn" style="height: 45px;background-color: #788402;">Place Your Order</button></a>
                 <a href=./product-gallery.jsp?type=12><button type="submit" value="Place Your Order" class="bt1 place-order-btn" style="height: 45px;background-color: #788402;">Continue Shopping</button></a>  
                <!-- <div style="display: flex;">
                    <hr width="50%"> &nbsp;or&nbsp;
                    <hr width="50%">
                </div>
                <input type="submit" value="Place Your Order" class="bt1 pick-up-store-btn" style="height: 45px;background-color: green;"> -->
            </div>

        </section>
    </div>
</section>
	<%
	con.close(); }
  catch(Exception e){
	  out.println(e);
  }
	%>
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