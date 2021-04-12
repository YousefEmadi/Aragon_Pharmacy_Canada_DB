-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------


-- Define Tables
-- April 7, 2021
-- Team ZOE

USE aragon
;
GO

/* ----- CUSTOM DATA TYPES  ----- */

DROP TYPE IF EXISTS NV50
;
GO

CREATE TYPE NV50
	FROM NVARCHAR(50)
;
GO

DROP TYPE IF EXISTS ID
;
GO

CREATE TYPE ID
	FROM INT NOT NULL
;
GO

DROP TYPE IF EXISTS DIN
;
GO

CREATE TYPE DIN
	FROM CHAR(8) NOT NULL
;
GO


/* ----- CARE SCHEMA TABLES ----- */

DROP TABLE IF EXISTS care.health_plans;
GO

CREATE TABLE care.health_plans
	(
		plan_id     NV50     NOT NULL,
		plan_name   NV50     NOT NULL,
		address     NV50     NOT NULL,
		city        NV50     NOT NULL,
		province    CHAR(2)  NOT NULL,
		postal_code CHAR(7)  NOT NULL,
		telephone   CHAR(14) NOT NULL,
		days        INT      NOT NULL,
		website     NV50     NULL,
		CONSTRAINT pk_health_plans PRIMARY KEY CLUSTERED (plan_id)
	)
;
GO

DROP TABLE IF EXISTS care.customers;
GO

CREATE TABLE care.customers
	(
		customer_id     ID,
		name_first      NV50          NOT NULL,
		name_last       NV50          NOT NULL,
		telephone       CHAR(14)      NOT NULL,
		date_of_birth   DATE          NOT NULL,
		gender          CHAR(1)       NOT NULL,
		balance         MONEY         NOT NULL,
		child_proof_cap BIT           NOT NULL,
		plan_id         NV50          NULL,
		house_id        INT           NULL,
		house_head      BIT           NULL,
		allergies       NVARCHAR(255) NULL,
		CONSTRAINT pk_customers PRIMARY KEY CLUSTERED (customer_id)
	);
GO

DROP TABLE IF EXISTS care.households;
GO

CREATE TABLE care.households
	(
		house_id    ID,
		address     NV50    NOT NULL,
		city        NV50    NOT NULL,
		province    CHAR(2) NOT NULL,
		postal_code CHAR(7) NOT NULL,
		CONSTRAINT pk_households PRIMARY KEY CLUSTERED (house_id)
	);
GO

DROP TABLE IF EXISTS care.doctors;
GO


CREATE TABLE care.doctors
	(
		doctor_id  ID,
		name_first NV50     NOT NULL,
		name_last  NV50     NOT NULL,
		telephone  CHAR(14) NOT NULL,
		cell       CHAR(14) NOT NULL,
		clinic_id  INT      NULL,
		CONSTRAINT pk_doctors PRIMARY KEY CLUSTERED (doctor_id)
	);
GO

DROP TABLE IF EXISTS care.clinics;
GO

CREATE TABLE care.clinics
	(
		clinic_id   ID,
		clinic_name NV50         NOT NULL,
		address1    NVARCHAR(40) NOT NULL,
		address2    NVARCHAR(40) NULL,
		city        NVARCHAR(40) NOT NULL,
		province    CHAR(2)      NOT NULL,
		postal_code CHAR(7)      NOT NULL,
		telephone   CHAR(14)     NOT NULL,
		CONSTRAINT pk_clinics PRIMARY KEY CLUSTERED (clinic_id)
	);
GO

DROP TABLE IF EXISTS ops.prescriptions
;
GO

/* ----- OPS SCHEMA TABLES ----- */

CREATE TABLE ops.prescriptions
	(
		prescription_id   ID,
		din_id            DIN,
		quantity          FLOAT      NOT NULL,
		unit              VARCHAR(5) NOT NULL,
		date_prescription DATE       NOT NULL,
		date_expiration   DATE       NOT NULL,
		refill            INT        NOT NULL,
		refill_auto       BIT        NOT NULL,
		refill_used       INT        NOT NULL,
		instructions      NV50       NOT NULL,
		customer_id       ID,
		doctor_id         ID,
		CONSTRAINT pk_prescriptions PRIMARY KEY CLUSTERED (prescription_id)
	)
;
GO

DROP TABLE IF EXISTS ops.refills;
GO

CREATE TABLE ops.refills
	(
		prescription_id ID,
		date_refill     DATE,
		employee_id     ID,
		CONSTRAINT pk_refills PRIMARY KEY (prescription_id, date_refill, employee_id)
	);
GO

DROP TABLE IF EXISTS ops.drugs;
GO

CREATE TABLE ops.drugs
	(
		din_id       DIN UNIQUE    NOT NULL,
		name         NV50          NOT NULL,
		generic      BIT           NOT NULL,
		description  NVARCHAR(255) NOT NULL,
		unit         VARCHAR(10)   NOT NULL,
		dosage       FLOAT         NOT NULL,
		dosage_form  NV50          NOT NULL,
		cost         MONEY         NOT NULL,
		price        MONEY         NOT NULL,
		fee          MONEY         NOT NULL,
		interactions NVARCHAR(255) NULL,
		supplier     NV50          NOT NULL,
		CONSTRAINT pk_drugs PRIMARY KEY (din_id)
	);
GO

/* ----- HR SCHEMA TABLES ----- */

DROP TABLE IF EXISTS hr.employees;
GO

CREATE TABLE hr.employees
	(
		employee_id         INT           NOT NULL,
		name_first          NV50          NOT NULL,
		name_middle         CHAR(1)       NULL,
		name_last           NV50          NOT NULL,
		sin                 CHAR(11)      NOT NULL,
		date_of_birth       DATE          NOT NULL,
		date_start          DATE          NOT NULL,
		date_end            DATE          NULL,
		address             NV50          NOT NULL,
		city                NV50          NOT NULL,
		province            CHAR(2)       NOT NULL,
		postal_code         CHAR(7)       NOT NULL,
		job_id              ID,
		memo                NVARCHAR(255) NULL,
		telephone_main      CHAR(14)      NOT NULL,
		telephone_secondary CHAR(14)      NULL,
		income_fixed        MONEY         NULL,
		income_hourly       MONEY         NULL,
		review              DATE          NULL,
		CONSTRAINT pk_employees PRIMARY KEY (employee_id)
	)
;
GO

CREATE TABLE hr.previous_employees
	(
		employee_id         INT           NOT NULL,
		name_first          NV50          NOT NULL,
		name_middle         CHAR(1)       NULL,
		name_last           NV50          NOT NULL,
		sin                 CHAR(11)      NOT NULL,
		date_of_birth       DATE          NOT NULL,
		date_start          DATE          NOT NULL,
		date_end            DATE          NULL,
		address             NV50          NOT NULL,
		city                NV50          NOT NULL,
		province            CHAR(2)       NOT NULL,
		postal_code         CHAR(7)       NOT NULL,
		job_id              ID,
		memo                NVARCHAR(255) NULL,
		telephone_main      CHAR(14)      NOT NULL,
		telephone_secondary CHAR(14)      NULL,
		income_fixed        MONEY         NULL,
		income_hourly       MONEY         NULL,
		review              DATE          NULL,
		CONSTRAINT pk_previous_employees PRIMARY KEY (employee_id)
	)
;
GO

DROP TABLE IF EXISTS hr.job_titles
;
GO


CREATE TABLE hr.job_titles
	(
		job_id ID,
		title  NV50 NOT NULL,
		CONSTRAINT pk_job_titles PRIMARY KEY (job_id)
	)
;
GO

DROP TABLE IF EXISTS hr.training_list
;
GO

CREATE TABLE hr.training_list
	(
		employee_id INT NOT NULL,
		date        DATE,
		class_id    ID,
		CONSTRAINT pk_training_list PRIMARY KEY (employee_id, date, class_id)
	)
;
GO

CREATE TABLE hr.previous_training_list
	(
		employee_id INT NOT NULL,
		date        DATE,
		class_id    ID,
		CONSTRAINT pk_previous_training_list PRIMARY KEY (employee_id, date, class_id)
	)
;
GO

DROP TABLE IF EXISTS hr.training_classes
;
GO

CREATE TABLE hr.training_classes
	(
		class_id    ID,
		description NVARCHAR(255) NOT NULL,
		cost        MONEY         NOT NULL,
		renewal     BIT           NULL,
		required    BIT           NOT NULL,
		provider    NV50          NOT NULL,
		CONSTRAINT pk_training_classes PRIMARY KEY (class_id)
	)
;
GO