<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="dbcon.jsp" %>    
<jsp:include page="sitil.css"></jsp:include>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
function silmeyemek(id,masa) {//yemek silmek istendiğinde post edilmeden önce son bir kez daha düşün
	 var r = confirm("silmek istediginize eminmisiniz");//eminmisin
		if (r == true) {//evetse günah benden gitti:)
		window.location = "yemekSil.jsp?id="+id+"&masa="+masa+"";//gönder
		} else {
		alert("Dikkatli ol!");//hadi bu seferlik affettim
		}
}
	
function yemegi()//yememi içmemi
{
	var str=document.getElementById("tuketimTip").value;//tuketim tipini selectten aldım
	if(str=="")
{
document.getElementById("yemek").innerHTML="";//flush edilecek alanı sıfırladım
return;
}else
{
if(window.XMLHttpRequest)//istek varsa
{
xmlhttp=new XMLHttpRequest();//yeni bir http istek olusturdum
}
else{//değilse
xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");//yenibir obje başlattım
}
xmlhttp.onreadystatechange=function()//durum değiştiğinde
{
if(xmlhttp.readyState==4&&xmlhttp.status==200)//ve başarılıysa
{
document.getElementById("yemek").innerHTML=xmlhttp.responseText;//dönen cevabı içeriğe koydum
}
};
xmlhttp.open("GET","yemekCek.jsp?q="+str,true);//cevap alınacak olan sayfaya parametre aktardım
xmlhttp.send();//ve yolladım
}
}
$( function() {//bu jquery fonsiyonlarını barındırır
$.yemekle=function(){//yemek eklemek için jquery ajazx özelliğini kullandım
var adisyon=$("input[name=adisyon]").val();
adisyon=$.trim(adisyon);
var masa=$("input[name=masa]").val();
masa=$.trim(masa);
var miktar=$("input[name=miktar]").val();
miktar=$.trim(miktar);

var yemek=document.getElementById("yemek").value;
yemek=$.trim(yemek);
//her bir değeri aldım
if(!adisyon||!masa||!miktar||!yemek)
{
alert("bos alanlar mevcut");
}//boş alan kalmayacak
else{
var degerler="masa="+masa+"&yemek="+yemek+"&adisyon="+adisyon+"&miktar="+miktar;//parametreleri değişkenime tanımladım
$.ajax({
type:"POST",
url:"yemekEkle.jsp",
data:degerler,
success:function(cevap){
	alert(cevap);
	location.reload();
	}//ve en sonunda sonc durumunu mesaj gösterecek sonra sayfayı yiniden renderlayacak
});

}
  }

$.adisyonkapat=function(){//adisyon kapatmak için
	var r = confirm("sonlandırmak istediginize eminmisiniz");//adisyon kapatmak istediğini herhangi bir yanlışlığın olmadığını teyit etmek için soruyorum
	
	
	var adisyon=$("input[name=adisyon]").val();
	if(r==true){//kabulse
		adisyon=$.trim(adisyon);

		if(!adisyon)
		{
		alert("bos alanlar mevcut");
		}
		else{//boş alanda yoksa
		var degerler="adisyon="+adisyon;
		$.ajax({//parametreleri gömüyorum
		type:"POST",
		url:"adisyonSonla.jsp",//adresime pst edicem
		data:degerler,
		success:function(cevap){
			alert(cevap);//oradan da bana cevap gelecek
			location.replace("masaSec.jsp");//ve url yeniden masalara gelecek
			}
		});

		}
	}else{
		alert("lütfen dikkatinizi veriniz!");//yanlışlıkla bastıysam dikkatli olmam gerekir
	}

	  }

} ); 	
</script>
<meta charset="UTF-8">
<title>Sipariş verme ekranı</title>
</head>
<body>
<div class="custom-select" >
<form method="yemekEkle.jsp" method="POST">
<%
//eğer masaya ait son adisyon bittiyse
///masanumarasına ait yeni bir adisyon numarası ile aç
//yoksa
//son adisyon bitmediyse son adisyon numarasına ait yenenleri çek
%>

<%
String vale= request.getParameter("masa");
%>
<input type="hidden" name="masa" value=<%=vale %>>
<% 
out.print("<h3>Masa Numarası:"+vale+" </h3>");
int id=0;
rs = statement.executeQuery("SELECT bitti FROM adisyon where adisyonNo in(select max(adisyonNo) from adisyon where masaNo="+vale+")");
//eğer masaya ait son adisyon bittiyse
    rs.next();
if(rs.getBoolean("bitti"))//bttiyse
{
	int i=statement.executeUpdate("insert into adisyon(masaNo,bitti) values("+vale+",0)");//yeni bir adisyon oluştur o masaya ait	
	rs=statement.executeQuery("select max(adisyonNo) as a from adisyon where masaNo="+vale+"");//ve bu adisyonun numarasını al
    rs.next();
       id=rs.getInt("a");//aldım hayırlı olsun
}
else//ha yok siparişi bitmemiş adisyon varsa o masaya ait
{
	rs=statement.executeQuery("select max(adisyonNo) as a from adisyon where masaNo="+vale+"");//o zaman o adisyon numarasını aldım
    rs.next();
       id=rs.getInt("a");//aldım
	rs = statement.executeQuery("SELECT tuketilenNo,(select concat(yemekAd,'-',fiyat,' tl') from yemek where yemekNo=tuketilen.yemekNo) as a,miktar FROM tuketilen where adisyonNo in(select max(adisyonNo) from adisyon where masaNo="+vale+")");
       ///secilen masaya ait yenilen içilenler listeleniyor adet ve fiyatları ile birlikte
	%>
	<table class="w3-table w3-bordered w3-striped">
	<tr>
	<b><%=id %> NUMARALI ADİSYON</b>
	</tr>
	<tr>
	<td>İslem sil</td>
	<td>Ürün</td>
	<td>miktar</td>
	</tr>
	<% 
	while (rs.next()) {
		%>
		<tr><th><input type="Button" onclick="silmeyemek(<%=rs.getString("tuketilenNo") %>,<%=vale %>)" value="sil">
		</th><th><%=rs.getString("a") %></th><th><%=rs.getString("miktar") %></th></tr>
	<% 
	}
	rs = statement.executeQuery("select sum(t.miktar*y.fiyat) as c from yemek y,tuketilen t where y.yemekNo=t.yemekNo and t.adisyonNo="+id+"");
	//ve son olarakta toplam adisyon tutarı şafakta görünüyor 
	rs.next();
	int toplam=rs.getInt("c");//toplam değişkeni
	%>	
	<tr><th></th><th>Toplam tutar=</th><th style="background-color:black;color:white;text-align:center;font-family: "Times New Roman"><%=toplam %></th></tr>
	</table>
<%//süsleyyerek yazdırdım siyah fontta beyaz yazdırdım:)
}

rs = statement.executeQuery("SELECT * FROM tuketimTip");//tuketim tipim değiştiğimde yemek selecttim ajaz ile güncellenecek
%>
<input type="hidden" name="adisyon" value=<%=id %> >
<p>Yeme içme?:<select   id="tuketimTip" name="tuketimTip" onchange="yemegi()">
<option selected value=0>none</option>
<% 
while (rs.next()) {
	%>  
	<option value=<%=rs.getString("tuketimNo")%>><%=rs.getString("tuketimAd")%></option>
<% 
}
%>
</select>
</p>
<%  rs = statement.executeQuery("SELECT * FROM yemek");%>
<p>Ne arzu edersiniz:<select  id="yemek" name="yemek">
<% 
while (rs.next()) {//ilk baş hepsini yazdırırım istediğini seç
	%>  
	<option value=<%=rs.getString("yemekNo")%>><%=rs.getString("yemekAd")%></option>
<% 
}
rs.close();
%>
</select></p>
<p>Yemek miktari:<input type="text" placeholder="yemek miktar" name="miktar"></p>
<button onclick="$.yemekle()">ekle</button>
<button onclick="$.adisyonkapat()">adisyon bitir</button>
</form>
</div>
</body>
</html>