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

SELECT * from Products
WHERE categoryid IN(1,2) 
	AND (unitprice BETWEEN 10 and 20) 
  AND (productname LIKE '%G%' AND productname LIKE '%S%')

SELECT * FROM Customers 
-- WHERE fax IS NULL
WHERE NOT fax IS NULL

SELECT * FROM 'Order Details' 
WHERE unitprice * quantity - (unitprice * quantity * discount) > 1000

SELECT COUNT(DISTINCT city) FROM Customers 
WHERE city IS NOT NULL

SELECT country as 'Ülke', COUNT(DISTINCT city) as 'Benzersiz Şehir' FROM Customers 
WHERE city IS NOT NULL
GROUP BY country
--ORDER BY COUNT(DISTINCT city) ASC
ORDER BY COUNT(DISTINCT city) DESC

--select DISTINCT contactname || ' - ' || city from Customers
SELECT DISTINCT CONCAT(contactname, ' - ', city) from Customers

SELECT country as 'Ülke', COUNT(DISTINCT city) as 'Benzersiz Şehir' FROM Customers 
WHERE city IS NOT NULL
GROUP BY country
HAVING COUNT(DISTINCT city) >= 3
--ORDER BY COUNT(DISTINCT city) ASC
ORDER BY COUNT(DISTINCT city) DESC