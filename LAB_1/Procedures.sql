use SixSemStore;

go
Create or alter procedure TotalPrice
@CustomerName nvarchar(254),
@ProductName nvarchar(254)
as begin
DECLARE
@ProductCount int,
@SinglePrice money,
@OrderedProduct nvarchar(254)
begin try
Set @ProductCount  = (select orderedCount from Orders where client = @CustomerName AND orderedProduct = @ProductName)
Set @OrderedProduct = (select orderedProduct from Orders where client = @CustomerName AND orderedProduct = @ProductName )
Set @SinglePrice = (select price from Goods where productName = @OrderedProduct)
print @ProductCount * @SinglePrice;
end try
begin catch
print 'Error: ' + cast(error_number() as varchar(6)) + ': ' + error_message();
print 'Customer dont by this'
end catch
end;
go

exec TotalPrice 'MetallFan34','Ring-petagram'



go
Create or alter procedure MakeOrder
@OrProduct nvarchar(254),
@Client nvarchar(254),
@OrDate date,
@OrCount int
as begin
DECLARE
@OldCount int,
@NewCount int

begin try
INSERT INTO Orders(orderedProduct,client,orderDate,orderedCount)
VALUES(@OrProduct,@Client,@OrDate,@OrCount);

SET @OldCount = (Select [count] from Goods where productName = @OrProduct);
SET @NewCount = @OldCount - @OrCount;

Update Goods SET [count] = @NewCount where productName = @OrProduct;
print 'ORDERED!'
end try
begin catch
print 'Error: ' + cast(error_number() as varchar(6)) + ': ' + error_message();
end catch
end;
go

exec MakeOrder 'Motorhead','John Wick','01-01-2023',5

select * from Goods;
Select * from Customers;
select * from Orders;