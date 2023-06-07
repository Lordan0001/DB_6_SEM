---Вычисление итогов заказов покупателей за определенный период объем продаж 
use SixSemStore
SELECT 
    Customers.customerName, 
    SUM(Orders.orderedCount * Goods.price) OVER(PARTITION BY Customers.customerName ORDER BY Orders.orderDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_sales
FROM 
    Orders 
    JOIN Goods ON Orders.orderedProduct = Goods.productName
    JOIN Customers ON Orders.client = Customers.customerName
WHERE 
    Orders.orderDate BETWEEN '2022-01-01' AND '2022-03-31'


---Вычисление итогов заказов покупателей за определенный период сравнение их с общим объемом заказов в процента
SELECT 
    client, 
    SUM(orderedCount) AS totalOrderCount, 
    SUM(orderedCount) * 100.0 / SUM(SUM(orderedCount)) OVER () AS percentageOfTotal
FROM Orders
WHERE orderDate BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY client
ORDER BY totalOrderCount DESC;

---Вычисление итогов заказов покупателей за определенный период сравнение их с наилучшим объемом заказов в процентах
SELECT 
    client, 
    SUM(orderedCount) AS totalOrderCount, 
    MAX(SUM(orderedCount)) OVER () AS maxOrderCount, 
    SUM(orderedCount) * 100.0 / MAX(SUM(orderedCount)) OVER () AS percentageOfMax
FROM Orders
WHERE orderDate BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY client
ORDER BY totalOrderCount DESC;


--
DECLARE
@page_number int = 1
SELECT *
FROM (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY Id) AS row_num, 
        *
    FROM Categories
) AS numbered_table
WHERE row_num > 20 * (@page_number - 1)
  AND row_num <= 20 * @page_number
ORDER BY row_num;

--Вернуть для каждого клиента суммы последних 6 заказов
WITH NumberedOrders AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY client 
            ORDER BY orderDate DESC
        ) AS row_num
    FROM Orders
)
SELECT 
    c.customerName,
    SUM(g.price * o.orderedCount) AS total
FROM 
    NumberedOrders o
    INNER JOIN Goods g ON o.orderedProduct = g.productName
    INNER JOIN Customers c ON o.client = c.customerName
WHERE 
    o.row_num <= 6
GROUP BY 
    c.customerName;

	--Какой клиент заказал наибольшее число какого товара   вывести  всех клиентов, с помощью функции ранжирования

WITH CTE AS (
    SELECT o.client, o.orderedProduct, SUM(o.orderedCount) AS totalOrdered,
           ROW_NUMBER() OVER (PARTITION BY o.orderedProduct ORDER BY SUM(o.orderedCount) DESC) AS rn
    FROM Orders o
    INNER JOIN Goods g ON o.orderedProduct = g.productName
    INNER JOIN Customers c ON o.client = c.customerName
    GROUP BY o.client, o.orderedProduct
)
SELECT c.customerName, cte.orderedProduct, cte.totalOrdered
FROM CTE
INNER JOIN Customers c ON CTE.client = c.customerName
WHERE cte.rn = 1
ORDER BY c.customerName, cte.totalOrdered DESC;

--доделал

declare @PageNumber INT = 1
declare @PageSize INT = 20
select *
from (
         select ROW_NUMBER() over (order by id) as RowNumber,
                *
         from Accounts
     ) as PaginatedOrders
where RowNumber between (@PageNumber - 1) * @PageSize + 1 and @PageNumber * @PageSize


select * from Accounts;
SET IDENTITY_INSERT Accounts ON;


insert into Accounts(Id,login,password,name,email,parent_id)
values(21,'login21','duplicate','duplicate','temp21@malito.com',null);

select * from History;

Create table Temp(
column1 int,
column2 int,
column3 int)

insert into Temp(column1,column2,column3)
values(1,1,1)

select * from Temp;


with delete_duplicates as (
    select *,
           ROW_NUMBER() over (partition by column1 , column2, column3  order by column1) as RowNumber
    from Temp
)
delete from delete_duplicates
where RowNumber > 1