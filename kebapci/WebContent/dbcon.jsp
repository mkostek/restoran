<%@ page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String connectionURL = "jdbc:mysql://localhost:3306/test?user=root;password=''";
Connection connection = null;
Statement statement = null;
ResultSet rs = null;

Class.forName("org.gjt.mm.mysql.Driver").newInstance();
connection = DriverManager.getConnection(connectionURL, "", "");
statement = connection.createStatement();
//bağlantı prosedürleri
%>