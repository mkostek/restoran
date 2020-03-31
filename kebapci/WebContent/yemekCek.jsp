    <%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>  
<%@include file="dbcon.jsp" %>
<%

 String val=request.getParameter("q"); 
rs = statement.executeQuery("SELECT * FROM yemek where tuketimNo="+val+"");
%>

<% 
while (rs.next()) {//seçilen kategoriye göre yenilen veya içilenler çekilecek
	%>  
	<option value=<%=rs.getString("yemekNo")%>><%=rs.getString("yemekAd")%></option>
<% 
}
rs.close();
%>
</select>