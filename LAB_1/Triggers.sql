go
Create or Alter TRIGGER OrderInsert
on Orders
AFTER INSERT
AS
INSERT INTO History(orderId,operation)
Select Id,'Заказан товар '+ orderedProduct + ' Клиентом ' + client
from inserted;
go

go
Create or Alter TRIGGER OrderDelete
on Orders
AFTER DELETE
AS
INSERT INTO History(orderId,operation)
Select Id,'Заказан удален '+ orderedProduct + ' Клиентом ' + client
from deleted;
go


go
Create or Alter TRIGGER OrderUpdate
on Orders
AFTER UPDATE
AS
INSERT INTO History(orderId,operation)
Select Id,'Заказан обновлен '+ orderedProduct + ' Клиентом ' + client
from inserted;
go

select * from History;
select * from Orders;
select * from Customers
select * from Goods;

exec MakeOrder 'Black','MetallFan34','02-01-2022',1
exec RemoveOrder 'Black','MetallFan34'

Delete from Orders where orderedProduct = 'Alestorm' AND client = 'Rob Tomson';

UPDATE Orders
Set client = 'Enjoer11'
where Id = 17;