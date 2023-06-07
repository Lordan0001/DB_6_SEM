
--2. Создать уч. записи, роли, юзеры, привилегии

CREATE LOGIN Vlad_C
WITH PASSWORD = 'toor';

	create user Vlad_User for login Vlad_C;		--юзер, привяз. к логину
	create user JustUser without login;				--юзер
	create role user_role;							--роль

-- привилегии
	grant select, insert, update, delete on orders to user_role;
	revoke update on orders from user_role;
	EXEC sp_addrolemember @rolename = 'user_role', @membername = 'Vlad_User';


--3. Продем. заимствование прав для процедуры
	create login John with password = 'john';
	create login Jane with password = 'jane';
	create user John for login John;
	create user Jane for login Jane;

	exec sp_addrolemember 'db_datareader', 'John';
	exec sp_addrolemember 'db_ddladmin', 'John';
	deny select on orders to Jane;
	go 
	create procedure Us_GetOrders 
		with execute as 'John'
		as select * from Orders;

	alter authorization on Us_GetOrders to John;
	grant execute on Us_GetOrders to Jane;
	
	--
	setuser 'Jane';
	exec Us_GetOrders;
	select * from orders;
	setuser;

---- С Е Р В Е Р Н Ы Й     А У Д И Т ----

--4. Создать серверный аудит
	use master;

	create server audit CAudit 
	to file(
		filepath = 'D:\University\Current\DataBase\All\LAB_10',
		maxsize = 0 mb,
		max_rollover_files = 0,
		reserve_disk_space = off
	) with ( queue_delay = 1000, on_failure = continue);

	create server audit PAudit to application_log;
	create server audit AAudit to security_log;

	--
	select * from sys.server_audits;


--5. Задать для серв. аудита спецификации	  (аещае на группу юзеров)
	create server audit specification ServerAuditSpecification1
		for server audit CAudit
		add (database_change_group)
		with (state=on)

--6. Запустить серверный аудит, показать журнал аудита
	alter server audit CAudit with (state=on);

	create database primer;
	drop database primer;
	

---- А У Д И Т    Б А З Ы    Д А Н Н Ы Х ----

--7. Создать объекты аудита БД + спец + запуск + журнал
	create database audit specification DatabaseAuditSpecification2
		for server audit CAudit
		add (insert on SixSemStore.dbo.Accounts by dbo)
		with (state=on);

		SET IDENTITY_INSERT Accounts ON;
	select * from SixSemStore.dbo.Accounts;
	delete from SixSemStore.dbo.Accounts where [name]='MetallFan34';
	insert into SixSemStore.dbo.Accounts(id,login,password,name,email,parent_id) values (202,'someLogin2','somePassword2','somepass2','someemail2',null);

	select statement from fn_get_audit_file('D:\University\Current\DataBase\All\LAB_10\*', null, null);	


--10. Остановить адуит БД и сервера
	alter server audit CAudit with (state=off);
	alter server audit PAudit with (state=off);
	alter server audit AAudit with (state=off);


---- Ш И Ф Р О В А Н И Е ----

--11. Создать ассим. ключ шифрования
	use SixSemStore;
	create asymmetric key SampleAKey
		with algorithm = rsa_2048
		encryption by password = 'Pas45!!~~';

--12. Зашифр и расш- данные при пом ключа
	declare @plaintext nvarchar(21);
	declare @ciphertext nvarchar (256);

	set @plaintext = 'this is a sample text';
	print @plaintext;

	set @ciphertext = EncryptByAsymKey(AsymKey_ID('SampleAKey'), @plaintext);
	print @ciphertext;

	set @plaintext = DecryptByAsymKey(AsymKey_ID('SampleAKey'), @ciphertext, N'Pas45!!~~');
	print @plaintext;


--13. Создать сертификат
	create certificate SampleCert
		encryption by password = N'pa$$W0RD'
		with subject = N'Sample Certificate',
		expiry_date = N'31/10/2024';


--14. Зашифр и расшиф данные при пом. сертификата.
	declare @plain_text nvarchar(58);
	set @plain_text = 'this is certificate encryption text';
	print @plain_text;

	declare @cipher_text nvarchar(256);
	set @cipher_text = EncryptByCert(Cert_ID('SampleCert'), @plain_text);
	print @cipher_text;

	set @plain_text = CAST(DecryptByCert(Cert_ID('SampleCert'), @cipher_text, N'pa$$W0RD') as nvarchar(58));
	print @plain_text;
	

--15. Создать симм. ключ шифрования
	create symmetric key SKey1
	with algorithm = AES_256
	encryption by password = N'PA$$W0RD';

	open symmetric key SKey1
	decryption by password = N'PA$$W0RD';

	create symmetric key SData1
	with algorithm = AES_256
	encryption by symmetric key SKey1;

	open symmetric key SData1
	decryption by symmetric key SKey1;


--16. Зашифр и расшифр данные при пом. ключа
	declare @plain_tex nvarchar(512);
	set @plain_tex = 'open the symmetric key with which to encrypt the data';
	print @plain_tex;

	declare @cipher_tex nvarchar(1024);
	set @cipher_tex = EncryptByKey(Key_GUID('SData'), @plain_tex);
	print @cipher_tex;

	set @plain_tex = CAST(DecryptByKey(@cipher_tex) as nvarchar(512));
	print @plain_tex;

	close symmetric key SData;
	close symmetric key SKey;

--17. Продем. прозрачное шифрование БД
	use master;
	create master key encryption by password = 'p@$$wOrd';
	
	create certificate LabCert1
		with subject = 'certificate to encrypt Lab10 DB ', 
		expiry_date = '31/10/2024';

	
	use SixSemStore;
	create database encryption key
	with algorithm = AES_256
	encryption by server certificate LabCert;
	go

	alter database Sklad
	set encryption on;
	go

	--удалить шифрование из БД
	alter database Sklad 
	set encryption off;
	go


--18. Продем. хеширование (MD2, MD4, MD5, SHA1, SHA2)
	use SixSemStore
	--
	select HashBytes('SHA1', 'open the symmetric key with which to encrypt the data');
	select HashBytes('MD4', 'open the symmetric key with which to encrypt the data');


--19. Продем применение ЭЦП при помощи сертификата.

	--подписывает текст сертификатом и возвращает подпись
	select * from sys. certificates;
	select SIGNBYCERT(258, N'univer', N'pa$$W0RD') as ЭЦП;	--сертификат	
	--0 - изменены, 1 - не изменены
	select VERIFYSIGNEDBYCERT(258, 'univer', 0x0106000000000009010000004D228C4307CD964BC78E7566920B92C179801A42);
	
	select * from sys. asymmetric_keys;
	select SIGNBYASymKey(256, N'univer', N'Pas45!!~~') as ЭЦП;	--ас.ключ
	select VERIFYSIGNEDBYASYMKEY(256, N'univer', 0x0100070204000000B45D0F2E891DFEE693BB65DE9857292DFAB5505C83EBB0488B79401DCEE6A21035DFB60800ABAFC53B0F6DA828F6AFA2F4F2D7D60E2461D2000BC885EDF2B04339567A926E4C2DACC7693E9790B8FE18EDE7F0F434BB676CC3E734EAE7BBE5C20277B29DFA8BAF178FED95E9D2F1BD9911013CB64A2DBEC98E40F20A7CD298E31BE86A657162F388752725D63D0BCEE13B48F4479A80F96956FFEA8C8E8857B774977D8434AA0D4373D87CED499C043C58A4E18920B0FA4B0ED53CAD876BC6FFBB63A10EF865FBD766C0B311ED9515AA59AFA19AA6B90779500F6BAF80420ACE572DEAE942EE363F31302CF5BBF6BA207767ECDC12B46B80F0573ED9044B2658);


--20. Сделать резервную копию необходимых ключей и сертификатов.
	backup certificate SampleCert1
	to file = N'D:\University\Current\DataBase\All\LAB_10\Backup\BackupSampleCert.cer'
		with private key(
			file = N'D:\University\Current\DataBase\All\LAB_10\BackupBackupSampleCert.pvk',
			encryption by password = N'pa$$W0RD',
			decryption by password = N'pa$$W0RD');

	use master;
	BACKUP MASTER KEY TO FILE = 'D:\University\Current\DataBase\All\LAB_10\Backup\BackupMasterKey.key' 
			ENCRYPTION BY PASSWORD = 'p@$$wOrd';

		