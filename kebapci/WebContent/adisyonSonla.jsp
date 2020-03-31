<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@include file="dbcon.jsp" %>
<%

String id=request.getParameter("adisyon");
int d = statement.executeUpdate("update adisyon set bitti=1 where adisyonNo="+id+"");//adisyon güncellendi hesabı ödendi
if(d==1)out.print("adisyon sonlandı.");
else out.print("adisyon sonlanmadı!");

%>