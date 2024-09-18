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


-- 1 sayfa (0. indeks) , 5 öğe sayısı
SELECT * FROM Products 
order by unitprice desc
limit 5
OFFSET 5 * 0

-- 2 sayfa (1. indeks) , 5 öğe sayısı
SELECT * FROM Products 
order by unitprice desc
limit 5
OFFSET 5 * 1


SELECT * FROM Products 
order by unitprice desc

SELECT * from Customers
ORDER BY country DESC, city ASC


SELECT CONCAT(firstname, ' ', lastname) as FullName FROM Employees
ORder by FullName

SELECT CONCAT(firstname, ' ', lastname) as 'Ad Soyad' FROM Employees
ORder by firstname, lastname

select concat(firstname, ' ', lastname) as [İsim Soyisim] from Employees
order by [İsim Soyisim]

SELECT * FROM Products
order by 
	CASE WHEN unitsinstock = 0 THEN 2
    	 -- WHEN categoryid = 1 then 1
    	 else 0
    end,
    productname DESC