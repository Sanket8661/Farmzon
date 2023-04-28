<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
        <%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%>
    <%try{
	Cookie c[]=request.getCookies();
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
    <link rel="stylesheet" href="./css/style.css">
    <style >input,select{
    width: 99%;
    border-radius: 5px;
    height: 40px;
    font-size: large;
    outline: none;
    border:1px solid gray;
    color:black; 
    }
    </style>
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
            <li><a href="./logout.jsp">Logout</a></li>
                <li><a href="./product-gallery.jsp?type=12">Marketplace</a></li>
                <li><a href="#">About Us</a></li>
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
<form class="ls2" method="post" action="actionforproduct-registration.jsp" enctype = "multipart/form-data">
    <p style="font-size:x-large; margin-bottom: 0px;">Register your Product</p>
    <input type="text" name="product_name" placeholder="ENTER PRODUCT NAME">
    <input type="text" name="product_price" placeholder="ENTER PRODUCT PRICE ">
    <input type="text" name="product_details" placeholder=" ENTER PRODUCT DETAILS ">
    <input type="file" name="file"  placeholder=" ENTER PRODUCT IMAGE ">
    <label for="product-type"  style="width:99% ;font-size:x-large; display:flex; column-gap:15px;"> Product type :
     <select id="product-type" name="product_type"style="width:58%;">
    <option value=seeds> Seeds</option>
    <option value=fertilizers> Fertilizers</option>
    <option value=pesticides> Pesticides</option>
    <option value=equipments> Equipments</option>
    <option value=machinery> Machinery</option>
    </select></label>
    <input type="submit" value="Register Your Product" class="bt1" style="height: 45px;"> 
    <a href="#" style="margin: 3% 0% 0% 0%;">Already have an product? Need Modifying</a>
    <a href="./login.jsp" class="bt1" style="background-color:#788402;color:white; border:1px solid gray; text-align: center; display:flex; align-items: center;justify-content: center;"> Redirect To Your Product</a>
</form>
<%con.close();
    }catch(Exception e){
    	out.println(e);
    }
%>
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
