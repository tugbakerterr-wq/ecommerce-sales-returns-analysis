/* ==============================================================================
   PROJE: E-Ticaret Satýþ ve Ýade Performans Analizi (2010 - 2011)
   VERÝ KAYNAÐI: Online Retail II Data Set (UCI Machine Learning / Kaggle)
   ARAÇLAR: PostgreSQL / MySQL / Power BI
   ============================================================================== */

-- 1. ADIM: Tablolardaki Toplam Satýr Sayýlarýnýn Kontrol Edilmesi
SELECT 
    'Sales' AS Tablo, 
    COUNT(*) AS ToplamSatir 
FROM sales
UNION ALL
SELECT 
    'Returns' AS Tablo, 
    COUNT(*) AS ToplamSatir 
FROM returns;


-- 2. ADIM: Genel Finansal Göstergeler (Brüt Satýþ, Toplam Ýade, Net Ciro ve Ýade Oraný)
SELECT 
    ROUND(SUM(s.TotalPrice), 2) AS BrutSatis,
    ROUND((SELECT SUM(ReturnAmount) FROM returns), 2) AS ToplamIade,
    ROUND(SUM(s.TotalPrice) - (SELECT SUM(ReturnAmount) FROM returns), 2) AS NetCiro,
    ROUND(((SELECT SUM(ReturnAmount) FROM returns) / SUM(s.TotalPrice)) * 100, 2) AS IadeOraniYuzde
FROM sales s;


-- 3. ADIM: En Çok Ciro Getiren Ýlk 10 Ürün (Top 10 Revenue Products)
SELECT 
    Description,
    SUM(Quantity) AS ToplamSatilanAdet,
    ROUND(SUM(TotalPrice), 2) AS ToplamKazanc
FROM sales
GROUP BY Description
ORDER BY ToplamKazanc DESC
LIMIT 10;


-- 4. ADIM: En Yüksek Ýade Tutarýna Sahip Ýlk 10 Ürün (Finansal Kayýp Analizi)
SELECT 
    Description,
    SUM(ABS(Quantity)) AS ToplamIadeAdedi,
    ROUND(SUM(ReturnAmount), 2) AS ToplamIadeTutari
FROM returns
GROUP BY Description
ORDER BY ToplamIadeTutari DESC
LIMIT 10;


-- 5. ADIM: Ülkelere Göre Sipariþ Hacmi ve Satýþ Cirosu (Top 10 Ülke)
SELECT
    Country, 
    COUNT(DISTINCT Invoice) AS ToplamSiparisSayisi,
    ROUND(SUM(TotalPrice), 2) AS ToplamCiro
FROM sales
GROUP BY Country
ORDER BY ToplamCiro DESC
LIMIT 10;


-- 6. ADIM: En Çok Harcama Yapan Ýlk 5 Müþteri (VIP Müþteri Analizi)
SELECT 
    Customer_ID,
    COUNT(DISTINCT Invoice) AS ToplamSiparis,
    ROUND(SUM(TotalPrice), 2) AS ToplamHarcama
FROM sales
GROUP BY Customer_ID
ORDER BY ToplamHarcama DESC
LIMIT 5;


-- 7. ADIM: Ortalama Sepet Tutarý (Average Order Value - AOV)
SELECT 
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT Invoice), 2) AS OrtalamaSepetTutari
FROM sales;


-- 8. ADIM: Ürün Bazlý Brüt Satýþ, Ýade Tutarý ve Gerçek Net Ciro Karþýlaþtýrmasý
WITH SatisOzeti AS (
    SELECT 
        StockCode, 
        Description, 
        ROUND(SUM(TotalPrice), 2) AS Satis
    FROM sales
    GROUP BY StockCode, Description
),
IadeOzeti AS (
    SELECT 
        StockCode, 
        ROUND(SUM(ReturnAmount), 2) AS Iade
    FROM returns
    GROUP BY StockCode
)
SELECT 
    s.StockCode,
    s.Description,
    s.Satis,
    COALESCE(i.Iade, 0) AS Iade,
    ROUND(s.Satis - COALESCE(i.Iade, 0), 2) AS NetCiro
FROM SatisOzeti s
LEFT JOIN IadeOzeti i ON s.StockCode = i.StockCode
ORDER BY s.Satis DESC
LIMIT 10;