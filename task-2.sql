
CREATE TABLE action_types
(
  id   INTEGER NOT NULL,
  name TEXT    NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE actions
(
  id                INTEGER  NOT NULL,
  happened_on       DATETIME NOT NULL,
  -- corresponds to
  action_types_id   INTEGER  NOT NULL,
  -- comes from
  parent_actions_id INTEGER  NULL    ,
  PRIMARY KEY (id),
  FOREIGN KEY (action_types_id) REFERENCES action_types (id),
  FOREIGN KEY (parent_actions_id) REFERENCES actions (id)
);

CREATE TABLE admissions
(
  id               INTEGER  NOT NULL,
  arrival_on       DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  departure_on     DATETIME NULL    ,
  -- received in
  rooms_id         INTEGER  NOT NULL,
  -- arrives to
  patients_id      INTEGER  NOT NULL,
  -- received by
  medical_staff_id INTEGER  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rooms_id) REFERENCES rooms (id),
  FOREIGN KEY (patients_id) REFERENCES patients (id),
  FOREIGN KEY (medical_staff_id) REFERENCES medical_staff (id)
);

CREATE TABLE allowed_actions_per_role
(
  since         DATETIME NOT NULL,
  actions_id    INTEGER  NOT NULL,
  roles_id      INTEGER  NOT NULL,
  allowed_until DATETIME NULL    ,
  PRIMARY KEY (since, actions_id, roles_id),
  FOREIGN KEY (actions_id) REFERENCES actions (id),
  FOREIGN KEY (roles_id) REFERENCES roles (id)
);

CREATE TABLE departments
(
  id   INTEGER NOT NULL,
  name TEXT    NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE diagnosis
(
  id          INTEGER NOT NULL,
  description TEXT    NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES actions (id)
);

CREATE TABLE drugs
(
  id   INTEGER NOT NULL,
  name         NULL     UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE instruments
(
  id         INTEGER  NOT NULL,
  name       TEXT     NULL    ,
  added      DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  expires_on DATETIME NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE instruments_used_for
(
  actions_id     INTEGER  NOT NULL,
  -- done with or required with
  instruments_id INTEGER  NOT NULL,
  used_on        DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  PRIMARY KEY (actions_id),
  FOREIGN KEY (actions_id) REFERENCES actions (id),
  FOREIGN KEY (instruments_id) REFERENCES instruments (id)
);

CREATE TABLE medical_staff
(
  id             INTEGER  NOT NULL,
  departments_id INTEGER  NOT NULL,
  first_name     TEXT     NULL    ,
  middle_name    TEXT     NULL    ,
  last_name      TEXT     NULL    ,
  date_of_birth  DATETIME NULL    ,
  gender         TEXT     NULL    ,
  PRIMARY KEY (id),
  FOREIGN KEY (departments_id) REFERENCES departments (id)
);

CREATE TABLE observations
(
  id    INTEGER NOT NULL,
  notes TEXT    NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES actions (id)
);

CREATE TABLE operations
(
  id   INTEGER NOT NULL,
  name TEXT    NOT NULL UNIQUE,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES actions (id)
);

CREATE TABLE ordained_prescription
(
  medical_staff_id INTEGER NOT NULL,
  drugs_id         INTEGER NOT NULL,
  prescriptions_id INTEGER NOT NULL,
  qte              INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (medical_staff_id, drugs_id, prescriptions_id),
  FOREIGN KEY (medical_staff_id) REFERENCES medical_staff (id),
  FOREIGN KEY (drugs_id) REFERENCES drugs (id),
  FOREIGN KEY (prescriptions_id) REFERENCES prescriptions (id)
);

CREATE TABLE patients
(
  id                INTEGER  NOT NULL,
  first_name        TEXT     NULL    ,
  middle_name       TEXT     NULL    ,
  last_name         TEXT     NULL    ,
  date_of_birth     DATETIME NULL    ,
  gender            TEXT     NULL    ,
  medical_record_no INTEGER  NULL     UNIQUE,
  rooms_id          INTEGER  NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (rooms_id) REFERENCES rooms (id)
);

CREATE TABLE performed_actions
(
  -- as part of
  admissions_id    INTEGER  NOT NULL,
  planned_on       DATETIME NULL    ,
  is_done          INTEGER  NOT NULL DEFAULT 0,
  -- what
  actions_id       INTEGER  NOT NULL,
  -- as
  roles_id         INTEGER  NOT NULL,
  -- from
  medical_staff_id INTEGER  NOT NULL,
  performed_on     DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  -- is done in
  rooms_id         INTEGER  NOT NULL,
  PRIMARY KEY (admissions_id, actions_id, roles_id, medical_staff_id, performed_on, rooms_id),
  FOREIGN KEY (admissions_id) REFERENCES admissions (id),
  FOREIGN KEY (actions_id) REFERENCES actions (id),
  FOREIGN KEY (roles_id) REFERENCES roles (id),
  FOREIGN KEY (medical_staff_id) REFERENCES medical_staff (id),
  FOREIGN KEY (rooms_id) REFERENCES rooms (id)
);

CREATE TABLE plans
(
  creation         DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  initiator_id     INTEGER  NOT NULL,
  patients_id      INTEGER  NOT NULL,
  admissions_id    INTEGER  NOT NULL,
  medical_staff_id INTEGER  NOT NULL,
  PRIMARY KEY (creation, patients_id, admissions_id, medical_staff_id),
  FOREIGN KEY (patients_id) REFERENCES patients (id),
  FOREIGN KEY (admissions_id) REFERENCES admissions (id),
  FOREIGN KEY (medical_staff_id) REFERENCES medical_staff (id)
);

CREATE TABLE prescriptions
(
  id          INTEGER  NOT NULL,
  valid_since DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  valid_until DATETIME NULL    ,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES actions (id)
);

CREATE TABLE roles
(
  id   INTEGER NOT NULL,
  name TEXT    NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE roles_held
(
  held_since       DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  medical_staff_id INTEGER  NOT NULL,
  roles_id         INTEGER  NOT NULL,
  held_until       DATETIME NULL    ,
  PRIMARY KEY (held_since, medical_staff_id, roles_id),
  FOREIGN KEY (medical_staff_id) REFERENCES medical_staff (id),
  FOREIGN KEY (roles_id) REFERENCES roles (id)
);

CREATE TABLE room_types
(
  id   INTEGER NOT NULL,
  name TEXT    NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE rooms
(
  id            INTEGER NOT NULL,
  name          TEXT    NOT NULL,
  room_no       INTEGER NOT NULL,
  floor_no      INTEGER NOT NULL,
  -- is a
  room_types_id INTEGER NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (room_types_id) REFERENCES room_types (id)
);

CREATE UNIQUE INDEX idx_instruments_used_for
  ON instruments_used_for (actions_id ASC, instruments_id ASC);

CREATE INDEX idx_admissions_rooms_id
  ON admissions (rooms_id ASC);

CREATE INDEX idx_admissions_patients_id
  ON admissions (patients_id ASC);

CREATE INDEX idx_admissions_medical_staff_id
  ON admissions (medical_staff_id ASC);

CREATE INDEX idx_plans_patients_id
  ON plans (patients_id ASC);

CREATE INDEX idx_plans_admissions_id
  ON plans (admissions_id ASC);

CREATE INDEX idx_plans_medical_staff_id
  ON plans (medical_staff_id ASC);

CREATE INDEX idx_patients_rooms_id
  ON patients (rooms_id ASC);

CREATE INDEX idx_rooms_types_id
  ON rooms (room_types_id ASC);

CREATE UNIQUE INDEX idx_performed_combined
  ON performed_actions (actions_id ASC, roles_id ASC, medical_staff_id ASC, rooms_id ASC, performed_on ASC, admissions_id ASC);

CREATE INDEX idx_medical_staff_departements_id
  ON medical_staff (departments_id ASC);


CREATE INDEX idx_roles_held_combined
  ON roles_held (roles_id ASC, medical_staff_id ASC, held_since ASC);

CREATE INDEX idx_allowed_actions_per_role_combined
  ON allowed_actions_per_role (since ASC, actions_id ASC, roles_id ASC);

CREATE INDEX idx_actions_types_id
  ON actions (action_types_id ASC);

CREATE INDEX idx_actions_parent_actions_id
  ON actions (parent_actions_id ASC);

CREATE INDEX idx_plans_initiator_id
  ON plans (initiator_id ASC);

CREATE UNIQUE INDEX idx_rooms_uq
  ON rooms (name ASC, room_no ASC, floor_no ASC);
