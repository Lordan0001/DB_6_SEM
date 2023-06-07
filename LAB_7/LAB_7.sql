---------
use LAB_7
drop table Report
create table Report (
id INTEGER primary key identity(1,1),
xml_ XML
);
select * from Report
----------------
drop procedure gen_xml

create or alter procedure gen_xml
as
declare @x XML
set @x = (select cust_num, company, salesreprs.name, salesreprs.hire_date  from customers 
				join salesreprs on salesreprs.id = customers.cust_rep
				join offices on offices.id = salesreprs.office 	
				FOR XML AUTO);
SELECT @x
go

execute gen_xml;

------------------
create or alter procedure add_report
as
DECLARE  @x XML  
SET @x = (select cust_num, company, salesreprs.name, salesreprs.hire_date  from customers 
				join salesreprs on salesreprs.id = customers.cust_rep
				join offices on offices.id = salesreprs.office 
				for xml path('newName'))
				--for xml raw
insert into Report values(@x);
go
  
execute add_report
select * from Report;

------------
create primary xml index xml_ind on Report(xml_)

-----------
select * from Report

	create or alter procedure xml_search 
	as
	select xml_.query('/newName/hire_date')
		as[xml_]
		from Report
		for xml auto, type;
	--select Report.Id,
	--	m.c.value('@name', 'nvarchar(max)')
	--	from Report 
	--	outer apply Report.xml_.nodes('/newName') as m(c)
	go
execute xml_search


