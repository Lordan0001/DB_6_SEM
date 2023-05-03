
--clr on
exec sp_configure 'clr enabled', 1;
reconfigure;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;
---


drop assembly Read_Assembly;
drop procedure ReadProc;
drop TYPE DirectoryPath;
drop TYPE Adres;
drop table test;

create  assembly Read_Assembly from 'D:\University\Current\DataBase\All\LAB_3\bin\Debug\LAB_3.dll'
	WITH PERMISSION_SET = SAFE;
go

select  from sys.assemblies;

--procedures


CREATE TYPE DirectoryPath 
EXTERNAL NAME Read_Assembly.[LAB_3.DirectoryPath];
GO

CREATE TYPE Adres 
EXTERNAL NAME Read_Assembly.[LAB_3.ReplacePointsWithSpaces];
GO

drop procedure ReadProc;
go

create or alter procedure ReadProc
as
external name Read_Assembly.[LAB_3.DbTask].ReadFile;
go

exec ReadProc 

create table test(
myType Adres )

insert into test(myType)
values('Baker.st.house.86');

select * from test;

