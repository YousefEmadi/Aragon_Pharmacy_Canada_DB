-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------



-- Define Triggers
-- April 7, 2021
-- Team ZOE

USE aragon;
GO

/* CARE SCHEMA */

CREATE OR ALTER TRIGGER tr_clinics_postalcode
    ON care.clinics
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE care.clinics
    SET postal_code = UPPER(CONCAT_WS(' ', SUBSTRING(postal_code, 1, 3), SUBSTRING(postal_code, 4, 3)))
    WHERE clinic_id IN (SELECT clinic_id FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO



CREATE OR ALTER TRIGGER tr_clinics_telephone
    ON care.clinics
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE care.clinics
    SET telephone = CONCAT('(', (SUBSTRING(telephone, 1, 3)), ') ', (SUBSTRING(telephone, 4, 3)), '-',
                           (SUBSTRING(telephone, 7, 4)))
    WHERE clinic_id IN (SELECT clinic_id FROM inserted);
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

-- CREATE OR ALTER TRIGGER tr_customers_telephone
--     ON care.customers
--     AFTER INSERT
--     AS
--     UPDATE care.customers
--     SET telephone = CONCAT('(', (SUBSTRING(telephone, 1, 3)), ') ', (SUBSTRING(telephone, 4, 3)), '-', (SUBSTRING(telephone, 7, 4)))
--     WHERE customer_id IN (SELECT customer_id FROM inserted)
--     ;
-- GO


-- CREATE OR ALTER TRIGGER tr_customers_telephone
--     ON care.customers
--     AFTER INSERT
--     AS
--     UPDATE care.customers
--     SET balance = TRIM('$' FROM )
--     WHERE customer_id IN (SELECT customers.customer_id FROM inserted)
--     ;
-- GO

CREATE OR ALTER TRIGGER tr_doctors_telephone
    ON care.doctors
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE care.doctors
    SET telephone = CONCAT('(', (SUBSTRING(telephone, 1, 3)), ') ', (SUBSTRING(telephone, 4, 3)), '-',
                           (SUBSTRING(telephone, 7, 4)))
    WHERE doctor_id IN (SELECT doctor_id FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

CREATE OR ALTER TRIGGER tr_doctors_cell
    ON care.doctors
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE care.doctors
    SET cell = CONCAT('(', (SUBSTRING(cell, 1, 3)), ') ', (SUBSTRING(cell, 4, 3)), '-', (SUBSTRING(cell, 7, 4)))
    WHERE doctor_id IN (SELECT doctor_id FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

CREATE OR ALTER TRIGGER tr_health_plans_telephone
    ON care.health_plans
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE care.health_plans
    SET telephone = CONCAT('(', (SUBSTRING(telephone, 1, 3)), ') ', (SUBSTRING(telephone, 4, 3)), '-',
                           (SUBSTRING(telephone, 7, 4)))
    WHERE plan_id IN (SELECT plan_id FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

CREATE OR ALTER TRIGGER tr_households_postalcode
    ON care.households
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE care.households
    SET postal_code = UPPER(CONCAT_WS(' ', SUBSTRING(postal_code, 1, 3), SUBSTRING(postal_code, 4, 3)))
    WHERE house_id IN (SELECT house_id FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

/* HR SCHEMA */

/* ----- [hr].[employees] ----- */
DROP TRIGGER IF EXISTS hr.employees_SIN_tr
;
GO
CREATE TRIGGER employees_SIN_tr
    ON [hr].[employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[employees]
    SET sin = CONCAT_WS('-', SUBSTRING(sin, 1, 3), SUBSTRING(sin, 4, 3), SUBSTRING(sin, 7, 3))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.employees_postalcode_tr
;
GO
CREATE TRIGGER employees_postalcode_tr
    ON [hr].[employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[employees]
    SET [postal_code] = UPPER(CONCAT_WS(' ', SUBSTRING(postal_code, 1, 3), SUBSTRING(postal_code, 4, 3)))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.employees_province_tr
;
GO
CREATE TRIGGER employees_province_tr
    ON [hr].[employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[employees]
    SET [province] = UPPER(province)
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.employees_telephone_main_tr
;
GO
CREATE TRIGGER employees_telephone_main_tr
    ON [hr].[employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[employees]
    SET [telephone_main] = CONCAT('(', SUBSTRING(telephone_main, 1, 3), ') ', SUBSTRING(telephone_main, 4, 3), '-',
                                  SUBSTRING(telephone_main, 7, 4))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.employees_telephone_secondary_tr
;
GO
CREATE TRIGGER employees_telephone_secondary_tr
    ON [hr].[employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[employees]
    SET telephone_secondary = CONCAT('(', SUBSTRING(telephone_secondary, 1, 3), ') ',
                                     SUBSTRING(telephone_secondary, 4, 3), '-', SUBSTRING(telephone_secondary, 7, 4))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

-------------------------------------------
/* ----- [hr].[previous_employees] ----- */
-- ----------------------------------------
DROP TRIGGER IF EXISTS hr.previous_employees_SIN_tr
;
GO
CREATE TRIGGER previous_employees_SIN_tr
    ON [hr].[previous_employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[previous_employees]
    SET sin = CONCAT_WS('-', SUBSTRING(sin, 1, 3), SUBSTRING(sin, 4, 3), SUBSTRING(sin, 7, 3))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.previous_employees_postalcode_tr
;
GO
CREATE TRIGGER previous_employees_postalcode_tr
    ON [hr].[previous_employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[previous_employees]
    SET [postal_code] = UPPER(CONCAT_WS(' ', SUBSTRING(postal_code, 1, 3), SUBSTRING(postal_code, 4, 3)))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.previous_employees_province_tr
;
GO
CREATE TRIGGER previous_employees_province_tr
    ON [hr].[previous_employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[previous_employees]
    SET [province] = UPPER(province)
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.previous_employees_telephone_main_tr
;
GO
CREATE TRIGGER previous_employees_telephone_main_tr
    ON [hr].[previous_employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[previous_employees]
    SET [telephone_main] = CONCAT('(', SUBSTRING(telephone_main, 1, 3), ') ', SUBSTRING(telephone_main, 4, 3), '-',
                                  SUBSTRING(telephone_main, 7, 4))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO

DROP TRIGGER IF EXISTS hr.previous_employees_telephone_secondary_tr
;
GO
CREATE TRIGGER previous_employees_telephone_secondary_tr
    ON [hr].[previous_employees]
    AFTER INSERT, UPDATE
    AS
BEGIN
    IF TRIGGER_NESTLEVEL() > 1 RETURN
    UPDATE [hr].[previous_employees]
    SET telephone_secondary = CONCAT('(', SUBSTRING(telephone_secondary, 1, 3), ') ',
                                     SUBSTRING(telephone_secondary, 4, 3), '-', SUBSTRING(telephone_secondary, 7, 4))
    WHERE [employee_id] IN (SELECT [employee_id] FROM inserted)
    IF TRIGGER_NESTLEVEL() > 1 RETURN
END
    ;
GO