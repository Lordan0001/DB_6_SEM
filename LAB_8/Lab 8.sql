alter database open;

--DROP TABLESPACE loblob;
--/home/oracle/b.txt

CREATE TABLESPACE loblob
  DATAFILE 'loblob.dbf'
  SIZE 30M
  AUTOEXTEND ON NEXT 10M
  MAXSIZE 200M
  EXTENT MANAGEMENT LOCAL;

CREATE USER Vlad IDENTIFIED BY orcl
  DEFAULT TABLESPACE LOB_LAB1
  ACCOUNT UNLOCK;
  

ALTER USER Vlad QUOTA 100M ON loblob;

-- C##loblob_user
--DROP DIRECTORY BFILE_DIR2;
CREATE DIRECTORY BFILE_DIR2 as 'D:\lab8';
GRANT READ ON DIRECTORY BFILE_DIR2 TO Vlad
--DROP TABLE lob_table;


CREATE TABLE fff (
  id   NUMBER(5)  PRIMARY KEY,
  fb bfile
)
INSERT INTO fff VALUES ( 1, BFILENAME( 'BFILE_DIR2', 'Image.jpg' ) );
select * from fff;

-----
--DROP TABLE bfile_table;
CREATE TABLE bfile_table (
 name VARCHAR(255),
 doc BFILE 
)

delete bfile_table where NAME = 'docx';
INSERT INTO bfile_table VALUES ( 'docx', BFILENAME( 'BFILE_DIR2', 'Document.docx' ) );
SELECT * FROM bfile_table;


