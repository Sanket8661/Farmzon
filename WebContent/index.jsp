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
<body id="ls1">
    <div class="bg"></div>
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
<section class="category" id="ls2">
    <ul>
        <li> <a href="./product-gallery.jsp?type=Seeds">Seeds</a> 
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
<section class="s1">
    <span class="q">
       <h1>Hi 
       <%
		try{
			email=c[2].getValue();
			rs= st.executeQuery("select * from registration where email='"+email+"'");
			rs.next();
		out.println(rs.getString("fname")+",");
   }
		catch(Exception e){
		out.println("There");}
       %>
</h1>
        <p>We Provide Quality At The Lowest Price</p>
    </span>
</section>
<div class="last-second">
    <div class="last-second-left">
        <p style="margin-top:0 ;">In carrying out e-commerce, the most important thing is to keep doing what you are doing right now with passion, to keep it up.</p>
    </div>
    <div class="last-second-right">
    </div>
</div>
<div style="background-color: #eae7e0;">
    <section class="s5">
        <div class="our-product">
            <h1 style="display:inline;">Our Products <br>
                <hr class="op-hr">
            </h1>
            <p>We provide a complete supply chain for a variety of products.</p>
            <div class="products">
            <a>
                <div class="product-card" style="height:120px">
                    <div class="product-image" style="background-image: url('./images/8.jpg');"></div>
                    <p>Seeds</p>
                </div>
            </a>
            <a>
                <div class="product-card" style="height:120px">
                    <div class="product-image" style="background-image: url('./images/10.jpg');"></div>
                    <p>Fertilizers</p>
                </div>
            </a>
            <a>
                <div class="product-card"style="height:120px">
                    <div class="product-image" style="background-image: url('./images/1.jpg');"></div>
                    <p>Pesticides</p>
                </div>
            </a>
            <a>
                <div class="product-card"style="height:120px">
                    <div class="product-image" style="background-image: url('./images/9.jpg');"></div>
                    <p>Equipment</p>
                </div>
            </a>
            <a>
                <div class="product-card"style="height:120px">
                    <div class="product-image" style="background-image: url('./images/14.jpg');"></div>
                    <p>Machinery</p>
                </div>
             </a>   
            </div>
        </div>
    </section>
    <div style="margin:3% 10%;"><h1 style="font-size: x-large;">Deals of the Day<br>
    <hr class="op-hr" style="width:90px">
    </h1></div>
    <div class="s3" id ="dod">
    <%
try{
String sql = "select * from product_registration";
rs = st.executeQuery(sql);
int i=0;
while (rs.next()){
	if(i%5==0){
 %>
            <div class="product_card">
                <div style="width:93%; margin:auto;">
                    <a href="./product-page.jsp?product_name=<%=rs.getString("product_name")%>" style="width: 100%; height: 100%; display: block;text-decoration: none;color: black;">
                        <div style="background-image: url('./images/product_images/<%=rs.getString("image_name")%>'); height:130px;"class="image"></div>
                        <div class="product_details">
                            
                            <p class="name"><%=rs.getString("product_name")%></p>
                            <p class="discount">$&nbsp;<%=rs.getString("product_price")%>.00</p>
                        </div>
                    </a>
                    <a href="./actionforcart.jsp?product_name=<%=rs.getString("product_name")%>&function=new&type=index"><button>ADD TO BASKET</button></a>
                </div>
            </div>
			<%} i++;}%>

</div>
<div style="width: 100%;display: block;"onclick= "view()">
    <button  style="margin:  2% 43%;width: 150px; height: 40px; background-color: white; border-radius: 5px;border:1px solid black;font-size: larger;" >View More</button>
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
<div style="background-color: #eae7e0;">
    <section class="s4">
        <div style="width: 100%;"><h1 style="font-size: x-large;margin-top:0">Shop By Seeds<br>
    <hr class="op-hr" style="width:90px">
    </h1></div>
    <section class="catagory_gallery">
    <% 
        sql = "select * from product_registration where product_type='Seeds'";
		rs = st.executeQuery(sql);
		while(rs.next()){
%>
		<a href="./product-page.jsp?product_name=<%=rs.getString("product_name")%>">
        <div class="catagory_card">
            <div style="background-image: url('./images/product_images/<%=rs.getString("image_name")%>');height: 80px;" class="image"></div>
            <p><a href="./product-gallery.jsp"><%=rs.getString("product_name")%></a></p>
        </div>
        </a>
              <%} %>
    </section>
    <%
    con.close();}
catch(Exception e){
	out.println(e);
}
//     }catch(Exception e){
//     	out.println(e);
//     }
%>
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