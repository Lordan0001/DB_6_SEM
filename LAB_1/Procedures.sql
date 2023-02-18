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



go
Create or alter procedure RemoveOrder
@OrProduct nvarchar(254),
@Client nvarchar(254)
as begin
DECLARE
@OldCount int,
@NewCount int,
@OrCount int
begin try
SET @OldCount = (Select [count] from Goods where productName = @OrProduct);
SET @OrCount = (Select orderedCount from Orders where orderedProduct = @OrProduct) 
SET @NewCount = @OldCount + @OrCount;

Delete from Orders where orderedProduct = @OrProduct AND client = @Client;

Update Goods SET [count] = @NewCount where productName = @OrProduct;
print 'Order delted!';
end try
begin catch
print 'Error: ' + cast(error_number() as varchar(6)) + ': ' + error_message();
end catch
end;
go

exec RemoveOrder 'Motorhead','John Wick';


go
Create or alter procedure AddFullUser
@CustomerName nvarchar(254),  -- main name
@Email nvarchar(254),
@CreditBalance money,
@Login nvarchar(254),
@Password nvarchar(254)

as begin

begin try

Insert INTO Accounts([login],[password],[name],email)
Values(@Login,@Password,@CustomerName,@Email);

Insert Into Customers(customerName,customerEmail,creditBalance)
Values(@CustomerName,@Email,@CreditBalance);
print 'User Created!'

end try
begin catch
print 'Error: ' + cast(error_number() as varchar(6)) + ': ' + error_message();
end catch
end;
go

Exec AddFullUser 'TEstName','test@mail.com',6000,'testLogin','testPass'

select * from Customers;
select * from Accounts;

go
Create or alter procedure DeleteFullUser
@CustomerName nvarchar(254)  -- main name

as begin

begin try

delete from Customers where customerName = @CustomerName;
delete from Accounts where [name] = @CustomerName;
print 'User Deleted!'

end try
begin catch
print 'Error: ' + cast(error_number() as varchar(6)) + ': ' + error_message();
end catch
end;
go

exec DeleteFullUser 'TEstName'