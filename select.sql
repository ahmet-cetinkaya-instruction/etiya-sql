-- SELECT [Sütunlar / *] FROM [Tablo]

-- SELECT productid, productname FROM Products 
-- SELECT * FROM Products 
-- SELECT productid as "Kimlik", productname AS "Ürün İsmi" FROM Products
-- SELECT (productname || ' ' || unitprice || '$ - ' || categoryid ) as "Ürünler" FROM Products

SELECT * FROM Products 
WHERE categoryid = 1 AND NOT (unitprice >= 20 OR unitprice < 10)

-- >, <, =>, =<, =, !=
-- AND, OR
-- NOT
-- IN(), BETWEEN ... AND ..., LIKE
-- IS NULL
-- İşlem Önceliği:
-- Paratezler, karşılaştırma operatörleri, not, and, or