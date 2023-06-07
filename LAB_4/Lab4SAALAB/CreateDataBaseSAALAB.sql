Use SAALAB;

create database SAALAB


CREATE TABLE Products
(
  ProductCode INT PRIMARY KEY IDENTITY(1,1),
  Name VARCHAR(50) NOT NULL,
  Version DECIMAL(18,1) NOT NULL,
  ReleaseDate datetime NOT NULL

)
CREATE TABLE Technicians
(
  TechID INT PRIMARY KEY IDENTITY(1,1),
  Name VARCHAR(50) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  Phone VARCHAR(50) NOT NULL
)
CREATE TABLE Customers 
(
  CustomerID INT PRIMARY KEY IDENTITY(1,1),
  Name VARCHAR(50) NOT NULL,
  Address VARCHAR(50) NOT NULL,
  City VARCHAR(50) NOT NULL,
  Phone VARCHAR(20),
  Email VARCHAR(50)
)
CREATE TABLE Incidents
(
  IncidentID INT PRIMARY KEY IDENTITY(1,1),
  CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID) NOT NULL,
  ProductCode INT FOREIGN KEY REFERENCES Products(ProductCode) NOT NULL,
  TechID INT FOREIGN KEY REFERENCES Technicians(TechID) NULL,
  DateOpened DATETIME NOT NULL DEFAULT getdate(),
  DateClosed DATETIME NULL,
  Title VARCHAR(50) NOT NULL,
  Description VARCHAR(2000) NOT NULL
)
CREATE TABLE Registrations
(
  CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID) NOT NULL,
  ProductCode INT FOREIGN KEY REFERENCES Products(ProductCode) NOT NULL,
  RegistrationDate datetime NOT NULL DEFAULT getdate()
)


INSERT into Products VALUES ('Windows',10,N'28.07.2017')
INSERT into Products VALUES ('Windows',11,N'28.07.2020')
INSERT into Products VALUES ('Windows',8,N'18.07.2015')
select * from products

select * from customers

INSERT INTO Customers VALUES ('name1 secondName1','Address1','Минск',null,null)
INSERT INTO Customers VALUES ('name2 secondName2','Address2','Брест','+375447442333',null)
INSERT INTO Customers VALUES ('name3 secondName3','Address3','Гродно','+375447442998','third@mail.ru')

select * from Technicians

INSERT INTO Technicians VALUES ('Natalia Pacey','Pacey@tut.by','+375293334444')
INSERT INTO Technicians VALUES ('Smelov','Smelov@mail.ru','+375294334444')
INSERT INTO Technicians VALUES ('Blinova','Blinova@gmail.com','+375337845637')

select * from Registrations

INSERT INTO Registrations(CustomerID,ProductCode) VALUES (1,2);
INSERT INTO Registrations VALUES (1,2,'22.12.2016')
INSERT INTO Registrations VALUES (2,3,'22.01.2021')
INSERT INTO Registrations VALUES (2,3,'20.01.2016')

select * from Incidents

INSERT INTO Incidents(CustomerID,ProductCode,Title,Description) VALUES (1,2,'License','License doesnt work');
INSERT INTO Incidents(CustomerID,ProductCode,Title,Description) VALUES (1,2,'Drivers','Drivers dont install');
INSERT INTO Incidents(CustomerID,ProductCode,Title,Description) VALUES (2,2,'Drivers','Drivers installing crashes');
INSERT INTO Incidents(CustomerID,ProductCode,Title,Description) VALUES (3,2,'Driver1s','1Drivers installing crashes');
INSERT INTO Incidents(CustomerID,ProductCode,Title,Description) VALUES (3,2,'Driver12s','1Drivers instal2ling crashes');