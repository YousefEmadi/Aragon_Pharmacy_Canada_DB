-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------
-- Insert Data
-- April 7, 2021
-- Team ZOE



-- ************************************************* 
-- ************************************************* 

-- IMPORTANT:
-- use Refined data sample from each Schema in folder:
-- ..//resources/refined_sample_for_inserting_data

-- ************************************************* 
-- ************************************************* 




USE aragon
;
GO

/* CARE SCHEMA */

-- TRUNCATE TABLE care.clinics
BULK INSERT care.clinics
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\care\Clinic.txt'
    WITH (
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
GO

-- TRUNCATE TABLE care.customers
BULK INSERT care.customers
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\care\Customer.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRE_TRIGGERS
    );
GO

-- TRUNCATE TABLE care.doctors
BULK INSERT care.doctors
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\care\Doctor.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRE_TRIGGERS
    );
GO


-- TRUNCATE TABLE care.health_plans
BULK INSERT care.health_plans
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\care\HealthPlan.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRE_TRIGGERS
    );
GO


-- TRUNCATE TABLE care.households
BULK INSERT care.households
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\care\Household.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRE_TRIGGERS
    );
GO


/* OPS SCHEMA */

-- TRUNCATE TABLE ops.drugs
BULK INSERT ops.drugs
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\ops\Drug.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
GO

-- TRUNCATE TABLE ops.refills
BULK INSERT ops.refills
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\ops\Refill.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
GO

-- TRUNCATE TABLE ops.prescriptions
BULK INSERT ops.prescriptions
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\ops\Rx.txt'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
GO


/* HR SCHEMA */

-- TRUNCATE TABLE hr.job_titles
BULK INSERT hr.job_titles
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\hr\JobTitle.txt'
    WITH (
-- 	CHECK_CONSTRAINTS,
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    ROWTERMINATOR = '\n',
    FIELDTERMINATOR = ','
    )
;
GO

-- TRUNCATE TABLE hr.employees
BULK INSERT hr.employees
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\hr\Employee.txt'
    WITH (
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    )
;
GO

-- TRUNCATE TABLE hr.previous_employees
BULK INSERT hr.previous_employees
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\hr\EmployeeHistory.txt'
    WITH (
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
GO

-- TRUNCATE TABLE hr.training_classes
BULK INSERT hr.training_classes
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\hr\Class.txt'
    WITH (
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
GO

-- TRUNCATE TABLE hr.training_list
BULK INSERT hr.training_list
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\hr\EmployeeTraining.txt'
    WITH (
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    ROWTERMINATOR = '\n',
    FIELDTERMINATOR = ','
    );
GO

-- TRUNCATE TABLE hr.previous_training_list
BULK INSERT hr.training_list
    FROM 'C:\Users\Joseph\OneDrive\Desktop\SQL_Server\Aragon Pharmacy Canada\Phase2\Aragon_DB_final_version_by_ZOE_team\resources\refined_sample_for_inserting_data\hr\EmployeeTrainingHistory.txt'
    WITH (
    FIRE_TRIGGERS,
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    )
;
GO