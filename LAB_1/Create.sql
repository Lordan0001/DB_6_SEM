use SixSemStore;

drop table Categories;
drop table Goods;
drop table Customers;
drop table Orders;
drop table Accounts;
drop Table History;


CREATE TABLE Categories(
  Id int PRIMARY key IDENTITY not null,
  category nvarchar(254) unique not null,
);

CREATE TABLE Goods(
    Id int PRIMARY key IDENTITY not null,
    productName nvarchar(254) unique not null,
    productCattegory nvarchar(254) REFERENCES Categories(category) not null,
    count int not null Check(count>=0 AND count <= 1000),
    price int not null
);

CREATE TABLE Accounts(
    Id int PRIMARY key IDENTITY not null,
	[login] nvarchar(254) unique not null,
	[password] nvarchar(254) unique not null,
	[name] nvarchar(254) unique not null,
	email  nvarchar(254) unique not null,
)



CREATE TABLE Customers(
    Id int PRIMARY key IDENTITY not null,
  customerName nvarchar(254) not null unique REFERENCES Accounts(name),
  customerEmail  nvarchar(254) REFERENCES Accounts(email) not null,
  creditBalance money not null
);

CREATE TABLE  Orders(
    Id int PRIMARY key IDENTITY not null,
    orderdProduct nvarchar(254) REFERENCES Goods(productName) not null,
    client nvarchar(254) REFERENCES Customers(customerName) not null,
    orderDate date not null,
    orderedCount int not null
);

CREATE TABLE History(
    Id int PRIMARY key IDENTITY not null,
	orderId int not null,
	operation nvarchar(254) not null,
	createAt DATETIME not null default GETDATE()
)



--change add single price column and
--ALTER TABLE Orders ADD TotalPrice AS (orderedCount * SinglePrice) PERSISTED;