

--ogr2ogr -overwrite -f MSSQLSpatial -lco "GEOM_TYPE=geography" -a_srs "EPSG:4326" "MSSQL:server=DESKTOP-T60D9R9\SQLEXPRESS;database=SAALAB;trusted_connection=yes" "D:\Education\3 курс 2 сем\DB\Lab4SAALAB\map\map.shp"
use SAALAB
select * from map;

go
declare @g geometry = geometry::STGeomFromText('Point(0 0)', 0);
select @g.STBuffer(5), @g.STBuffer(5).ToString() as WKT from map

go
DECLARE @g geography;  
SET @g = geography::STGeomFromText('LINESTRING(-122.360 47.656, -122.343 47.656)', 4326);  
SELECT @g.ToString();  

go
--3. пересечение, исключение или объединение данных
go
DECLARE @g geometry;  
DECLARE @h geometry;  
SET @g = geometry::STGeomFromText('LINESTRING(0 2, 2 0)', 0);  
SET @h = geometry::STGeomFromText('LINESTRING(0 0, 2 2)', 0);  
SELECT @g.STCrosses(@h)[Пересечение];  

go
DECLARE @g geometry;  
DECLARE @h geometry;  
SET @g = geometry::STGeomFromText('LINESTRING(0 2, 2 0, 4 2)', 0);  
SET @h = geometry::STGeomFromText('POINT(0 1)', 0);  
SELECT @g.STIntersects(@h)[Исключение];  

go
DECLARE @g geometry;  
DECLARE @h geometry;  
SET @g = geometry::STGeomFromText('POLYGON((0 0, 2 0, 2 2, 0 2, 0 0))', 0);  
SET @h = geometry::STGeomFromText('POINT(1 1)', 0);  
SELECT @g.STContains(@h) [Объединение];  

--Объединение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STUnion(@h);

--Исключение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STSymDifference(@h);

--Пересечение
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g.STIntersection(@h);


--3. Расстояние
go
declare @g1 geometry; 
select @g1 = Point from cityCoord where Id = (select City_Addr from Customers where City = 'Минск');
declare @g2 geometry; 
select @g2 = Point from cityCoord where Id = (select City_Addr from Customers where City = 'Гродно');
Select @g1.STDistance(@g2) as D;

--5. Уточнить пространственный объект --- работает
Declare @m geometry = geometry::STGeomFromText('LINESTRING(6 6, 3 2.2, 17 17)', 0);
select @m.ToString(), @m.Reduce(10000).ToString() as Reduced;

DECLARE @g geography = 'LineString(120 45, 120.1 45.1, 199.9 45.2, 120 46)'  
SELECT @g.ToString(), @g.Reduce(10000).ToString()

DECLARE @g geometry;  
DECLARE @h geometry;  
SET @g = geometry::STGeomFromText('LINESTRING(0 2, 2 0)', 0);  
SET @h = geometry::STGeomFromText('LINESTRING(0 0, 2 2)', 0);  
SELECT @g.STIntersects(@h) [Пересеклось];  

--FUNCTIONS
go
Create FUNCTION getDistanse(@idCity int,@idCityT int) returns float
as
begin
	declare @g1 geometry; 
	select @g1 = Point from cityCoord where Id = (select City_Addr from Customers where id=@idCity);
	declare @g2 geometry; 
	select @g2 = Point from cityCoord where Id = (select City_Addr from Customers where id=@idCityT);
	return @g1.STDistance(@g2);
end;

CREATE or alter FUNCTION getDistanse(@idCity int, @idCityT int) RETURNS FLOAT
AS
BEGIN
    DECLARE @g1 geometry; 
    SELECT @g1 = (SELECT TOP 1 Point FROM cityCoord WHERE Id IN (SELECT City_Addr FROM Customers WHERE id = @idCity));
    
    DECLARE @g2 geometry; 
    SELECT @g2 = (SELECT TOP 1 Point FROM cityCoord WHERE Id IN (SELECT City_Addr FROM Customers WHERE id = @idCityT));
    
    RETURN @g1.STDistance(@g2);
END;


SELECT dbo.getDistanse(1, 2) AS Distance;

go
Create or alter FUNCTION findNearest(@latitude float,@longitude float) returns table
as
return
	select City [Название города],min((geometry::STGeomFromText('Point('+ CAST(@latitude as nvarchar(max)) +' ' + CAST(@longitude as nvarchar(max)) + ')', 0)).STDistance(Point)) [Растояние] 
	from cityCoord inner join Customers on cityCoord.id = Customers.City_Addr group by City;

go

exec findNearest 1, 2


Create or alter FUNCTION getIntersect(@idCityOne int,@idCityTwo int,@idCityThree int,@idCityFour int) returns bit
as
begin
	declare @g1 geography; 
	select @g1 = geography::STGeomFromText(Point.ToString(), 4326) from cityCoord where Id = (select City_Addr from Customers where Id = @idCityOne);
	declare @g2 geography; 
	select @g2 = geography::STGeomFromText(Point.ToString(), 4326) from cityCoord where Id = (select City_Addr from Customers where Id = @idCityTwo);
	declare @g3 geography; 
	select @g3 = geography::STGeomFromText(Point.ToString(), 4326) from cityCoord where Id = (select City_Addr from Customers where Id = @idCityThree);
	declare @g4 geography; 
	select @g4 = geography::STGeomFromText(Point.ToString(), 4326) from cityCoord where Id = (select City_Addr from Customers where Id = @idCityFour);

	declare @g geometry = geometry::STGeomFromText('LINESTRING('+CAST(@g1.Lat as nvarchar(max))+' '+ CAST(@g1.Lat as nvarchar(max))+', '+CAST(@g2.Lat as nvarchar(max))+' '+ CAST(@g2.Lat as nvarchar(max))+')', 0);  
	declare @h geometry = geometry::STGeomFromText('LINESTRING('+CAST(@g3.Lat as nvarchar(max))+' '+ CAST(@g3.Lat as nvarchar(max))+', '+CAST(@g4.Lat as nvarchar(max))+' '+CAST(@g4.Lat as nvarchar(max))+')', 0);  

	return @g.STIntersects(@h);
end;


EXEC getIntersect 1, 2, 3, 4;



--ближайший
CREATE OR ALTER FUNCTION getNearestCity(@idCity int, @idCityT1 int, @idCityT2 int) RETURNS INT
AS
BEGIN
    DECLARE @g1 geometry; 
    SELECT @g1 = (SELECT TOP 1 Point FROM cityCoord WHERE Id IN (SELECT City_Addr FROM Customers WHERE id = @idCity));
    
    DECLARE @g2 geometry; 
    SELECT @g2 = (SELECT TOP 1 Point FROM cityCoord WHERE Id IN (SELECT City_Addr FROM Customers WHERE id = @idCityT1));
    
    DECLARE @g3 geometry; 
    SELECT @g3 = (SELECT TOP 1 Point FROM cityCoord WHERE Id IN (SELECT City_Addr FROM Customers WHERE id = @idCityT2));
    
    DECLARE @distance1 float;
    SET @distance1 = @g1.STDistance(@g2);
    
    DECLARE @distance2 float;
    SET @distance2 = @g1.STDistance(@g3);
    
    IF @distance1 < @distance2
        RETURN @idCityT1;
    
    RETURN @idCityT2;
END;



SELECT dbo.getNearestCity(4, 3, 5) AS NearestCityId;


--карта покрытия

SELECT c.Id, c.Point.ToString() AS Point, COUNT(*) AS Coverage
FROM cityCoord c
INNER JOIN Customers cust ON c.Id = cust.City_Addr
GROUP BY c.Id, c.Point.ToString()
ORDER BY c.Id;

--доделал

go
Create or alter FUNCTION findNearest2(@latitude float,@longitude float) returns table
as
return
  select top(1) City [Название города],min((geometry::STGeomFromText('Point('+ CAST(@latitude as nvarchar(max)) +' ' + CAST(@longitude as nvarchar(max)) + ')', 0)).STDistance(Point)) [Растояние] 
  from cityCoord inner join Customers on cityCoord.id = Customers.City_Addr group by City order by [Растояние] asc

  Select * from findNearest2(153,54);