<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@page import="javax.servlet.http.Part" %>
<%@page import="java.util.Collection"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "Connector.Connector"%>
<%
String product_name = null;
Part part = null;
String product_price = null;
String product_details = null;
String product_type = null;
String image_name=null;
String email=null;
String submit=null;
String image=null;
try{
image=request.getParameter("image_name");
}catch(Exception e){
	out.println(e);
}
%>
<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = "C:/Users/ASUS/eclipse-workspace/Farmzone/WebContent/images/product_images/";

   // Verify the content type
   String contentType = request.getContentType();
   
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("C:/Users/ASUS/eclipse-workspace/Farmzone/WebContent/temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
            	try{
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath + 
                  fileName.substring( fileName.lastIndexOf("\\"))) ;
               } else {
                  file = new File( filePath + 
                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
//                out.println(fileName+"-----------------");
               }
               image_name=fileName;
               fi.write( file ) ;
            	}catch(Exception e){image_name=image;}
//                out.println("Uploaded Filename: " + filePath + 
//                fileName + "<br>");
            }
            else{
            	String fieldname = fi.getFieldName();
                String fieldvalue = fi.getString();
                if (fieldname.equals("product_name")) {
                    //logic goes here...
                    product_name= fieldvalue;
                } else if (fieldname.equals("product_price")) {
                	product_price= fieldvalue;
                }else if (fieldname.equals("product_details")) {
                	 product_details= fieldvalue;
                }
                else if (fieldname.equals("product_type")) {
                	 product_type= fieldvalue;
//                 	 out.println(product_type+"++++++++++++++++++++");
                }else if (fieldname.equals("email")){
                	 email= fieldvalue;
                	
//                 	 response.sendRedirect("./admin.jsp");
// 						submit=request.getParameter("submit");
                }
                else if (fieldname.equals("submit")){
               	 submit= fieldvalue;
//                	 out.println(submit+"**************");
               }
                
            	
            }
            
         }
         out.println("</body>");
         out.println("</html>");
      } catch(Exception ex) {
         System.out.println(ex);
      }
   } else {
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>
<% 
try{
	Connector db = new Connector();
Connection con =Connector.conn();
if(submit.equals("insert")){
PreparedStatement ps =con.prepareStatement("insert into product_registration values(?,?,?,?,?,?,?)");
out.println();
ps.setString(1,email); 
ps.setString(2,product_name);  
ps.setString(3,product_price);  
ps.setString(4,product_details);  
ps.setString(5,product_type);  
ps.setString(6,image_name);
ps.setString(7,"12");
ps.executeUpdate();
response.sendRedirect("./admin.jsp");
con.close();
}
else if(submit.equals("update")){
	PreparedStatement ps =con.prepareStatement("update product_registration set email=?,product_name=? , product_price=? , product_details=? , product_type=? , image_name=? where product_name='"+product_name+"'");
	out.println();
	ps.setString(1,email); 
	ps.setString(2,product_name);  
	ps.setString(3,product_price);  
	ps.setString(4,product_details);  
	ps.setString(5,product_type);  
	ps.setString(6,image_name);
	ps.executeUpdate();
	out.println("updated");
	response.sendRedirect("./admin.jsp");
	con.close();
	}
else if(submit.equals("delete")){
	PreparedStatement ps =con.prepareStatement("delete from product_registration where product_name='"+product_name+"'");
	ps.executeUpdate();
	out.println("deleted");
	response.sendRedirect("./admin.jsp");
	con.close();
	}
}
catch(Exception e){
	out.println(e);
}

%>