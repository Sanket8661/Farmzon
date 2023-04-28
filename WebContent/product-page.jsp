<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "Connector.Connector"%> 
    <%@ page import = "java.sql.*"%>
  <%  try{
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
    Cookie[] c =request.getCookies();
	%>
	 <%
					try{
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
                <li><a href="./product-gallery.jsp">Marketplace</a></li>
                <li><a href="#">About Us</a></li>
               <li><a href="./cart.jsp">
                   <div class="basket">
                       <div style="display: flex;">
                        <img src="./images/cart.svg" alt="">
                        <h5>Basket</h5>
                        <div class="cart_counter">
                        <%
                        Statement st1 = con.createStatement();
                        try{
                            rs= st1.executeQuery("select * from cart where email='"+c[2].getValue()+"'");
                            }
                            catch(Exception e){
                            	rs= st1.executeQuery("select * from cart where email=''");
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
    <section class="pg1" style="margin-top: 10%;">
        <div class="product-data" style="border:2px solid;">
        <%
    	String product_name=request.getParameter("product_name");
    	rs = st.executeQuery("select * from product_registration where product_name='"+product_name+"'");
    	rs.next(); %>
            <div class="product-image-big" style="background-image:url('./images/<%=rs.getString("image_name")%>');"></div>
            <div class="product-info">
                <p class="product-id"><%=rs.getString("product_name")%>
                </p>
                <p class="product-id">rs <%=rs.getString("product_price")%>.00</p>
                </p>
                <div style="display: flex; flex-direction: row; column-gap: 30px;">

                                        <a href="./actionforcart.jsp?product_name=<%=rs.getString("product_name")%>&function=new&buy=yes"><button class="add-to-bag">BUY</button></a>
                    <a href="./actionforcart.jsp?product_name=<%=rs.getString("product_name")%>&function=new"><button class="add-to-bag">ADD TO BASKET</button></a>
                </div>
                <hr style="margin: 5% auto;">
                <p class="quantity"><%=rs.getString("product_details")%>

                </p>
            </div>
        </div>
    </section>
</section>
<div style="margin:3% 12%;"><p style="font-size: larger;">Deals of the Day</p></div>
<div class="s3" id ="dod">
<%
String sql = "select * from product_registration";
rs = st.executeQuery(sql);
int i=0;
while (rs.next()){
	if(i%5==0){
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
                    <button>ADD TO BASKET</button>
                </div>
            </div>
			<%} i++;}%>


</div>
<div style="width: 100%;display: block;"onclick= "view()">
<button  style="margin:  2% 43%;width: 150px; height: 40px; background-color: white; border-radius: 5px;border:1px solid black;" >View More</button>
 <% con.close();}
  catch(Exception e){
	  out.println(e);
  }
%>
</div>
</div>
</section>
<script>
    let view_more= document.getElementById("dod");
    function view(){
        if(dod.style.overflow=='hidden'){
            dod.style.overflow="visible";
            dod.style.height="auto";    
        }
        else{
            dod.style.overflow="hidden";
            dod.style.height="570px";    

        }
    }
</script>
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