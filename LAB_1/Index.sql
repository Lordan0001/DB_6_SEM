CREATE INDEX ix_productName ON Goods(productName);

CREATE UNIQUE INDEX ix_ClientOrder
    ON Orders (orderedProduct, client)
    WITH FILLFACTOR= 80;

	CREATE UNIQUE INDEX ix_ProductNamePrice
    ON Goods (productName, price)
    WITH FILLFACTOR= 80;

		CREATE UNIQUE INDEX ix_ProductNamePrice
    ON Customers (customerName, creditBalance)
    WITH FILLFACTOR= 80;