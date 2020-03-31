<%@ page import="java.sql.*" %>
<%@include file="dbcon.jsp" %>
<%   
//adisyon başlatma işlemleri
String masa=request.getParameter("masa");
String yemek=request.getParameter("yemek");
String adisyon=request.getParameter("adisyon");
String miktar=request.getParameter("miktar");
int d = statement.executeUpdate("insert into tuketilen(adisyonNo,yemekNo,miktar,aciklama) values("+adisyon+","+yemek+","+miktar+",'aciklama')");
if(d==1)out.print("ekleme basarili");
else out.print("basarisiz!");
%>
