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

SELECT Products.ProductID, Products.ProductName, Products.CategoryID, Categories.CategoryName FROM Products 
Join Categories on Products.CategoryID = Categories.CategoryID

SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID, Orders.OrderDate FROM Customers 
LEFT join Orders on Customers.CustomerID = Orders.CustomerID
Order by Customers.CustomerID

SELECT Suppliers.SupplierID, Suppliers.CompanyName, COUNT(Products.ProductID) as ProductCount FROM Suppliers 
LEFt join Products on Suppliers.SupplierID = Products.SupplierID
GROUP by Suppliers.SupplierID

SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Title, Orders.OrderID FROM Orders 
RIGHT join Employees on Employees.EmployeeID = Orders.EmployeeID
ORDER by Employees.EmployeeID

SELECT Customers.CustomerID, Customers.CompanyName, Orders.ShippedDate FROM Orders 
RIGHT join Customers on Orders.CustomerID == Customers.CustomerID
order by Customers.CustomerID

SELECT Products.ProductName, Categories.CategoryName FROM Products 
Cross join Categories;

-- Self join
SELECT e1.EmployeeID, CONCAT(e1.FirstName, ' ', e1.LastName) as "Çalışan", CONCAT(e2.FirstName, ' ', e2.LastName) as "Yöneticisi" FROM Employees e1
join Employees e2 on e1.ReportsTo = e2.EmployeeID

SELECT Products.ProductName, Categories.CategoryName, Suppliers.CompanyName, "Order Details"."OrderID" FROM Products 
left join Categories on Products.CategoryID = Categories.CategoryID
join Suppliers on Products.SupplierID = Suppliers.SupplierID
RIGHT join "Order Details" on "Order Details"."ProductID" = Products.ProductID


SELECT * FROM Products 
where unitprice > (SELECT AVG(unitprice) from Products) -- 28.8

SELECT * FROM Products 
where unitprice = (SELECT MAX(unitprice) from Products) -- ProductId: 38

SELECT orderid, orderdate from Orders
where orderdate = (select min(orderdate) from orders where customerid = 'ALFKI')
	and customerid = 'ALFKI'
    
select * from Products
where categoryid in(
  Select categoryid from Categories 
  where categoryname in('Beverages', 'Confections')
  )
  
SELECT productname FROM Products
WHERE supplierid in (
  Select supplierid from Suppliers
  where country = 'USA'
  )

-- Kapsayıcı (Correlated) alt sorgular
SELECT productname FROM Products p
WHERE EXISTS (
  Select 1 from Suppliers s
  where s.SupplierID = p.SupplierID
  	and s.Country = 'USA'
  )

SELECT p.productname, p.categoryid, c.CategoryName from Products p
join Categories c on c.categoryid = p.CategoryID
where unitprice > (select AVG(unitprice) FROM Products p2
                   WHERE p2.categoryid = p.CategoryID)

-- nested join
SELECT c.CustomerID, c.CompanyName, COUNT(OrdersIn2023.CustomerID) from Customers c
JOIN (Select o.CustomerID from Orders o 
  		WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
	 ) as OrdersIn2023
ON c.CustomerID = OrdersIn2023.CustomerID
GROUP BY c.CustomerID

SELECT c.CustomerID, c.CompanyName, CustomerOrders.OrderCount from Customers c
JOIN (SELECT o.CustomerID, COUNT(orderid) as OrderCount from Orders o
  	  GROUP by o.CustomerID
  	  HAVING COUNT(o.OrderID) > 180
  	 ) as CustomerOrders
     ON c.CustomerID = CustomerOrders.CustomerID

-- Özyinelemeli (Recursive) sorgular
WITH RECURSIVE EmployeeHiearchy(EmployeeID, EmployeeFullName, ManagerId, Level) as (
	-- Anchor query
  	SELECT EmployeeID, CONCAT(firstname,' ',lastname) as EmployeeFullName, reportsto as ManegerId, 1 as Level from Employees
  	WHERE reportsto is null
  
  	UNION ALL
  
  	-- Recursive
    SELECT e.EmployeeID, CONCAT(e.firstname,' ',e.lastname) as EmployeeFullName, e.reportsto as ManegerId, eh.Level + 1 as Level from Employees e
  	JOIN EmployeeHiearchy eh ON e.ReportsTo == eh.EmployeeID
)
SELECT * FROM EmployeeHiearchy
