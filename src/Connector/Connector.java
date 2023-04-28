package Connector;
import java.sql.*;
public class Connector {
	public static Connection conn() throws Exception{
		Connection con=null;
String url="jdbc:mysql://localhost:3306/farmzon";
try {
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection(url,"root","");
}
catch(Exception e) {
	
}
return con;
	}
}


//package Connector;
//import java.sql.*;
//public class Connector {
//	public static Connection conn() throws Exception{
//		Connection con=null;
//String url="jdbc:mysql://localhost:3306/";
//try {
//Class.forName("com.mysql.jdbc.Driver");
//con = DriverManager.getConnection(url,"root","");
//Statement st =con.createStatement();
//st.execute("CREATE DATABASE farmzon");
//url="jdbc:mysql://localhost:3306/farmzon";
//con = DriverManager.getConnection(url,"root","");
//st =con.createStatement();
//st.execute("CREATE TABLE cart (email varchar(50),product_name varchar(40),price int,quantity int,total_price int);");
//st.execute("CREATE TABLE product_registration(email varchar(40),product_name varchar(30),product_price int,product_details varchar(500),product_type varchar(20),image_name varchar(100),extra int);");
//st.execute("CREATE TABLE registration(fname varchar(20),lname varchar(20),email varchar(40),address varchar(350),password varchar(50));");
//}
//catch(Exception e) {
//	
//}
//return con;
//	}
//}