Create or alter function TotalPrice(
@Name nvarchar(254))
Returns  money
DECLARE
@ProductCount int,
@SinglePrice money,
@OrderedProduct nvarchar(254)
as begin
Set @ProductCount (select orderedCount from Orders where client = @Name)
Set @OrderedProduct (select orderedProduct from Orders where client = @Name)
Set @SinglePrice (select price from Goods where productName = @OrderedProduct)
return @ProductCount * @SinglePrice;
end;