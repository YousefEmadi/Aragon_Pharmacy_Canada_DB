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


-- Define Database
-- April 7, 2021
-- Team ZOE

/*********** FIND DUPLICATES ***********/

-- Execute SP that displays any duplicates across tables
EXECUTE hr.FindDuplicates2Tables
;
GO

-- Execute SP that displays duplicates within a table
EXECUTE hr.FindDuplicatesSameTable
;
GO


/*********** EMPLOYEE INFORMATION ***********/

-- Query HourlyRateAnalysis View
SELECT *
FROM hr.HourlyRateAnalysisView
ORDER BY Hourly_Wage DESC
;
GO

-- Query SpeakSpanish View
SELECT *
FROM hr.SpeakSpanishView
;
GO

-- Query HourlyRateSummary View
SELECT *
FROM hr.HourlyRateSummaryView
;
GO

-- Query MaxMinAvgHourlyRate View
SELECT *
FROM hr.MaxMinAvgHourlyRateView
;
GO

-- Demonstrate YearsOfService Function
SELECT employee_id, name_first, name_last, hr.YearsOfServiceFN(date_start, GETDATE()) Years_Of_Service
FROM hr.employees
ORDER BY Years_Of_Service DESC
;
GO

-- GetSubstituteList Function
SELECT *
FROM hr.GetSubstituteListFN(5);




/*********** TRAINING CLASSES ************/

-- Query the EmployeeClassesView View
SELECT *
FROM hr.EmployeeClassesView
ORDER BY Employee_Name
;
GO

-- Query the EmployeeClassesDescription View
SELECT *
FROM hr.EmployeeClassesDescriptionView
ORDER BY Employee_Name
;
GO

-- Demonstrate the ClassRenewalFN Function
SELECT *
FROM hr.ClassRenewalFN(3)
;
GO

-- Execute CompanyTrainingStatus SP
EXECUTE hr.CompanyTrainingStatus
;
GO