CREATE TABLE patient
(
	SSN int(11) NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	birthdate DATE NOT NULL,
	MED_ID int,
	DOC_ID int,
	PRIMARY KEY (SSN),
	FOREIGN KEY (MED_ID) REFERENCES medication(ID),
	FOREIGN KEY (DOC_ID) REFERENCES doctor(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE medication
(
	ID int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	p_safe tinyint(1) NOT NULL,
	PRIMARY KEY (ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE clinic
(
	ID int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255) NOT NULL,
	address varchar(255) NOT NULL,
	city varchar(255) NOT NULL,
	state varchar(255) NOT NULL,
	zip int(11) NOT NULL,
	PRIMARY KEY (ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE doctor
(
	ID int(11) NOT NULL AUTO_INCREMENT,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	C_ID int(11),
	PRIMARY KEY (ID),
	FOREIGN KEY (C_ID) REFERENCES clinic (ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*The new plan is to generate these tables using data manipulations
eg inner joins so the user can look up a specific patient in the actual site.
These table might be useful in other situations so I'm just commenting
them out for now.
CREATE TABLE patient_medication
(
	P_SSN int(11) NOT NULL,
	M_ID int(11) NOT NULL,
	
	FOREIGN KEY (P_SSN) REFERENCES patient (SSN),
	FOREIGN KEY (M_ID) REFERENCES medication (ID),
	PRIMARY KEY (P_SSN, M_ID)
) ENGINE = InnoDB;

CREATE TABLE doctor_medication
(
	D_ID int(11) NOT NULL,
	M_ID int(11) NOT NULL,
	
	FOREIGN KEY (D_ID) REFERENCES doctor (ID),
	FOREIGN KEY (M_ID) REFERENCES medication (ID),
	PRIMARY KEY (D_ID, M_ID)
) ENGINE = InnoDB;

*/

LOCK TABLES patient WRITE;
INSERT INTO patient(SSN, first_name, last_name, birthdate, MED_ID, DOC_ID) VALUES

(102384662,'John','Johnson','1945-22-03',2,3),
(639284611, 'Ellen', 'Norris', '1934-03-12',8,2),
(934772337,'Victoria','Addams','1963-11-05',7,4),
(733492091,'Caroline','Stevenson','2011-05-01',10,3),
(733492091,'Caroline','Stevenson','2011-05-01',10,4),
(378455109,'Benjamin','Norris','1987-17-08',1,2),
(342265096, 'Peter', 'Jacobs','1993-27-11', 1,8),
(473829476, 'Blake', 'Harrison', '2014-20-04',1,6),
(453261187, 'Haley', 'Mathison', '2001-13-07',6,4),
(342265096, 'Peter', 'Jacobs','1993-27-11', 9,3),
(733492091,'Caroline','Stevenson','2011-05-01',1,2),
(102384662,'John','Johnson','1945-22-03',1,3),
(934772337,'Victoria','Addams','1963-11-05',3,5),
(341285421, 'Harry', 'Whiteside', '1971-03-02',2,3),
(102384662,'John','Johnson','1945-22-03',1,5),
(639284611, 'Ellen', 'Norris', '1934-03-12',8,5),
(934772337,'Victoria','Addams','1963-11-05',6,2),
(733492091,'Caroline','Stevenson','2011-05-01',10,8),
(378455109,'Benjamin','Norris','1987-17-08',1,2),
(255788922,'Emily','Langford','2016-13-06',4,5),
(352846454,'Tom', 'Bleary', '1985-20-10',3,2),
(462846589, 'John', 'Carver', '1967-28-08',2,2),
(102384662,'John','Johnson','1945-22-03',1,4),
(341285421, 'Harry', 'Whiteside', '1971-03-02',6,1),
(364519102, 'Noah', 'McKinley', '1987-14-07',3,9),
(473829476, 'Blake', 'Harrison', '2014-20-04',3,10),
(473829476, 'Blake', 'Harrison', '2014-20-04',2,7),
(524376845, 'Mary', 'Hartford', '1942-18-06',3,8),
(364519102, 'Noah', 'McKinley', '1987-14-07',4,4),
(453261187, 'Haley', 'Mathison', '2001-13-07',6,5),
(341285421, 'Harry', 'Whiteside', '1971-03-02',2,1),
(473829476, 'Blake', 'Harrison', '2014-20-04',7,10),
(524376845, 'Mary', 'Hartford', '1942-18-06',9,8),
(733492091,'Caroline','Stevenson','2011-05-01',10,1),
(378455109,'Benjamin','Norris','1987-17-08',3,6),
(473829476, 'Blake', 'Harrison', '2014-20-04',7,2),
(342265096, 'Peter', 'Jacobs','1993-27-11', 3,3),
(453261187, 'Haley', 'Mathison', '2001-13-07',6,2),
(524376845, 'Mary', 'Hartford', '1942-18-06',3,2),
(453261187, 'Haley', 'Mathison', '2001-13-07',2,7);

UNLOCK TABLES;

LOCK TABLES medication WRITE;
INSERT INTO medication(ID, name, p_safe) VALUES
(1, 'Claritin D', 1),
(2, 'Codeine', 0),
(3, 'Clonazepam', 0),
(4, 'Prozac', 1),
(5, 'Paxil', 0),
(6, 'Ativan', 0),
(7, 'Thalidomide',0),
(8, 'Isotretinoin', 0),
(9, 'Prilosec', 0),
(10, 'Penicilin',1);

UNLOCK TABLES;

LOCK TABLES clinic WRITE;
INSERT INTO clinic(ID, name, address,city,state,zip) VALUES
(1,'Corvallis Family Medicine','2400 NW Kings Blvd','Corvallis','OR',97330),
(2,'Samaritan Ahtletic Medicine Center','840 SW 39th St','Corvallis','OR',97331),
(3,'Albany OB/GYN','705 SW Elm St Suite 200','Albany','OR',97321),
(4,'Philomath Family Medicine, PC','1219 Applegate St','Philomath','OR',97370),
(5,'Valley Clinics Internal Medicine, PC','981 NW Spruce Ave','Corvallis','OR',97330);
UNLOCK TABLES;

LOCK TABLES doctor WRITE;
INSERT INTO doctor(ID, first_name, last_name,C_ID) VALUES
(1,'Carl','Masson',3),
(2,'Jeremy','Johsnon',2),
(3,'Emily','Benson',2),
(4, 'Norman', 'Langley',1),
(5, 'Karen', 'Freeman', 3),
(6, 'John', 'Kenzie', 5),
(7, 'Meredith', 'Baxter', 4),
(8, 'Eva', 'Terrence', 4),
(9, 'Steve', 'Harrison', 2),
(10, 'Kevin', 'Jeremiah', 1);
UNLOCK TABLES;
