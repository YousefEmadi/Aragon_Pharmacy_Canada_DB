-- ------------------------------------------------------------------
-- Aragon Canadian Pharmacy Database Project
-- By: ZOE Team 
-- Team members: Yousef Emadi, Jerome Olivier, Anthony Zampino
-- On: Microsoft SQL Server
-- Date: April 2021
-- ------------------------------------------------------------------



-- Define Foreign Keys
-- April 7, 2021
-- Team ZOE

USE aragon
;
GO


/* ----- OPS SCHEMA FOREIGN KEYS ----- */

-- ops_1. which employee was responsible for the refill?
ALTER TABLE ops.refills
	ADD CONSTRAINT fk_refills_employees
		FOREIGN KEY (employee_id) REFERENCES hr.employees (employee_id)
;
GO

-- ops_2. what drug is being prescribed?
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT fk_prescriptions_drugs
		FOREIGN KEY (din_id) REFERENCES ops.drugs (din_id)
;
GO

-- ops_3. for which customer is this prescription for?
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT fk_prescriptions_clients
		FOREIGN KEY (customer_id) REFERENCES care.customers (customer_id)
;
GO

-- ops_4. which doctor created the prescription?
ALTER TABLE ops.prescriptions
	ADD CONSTRAINT fk_prescriptions_doctors
		FOREIGN KEY (doctor_id) REFERENCES care.doctors (doctor_id)
;
GO

-- ops_5. for which prescription is this refill?
ALTER TABLE ops.refills
	ADD CONSTRAINT fk_refills_prescription
		FOREIGN KEY (prescription_id) REFERENCES ops.prescriptions (prescription_id)
;
GO



/* ----- HR SCHEMA FOREIGN KEYS ----- */

-- hr_1. what is this employee's job title?
ALTER TABLE hr.employees
	ADD CONSTRAINT fk_employees_job_titles
		FOREIGN KEY (job_id) REFERENCES hr.job_titles (job_id)
;
GO

-- hr_2. which employee did which training (joint table)?
ALTER TABLE hr.training_list
	ADD CONSTRAINT fk_training_lists_training_classes
		FOREIGN KEY (class_id) REFERENCES hr.training_classes (class_id)
;
GO

-- hr_3. which classes did each employee take?
ALTER TABLE hr.training_list
	ADD CONSTRAINT fk_training_lists_employees
		FOREIGN KEY (employee_id) REFERENCES hr.employees (employee_id)
;
GO



/* ----- CARE SCHEMA FOREIGN KEYS ----- */

-- care_1. which clinic do these doctors work at?
ALTER TABLE care.doctors
	ADD CONSTRAINT fk_doctors_clinics
		FOREIGN KEY (clinic_id) REFERENCES care.clinics (clinic_id)
;
GO

-- care_2. what health plan does this customer have?
ALTER TABLE care.customers
	ADD CONSTRAINT fk_customers_health_plan
		FOREIGN KEY (plan_id) REFERENCES care.health_plans (plan_id)
;
GO

-- care_3. to which household is this customer a part of?
ALTER TABLE care.customers
	ADD CONSTRAINT fk_customers_households
		FOREIGN KEY (house_id) REFERENCES care.households (house_id)
;
GO