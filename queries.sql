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

/*Table:Look up a patient's doctors from user input*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN prescription_doctor PRES_DOC on PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
WHERE P.SSN = '&userInput'
ORDER BY D.ID;

/*Table:Look up a doctor's patients from user input*/
SELECT DISTINCT D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', P.SSN, P.last_name AS 'Patient Last',  FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN prescription_doctor PRES_DOC on PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
WHERE D.ID = '&userInput'
ORDER BY SSN;

/*Creates a table of all the medications that have been prescribed by doctors in ascending order*/
SELECT PRES.ID AS 'Prescription', M.ID AS 'MED_ID', M.name AS 'Medication', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM medication M
INNER JOIN prescription PRES ON PRES.MED_ID = M.ID
INNER JOIN prescription_doctor PRES_DOC ON PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
ORDER BY PRES.ID;

/*Table: All the prescriptions by an inputted doctor*/
SELECT PRES.ID AS 'Prescription', M.ID AS 'MED_ID', M.name AS 'Medication', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM medication M
INNER JOIN prescription PRES ON PRES.MED_ID = M.ID
INNER JOIN prescription_doctor PRES_DOC ON PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
WHERE D.ID = '&userInput'
ORDER BY PRES.ID;

/*Table: All the doctors that have prescribed a specific medication*/
SELECT PRES.ID AS 'Prescription', M.ID AS 'MED_ID', M.name AS 'Medication', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM medication M
INNER JOIN prescription PRES ON PRES.MED_ID = M.ID
INNER JOIN prescription_doctor PRES_DOC ON PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
WHERE M.ID = '&userInput'
ORDER BY PRES.ID;

/*Table: All clinics all the patients go to*/

SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN prescription_doctor PRES_DOC on PRES_DOC.PRES_ID = PRES.ID
INNER JOIN doctor D ON D.ID = PRES_DOC.DOC_ID
INNER JOIN clinic C ON C.ID = D.C_ID
ORDER BY SSN;

/*Table: Which clinic all the doctors are employed at*/
SELECT D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM doctor D
INNER JOIN clinic C ON C.ID = D.C_ID
ORDER BY C.ID;

/*Table:The clinic where a doctors works from input*/
SELECT D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM doctor D
INNER JOIN clinic C ON C.ID = D.C_ID
WHERE D.ID = '&userInput'
ORDER BY D.ID;

/*Table: All the doctors employed at an iputted clinic*/
SELECT D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM doctor D
INNER JOIN clinic C ON C.ID = D.C_ID
WHERE C.ID = '&userInput'
ORDER BY D.ID;
