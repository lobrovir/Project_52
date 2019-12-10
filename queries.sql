

/*The prescription entity is for tying everything together, not for display purposes.
So we will use this code to display an actual prescription*/
/*A nice table giving all the useful information for all prescriptions in order of oldest issue date*/
SELECT M.ID AS 'MED_ID', M.name AS 'Medication', P.SSN, P.last_name AS 'Patient Last', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', PRES.issue_date AS 'Issue Date' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN medication M ON M.ID = PRES.MED_ID
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
ORDER BY PRES.issue_date;

/*Same nice prescription table, but for an inputted SSN, display all of a patient's prescriptions*/
SELECT M.ID AS 'MED_ID', M.name AS 'Medication', P.SSN, P.last_name AS 'Patient Last', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', PRES.issue_date AS 'Issue Date' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN medication M ON M.ID = PRES.MED_ID
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
WHERE P.SSN = '&userInput'
ORDER BY PRES.issue_date;

/*Patient Table
view patient table*/
 SELECT SSN, first_name, last_name, DATE_FORMAT(birthdate, '%m/%d/%Y') AS birthdate
 FROM	patient;

/*new patient*/
INSERT INTO patient(SSN, first_name, last_name, birthdate)
VALUES(?,?,?,?);

/* View a single patient page based on SSN*/
/*Also displays patient's doctors and prescriptions*/
 SELECT SSN, first_name, last_name, DATE_FORMAT(birthdate, '%m/%d/%Y') AS birthdate
 FROM	patient WHERE	SSN = ?;
 
  SELECT doctor.ID, doctor.first_name, doctor.last_name, IfNull(C_ID, 'null') as C_ID,
IfNull(name, 'null') as name, PAT_SSN as SSN
 FROM  doctor
 INNER JOIN	patient_doctor	ON doctor.ID	= patient_doctor.DOC_ID
LEFT JOIN	clinic			ON doctor.C_ID	= clinic.ID
 WHERE patient_doctor.PAT_SSN = ?;
 
 SELECT prescription.ID AS pID,
	DATE_FORMAT(prescription.issue_date, '%m/%d/%Y') AS issue_date,
	IfNull(clinic.name, 'null') as clinic_name,
	IfNull(clinic.ID, 'null') as cID,
	doctor.first_name AS doctor_first_name,
	doctor.last_name AS doctor_last_name,
	doctor.ID AS dID,
	medication.name,
	medication.ID
	FROM	prescription
	INNER JOIN	medication	ON prescription.MED_ID	= medication.ID
	INNER JOIN	doctor		ON prescription.DOC_ID	= doctor.ID
	LEFT JOIN	clinic		ON doctor.C_ID = clinic.ID
	WHERE prescription.PAT_SSN = ?
	ORDER BY prescription.issue_date DESC;

/*delete patient*/
DELETE FROM patient WHERE SSN = ?;

/*delete patient_doctor of specific patient*/
DELETE FROM patient_doctor WHERE PAT_SSN = ? AND DOC_ID = ?;

/*edit patient*/
UPDATE patient
SET first_name = ?, last_name = ?
WHERE SSN = ?;

/*Medication Table*/
/*view medication table*/
SELECT ID, name, CASE WHEN p_safe = 1 THEN 'Yes' ELSE 'No' END AS p_safe
FROM medication;

/*new medication*/
INSERT INTO medication( name, p_safe)
VALUE(?, ?);

/*Displays a single medication page including prescriptions it is a part of*/
SELECT ID, name, CASE WHEN p_safe = 1 THEN 'checked' ELSE '' END AS p_safe
FROM medication WHERE ID = ?;

SELECT prescription.ID AS pID, DATE_FORMAT(prescription.issue_date, '%m/%d/%Y') AS issue_date,
IfNull(clinic.name, 'null') as clinic_name, IfNull(clinic.ID, 'null') as cID,
doctor.first_name AS doctor_first_name, doctor.last_name AS doctor_last_name,
doctor.ID AS dID, patient.first_name, patient.last_name, patient.SSN
FROM		prescription
 INNER JOIN	medication	ON prescription.MED_ID	= medication.ID
 INNER JOIN	patient		ON prescription.PAT_SSN	= patient.SSN
 INNER JOIN	doctor		ON prescription.DOC_ID	= doctor.ID
 LEFT JOIN	clinic		ON doctor.C_ID = clinic.ID
 WHERE medication.ID = ?
 ORDER BY prescription.issue_date DESC;

/*delete medication*/
DELETE FROM medication WHERE ID = ?;

/*edit medication*/
UPDATE medication
SET name = ?, p_safe = ? 
WHERE ID = ?;

/*Doctor Table*/
/*view doctor table*/
 SELECT doctor.ID, first_name, last_name, IfNull(clinic.name, 'null') as name
FROM doctor
 LEFT JOIN clinic ON doctor.C_ID = clinic.ID
 ORDER BY doctor.ID ASC;

SELECT ID, name FROM clinic;

/*new doctor*/
INSERT INTO doctor(first_name, last_name, C_ID)
VALUE(?, ?, ?);

/*delete doctor*/
DELETE FROM doctor WHERE ID = ?;

/*edit doctor*/
UPDATE doctor
SET first_name = ?, last_name = ?, C_ID = ?
WHERE ID = ?;

/*Displays page from doctor ID, includes their patients from patient_doctor*/
/*Also displays the prescriptions they have given*/
SELECT ID, first_name, last_name, IfNull(C_ID, 0) as C_ID
 FROM doctor WHERE ID = ?;

 SELECT	ID, name FROM	clinic;

 SELECT SSN, patient.first_name, patient.last_name, DATE_FORMAT(birthdate, '%m/%d/%Y') AS birthdate, DOC_ID
 FROM patient
 INNER JOIN patient_doctor ON patient.SSN = patient_doctor.PAT_SSN
 WHERE patient_doctor.DOC_ID = ?
 ORDER BY patient.SSN ASC;

 SELECT DISTINCT SSN, patient.first_name, patient.last_name 
 FROM patient WHERE NOT EXISTS (SELECT * FROM patient_doctor
	WHERE patient_doctor.PAT_SSN = patient.SSN AND patient_doctor.DOC_ID = '1' )
ORDER BY patient.first_name ASC

 SELECT	prescription.ID AS pID, DATE_FORMAT(prescription.issue_date, '%m/%d/%Y') AS issue_date,
clinic.name AS clinic_name, clinic.ID AS cID, patient.first_name, patient.last_name, patient.SSN,
medication.name, medication.ID
 FROM prescription
INNER JOIN	medication	ON prescription.MED_ID	= medication.ID
 INNER JOIN	patient		ON prescription.PAT_SSN	= patient.SSN
INNER JOIN	doctor		ON prescription.DOC_ID	= doctor.ID
 LEFT JOIN	clinic		ON doctor.C_ID = clinic.ID
 WHERE prescription.DOC_ID = ?
 ORDER BY prescription.issue_date DESC;
 
 INSERT INTO prescription (issue_date, PAT_SSN, MED_ID, DOC_ID)
VALUES (Now(), ?, ?, ?);

/*display patient_doctor.*/
SELECT * FROM patient_doctor;
/*delete patient_doctor*/
DELETE FROM patient_doctor WHERE PAT_SSN = ? AND DOC_ID = ?;
/*new patient_doctor relationship: */
INSERT INTO patient_doctor (PAT_SSN, DOC_ID) VALUES (?, ?);

/*Clinic Table*/
/*view clinic table*/
SELECT ID, name, address, city, state, zip
FROM clinic;

/*new clinic*/
INSERT INTO clinic(ID, address, city, state, zip)
VALUE(?,?,?,?,?);

/*Page based on a single clinic froma  passed ID*/
/*Also displays the clinic's current doctors and prescriptions*/
SELECT ID, name, address, city, state, zip
FROM clinic
WHERE ID = ?;

 SELECT	doctor.ID, first_name, last_name,
 FROM	doctor
 INNER JOIN clinic ON doctor.C_ID = clinic.ID
 WHERE doctor.C_ID = ?
 ORDER BY doctor.ID ASC;

SELECT prescription.ID AS pID, DATE_FORMAT(prescription.issue_date, '%m/%d/%Y') AS issue_date,
	doctor.first_name AS doctor_first_name, doctor.last_name AS doctor_last_name, doctor.ID AS dID,
patient.first_name, patient.last_name, patient.SSN, medication.name, medication.ID
 FROM prescription
INNER JOIN	medication	ON prescription.MED_ID	= medication.ID
 INNER JOIN	patient		ON prescription.PAT_SSN	= patient.SSN
 INNER JOIN	doctor		ON prescription.DOC_ID	= doctor.ID
 INNER JOIN	clinic		ON doctor.C_ID = clinic.ID
 WHERE doctor.C_ID = ?
 ORDER BY prescription.issue_date DESC;

/*delete clinic*/
DELETE FROM clinic WHERE ID = ?;
/*Update clinic*/
UPDATE clinic
SET name = ?, address = ?, city = ?, state = ?, zip = ?
WHERE ID = ?;

/*Searchbar that uses keyword*/
/*Displays all the prescriptions involved with the keyword*/
/*Then displays any doctors, medications, or patients with the keyword*/
 SELECT DISTINCT prescription.ID AS pID, DATE_FORMAT(issue_date, '%m/%d/%Y') AS issue_date,
IfNull(clinic.name, 'null') AS clinic_name, IfNull(clinic.ID, 'null') AS cID, doctor.first_name AS doctor_first_name,
doctor.last_name AS doctor_last_name, doctor.ID AS dID, SSN, patient.first_name, patient.last_name,
medication.name, medication.ID
FROM patient
 INNER JOIN	prescription	ON patient.SSN			= prescription.PAT_SSN
 INNER JOIN	medication		ON prescription.MED_ID	= medication.ID
 INNER JOIN	doctor			ON prescription.DOC_ID	= doctor.ID
 LEFT JOIN	clinic			ON doctor.C_ID			= clinic.ID
 WHERE prescription.ID LIKE CONCAT('%', ?, '%') OR
SSN LIKE CONCAT('%', ?, '%') OR
patient.first_name LIKE CONCAT('%', ?, '%') OR
patient.last_name LIKE CONCAT('%', ?, '%') OR
birthdate LIKE CONCAT('%', ?, '%') OR
doctor.ID LIKE CONCAT('%', ?, '%') OR
doctor.first_name LIKE CONCAT('%', ?, '%') OR
doctor.last_name LIKE CONCAT('%', ?, '%') OR
C_ID LIKE CONCAT('%', ?, '%') OR
clinic.name LIKE CONCAT('%', ?, '%') OR
medication.ID LIKE CONCAT('%', ?, '%') OR
medication.name LIKE CONCAT('%', ?, '%') OR
p_safe LIKE CONCAT('%', ?, '%')
 ORDER BY issue_date DESC;

SELECT SSN, first_name, last_name, DATE_FORMAT(birthdate, '%m/%d/%Y') AS birthdate
FROM patient  WHERE
SSN LIKE CONCAT('%', ?, '%') OR
patient.first_name LIKE CONCAT('%', ?, '%') OR
patient.last_name LIKE CONCAT('%', ?, '%') OR
birthdate LIKE CONCAT('%', ?, '%');

SELECT doctor.ID, first_name, last_name, IfNull(clinic.name, 'null') AS name
 FROM doctor
LEFT JOIN clinic ON doctor.C_ID = clinic.ID
 WHERE
doctor.ID LIKE CONCAT('%', ?, '%') OR
first_name LIKE CONCAT('%', ?, '%') OR
last_name LIKE CONCAT('%', ?, '%') OR
C_ID LIKE CONCAT('%', ?, '%')
 ORDER BY doctor.ID ASC;

SELECT ID, name, CASE WHEN p_safe = 1 THEN 'Yes' ELSE 'No' END AS p_safe
 FROM medication
 WHERE ID LIKE CONCAT('%', ?, '%') OR
name LIKE CONCAT('%', ?, '%') OR
p_safe LIKE CONCAT('%', ?, '%');

/*Variations of all the tables we may use*/
/*Creates doctor_patient m:m table with IDs and last names for context for User*/
/*Order by SSN: for patient's doctors. Order by: D.ID for doctor's patients*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM patient P
INNER JOIN patient_doctor P_D ON P_D.PAT_SSN = P.SSN
INNER JOIN doctor D ON D.ID = P_D.DOC_ID
ORDER BY SSN;

/*Table:Look up a patient's doctors from user input*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM patient P
INNER JOIN patient_doctor P_D ON P_D.PAT_SSN = P.SSN
INNER JOIN doctor D ON D.ID = P_D.DOC_ID
WHERE P.SSN = '&userInput'
ORDER BY D.ID;

/*Table:Look up a doctor's patients from user input*/
SELECT DISTINCT D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last', P.SSN, P.last_name AS 'Patient Last',  FROM patient P
INNER JOIN patient_doctor P_D ON P_D.PAT_SSN = P.SSN
INNER JOIN doctor D ON D.ID = P_D.DOC_ID
WHERE D.ID = '&userInput'
ORDER BY SSN;

/*Creates a table of all the medications that have been prescribed by doctors in ascending order*/
SELECT PRES.ID AS 'Prescription', M.ID AS 'MED_ID', M.name AS 'Medication', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM medication M
INNER JOIN prescription PRES ON PRES.MED_ID = M.ID
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
ORDER BY PRES.ID;

/*Table: All the prescriptions by an inputted doctor*/
SELECT PRES.ID AS 'Prescription', M.ID AS 'MED_ID', M.name AS 'Medication', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM medication M
INNER JOIN prescription PRES ON PRES.MED_ID = M.ID
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
WHERE D.ID = '&userInput'
ORDER BY PRES.ID;

/*Table: All the doctors that have prescribed a specific medication*/
SELECT PRES.ID AS 'Prescription', M.ID AS 'MED_ID', M.name AS 'Medication', D.ID AS 'DOC_ID', D.last_name AS 'Doctor Last' FROM medication M
INNER JOIN prescription PRES ON PRES.MED_ID = M.ID
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
WHERE M.ID = '&userInput'
ORDER BY PRES.ID;

/*Table: All clinics all the patients go to*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
INNER JOIN clinic C ON C.ID = D.C_ID
ORDER BY SSN;

/*Table: All the clinics an inputted patient goes to*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
INNER JOIN clinic C ON C.ID = D.C_ID
WHERE P.SSN = '&userInput'
ORDER BY C.ID;

/*Table: All the patients at an inputted clinic*/
SELECT DISTINCT P.SSN, P.last_name AS 'Patient Last', C.ID AS 'C_ID', C.name AS 'Clinic Name' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN doctor D ON D.ID = PRES.DOC_ID
INNER JOIN clinic C ON C.ID = D.C_ID
WHERE C.ID = '&userInput'
ORDER BY SSN;

/*Table: Where all the doctors are employed*/
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

/*Table: All the medications an inputted patient has been prescribed*/
SELECT DISTINCT M.ID AS 'MED_ID', M.name AS 'Medication', P.SSN, P.last_name AS 'Patient Last' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN medication M ON M.ID = PRES.MED_ID
WHERE P.SSN = '&userInput'
ORDER BY M.ID;

/*Table: All the patients that have been prescribed an inputted medication.*/
SELECT DISTINCT M.ID AS 'MED_ID', M.name AS 'Medication', P.SSN, P.last_name AS 'Patient Last' FROM patient P
INNER JOIN prescription PRES ON PRES.PAT_SSN = P.SSN
INNER JOIN medication M ON M.ID = PRES.MED_ID
WHERE M.ID = '&userInput'
ORDER BY SSN;

