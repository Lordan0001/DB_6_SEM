
--clr on
exec sp_configure 'clr enabled', 1;
reconfigure;

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;

ALTER AUTHORIZATION ON DATABASE::SixSemStore TO main; 
GO
ALTER DATABASE SixSemStore SET TRUSTWORTHY ON; 

---


drop assembly Read_Assembly;
drop procedure ReadProc;
drop TYPE Adres;
drop table test;

create  assembly Read_Assembly from 'D:\University\Current\DataBase\All\LAB_3\bin\Debug\LAB_3.dll'
	WITH PERMISSION_SET = EXTERNAL_ACCESS;
go

create or alter procedure ReadProc @pathToFile nvarchar(256)
as
external name Read_Assembly.[LAB_3.DbTask].ReadFile;
go

exec ReadProc 'D:/b.txt'

select  from sys.assemblies;

--procedures


CREATE TYPE Adres 
EXTERNAL NAME Read_Assembly.[Route];
GO


drop table test;

create table test(
myType Adres )

insert into test(myType)
values('qwerty.st.house.16');

select * from test;

