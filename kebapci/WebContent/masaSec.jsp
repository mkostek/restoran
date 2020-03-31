<html>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<%@include file="dbcon.jsp" %>
<div class="custom-select">
<jsp:include page="sitil.css"></jsp:include>
<form action="siparis.jsp" method="get">

<% 
rs = statement.executeQuery("SELECT * FROM masa");
%>
<p>Masa Secimi:<select id="masa" name="masa">

<% 
while (rs.next()) {
	%>  
	<option value=<%=rs.getString("masaNo")%>><%=rs.getString("masaAd")%></option>
<% 
}
rs.close();
%>
</select></p>
<input type="submit" value="siparis al">
</form>
</div>
</body></html>