--------------------------- Data definition ---------------------------

CREATE TABLE Citizenship
(
  person_id  INTEGER NOT NULL,
  country_id INTEGER NOT NULL,
  visa       TEXT    NULL    ,
  PRIMARY KEY (person_id, country_id),
  FOREIGN KEY (person_id) REFERENCES Person (id),
  FOREIGN KEY (country_id) REFERENCES Country (id)
);

CREATE TABLE Country
(
  id   INTEGER NOT NULL,
  name TEXT    NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Course
(
  id             INTEGER NOT NULL,
  name           TEXT    NOT NULL,
  ects           INTEGER NOT NULL,
  level          TEXT    NOT NULL,
  is_active      INTEGER NOT NULL DEFAULT 1,
  nationals_only INTEGER NOT NULL DEFAULT 0,
  is_part_time   INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE TABLE Enrollment
(
  person_id INTEGER  NOT NULL,
  course_id INTEGER  NOT NULL,
  role_id   INTEGER  NOT NULL,
  start     DATETIME NOT NULL,
  end       DATETIME NULL    ,
  PRIMARY KEY (person_id, course_id, role_id),
  FOREIGN KEY (person_id) REFERENCES Person (id),
  FOREIGN KEY (course_id) REFERENCES Course (id),
  FOREIGN KEY (role_id) REFERENCES Role (id)
);

CREATE TABLE Person
(
  id            INTEGER NOT NULL,
  firstname     TEXT    NULL    ,
  middlename    TEXT    NULL    ,
  surname       TEXT    NULL    ,
  date_of_birth DATE    NOT NULL,
  joined        DATE    NOT NULL,
  is_actvie     INTEGER NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE PersonAddress
(
  person_id        INTEGER NOT NULL,
  country_id       INTEGER NOT NULL,
  kind             TEXT    NOT NULL DEFAULT "H",
  street           TEXT    NOT NULL,
  postcode         TEXT    NOT NULL,
  number           INTEGER NULL    ,
  alternative_name TEXT    NULL    ,
  PRIMARY KEY (person_id, country_id, kind),
  FOREIGN KEY (person_id) REFERENCES Person (id),
  FOREIGN KEY (country_id) REFERENCES Country (id)
);

CREATE TABLE PersonRole
(
  person_id INTEGER NOT NULL,
  role_id   INTEGER NOT NULL,
  is_main   INTEGER NOT NULL,
  since     DATE    NOT NULL,
  PRIMARY KEY (person_id, role_id),
  FOREIGN KEY (person_id) REFERENCES Person (id),
  FOREIGN KEY (role_id) REFERENCES Role (id)
);

CREATE TABLE Role
(
  id   INTEGER NOT NULL,
  name TEXT    NULL    ,
  PRIMARY KEY (id)
);

CREATE INDEX idx_names
  ON Person (middlename ASC, firstname ASC, surname ASC);

CREATE UNIQUE INDEX idx_country
  ON Country (name ASC);

CREATE INDEX idx_citizenship
  ON Citizenship (person_id ASC, country_id ASC);

CREATE UNIQUE INDEX idx_enrollment
  ON Enrollment (person_id ASC, course_id ASC, role_id ASC);

CREATE INDEX idx+personrole
  ON PersonRole (person_id ASC, role_id ASC);

CREATE UNIQUE INDEX idx_course
  ON Course (name ASC);

CREATE UNIQUE INDEX idx_role
  ON Role (name ASC);

--------------------------- Data manipulation ---------------------------

INSERT INTO Role(name) VALUES("Student");
INSERT INTO Role(name) VALUES("Lecturer");

INSERT INTO Course(name, ects, level) VALUES("Computer Science", 90, "Msc");
INSERT INTO Course(name, ects, level) VALUES("Data science", 90, "Msc");
INSERT INTO Course(name, ects, level) VALUES("Cybersecurity", 90, "Msc");

INSERT INTO Country(name) VALUES("CH");
INSERT INTO Country(name) VALUES("CN");
INSERT INTO Country(name) VALUES("UK");

INSERT INTO Person(id, firstname, middlename, surname, date_of_birth, joined, is_actvie)
VALUES
  (1, "Alice",  "M.", "Johnson",     "1998-05-12", "2024-09-01", 1),
  (2, "Brian",  NULL, "Smith",       "1995-11-23", "2023-02-15", 1),
  (3, "Chen",   NULL, "Wang",        "1999-03-09", "2024-09-01", 1);


INSERT INTO Citizenship(person_id, country_id, visa)
VALUES
  (1, 3, NULL),          
  (2, 3, NULL),          
  (3, 2, "Student Visa"); 

INSERT INTO PersonAddress(person_id, country_id, kind, street, postcode, number, alternative_name)
VALUES
  (1, 3, "H", "Baker Street",    "WC2N 5DU", 221, NULL),
  (2, 3, "H", "King Street",     "W1A 1AA",   10, NULL),
  (3, 3, "H", "Oxford Road",     "M13 9PL",   42, NULL);


INSERT INTO PersonRole(person_id, role_id, is_main, since)
VALUES
  (1, 1, 1, "2024-09-01"), 
  (2, 2, 1, "2023-02-15"),
  (3, 1, 1, "2024-09-01");


INSERT INTO Enrollment(person_id, course_id, role_id, start, end)
VALUES
  (1, 1, 1, "2024-09-01", NULL), 
  (2, 3, 2, "2023-03-01", NULL), 
  (3, 2, 1, "2024-09-01", NULL); 
