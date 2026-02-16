
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

CREATE INDEX idx_country
  ON Country (name ASC);

CREATE INDEX idx_citizenship
  ON Citizenship (person_id ASC, country_id ASC);

CREATE UNIQUE INDEX idx_enrollment
  ON Enrollment (person_id ASC, course_id ASC, role_id ASC);

CREATE INDEX idx+personrole
  ON PersonRole (person_id ASC, role_id ASC);

CREATE INDEX idx_course
  ON Course (name ASC);
