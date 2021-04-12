-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------



-- Define Tables
-- March 30, 2021
-- Team ZOE

USE aragon
;
GO

/* ----- CARE SCHEMA INDEXES AND DEFAULTS ----- */

CREATE NONCLUSTERED INDEX ix_customers_name_last
    ON care.customers (name_last)
;
GO



/* ----- OPS SCHEMA INDEXES AND DEFAULTS ----- */

CREATE NONCLUSTERED INDEX ix_drugs_name
    ON ops.drugs (name)
;
GO

ALTER TABLE ops.prescriptions
	ADD CONSTRAINT df_quantity_prescriptions DEFAULT (0) FOR quantity;
GO

ALTER TABLE ops.prescriptions
	ADD CONSTRAINT df_refills_prescriptions DEFAULT (0) FOR refill;
GO



/* ----- HR SCHEMA INDEXES AND DEFAULTS ----- */

ALTER TABLE hr.employees
	ADD CONSTRAINT df_salary_income_fixed DEFAULT (0) FOR income_fixed;
GO

ALTER TABLE hr.employees
	ADD CONSTRAINT df_income_income_hourly DEFAULT (0) FOR income_hourly;
GO



