-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------



-- Define Unique Values
-- April 7, 2021
-- Team ZOE

USE aragon
;
GO

/* ----- CARE SCHEMA UNIQUE CONSTRAINTS ----- */

-- 01. each household should have a unique address
CREATE UNIQUE INDEX uq_household_address ON care.households (address)
;
GO

-- 02. each clinic should have a unique address
CREATE UNIQUE INDEX uq_clinic_phonenumber ON care.clinics (telephone)
;
GO

-- 03. each doctor needs to have a unique telephone number for emergencies

-- 04. each healthplan company should have a unique website
CREATE UNIQUE INDEX uq_website_health_plans ON care.health_plans (website)
WHERE website IS NOT NULL
;
GO



/* ----- HR SCHEMA UNIQUE CONSTRAINTS ----- */

-- 05. each employee must have a unique social insurance number
CREATE UNIQUE INDEX up_employee_sin ON hr.employees (sin)
;
GO

-- 06. each job position should be unique to avoid redundancies
CREATE UNIQUE INDEX up_job_title ON hr.job_titles (title)
;
GO

-- 07. each employee has a unique social insurance number
ALTER TABLE hr.employees
	ADD CONSTRAINT uq_sin_employees UNIQUE (sin);
GO

