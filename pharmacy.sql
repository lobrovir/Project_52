CREATE TABLE patient
(
	SSN int(11) NOT NULL,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	birthdate DATE NOT NULL,
	PRIMARY KEY (SSN)
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
	CONSTRAINT doc_clinic FOREIGN KEY (C_ID) REFERENCES clinic (ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE prescription
(
	ID int(11) NOT NULL AUTO_INCREMENT,
	PAT_SSN int(11) NOT NULL,
	MED_ID int(11) NOT NULL,
	issue_date DATE NOT NULL,
	
	FOREIGN KEY (PAT_SSN) REFERENCES patient (SSN),
	FOREIGN KEY (MED_ID) REFERENCES medication (ID),
	PRIMARY KEY (ID)
) ENGINE = InnoDB;

CREATE TABLE prescription_doctor
(
	PRES_ID int(11) NOT NULL,
	DOC_ID int(11) NOT NULL,
	
	FOREIGN KEY (DOC_ID) REFERENCES doctor (ID),
	FOREIGN KEY (PRES_ID) REFERENCES prescription (ID),
	PRIMARY KEY (PRES_ID, DOC_ID)
) ENGINE = InnoDB;


LOCK TABLES patient WRITE;
INSERT INTO patient(SSN, first_name, last_name, birthdate) VALUES

(102384662,'John','Johnson','1945-22-03'),
(639284611, 'Ellen', 'Norris', '1934-03-12'),
(934772337,'Victoria','Addams','1963-11-05'),
(733492091,'Caroline','Stevenson','2011-05-01'),
(378455109,'Benjamin','Norris','1987-17-08'),
(473829476, 'Blake', 'Harrison', '2014-20-04'),
(341285421, 'Harry', 'Whiteside', '1971-03-02'),
(255788922,'Emily','Langford','2016-13-06'),
(352846454,'Tom', 'Bleary', '1985-20-10'),
(462846589, 'John', 'Carver', '1967-28-08'),
(364519102, 'Noah', 'McKinley', '1987-14-07'),
(342265096, 'Peter', 'Jacobs','1993-27-11'),
(453261187, 'Haley', 'Mathison', '2001-13-07'),
(524376845, 'Mary', 'Hartford', '1942-18-06');

UNLOCK TABLES;

LOCK TABLES prescription WRITE;
INSERT INTO prescription(ID, PAT_SSN, MED_ID) VALUES
(1,102384662,3),
(2,102384662,5),
(3,102384662,5),
(4,102384662,7),
(5,639284611,1),
(6,639284611,2),
(7,639284611,8),
(8,639284611,9),
(9,639284611,9),
(10,934772337,10),
(11,934772337,4),
(12,934772337,6),
(13,934772337,6),
(14,934772337,7),
(15,733492091,4),
(16,733492091,4),
(17,733492091,3),
(18,733492091,2),
(19,378455109,9),
(20,378455109,8),
(21,378455109,2),
(22,473829476,3),
(23,473829476,3),
(24,473829476,5),
(25,473829476,7),
(26,473829476,7),
(27,473829476,2),
(28,341285421,1),
(29,341285421,5),
(30,341285421,10),
(31,341285421,8),
(32,255788922,1),
(33,255788922,1),
(34,255788922,6),
(35,352846454,9),
(36,352846454,9),
(37,352846454,2),
(38,352846454,8),
(39,352846454,7),
(40,462846589,10),
(41,462846589,6),
(42,462846589,4),
(43,364519102,1),
(44,364519102,3),
(45,364519102,5),
(46,364519102,8),
(47,364519102,9),
(48,342265096,2),
(49,342265096,2),
(50,342265096,8),
(51,342265096,10),
(52,342265096,10),
(53,342265096,6),
(54,342265096,5),
(55,453261187,3),
(56,453261187,1),
(57,453261187,7),
(58,453261187,7),
(59,524376845,2),
(60,524376845,4),
(61,524376845,4);
UNLOCK TABLES;

LOCK TABLES prescription_doctor WRITE;
INSERT INTO prescription_doctor(PRES_ID, DOC_ID) VALUES
(1,1),(2,2),(3,5),(4,6),(5,2),(6,4),(7,3),(8,3),(9,5),(10,8),
(11,2),(12,2),(13,4),(14,6),(15,6),(16,4),(17,9),(18,8),(19,9),(20,3),
(21,5),(22,3),(23,4),(24,7),(25,9),(26,9),(27,3),(28,1),(29,6),(30,2),
(31,4),(32,5),(33,7),(34,9),(35,10),(36,3),(37,1),(38,2),(39,7),(40,5),
(41,8),(42,7),(43,8),(44,10),(45,10),(46,5),(47,6),(48,8),(49,2),(50,9),
(51,9),(52,9),(53,10),(54,8),(55,7),(56,7),(57,2),(58,3),(59,4),(60,5),
(61,10);
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
