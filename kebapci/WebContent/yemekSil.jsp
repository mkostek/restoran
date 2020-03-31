<%@ page import="java.sql.*" %>
<%@include file="dbcon.jsp" %>
<%   

String id=request.getParameter("id");
String masa=request.getParameter("masa");
int d = statement.executeUpdate("delete from tuketilen where tuketilenNo="+id+"");
if(d==1)out.print("<script>alert(silme basarili.)</script>");
else out.print("<script>alert(silme basarisiz!)</script>");
//yemekleri silme yanlışlık olabilir
response.sendRedirect("siparis.jsp?masa="+masa+""); 
%>