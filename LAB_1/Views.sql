use SixSemStore;
select * from Orders;
select * from Customers;

Create or alter VIEW FullOrderInfo AS
select Customers.customerName, Customers.customerEmail, Customers.creditBalance,
Orders.orderedProduct, Orders.orderDate, Orders.orderedCount
from Customers inner JOIN Orders on Customers.customerName = Orders.client;

Select * from FullOrderInfo;

Create or Alter VIEW ShowGoods AS
select * from Goods;

Select * from ShowGoods;

Create or Alter VIEW ShowAccounts AS
select * from Accounts;

Select * from ShowAccounts;