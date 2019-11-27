/*Patient Table
view patient table*/
SELECT * FROM patient;

/*new patient*/
INSERT INTO patient(SSN, first_name, last_name, birthdate)
VALUE(:SSN, :first_name,:last_name, :birthdate);

/*delete patient*/
DELETE FROM patient WHERE SSN = :SSN;

/*edit patient*/
UPDATE patient
SET first_name = :first_name, last_name = :last_name, birthdate=birthdate
WHERE SSN = :SSN;

/*Medication Table*/
/*view medication table*/
SELECT * FROM medication;

/*new medication*/
INSERT INTO medication(ID, name, p_safe)
VALUE(:ID, name, p_safe);

/*delete medication*/
DELETE FROM medication WHERE id = :id;

/*edit medication*/
UPDATE medication
SET name = :name, p_safe = :p_safe
WHERE ID = :ID;


/*Doctor Table*/
/*view doctor table*/
SELECT * FROM doctor;

/*new doctor*/
INSERT INTO doctor(ID, first_name, last_name, C_ID)
VALUE(:ID, :first_name,:last_name, :C_ID);

/*delete doctor*/
DELETE FROM doctor WHERE id = :id;

/*edit doctor*/
UPDATE doctor
SET first_name = :first_name, last_name = :last_name, C_ID = :C_ID
WHERE ID = :ID;

/*Clinic Table*/
/*view clinic table*/
SELECT * FROM clinic;

/*new clinic*/
INSERT INTO clinic(ID, address, city, state, zip)
VALUE(:ID, :address, :city, :state, :zip);

/*delete clinic*/
DELETE FROM clinic WHERE id = :id
/*Update foreign C_ID of doctor after deletion*/
UPDATE doctor
SET C_ID = NULL
WHERE C_ID = :ID;

/*edit clinic*/
UPDATE clinic
SET address = :address, city = :city, state = :state, zip = :zip
WHERE ID = :ID;

/*Creates doctor_patient m:m table with IDs and last names for context for User*/
/*Order by SSN: for patient's doctors. Order by: D.ID for doctor's patients*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN prescription_doctor PRES_DOC on PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
ORDER BY SSN;
