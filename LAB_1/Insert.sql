--how to add data

--1. Categories
--2. Goods
--3. Accounts
--4. Customers
--5. Orders
use SixSemStore;
select * from Categories;
select * from Goods;
select * from Accounts;
select * from Customers;
select * from Orders;

--------------------------------Categories
INSERT INTO Categories(category)
values('Rings');
INSERT INTO Categories(category)
values('Bracelets');
INSERT INTO Categories(category)
values('T-shirts');
INSERT INTO Categories(category)
values('Cups');
INSERT INTO Categories(category)
values('Masks');
INSERT INTO Categories(category)
values('Stickers');
INSERT INTO Categories(category)
values('Souvenirs');
------------------------------Goods
select * from Goods;
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Ring-13','Rings',27,25);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Ring-petagram','Rings',52,25);

INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Bracelet-Sckulls','Bracelets',3,50);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Bracelet-Steel','Bracelets',1,50);

INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Black-Sabbath','T-shirts',4,80);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Metallica','T-shirts',34,80);

INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Motorhead','Cups',44,22);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Godsmack','Cups',31,22);

INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('AC/DC','Masks',2,30);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Alestorm','Masks',38,30);

INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Black','Stickers',23,2);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Pantera','Stickers',21,2);

INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('Spell-book','Souvenirs',2,20);
INSERT INTO Goods(productName,productCattegory,[count],price)
VALUES ('bust Iron Maiden','Souvenirs',21,2);


----------------------------Accouts
select * from Accounts;
INSERT INTO Accounts([login],[password],[name],email)
VALUES('user1','12345','MetallFan34','user@mail.ru')

INSERT INTO Accounts([login],[password],[name],email)
VALUES('user2','bfh3ds','Enjoer11','rock32@mail.ru')

INSERT INTO Accounts([login],[password],[name],email)
VALUES('tempLogin','qwerty54321','Rob Tomson','Tomson@mail.ru')

INSERT INTO Accounts([login],[password],[name],email)
VALUES('anotherAccount','lol9999','Evil corp','Robot@temp.com')

INSERT INTO Accounts([login],[password],[name],email)
VALUES('Skull382','CoolPasword','Papich','Arthas@gmail.com')

INSERT INTO Accounts([login],[password],[name],email)
VALUES('John234','baba-yaga4','John Wick','mrWick@gmail.com')

INSERT INTO Accounts([login],[password],[name],email)
VALUES('Scream3121','BestAlbum13','Ozzy Osborne','HelpMe@proton.com')

--------------------------Customers

select * from Customers;


INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('MetallFan34','user@mail.ru',5000);

INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('Enjoer11','rock32@mail.ru',300);

INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('Rob Tomson','Tomson@mail.ru',232112);

INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('Evil corp','Robot@temp.com',999999);

INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('Papich','Arthas@gmail.com',3000);

INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('John Wick','mrWick@gmail.com',333);

INSERT INTO Customers(customerName,customerEmail,creditBalance)
VALUES('Ozzy Osborne','HelpMe@proton.com',666);


----------------------Orders

select * from Orders;
select * from Goods;

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Ring-13','MetallFan34','01-01-2019',3);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Ring-petagram','MetallFan34','03-05-2020',1);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Alestorm','Rob Tomson','12-06-2021',5);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Godsmack','Papich','11-10-2021',10);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Bracelet-Steel','Papich','11-10-2021',4);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Spell-book','Ozzy Osborne','11-10-2022',6);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Pantera','Evil corp','12-09-2022',4);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Alestorm','John Wick','09-08-2022',3);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Black-Sabbath','Ozzy Osborne','04-07-2022',5);

INSERT INTO Orders(orderdProduct,client,orderDate,orderedCount)
VALUES('Metallica','MetallFan34','02-06-2022',15);