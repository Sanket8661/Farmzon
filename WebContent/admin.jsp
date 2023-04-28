<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
        <%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%>
    <%
//     try{
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
<div style="margin-top:5%;display: grid;grid-template-columns: 35% 108%;">
	<%
	String product_name;
	try{
	 product_name=request.getParameter("product_name");
	}catch(Exception e){
		product_name="";
	}
	%>
	<%
	String sql = "select * from product_registration where product_name='"+product_name+"'";
	rs = st.executeQuery(sql);
	rs.next();
	String email=null;
	product_name=null;
	String product_price=null;
	String product_details=null;
	String  image_name=null;
	try{
		email=rs.getString("email");
		product_name=rs.getString("product_name");
		 product_price=rs.getString("product_price");
		 product_details=rs.getString("product_details");
		 image_name=rs.getString("image_name");
	}
	catch(Exception e){
		 email="";
		product_name="";
		 product_price="";
		 product_details="";
	  image_name="";
	}
	%>
	<form class="ls2" method="post" action="actionforadmin.jsp?image_name=<%=image_name %>" enctype = "multipart/form-data" style="margin:10px 0;margin-left: 30px;">
		<p style="font-size:x-large; margin-bottom: 0px;">your product</p>		   
	<input type="email" value="<%=email%>" name="email" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder=" Email ">
    <input type="text" value="<%=product_name%>" name="product_name" placeholder="ENTER PRODUCT NAME">
    <input type="text" value="<%=product_price%>" name="product_price" placeholder="ENTER PRODUCT PRICE ">
    <input type="text" value="<%=product_details%>" name="product_details" placeholder=" ENTER PRODUCT DETAILS ">
<!--     <p style="color:red;margin:0">please choose the images</p> -->
<% if(image_name.equals("") || image_name.equals(null)){%>
	<img id="selected" alt=""height="100px"  width="100px" border="2px solid" >
<%}else{%>
<img id="selected" alt="" src="./images/product_images/<%=image_name%>" height="100px" width="100px" border="2px solid" >
<%}%>
    <input id="file" type="file" name="file"  placeholder=" ENTER PRODUCT IMAGE " onchange="PreviewImage();">
	<script>
    function PreviewImage() {
        var oFReader = new FileReader();
        oFReader.readAsDataURL(document.getElementById("file").files[0]);

        oFReader.onload = function (oFREvent) {
            document.getElementById("selected").src = oFREvent.target.result;
        };
    };
</script>
    <label for="product-type"  style="width:99% ;font-size:x-large; display:flex; column-gap:15px;"> Product type :
		<select id="product-type" name="product_type"style="width:58%;">
    <option value=crops> Crops</option>
    <option value=fertilizers> Fertilizers</option>
    <option value=pesticides> Pesticides</option>
    <option value=equipments> Equipments</option>
    <option value=machinery> Machinery</option>
    </select></label>
    <div style="border: none;display: flex;column-gap: 24px;">
    <input type="submit" value="insert" name="submit" class="bt1" style="height: 45px;">
    <input type="submit" value="update" name="submit"  class="bt1" style="height: 45px;">
    <input type="submit" value="delete" name="submit"  class="bt1" style="height: 45px;">
</div>
</form>
<%
sql = "select * from product_registration";
rs = st.executeQuery(sql);
%>
<aside style="width: 60%;" >
	<p class="product-group-title" style="width: auto; margin-top: 0%;margin-bottom: 10px;">Select Product</p>
	<div class="aside-right">
		<% while(rs.next()){%>
		<div class="product_card" style="height: 200px;">
			<div style="width:93%; margin:auto;">
				<a href="./admin.jsp?product_name=<%=rs.getString("product_name")%>" style="width: 100%; height: 100%; display: block;text-decoration: none;color: black;">
					<div style="background-image: url('./images/product_images/<%=rs.getString("image_name")%>'); height:130px;"class="image"></div>
					<div class="product_details">						
						<h3 class="name" style="text-align: center;"><%=rs.getString("product_name")%></h3>
					</div>
				</a>
			</div>
		</div>
		<%} %>
	</div>
</aside>
<%
	String user;
	try{
	 user=request.getParameter("user");
	 if(user.equals(null)){
		 user="";
		 }
	}catch(Exception e){
		user="";
	}
	%>
	<%
	sql = "select * from registration where email='"+user+"'";
	rs = st.executeQuery(sql);
	rs.next();
	String fname=null;
	String lname=null;
	email=null;
	String address=null;
	String  password=null;
	try{
		fname=rs.getString("fname");
		lname=rs.getString("lname");
		 email=rs.getString("email");
		 address=rs.getString("address");
		 password=rs.getString("password");
	}
	catch(Exception e){
		 fname="";
		lname="";
		 email="";
		 address="";
	  password="";
	}
	%>
<form class="ls2" style="margin-left: 30px;" action="actionforadmin_users.jsp" id="form">
    <p style="font-size:x-large; margin-bottom: 0px;">Create Account</p>
    <input type="text" name="fname" value="<%=fname %>" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder="First Name ">
    <input type="text" name="lname" value="<%=lname %>" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder="Last Name ">
    <% 
    if(user.equals("") || user.equals(null)){
    %>
	<input type="email" name="email" value="<%=email %>"  style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder=" Email ">
<%
}else{
%>
<input type="email" name="email" value="<%=email %>" readonly style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder=" Email ">
<input type="email" name="email2"  style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder=" Changed Email ">
<%
}
%>
    <input type="text" name="address" value="<%=address %>" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder=" Address ">
    <input type="text" name="password" value="<%=password %>" style="width: 99%;border-radius: 5px;height: 40px;font-size: large;outline: none;border:1px solid gray; " placeholder=" Create Password">
	<div style="border: none;display: flex;column-gap: 24px;">
	<input type="submit" name="submit" value="insert" class="bt1" style="height: 45px;">
    <input type="submit" name="submit" value="update" class="bt1" style="height: 45px;">
    <input type="submit" name="submit" value="delete" class="bt1" style="height: 45px;">
</div>
</form>
<%
sql = "select * from registration";
rs = st.executeQuery(sql);
%>
<aside style="width: 60%;" >
	<p class="product-group-title" style="width: auto; margin-top: 0%;margin-bottom: 10px;">Select users</p>
	<table>
		<tr>
			<th width="10px"><a href="./admin.jsp?user#form" style="width: 100%; height: 100%;">Empty form</a></th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>email</th>
			<th>Address</th>
			<th>password</th>	
		</tr>
		<%while(rs.next()){%>
		<tr>
			<td width="10px"><a href="./admin.jsp?user=<%=rs.getString("email")%>#form" style="width: 100%; height: 100%;">Select</a></td>
			<td><%=rs.getString("fname")%></td>
			<td><%=rs.getString("lname")%></td>
			<td><%=rs.getString("email")%></td>
			<td><%=rs.getString("address")%></td>
			<td><%=rs.getString("password")%></td>	
		</tr>
		<%} %>
	</table>
	<style>
		table a{
			text-decoration: none;
			color: brown;
		}
		table,tr,th,td{
			border: 2px solid black	;
		}
		table{
			width: 100%;
		}
	</style>
</aside>
</div>
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
// }catch(Exception e){
// 	out.println(e);
// } 
%>