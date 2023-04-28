<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%> 
<%
try{
	Cookie c[]=request.getCookies();
ResultSet rs = null;
Connector db = new Connector();
Connection con =Connector.conn();
Statement st = con.createStatement();
String type=request.getParameter("type");
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
            <input type="text" name="search"  list="search" placeholder="      Search for product">
            <datalist id = "search" style="display:none;">
			<% rs = st.executeQuery("select * from product_registration;"); 
				while(rs.next()){%>
					<option value="<%= rs.getString("product_name")%>">
				<%}%>
									<option value="">
									<option value="">
				
            </datalist>
            </form>
        </div>
        <div class="right_header">
            <ul>
                <%
					try{
// 						   Cookie[] c =request.getCookies();
						   String email =c[2].getValue();%>
						   <%
                		if(c[1].getValue()=="true" || c[1].getValue()!=null){
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
<section class="pro-sec1">
    <aside >
    </aside>
<%
if(type==null){
	type="12";
}
// out.println(type);
if(type.equals("12")){
String sql = "select * from product_registration where extra='"+type+"'";
rs = st.executeQuery(sql);
type="products";
}else{
	String sql = "select * from product_registration where product_type='"+type+"'";
	rs = st.executeQuery(sql);
}%>
 <aside >
        <p class="product-group-title">Our <%= type %></p>
        <div class="aside-right">
        <%
while (rs.next()){

 %>
            <div class="product_card">
                <div style="width:93%; margin:auto;">
                    <a href="./product-page.jsp?product_name=<%=rs.getString("product_name")%>" style="width: 100%; height: 100%; display: block;text-decoration: none;color: black;">
                        <div style="background-image: url('./images/<%=rs.getString("image_name")%>'); height:130px;"class="image"></div>
                        <div class="product_details">
                            
                            <p class="name"><%=rs.getString("product_name")%></p>
                            <p class="discount">$&nbsp;<%=rs.getString("product_price")%>.00</p>
                        </div>
                    </a>
                    <a href="./actionforcart.jsp?product_name=<%=rs.getString("product_name")%>&function=new&type=<%= type%>"><button>ADD TO BASKET</button></a>
                </div>
            </div>
			<%}con.close();}
catch(Exception e){
	out.println(e);
}
%>
            
    </div>
    </aside>
    <aside >
    </aside>
</section>
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