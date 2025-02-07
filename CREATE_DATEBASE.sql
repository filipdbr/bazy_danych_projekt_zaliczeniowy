-- usuni�cie takiej bazy danych o takiej samej nazwie (je�eli istnieje)
IF EXISTS (SELECT * FROM master..sysdatabases WHERE NAME = 'Wypozyczalnia')
DROP DATABASE Wypozyczalnia;

GO

-- utworznie bazy danych
CREATE DATABASE Wypozyczalnia
ON Primary
(	name = WypozyczalniaData,
	filename = 'C:\baza_danych_wypozyczalnia\data\Wypozyczalnia.mdf',
	size = 20MB,
	maxsize = 100MB,
	filegrowth = 10MB)
LOG ON
(	name = WypozyczalniaLog,
	filename = 'C:\baza_danych_wypozyczalnia\log\Wypozyczalnia.mdf',
	size = 10MB,
	maxsize = 50MB,
	filegrowth = 10MB)


-- Usuni�cie loginu, je�eli istnieje
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'admin_wypozyczalnia')
    DROP LOGIN admin_wypozyczalnia;
GO

-- utworznie loginu na poziomie serwera
CREATE LOGIN admin_wypozyczalnia WITH PASSWORD = '1234';
GO

USE Wypozyczalnia;

GO


-- usuni�cie u�ytkownika je�eli istnieje 
IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'admin_wypozyczalnia')
    DROP USER admin_wypozyczalnia;
GO

-- utworzenie u�ytkownika
CREATE USER admin_wypozyczalnia FOR LOGIN admin_wypozyczalnia;

-- tworz� schematy
GO
CREATE SCHEMA Osoby;
GO
CREATE SCHEMA Sprzet;
GO
CREATE SCHEMA Zamowienia;
GO
CREATE SCHEMA Kategorie;
GO
CREATE SCHEMA Serwis;
GO

-- przydzielenie uprawnie� do schemat�w
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Osoby TO admin_wypozyczalnia;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sprzet TO admin_wypozyczalnia;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Zamowienia TO admin_wypozyczalnia;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Kategorie TO admin_wypozyczalnia;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Serwis TO admin_wypozyczalnia;

-- przydzielenie u�ytkownika admin_wypozyczalnia do roli db_owner
ALTER ROLE db_owner ADD MEMBER admin_wypozyczalnia;
GO
