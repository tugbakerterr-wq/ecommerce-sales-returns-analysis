# 📊 E-Ticaret Satış ve İade Analizi (2010 - 2011)

Bu projede, popüler **Online Retail II** veri setini ele alarak bir e-ticaret şirketinin satış performansını, iade kayıplarını ve müşteri harcama alışkanlıklarını analiz ettim. 

Amacım ham veriden işe yarar içgörüler çıkarıp, karar vericilerin tek bakışta durumu görebileceği bir yönetici panosu hazırlamaktı.

---

## 🖼️ Dashboard
![E-Ticaret Dashboard](image.png)

---

## 🛠️ Neler Yaptım & Hangi Araçları Kullandım?

### 1. Excel ile Veri Ön Hazırlığı ve Temizleme
  * Ham veri setindeki eksik (`null`) müşteri ID'lerini ve anlamsız kayıtları filtreledim.
  * Başında 'C' kodu olan iptal/iade faturaları ile normal satış hareketlerini mantıksal olarak birbirinden ayırdım.
  * Veriyi veri tabanına ve analize en uygun olacak şekilde **`sales` (satışlar)** ve **`returns` (iadeler)** olmak üzere iki ayrı yapıya dönüştürdüm.

### 2. SQL ile Veri Analitiği & İş Mantığı
  **SQL ile Veri Analitiği:** 
  * Satış ve iade hareketlerini ayırıp toplam satır sayılarını doğruladım.
  * Gruplamalar (`GROUP BY`), tekil sayımlar (`COUNT DISTINCT`) ve filtreler kullanarak ciro, iade ve sepet ortalamalarını çıkardım.
  * Satış ve iadeleri `CTE` ve `JOIN` yapılarıyla birleştirerek ürün bazında gerçek net ciroları hesapladım.

  **3. Power BI ile Görselleştirme:** 
  * Üst kısma en kritik metrikleri (Brüt Satış, İade, Sipariş ve Müşteri Sayısı) KPI kartı olarak yerleştirdim.
  * Satışları **yeşil**, şirket için kayıp anlamına gelen iadeleri ise **kırmızı** tonlarda vurgulayarak görsel karmaşayı önledim.
  * En çok kazandıran ve en çok iade edilen ilk 10 ürünü, ülke dağılımlarını ve en çok harcayan ilk 5 müşteriyi modelledim.

---

## 📌 Çıkardığım Önemli Notlar & Sonuçlar
* **Ciro & İade Dengesi:** Şirket yaklaşık 8.69 M £ brüt satış yaparken, 603.75 K £ civarında iade almış. İade oranının **%6.94** çıkması e-ticaret sektörü için gayet makul bir seviyede.
* **Ortalama Sepet:** Sipariş başına ortalama harcama tutarı **469.16 £**.
* **Pazar Hacmi:** Siparişlerin ve cironun ezici bir çoğunluğu Birleşik Krallık (İngiltere) üzerinden geliyor.
* **Ürün Detayı:** `Paper Craft, Little Birdie` ürünü ciro şampiyonu olsa da, en çok iade edilen ürünler listesinde de başı çekiyor. 

---

## 📁 Dosyalar
* `ecommerce_analysis_queries.sql`: Yazdığım ve optimize ettiğim 8 analitik SQL sorgusu.
* `Online Retail Dashboard.pbix`: Tasarladığım Power BI panosu ve veri modeli.
* `E-Ticaret_Satis_Analiz_Raporu.docx`: Detaylı analiz ve raporlama belgem.
* `image.png`: Panonun genel ekran görüntüsü.
