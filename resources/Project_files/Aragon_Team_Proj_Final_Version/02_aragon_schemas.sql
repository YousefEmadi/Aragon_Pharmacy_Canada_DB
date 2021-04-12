-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------




-- Define Schemas
-- April 7, 2021
-- Team ZOE

-- a schema is a namespace that organizes the structure of a database that acts as a container
-- for tables, views, stored procedures and other objects. Security permissions can also be assigned at the schema level.

USE aragon
;
GO

/* ----- CARE SCHEMA  ----- */

DROP SCHEMA IF EXISTS care
;
GO

CREATE SCHEMA care AUTHORIZATION dbo -- create sales schema
;
GO

/* ----- HR SCHEMA  ----- */

DROP SCHEMA IF EXISTS hr
;
GO

CREATE SCHEMA hr AUTHORIZATION dbo -- create human resources schema
;
GO

/* ----- OPS SCHEMA  ----- */

DROP SCHEMA IF EXISTS ops
;
GO

CREATE SCHEMA ops AUTHORIZATION dbo -- create operations schema
;
GO