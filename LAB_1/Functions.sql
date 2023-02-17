use SixSemStore;

select * from Orders;
select * from Goods;

go
Create or Alter Function OrdersCount()
returns int
as begin declare @rc int;
 SET @rc = (Select COUNT(orderdProduct) from Orders); 
return @rc;
end;
go

select dbo.OrdersCount();

go
Create or Alter Function PotentialProfit()
returns money
as begin declare @rc money;
 SET @rc = (Select Sum(price) from Goods); 
return @rc;
end;
go


select dbo.PotentialProfit();


go
Create or Alter Function AccountMaxCash()
returns money
as begin declare @rc money;
 SET @rc =  (Select Max(creditBalance) from Customers); 
return @rc;
end;
go

select dbo.AccountMaxCash();