-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------

-- Define Database
-- April 7, 2021
-- Team ZOE

-- The master database records all the system-level information for a SQL Server system, including
-- the location of all other database files, and records the initialization information for SQL Server.
-- Therefore, a SQL Server cannot start if the master database is unavailable.
USE master
;
GO

DROP DATABASE IF EXISTS aragon
;
GO

CREATE DATABASE aragon
	ON PRIMARY
	-- When you create a database in Microsoft SQL Server you can have multiple file groups,
	-- where storage is created in multiple directories or disks. Each file group can be named.
	-- The default group is the PRIMARY file, which is always created, and so the SQL you've given
	-- creates your table ON the PRIMARY file group.
	(
		NAME = 'aragon', -- define primary file group
		SIZE = 12 MB, -- define initial size of primary file group
		FILEGROWTH = 8 MB, -- define increment growth of primary file group
		MAXSIZE = 500 MB, -- define database max size for primary file group
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\aragon.mdf' -- define directory for primary file group
		)
	LOG ON
	-- A transaction log is a file, an integral part of every SQL Server database.
	-- It contains log records produced during the logging process in a SQL Server database.
	-- When it comes to disaster recovery, the log is the most important component of a SQL Server database.
	-- After each database modification, a record is made of it to the log. All the changes are written sequentially.
	(
		NAME = 'aragon_log', -- define log file name
		SIZE = 3 MB, -- define initial size of log file.
		FILEGROWTH = 10%, -- define auto growth increment for log file
		MAXSIZE = 25 MB, -- define maximum size of log file
		FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\aragon_log.ldf' -- define the path for the log file
		);
GO

-- generate generic reports

EXECUTE sp_helpdb 'Aragon' -- Reports information about a specified database or all databases.
;
GO

SELECT @@VERSION AS 'sql server version', -- Returns system and build information for the current installation of SQL Server.
       @@SERVERNAME AS 'server name'
;
GO

SELECT USER_NAME() AS 'user name', -- Returns a database user name from a specified identification number.
       DB_NAME() AS 'database name'
;
GO