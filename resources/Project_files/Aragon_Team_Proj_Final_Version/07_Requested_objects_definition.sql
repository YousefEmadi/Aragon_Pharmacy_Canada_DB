-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------
use aragon
;
go

/*  FIND DUPLICATES OVER TWO TABLES*/
CREATE OR ALTER PROCEDURE hr.FindDuplicates2Tables
AS
BEGIN
    SELECT CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
           COUNT(*) AS                               number_of_duplicates
    FROM hr.employees e
             JOIN hr.previous_employees pe ON e.sin = pe.sin
    GROUP BY e.name_first,
             e.name_last
    ORDER BY Employee_Name
END
    ;
GO

/* FIND DUPLICATES WITHIN SAME TABLE */
CREATE OR
ALTER PROCEDURE hr.FindDuplicatesSameTable
AS
BEGIN
    SELECT CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
           sin,
           COUNT(*)                                  Count
    FROM hr.employees e
    GROUP BY name_last, name_first, sin
    HAVING COUNT(*) > 1
    ORDER BY name_last

    SELECT CONCAT_WS(' ', c.name_first, c.name_last) Customer_Name,
           date_of_birth,
           COUNT(*)                                  Count
    FROM care.customers c
    GROUP BY name_last, name_first, date_of_birth
    HAVING COUNT(*) > 1
    ORDER BY name_last


    SELECT CONCAT_WS(' ', d.name_first, d.name_last) Doctor_Name,
           telephone,
           COUNT(*)                                  Count
    FROM care.doctors d
    GROUP BY name_last, name_first, telephone
    HAVING COUNT(*) > 1
    ORDER BY name_last

END
    ;
GO


/* CREATE VIEWS AND FUNCTION FOR EMPLOYEE INFORMATION*/

-- HourlyRateAnalysisView
CREATE OR ALTER VIEW hr.HourlyRateAnalysisView
AS
SELECT e.employee_id                             Employee_ID,
       CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
       jt.title                                  Job_Title,
       e.income_hourly                           Hourly_Wage
FROM hr.employees e
         JOIN hr.job_titles jt ON jt.job_id = e.job_id
WHERE jt.title IN ('technician', 'cashier');
GO

-- SpeakSpanishView
CREATE OR ALTER VIEW hr.SpeakSpanishView
AS
SELECT employee_id,
       CONCAT_WS(' ', name_first, name_last) Employee_Name,
       memo
FROM hr.employees
WHERE memo LIKE '%spanish%'
;
GO

-- HourlyRateSummaryView
CREATE OR ALTER VIEW hr.HourlyRateSummaryView
AS
SELECT title                           Job_Title,
       CONCAT('$', MIN(income_hourly)) Lowest_Hourly_Wage,
       CONCAT('$', MAX(income_hourly)) Highest_Hourly_Wage
FROM hr.employees e
         JOIN hr.job_titles jt ON jt.job_id = e.job_id
WHERE jt.title IN ('technician', 'cashier')
GROUP BY title
;
GO
-- MaxMinAvgHourlyRateView
CREATE OR ALTER VIEW hr.MaxMinAvgHourlyRateView
AS
SELECT e.job_id,
       CONCAT('$', MIN(income_hourly)) Lowest_Hourly_Wage,
       CONCAT('$', MAX(income_hourly)) Highest_Hourly_Wage,
       CONCAT('$', AVG(income_hourly)) Average_Hourly_Wage
FROM hr.employees e
WHERE e.job_id IN (3, 4)
GROUP BY e.job_id
;
GO


-- YearsOfServiceFN
CREATE OR
ALTER FUNCTION hr.YearsOfServiceFN(
    -- Add the parameters for the function here
    @StartDate datetime,
    @EndDate datetime
)
    RETURNS int
AS
BEGIN
    -- Declare the return variable here
    DECLARE @YearsOfService int

    -- Add the T-SQL statements to compute the return value here
    SELECT @YearsOfService = (DATEDIFF(YEAR, @StartDate, @EndDate));

    -- Return the result of the function
    RETURN @YearsOfService

END
;
GO

-- GetSubstituteListFN
CREATE OR
ALTER FUNCTION hr.GetSubstituteListFN(@job_id INT)
    RETURNS TABLE
        AS
        RETURN
            (
                SELECT name_last,
                       name_first,
                       job_id,
                       telephone_main,
                       telephone_secondary,
                       date_end
                FROM hr.employees
                WHERE job_id = @job_id
            );
GO


/* TRAINING CLASSES VIEWS AND FUNCTIONS*/

-- EmployeeTrainingView
CREATE OR ALTER VIEW hr.EmployeeTrainingView
AS
SELECT CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
       E.employee_id,
       TL.class_id,
       TC.description,
       TL.date,
       TC.renewal,
       TC.required,
       DATEDIFF(DAY, tl.date, GETDATE()) AS      Days_Since_Last_Renewal
FROM hr.employees e
         LEFT JOIN hr.training_list tl ON tl.employee_id = e.employee_id
         LEFT JOIN hr.training_classes tc ON tl.class_id = tc.class_id;
GO


-- EmployeeClassesView
CREATE OR ALTER VIEW hr.EmployeeClassesView
AS
SELECT CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
       TL.date,
       TL.class_id
FROM hr.employees e
         LEFT JOIN hr.training_list tl ON tl.employee_id = e.employee_id
         LEFT JOIN hr.training_classes tc ON tl.class_id = tc.class_id
WHERE TL.class_id IN (1, 2, 3, 5, 6);
GO


-- EmployeeClassesDescriptionView
CREATE OR ALTER VIEW hr.EmployeeClassesDescriptionView
AS
SELECT CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
       tl.date,
       tc.description
FROM hr.employees e
         LEFT JOIN hr.training_list tl ON tl.employee_id = e.employee_id
         LEFT JOIN hr.training_classes tc ON tl.class_id = tc.class_id
WHERE tl.class_id IN (1, 2, 3, 5, 6)
;
GO


CREATE OR
ALTER FUNCTION hr.ClassRenewalFN(
    @ClassID int
)
    RETURNS TABLE
        AS
        RETURN
        SELECT tl.employee_id,
               CONCAT_WS(' ', e.name_first, e.name_last) Employee_Name,
               tl.date,
               tl.class_id,
               DATEDIFF(DAY, tl.date, GETDATE())         Days_Since_Last_Renewal
        FROM hr.training_classes tc
                 JOIN hr.training_list tl
                      ON tc.class_id = tl.class_id
                 JOIN hr.employees e
                      ON e.employee_id = tl.employee_id
        WHERE tc.class_id = @ClassID
          AND DATEDIFF(DAY, tl.date, GETDATE()) > 365
;
GO


CREATE OR ALTER VIEW hr.AllEmployeesMandatoryClassesView
AS
SELECT E.employee_id, E.name_first, E.name_last, TC.class_id, TC.description
FROM hr.employees AS E
         CROSS JOIN hr.training_classes AS TC
WHERE TC.class_id IN (1, 2, 3, 5, 6);
GO


CREATE OR ALTER VIEW hr.ClassesTakenByEmployeesView AS
SELECT TL.employee_id, TL.date, TC.class_id, TC.description
FROM hr.training_list AS TL
         JOIN hr.training_classes AS TC ON TL.class_id = TC.class_id
WHERE TL.class_id IN (1, 2, 3, 5, 6)
;
GO


CREATE OR
ALTER PROCEDURE hr.CompanyTrainingStatus
AS
BEGIN
    SELECT CONCAT_WS(', ', e.name_last, e.name_first)     Employee_Name,
           E.descriptioN,
           'Expired'                                   AS Status,
           COALESCE(CONVERT(NVARCHAR(30), C.DATE), '') AS DATE
    FROM hr.AllEmployeesMandatoryClassesView AS E
             LEFT JOIN hr.ClassesTakenByEmployeesView AS C ON E.employee_id = C.employee_id AND E.class_id = C.class_id
    WHERE DATEDIFF(DAY, c.date, GETDATE()) > 365
      AND c.class_id IN (3, 5, 6)

    UNION

    SELECT CONCAT_WS(', ', f.name_last, f.name_first)     Employee_Name,
           f.descriptioN,
           'Up to date'                                AS Status,
           COALESCE(CONVERT(NVARCHAR(30), C.DATE), '') AS DATE
    FROM hr.AllEmployeesMandatoryClassesView AS f
             LEFT JOIN hr.ClassesTakenByEmployeesView AS C ON f.employee_id = C.employee_id AND f.class_id = C.class_id
    WHERE DATEDIFF(DAY, c.date, GETDATE()) <= 365

    UNION

    SELECT CONCAT_WS(', ', f.name_last, f.name_first)     Employee_Name,
           f.descriptioN,
           'Never Took Class'                          AS Status,
           COALESCE(CONVERT(NVARCHAR(30), C.DATE), '') AS DATE

    FROM hr.AllEmployeesMandatoryClassesView AS f
             LEFT JOIN hr.ClassesTakenByEmployeesView AS C ON f.employee_id = C.employee_id AND f.class_id = C.class_id
    WHERE c.date IS NULL

    UNION

    SELECT CONCAT_WS(', ', f.name_last, f.name_first)     Employee_Name,
           f.descriptioN,
           'Class completed'                           AS Status,
           COALESCE(CONVERT(NVARCHAR(30), C.DATE), '') AS DATE
    FROM hr.AllEmployeesMandatoryClassesView AS f
             LEFT JOIN hr.ClassesTakenByEmployeesView AS C ON f.employee_id = C.employee_id AND f.class_id = C.class_id
    WHERE c.class_id IN (1, 2)
    ORDER BY Employee_Name

END
    ;
GO

/*
BACKUP DATABASE aragon
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup';

*/