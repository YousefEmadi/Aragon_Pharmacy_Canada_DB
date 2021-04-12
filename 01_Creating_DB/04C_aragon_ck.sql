-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------



-- Define Checks
-- March 30, 2021
-- Team ZOE

USE aragon
;
GO



/* ----- CARE SCHEMA CHECK CONSTRAINTS ----- */

-- care_1.
ALTER TABLE care.clinics
	ADD CONSTRAINT ck_clinics_phone CHECK
		(telephone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- care_2.
ALTER TABLE care.customers
	ADD CONSTRAINT ck_customers_phone CHECK
		(telephone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- care_3.
ALTER TABLE care.doctors
	ADD CONSTRAINT ck_doctors_phone CHECK
		(telephone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- care_4.
ALTER TABLE care.health_plans
	ADD CONSTRAINT ck_health_plans_phone CHECK
		(telephone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- care_5. postal code and province constraints
ALTER TABLE care.clinics
	ADD CONSTRAINT ck_clinic_postalcode
		CHECK (postal_code LIKE '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'),
		CONSTRAINT ck_clinic_province
			CHECK (province IN ('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'ON', 'PE', 'QC', 'SK', 'NT', 'NU', 'YT')),
		CONSTRAINT df_clinic_postalcode
			DEFAULT 'QC' FOR province,
		CONSTRAINT ck_clinic_telephone CHECK
			(telephone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- care_6.
ALTER TABLE care.health_plans
	ADD CONSTRAINT ck_health_plans_postalcode
		CHECK (postal_code LIKE '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'),
		CONSTRAINT ck_health_plan_province
			CHECK (province IN ('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'ON', 'PE', 'QC', 'SK', 'NT', 'NU', 'YT'))
;
GO

-- care_7.
ALTER TABLE care.households
	ADD CONSTRAINT ck_households_postalcode
		CHECK (postal_code LIKE '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]'),
		CONSTRAINT ck_households_province
			CHECK (province IN ('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'ON', 'PE', 'QC', 'SK', 'NT', 'NU', 'YT'))
;
GO



/* ----- HR SCHEMA CHECK CONSTRAINTS ----- */

-- hr_1.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_employees_main_phone CHECK
		(telephone_main LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- hr_2.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_employees_secondary_phone CHECK
		(telephone_secondary LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
GO

-- hr_3.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_employees_sin
		CHECK (sin LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]')
;
GO

-- hr_4.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_employees_dob
		CHECK (date_of_birth LIKE '[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]')
;
GO

-- hr_5.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_income_fixed_employees CHECK (income_fixed >= 0);
GO

-- hr_6.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_income_hourly_employees CHECK (income_hourly >= 0);
GO

-- hr_7.
ALTER TABLE hr.employees
	ADD CONSTRAINT ck_hire_greater_than_birth_date CHECK (date_start > date_of_birth);
GO





/* ----- OPS SCHEMA CHECK CONSTRAINTS ----- */

-- ops_1.
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT ck_prescription_date
		CHECK (date_prescription LIKE '[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]')
;
GO

-- ops_2.
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT ck_prescription_expiry
		CHECK (date_expiration LIKE '[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]')
;
GO

-- ops_3.
ALTER TABLE care.health_plans
	ADD CONSTRAINT ck_days_health_plans CHECK (days >= 30);
GO

-- ops_4.
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT ck_refill_prescriptions CHECK (refill < 3);
GO

-- ops_5.
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT ck_prescriptions_expirations CHECK (date_prescription > date_expiration);
GO

