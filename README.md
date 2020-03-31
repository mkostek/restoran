<h3>Bu uygulama server tabanlı çalışan java uygulamasıdır</h3>
<p>Senaryo olarak müşteri gelir.Bir masaya oturur.Sonrasında oturduğu masaya ait adisyon oluşturulur.Oluşturulan adisyon müşteri masadan kalkana kadar hayattadır.Müşteri masada iken seçim yapacağı kategoriler olur(çorbalar,kebaplar,pideler vb.).Müşteri seçtiği bir kategoriyi filtreleyerek alt olan liste güncellenir,ve o kategoriye ait hizmet grubu görüntülenir,müşteri buradan seçimini yaparak miktarıyla birlikte adisyona ekler,eklediği zaman tabloya sipariş ettikleri miktarı ile beraber toplam tutarı gösterilir.Müşteri masadan kalkıp ödediğinde adisyonu masadan son bulacak ve gelen müşteri için yeni bir adisyon numarası ile masa hizmet vermeye devamedecektir.<p>
  <ul>Kurallar
    <li>Bir restoranda birden çok masa vardır</li>
    <li>Bir lokanta birden çok kategoride yemek veya içecek olabilir</li>
    <li>Bir müşteri birden çok yemek yiyebilir</li>
    <li>Bir masaya birden çok adisyon açılabilir</li>
    </ul>
    <h4>Programın çalışması</h4>
    <p>Öncelikle bir müşteri boş bir masaya oturduğu zaman o masayayı masaSec.jsp sayfasından seçecek sö submitleyecek,sonra karşısına bir adisyon numarası ile masa numarası gösterilecek,kullanıcı arzu ettiği kategoriden arzu ettiği şeyleri garsona söyleyerek garsona eklettirecek ve bilgi girişini gerçeklşetirecek masadan kalkıldıktan sonra müşteri hangi masada oturduğunu söyleyerek kasayı bilgilendirecek ve sonra kasacı toplam adisyon tutarını tahsil ederek adisyonu bitirecektir</p> 
