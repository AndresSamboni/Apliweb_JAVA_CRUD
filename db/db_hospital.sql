-- SISTEMA DE GESTIÓN PARA UN HOSPITAL

-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE IF NOT EXISTS db_hospital;
USE db_hospital;

-- CREACIÓN DE LA TABLA DE ROLES PARA EL PERSONAL MÉDICO
CREATE TABLE IF NOT EXISTS tbl_role(
    id_role INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL,
    description TEXT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA DE ESPECIALIDADES PARA EL PERSONAL MÉDICO
CREATE TABLE IF NOT EXISTS tbl_specialty(
    id_specialty INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL,
    description TEXT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA PARA EL PERSONAL MÉDICO
CREATE TABLE IF NOT EXISTS tbl_medical_staff(
    id_medical_staff BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (100) NOT NULL,
    last_name VARCHAR (100) NOT NULL,
    sex ENUM ('F', 'M') NOT NULL,
    birthdate DATE,
    address VARCHAR (200) NOT NULL,
    phone BIGINT NOT NULL,
    email VARCHAR (200) NOT NULL,
    rethus BIGINT NOT NULL,
    contract_start_date DATE NOT NULL,
    contract_end_date DATE,
    id_role INT NOT NULL,
    id_specialty INT,
    FOREIGN KEY (id_role) REFERENCES tbl_role(id_role),
    FOREIGN KEY (id_specialty) REFERENCES tbl_specialty(id_specialty)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA PARA EL CONSULTORIO DEL MÉDICO
CREATE TABLE IF NOT EXISTS tbl_office(
    id_office INT PRIMARY KEY AUTO_INCREMENT,
    state ENUM ('FREE', 'OCCUPIED') NOT NULL,
    id_doctor BIGINT,
    FOREIGN KEY (id_doctor) REFERENCES tbl_medical_staff(id_medical_staff)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA PARA LOS PACIENTES
CREATE TABLE IF NOT EXISTS tbl_patient(
    id_patient VARCHAR (15) PRIMARY KEY,
    name VARCHAR (100) NOT NULL,
    last_name VARCHAR (100) NOT NULL,
    sex ENUM ('F', 'M') NOT NULL,
    birthdate DATE NOT NULL,
    address VARCHAR (200) NOT NULL,
    phone BIGINT NOT NULL,
    email VARCHAR (200) NOT NULL,
    registration_date DATE NOT NULL,
    social_security_number BIGINT,
    name_eps VARCHAR (100) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA PARA LAS CITAS MÉDICAS
CREATE TABLE IF NOT EXISTS tbl_appointment(
    id_appointment INT PRIMARY KEY AUTO_INCREMENT,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR (255) NOT NULL,
    notes TEXT,
    id_patient VARCHAR (15) NOT NULL,
    id_doctor BIGINT NOT NULL,
    FOREIGN KEY (id_patient) REFERENCES tbl_patient(id_patient),
    FOREIGN KEY (id_doctor) REFERENCES tbl_medical_staff(id_medical_staff)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA QUE SE ENCARGA DE LOS TRATAMIENTOS DE LOS PACIENTES
CREATE TABLE IF NOT EXISTS tbl_treatment(
    id_treatment INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR (255) NOT NULL,
    description TEXT,
    id_patient VARCHAR (15) NOT NULL,
    id_doctor BIGINT NOT NULL,
    FOREIGN KEY (id_patient) REFERENCES tbl_patient(id_patient),
    FOREIGN KEY (id_doctor) REFERENCES tbl_medical_staff(id_medical_staff)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA PARA EL HISTORIAL MÉDICO DE LOS PACIENTES
CREATE TABLE IF NOT EXISTS tbl_medical_history(
    id_medical_history INT PRIMARY KEY AUTO_INCREMENT,
    alergies TEXT NOT NULL,
    diseases TEXT NOT NULL,
    surgeries TEXT NOT NULL,
    notes TEXT NOT NULL,
    id_patient VARCHAR (15) NOT NULL,
    FOREIGN KEY (id_patient) REFERENCES tbl_patient(id_patient)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA QUE SE ENCARGA PARA LAS HABITACIONES DE LOS PACIENTES
CREATE TABLE IF NOT EXISTS tbl_room(
    id_room INT PRIMARY KEY AUTO_INCREMENT,
    state ENUM ('FREE', 'OCCUPIED') NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA QUE SE ENCARGA DE LAS HOSPITALIZACIONES DE LOS PACIENTES
CREATE TABLE IF NOT EXISTS tbl_hospitalization(
    id_hospitalization INT PRIMARY KEY AUTO_INCREMENT,
    admission_date DATETIME NOT NULL,
    high_date DATETIME,
    reason TEXT NOT NULL,
    id_patient VARCHAR (15) NOT NULL,
    id_room INT NOT NULL,
    FOREIGN KEY (id_patient) REFERENCES tbl_patient(id_patient),
    FOREIGN KEY (id_room) REFERENCES tbl_room(id_room)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA QUE SE ENCARGA DE LAS MEDICINAS DEL HOSPITAL
CREATE TABLE IF NOT EXISTS tbl_medicine(
    id_medicine INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    recomended_dose VARCHAR (100) NOT NULL,
    side_effects TEXT NOT NULL,
    manufacturer VARCHAR (100)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- CREACIÓN DE LA TABLA QUE SE ENCARGA DE LOS MEDICAMENTOS QUE SE LE SUMINISTRAN A LOS PACIENTES
CREATE TABLE IF NOT EXISTS tbl_ordered_medications(
    dose VARCHAR (100) NOT NULL,
    amount INT NOT NULL,
    id_patient VARCHAR (15) NOT NULL,
    id_doctor BIGINT NOT NULL,
    id_medicine INT NOT NULL,
    FOREIGN KEY (id_patient) REFERENCES tbl_patient(id_patient),
    FOREIGN KEY (id_doctor) REFERENCES tbl_medical_staff(id_medical_staff),
    FOREIGN KEY (id_medicine) REFERENCES tbl_medicine(id_medicine)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;

-- INSERCIÓN DE DATOS DE PRUEBA EN LAS TABLAS DEL SISTEMA DE GESTIÓN PARA UN HOSPITAL

-- Inserción de datos en la tabla de roles
INSERT INTO tbl_role (name, description) VALUES 
('Medico', 'Personal graduado en medicina'),
('Enfermera', 'Personal de enfermería para cuidados generales'),
('Cirujano', 'Especialista en procedimientos quirúrgicos'),
('Pediatra', 'Médico especialista en niños'),
('Cardiólogo', 'Especialista en enfermedades del corazón'),
('Dermatólogo', 'Especialista en enfermedades de la piel'),
('Neurólogo', 'Especialista en enfermedades del sistema nervioso');

-- Inserción de datos en la tabla de especialidades
INSERT INTO tbl_specialty (name, description) VALUES 
('Cardiología', 'Especialidad médica centrada en el corazón y el sistema circulatorio'),
('Dermatología', 'Especialidad médica centrada en la piel'),
('Neurología', 'Especialidad médica centrada en el sistema nervioso'),
('Pediatría', 'Especialidad médica centrada en el cuidado de los niños'),
('Cirugía General', 'Especialidad médica centrada en procedimientos quirúrgicos generales'),
('Ginecología', 'Especialidad médica centrada en el sistema reproductivo femenino'),
('Oncología', 'Especialidad médica centrada en el tratamiento del cáncer');

-- Inserción de datos en la tabla del personal médico
INSERT INTO tbl_medical_staff (name, last_name, sex, birthdate, address, phone, email, rethus, contract_start_date, contract_end_date, id_role, id_specialty) VALUES 
('Carlos', 'Pérez', 'M', '1980-05-12', 'Calle 123 #45-67', 3111234567, 'cperez@mail.com', 1234567890, '2021-01-01', NULL, 1, NULL),
('Ana', 'Gómez', 'F', '1975-10-20', 'Carrera 50 #30-40', 3119876543, 'agomez@mail.com', 1234567891, '2020-02-15', '2022-02-15', 2, NULL),
('Carlos', 'Pérez', 'M', '1980-05-12', 'Calle 123 #45-67', 3111234567, 'cperez@mail.com', 1234567890, '2021-01-01', NULL, 1, NULL),
('Ana', 'Gómez', 'F', '1975-10-20', 'Carrera 50 #30-40', 3119876543, 'agomez@mail.com', 1234567891, '2020-02-15', '2022-02-15', 2, NULL),
('Luis', 'Martínez', 'M', '1982-08-17', 'Calle 12 #34-56', 3112345678, 'lmartinez@mail.com', 1234567892, '2019-05-01', NULL, 3, 1),
('María', 'Lopez', 'F', '1985-01-25', 'Carrera 23 #45-67', 3113456789, 'mlopez@mail.com', 1234567893, '2018-06-20', NULL, 4, 4),
('Jorge', 'Hernández', 'M', '1990-12-10', 'Avenida 78 #12-34', 3114567890, 'jhernandez@mail.com', 1234567894, '2020-03-15', NULL, 5, 2),
('Sofía', 'García', 'F', '1992-03-30', 'Calle 90 #12-56', 3115678901, 'sgarcia@mail.com', 1234567895, '2019-09-10', NULL, 6, 3),
('Diego', 'Ramírez', 'M', '1978-07-22', 'Calle 56 #78-90', 3116789012, 'dramirez@mail.com', 1234567896, '2020-10-25', NULL, 7, 5),
('Laura', 'Jiménez', 'F', '1983-02-15', 'Carrera 45 #67-89', 3117890123, 'ljimenez@mail.com', 1234567897, '2017-12-05', NULL, 1, NULL),
('Pedro', 'Ruiz', 'M', '1986-09-17', 'Calle 23 #12-34', 3118901234, 'pruiz@mail.com', 1234567898, '2016-05-20', NULL, 2, NULL),
('Claudia', 'Ortiz', 'F', '1991-11-11', 'Avenida 34 #45-56', 3119012345, 'cortiz@mail.com', 1234567899, '2020-08-15', NULL, 3, 6),
('Fernando', 'Muñoz', 'M', '1984-06-30', 'Calle 78 #90-12', 3119123456, 'fmunoz@mail.com', 1234567800, '2021-04-10', NULL, 4, 7),
('Daniela', 'Castro', 'F', '1988-04-24', 'Carrera 56 #78-90', 3119234567, 'dcastro@mail.com', 1234567801, '2019-07-01', NULL, 5, 1),
('Juan', 'Mendoza', 'M', '1979-01-05', 'Calle 90 #12-34', 3119345678, 'jmendoza@mail.com', 1234567802, '2018-11-20', NULL, 6, 4),
('Marta', 'Rojas', 'F', '1987-03-29', 'Avenida 12 #34-56', 3119456789, 'mrojas@mail.com', 1234567803, '2019-03-10', NULL, 7, 5),
('Roberto', 'Moreno', 'M', '1981-05-18', 'Calle 45 #67-89', 3119567890, 'rmoreno@mail.com', 1234567804, '2020-01-15', NULL, 1, NULL),
('Sara', 'Gómez', 'F', '1993-10-23', 'Carrera 78 #90-12', 3119678901, 'sgomez@mail.com', 1234567805, '2020-06-30', NULL, 2, NULL),
('Oscar', 'Torres', 'M', '1980-11-12', 'Calle 34 #56-78', 3119789012, 'otorres@mail.com', 1234567806, '2019-12-15', NULL, 3, 2),
('Elena', 'Suárez', 'F', '1982-08-06', 'Avenida 56 #78-90', 3119890123, 'esuarez@mail.com', 1234567807, '2021-07-25', NULL, 4, 3),
('Tomás', 'Gutiérrez', 'M', '1987-05-19', 'Calle 78 #90-12', 3119901234, 'tgutierrez@mail.com', 1234567808, '2020-04-20', NULL, 5, 6),
('Gloria', 'Navarro', 'F', '1986-01-30', 'Carrera 12 #34-56', 3119012345, 'gnavarro@mail.com', 1234567809, '2021-02-10', NULL, 6, 7),
('Luis', 'Cabrera', 'M', '1983-07-25', 'Calle 45 #67-89', 3119123456, 'lcabrera@mail.com', 1234567810, '2020-09-01', NULL, 7, 1),
('Andrea', 'Ríos', 'F', '1992-02-13', 'Avenida 78 #90-12', 3119234567, 'arios@mail.com', 1234567811, '2019-04-15', NULL, 1, NULL),
('Héctor', 'Ortiz', 'M', '1985-09-27', 'Calle 23 #45-67', 3119345678, 'hortiz@mail.com', 1234567812, '2018-02-25', NULL, 2, NULL),
('Paola', 'Salazar', 'F', '1989-11-20', 'Carrera 56 #78-90', 3119456789, 'psalazar@mail.com', 1234567813, '2020-05-30', NULL, 3, 4),
('Santiago', 'Mejía', 'M', '1984-12-14', 'Calle 90 #12-34', 3119567890, 'smejia@mail.com', 1234567814, '2019-08-20', NULL, 4, 5),
('Carolina', 'Zapata', 'F', '1986-06-28', 'Avenida 12 #34-56', 3119678901, 'czapata@mail.com', 1234567815, '2020-11-10', NULL, 5, 1),
('Raúl', 'Vargas', 'M', '1987-04-03', 'Calle 56 #78-90', 3119789012, 'rvargas@mail.com', 1234567816, '2021-03-25', NULL, 6, 6),
('Natalia', 'Cruz', 'F', '1991-05-21', 'Carrera 78 #90-12', 3119890123, 'ncruz@mail.com', 1234567817, '2019-10-15', NULL, 7, 7),
('Gustavo', 'Silva', 'M', '1982-03-07', 'Calle 12 #34-56', 3119901234, 'gsilva@mail.com', 1234567818, '2018-01-30', NULL, 1, NULL),
('Adriana', 'Pardo', 'F', '1984-09-10', 'Avenida 34 #56-78', 3119012345, 'apardo@mail.com', 1234567819, '2020-08-05', NULL, 2, NULL),
('Felipe', 'Acosta', 'M', '1980-11-30', 'Calle 34 #12-56', 3119123456, 'facosta@mail.com', 1234567820, '2019-11-20', NULL, 3, 2);

-- Inserción de datos en la tabla de oficinas
INSERT INTO tbl_office (state, id_doctor) VALUES
('FREE', NULL),
('FREE', NULL),
('FREE', NULL),
('OCCUPIED', 1),
('OCCUPIED', 3),
('OCCUPIED', 4),
('FREE', NULL),
('OCCUPIED', 5),
('OCCUPIED', 6),
('FREE', NULL),
('OCCUPIED', 7),
('OCCUPIED', 9),
('FREE', NULL),
('OCCUPIED', 10),
('OCCUPIED', 11),
('FREE', NULL),
('OCCUPIED', 12),
('OCCUPIED', 13),
('FREE', NULL),
('OCCUPIED', 14),
('OCCUPIED', 16),
('FREE', NULL),
('OCCUPIED', 17),
('OCCUPIED', 18),
('FREE', NULL),
('OCCUPIED', 19),
('OCCUPIED', 20),
('FREE', NULL),
('OCCUPIED', 21),
('OCCUPIED', 22),
('FREE', NULL),
('OCCUPIED', 23),
('OCCUPIED', 25),
('FREE', NULL),
('OCCUPIED', 26),
('OCCUPIED', 27),
('FREE', NULL),
('OCCUPIED', 28),
('OCCUPIED', 29),
('FREE', NULL),
('OCCUPIED', 30),
('OCCUPIED', 31),
('FREE', NULL),
('OCCUPIED', 32),
('OCCUPIED', 33),
('FREE', NULL),
('FREE', NULL),
('FREE', NULL),
('FREE', NULL),
('FREE', NULL),
('FREE', NULL);

-- Inserción de datos en la tabla de pacientes
INSERT INTO tbl_patient (id_patient, name, last_name, sex, birthdate, address, phone, email, registration_date, social_security_number, name_eps) VALUES 
('P001', 'Laura', 'Martínez', 'F', '1990-04-15', 'Calle 45 #23-56', 3101234567, 'lmartinez@mail.com', '2021-03-10', 9876543210, 'EPS A'),
('P002', 'Andrés', 'Lopez', 'M', '1985-11-05', 'Carrera 10 #20-30', 3109876543, 'alopez@mail.com', '2021-05-20', 9876543211, 'EPS B'),
('P003', 'María', 'García', 'F', '1982-07-20', 'Calle 67 #45-78', 3102345678, 'mgarcia@mail.com', '2021-06-05', 9876543212, 'EPS C'),
('P004', 'Juan', 'Hernández', 'M', '1978-09-12', 'Avenida 30 #40-50', 3103456789, 'jhernandez@mail.com', '2021-07-15', 9876543213, 'EPS D'),
('P005', 'Ana', 'Martínez', 'F', '1995-02-28', 'Carrera 50 #60-70', 3104567890, 'amartinez@mail.com', '2021-08-20', 9876543214, 'EPS E'),
('P006', 'Carlos', 'Gómez', 'M', '1980-10-10', 'Calle 12 #34-56', 3105678901, 'cgomez@mail.com', '2021-09-25', 9876543215, 'EPS F'),
('P007', 'Laura', 'Rodríguez', 'F', '1991-05-15', 'Carrera 78 #90-12', 3106789012, 'lrodriguez@mail.com', '2021-10-10', 9876543216, 'EPS G'),
('P008', 'Andrea', 'Pérez', 'F', '1988-03-08', 'Calle 23 #45-67', 3107890123, 'aperez@mail.com', '2021-11-15', 9876543217, 'EPS H'),
('P009', 'David', 'Sánchez', 'M', '1976-12-25', 'Avenida 56 #78-90', 3108901234, 'dsanchez@mail.com', '2021-12-20', 9876543218, 'EPS I'),
('P010', 'Sara', 'Gutiérrez', 'F', '1994-08-20', 'Calle 34 #56-78', 3109012345, 'sgutierrez@mail.com', '2022-01-25', 9876543219, 'EPS J'),
('P011', 'Javier', 'Ramírez', 'M', '1983-11-30', 'Carrera 12 #34-56', 3109123456, 'jramirez@mail.com', '2022-02-10', 9876543220, 'EPS K'),
('P012', 'Elena', 'Suárez', 'F', '1990-09-05', 'Calle 90 #12-34', 3109234567, 'esuarez@mail.com', '2022-03-15', 9876543221, 'EPS L'),
('P013', 'Manuel', 'Torres', 'M', '1979-06-18', 'Avenida 45 #67-89', 3109345678, 'mtorres@mail.com', '2022-04-20', 9876543222, 'EPS M'),
('P014', 'Natalia', 'Cruz', 'F', '1985-04-03', 'Calle 67 #89-12', 3109456789, 'ncruz@mail.com', '2022-05-25', 9876543223, 'EPS N'),
('P015', 'Diego', 'Martínez', 'M', '1996-01-10', 'Carrera 78 #90-12', 3109567890, 'dmartinez@mail.com', '2022-06-10', 9876543224, 'EPS O'),
('P016', 'Laura', 'Herrera', 'F', '1987-07-28', 'Calle 34 #56-78', 3109678901, 'lherrera@mail.com', '2022-07-15', 9876543225, 'EPS P'),
('P017', 'Andrés', 'Gómez', 'M', '1982-02-15', 'Avenida 23 #45-67', 3109789012, 'agomez@mail.com', '2022-08-20', 9876543226, 'EPS Q'),
('P018', 'María', 'Hernández', 'F', '1978-12-20', 'Calle 45 #67-89', 3109890123, 'mhernandez@mail.com', '2022-09-25', 9876543227, 'EPS R'),
('P019', 'Carlos', 'López', 'M', '1993-10-05', 'Carrera 56 #78-90', 3109901234, 'clopez@mail.com', '2022-10-10', 9876543228, 'EPS S'),
('P020', 'Laura', 'González', 'F', '1980-03-15', 'Calle 78 #90-12', 3109012345, 'lgonzalez@mail.com', '2022-11-15', 9876543229, 'EPS T');

-- Inserción de datos en la tabla de citas médicas
INSERT INTO tbl_appointment (appointment_date, reason, notes, id_patient, id_doctor) VALUES 
('2021-06-15 09:00:00', 'Revisión general', 'Paciente sin antecedentes significativos', 'P001', 1),
('2021-07-10 11:00:00', 'Dolor de cabeza recurrente', 'Se recomienda seguimiento neurológico', 'P002', 2),
-- Paciente P001
('2020-01-10 09:00:00', 'Consulta de rutina', 'Todo normal', 'P001', 1), -- Carlos Pérez
('2020-03-15 10:30:00', 'Dolor abdominal', 'Se recomienda ecografía', 'P001', 3), -- Luis Martínez
-- Paciente P002
('2020-02-20 11:00:00', 'Examen físico anual', 'Resultados normales', 'P002', 4), -- María López
('2020-04-25 15:45:00', 'Dolor en el pecho', 'Se solicitan análisis de sangre', 'P002', 5), -- Jorge Hernández
-- Paciente P003
('2020-05-12 08:30:00', 'Control de embarazo', 'Todo en orden', 'P003', 6), -- Sofía García
('2020-06-18 12:15:00', 'Dolor de cabeza crónico', 'Se prescribe tratamiento', 'P003', 7), -- Diego Ramírez
-- Paciente P004
('2020-07-05 14:00:00', 'Consulta de rutina', 'Presión arterial alta', 'P004', 1), -- Carlos Pérez
('2020-08-10 16:30:00', 'Vacunación', 'Vacuna contra la gripe', 'P004', 3), -- Luis Martínez
-- Paciente P005
('2020-09-22 09:45:00', 'Examen físico anual', 'Resultados normales', 'P005', 4), -- María López
('2020-10-28 11:30:00', 'Dolor en el pecho', 'Se recomienda ecocardiograma', 'P005', 5), -- Jorge Hernández
-- Paciente P006
('2020-11-15 13:00:00', 'Control de embarazo', 'Ecografía de seguimiento', 'P006', 6), -- Sofía García
('2020-12-20 15:45:00', 'Dolor de espalda crónico', 'Se recomienda fisioterapia', 'P006', 7), -- Diego Ramírez
-- Paciente P007
('2021-01-08 10:30:00', 'Consulta de rutina', 'Resultados de laboratorio pendientes', 'P007', 1), -- Carlos Pérez
('2021-02-14 12:45:00', 'Vacunación', 'Vacuna contra el tétanos', 'P007', 3), -- Luis Martínez
-- Paciente P008
('2021-03-30 14:15:00', 'Examen físico anual', 'Presión arterial ligeramente elevada', 'P008', 4), -- María López
('2021-04-28 16:30:00', 'Dolor de cabeza recurrente', 'Se prescribe medicación', 'P008', 5), -- Jorge Hernández
-- Paciente P009
('2021-05-10 08:00:00', 'Control de embarazo', 'Ecografía obstétrica', 'P009', 6), -- Sofía García
('2021-06-18 10:45:00', 'Dolor de rodilla', 'Se recomienda radiografía', 'P009', 7), -- Diego Ramírez
-- Paciente P010
('2021-07-20 11:30:00', 'Consulta de rutina', 'Prescripción de vitaminas', 'P010', 1), -- Carlos Pérez
('2021-08-25 13:45:00', 'Vacunación', 'Vacuna contra la hepatitis', 'P010', 3), -- Luis Martínez
-- Paciente P011
('2021-09-15 15:15:00', 'Examen físico anual', 'Análisis de sangre normal', 'P011', 4), -- María López
('2021-10-30 17:30:00', 'Dolor abdominal', 'Se recomienda endoscopia', 'P011', 5), -- Jorge Hernández
-- Paciente P012
('2021-11-10 09:00:00', 'Control de embarazo', 'Ecografía de seguimiento', 'P012', 6), -- Sofía García
('2021-12-18 11:15:00', 'Dolor de cuello', 'Se prescribe tratamiento', 'P012', 7), -- Diego Ramírez
-- Paciente P014
('2022-02-15 14:30:00', 'Control de la diabetes', 'Análisis de glucosa en sangre', 'P014', 1), -- Carlos Pérez
('2022-03-20 16:45:00', 'Vacunación', 'Vacuna contra la influenza', 'P014', 3), -- Luis Martínez
-- Paciente P015
('2022-04-10 10:00:00', 'Examen físico anual', 'Resultados normales', 'P015', 4), -- María López
('2022-05-25 11:30:00', 'Dolor de garganta', 'Se prescribe antibióticos', 'P015', 5), -- Jorge Hernández
-- Paciente P016
('2022-06-18 13:15:00', 'Control de embarazo', 'Ecografía obstétrica', 'P016', 6), -- Sofía García
('2022-07-28 15:45:00', 'Dolor de espalda crónico', 'Se recomienda fisioterapia', 'P016', 7), -- Diego Ramírez
-- Paciente P017
('2022-08-20 08:30:00', 'Consulta de rutina', 'Resultados de laboratorio pendientes', 'P017', 1), -- Carlos Pérez
('2022-09-25 10:45:00', 'Vacunación', 'Vacuna contra el tétanos', 'P017', 3), -- Luis Martínez
-- Paciente P018
('2022-10-15 14:00:00', 'Examen físico anual', 'Presión arterial ligeramente elevada', 'P018', 4), -- María López
('2022-11-28 16:30:00', 'Dolor de cabeza recurrente', 'Se prescribe medicación', 'P018', 5), -- Jorge Hernández
-- Paciente P019
('2022-12-10 08:45:00', 'Control de embarazo', 'Ecografía obstétrica', 'P019', 6), -- Sofía García
('2023-01-18 10:30:00', 'Dolor de rodilla', 'Se recomienda radiografía', 'P019', 7), -- Diego Ramírez
-- Paciente P020
('2023-02-20 11:30:00', 'Consulta de rutina', 'Prescripción de vitaminas', 'P020', 1), -- Carlos Pérez
('2023-03-25 13:45:00', 'Vacunación', 'Vacuna contra la hepatitis', 'P020', 3); -- Luis Martínez


-- Inserción de datos en la tabla de tratamientos
INSERT INTO tbl_treatment (name, description, id_patient, id_doctor) VALUES 
('Fisioterapia para espalda', 'Tratamiento para aliviar el dolor crónico de espalda', 'P006', 7), -- Carlos Gómez con Diego Ramírez
('Tratamiento dermatológico', 'Tratamiento para una condición de la piel', 'P014', 7), -- Natalia Cruz con Diego Ramírez
('Terapia ocupacional', 'Terapia para recuperación de lesiones en la mano', 'P009', 7), -- David Sánchez con Diego Ramírez
('Control de diabetes', 'Tratamiento para controlar los niveles de azúcar en sangre', 'P014', 1), -- Natalia Cruz con Carlos Pérez
('Tratamiento para migraña', 'Tratamiento para reducir la frecuencia y la intensidad de las migrañas', 'P011', 7), -- Javier Ramírez con Diego Ramírez
('Rehabilitación postoperatoria', 'Terapia para recuperación después de una cirugía', 'P002', 2), -- Andrés López con Ana Gómez
('Tratamiento para alergias', 'Tratamiento para controlar las reacciones alérgicas', 'P017', 7), -- Andrés Gómez con Diego Ramírez
('Tratamiento cardiológico', 'Tratamiento para enfermedades del corazón', 'P005', 5), -- Ana Martínez con Jorge Hernández
('Fisioterapia para rodilla', 'Tratamiento para recuperación de lesiones en la rodilla', 'P019', 7), -- Carlos López con Diego Ramírez
('Psicoterapia', 'Terapia para manejar problemas emocionales', 'P020', 7), -- Laura González con Diego Ramírez
('Tratamiento para la hipertensión', 'Tratamiento para reducir la presión arterial alta', 'P007', 1), -- Laura Rodríguez con Carlos Pérez
('Terapia de pareja', 'Terapia para mejorar la comunicación y resolver conflictos en la pareja', 'P012', 7), -- Elena Suárez con Diego Ramírez
('Rehabilitación respiratoria', 'Terapia para mejorar la función pulmonar', 'P015', 5); -- Sara Gutiérrez con Jorge Hernández

-- Inserción de datos en la tabla de historial médico
INSERT INTO tbl_medical_history (alergies, diseases, surgeries, notes, id_patient) VALUES 
('Ninguna', 'Diabetes tipo 2', 'Colecistectomía', 'Controlar la ingesta de azúcar', 'P003'),
('Aspirina', 'Hipertensión', 'Ninguna', 'Controlar la presión arterial regularmente', 'P004'),
('Polen', 'Asma', 'Ninguna', 'Evitar exposición a alérgenos', 'P005'),
('Ninguna', 'Colesterol alto', 'Ninguna', 'Seguir una dieta baja en grasas', 'P006'),
('Ninguna', 'Artritis', 'Ninguna', 'Hacer ejercicios de bajo impacto', 'P007'),
('Ninguna', 'Depresión', 'Ninguna', 'Seguir terapia cognitivo-conductual', 'P008'),
('Ninguna', 'Gastritis', 'Ninguna', 'Evitar alimentos irritantes', 'P009'),
('Ninguna', 'Osteoporosis', 'Ninguna', 'Tomar suplementos de calcio y vitamina D', 'P010'),
('Polen', 'Rinitis alérgica', 'Ninguna', 'Usar antihistamínicos según sea necesario', 'P011'),
('Ninguna', 'Insomnio', 'Ninguna', 'Seguir técnicas de higiene del sueño', 'P012'),
('Ninguna', 'Reflujo gastroesofágico', 'Ninguna', 'Evitar comidas pesadas antes de dormir', 'P013'),
('Ninguna', 'Ansiedad', 'Ninguna', 'Practicar técnicas de relajación', 'P014'),
('Ninguna', 'Dolor crónico de espalda', 'Ninguna', 'Realizar ejercicios de estiramiento', 'P015'),
('Ninguna', 'Dermatitis atópica', 'Ninguna', 'Usar cremas hidratantes regularmente', 'P016'),
('Ninguna', 'Migraña', 'Ninguna', 'Identificar y evitar desencadenantes', 'P017'),
('Ninguna', 'Diabetes tipo 1', 'Ninguna', 'Administrar insulina según lo prescrito', 'P018'),
('Ninguna', 'Hipotiroidismo', 'Ninguna', 'Tomar medicación hormonal diariamente', 'P019'),
('Ninguna', 'Trastorno de pánico', 'Ninguna', 'Realizar terapia cognitivo-conductual', 'P020');

-- Inserción de datos en la tabla de habitaciones
INSERT INTO tbl_room (state) VALUES 
('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), 
('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), 
('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), 
('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), 
('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), 
('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), 
('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), 
('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), 
('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), 
('OCCUPIED'), ('FREE'), ('OCCUPIED'), ('FREE'), ('OCCUPIED');


-- Inserción de datos en la tabla de hospitalizaciones
INSERT INTO tbl_hospitalization (admission_date, high_date, reason, id_patient, id_room) VALUES 
('2021-08-01 14:00:00', NULL, 'Observación por dolor abdominal', 'P001', 1),
('2021-09-10 10:00:00', '2021-09-15 12:00:00', 'Cirugía de rodilla', 'P002', 2),
('2021-10-05 08:30:00', '2021-10-10 10:00:00', 'Tratamiento de neumonía', 'P003', 3),
('2021-11-12 11:15:00', NULL, 'Observación por dolor de pecho', 'P004', 4),
('2021-12-20 09:45:00', '2021-12-25 11:30:00', 'Apéndice inflamado', 'P005', 5),
('2022-01-15 16:00:00', NULL, 'Control postoperatorio', 'P006', 6),
('2022-02-08 13:30:00', NULL, 'Tratamiento de fractura de pierna', 'P007', 7),
('2022-03-25 10:45:00', '2022-03-30 09:00:00', 'Cirugía de vesícula', 'P008', 8),
('2022-04-18 11:00:00', NULL, 'Observación por dolor abdominal', 'P009', 9),
('2022-05-10 14:15:00', NULL, 'Tratamiento de gastroenteritis', 'P010', 10),
('2022-06-22 08:00:00', '2022-06-27 10:30:00', 'Rehabilitación postoperatoria de hombro', 'P011', 11),
('2022-07-17 15:45:00', NULL, 'Observación por mareos frecuentes', 'P012', 12),
('2022-08-30 09:30:00', NULL, 'Tratamiento de infección urinaria', 'P013', 13),
('2022-09-25 12:00:00', '2022-10-01 08:45:00', 'Cirugía de hernia', 'P014', 14),
('2022-10-20 16:30:00', NULL, 'Observación por presión arterial alta', 'P015', 15),
('2022-11-10 14:00:00', NULL, 'Tratamiento de lumbalgia', 'P016', 16),
('2022-12-05 09:15:00', '2022-12-10 11:00:00', 'Apéndice inflamado', 'P017', 17),
('2023-01-20 12:45:00', NULL, 'Control postoperatorio de cadera', 'P018', 18),
('2023-02-15 14:30:00', NULL, 'Tratamiento de gripe severa', 'P019', 19),
('2023-03-10 11:00:00', '2023-03-15 10:15:00', 'Cirugía de nariz', 'P020', 20),
('2023-04-18 10:30:00', NULL, 'Observación por dolor abdominal', 'P001', 21),
('2023-05-25 16:15:00', NULL, 'Tratamiento de gastritis crónica', 'P002', 22),
('2023-06-20 08:45:00', '2023-06-25 12:30:00', 'Rehabilitación postoperatoria de tobillo', 'P003', 23),
('2023-07-15 12:00:00', NULL, 'Observación por dolor de cabeza intenso', 'P004', 24),
('2023-08-28 14:30:00', NULL, 'Tratamiento de infección de garganta', 'P005', 25),
('2023-09-20 09:15:00', '2023-09-25 10:45:00', 'Cirugía de hernia discal', 'P006', 26),
('2023-10-10 15:00:00', NULL, 'Observación por fiebre alta', 'P007', 27);

-- Inserción de datos en la tabla de medicinas
INSERT INTO tbl_medicine (name, description, recomended_dose, side_effects, manufacturer) VALUES 
('Amoxicilina', 'Antibiótico de amplio espectro', '500 mg cada 8 horas', 'Náuseas, diarrea', 'Farmalab'),
('Omeprazol', 'Inhibidor de la bomba de protones', '20 mg una vez al día', 'Dolor de cabeza, diarrea', 'PharmaHealth'),
('Atorvastatina', 'Estatinas para reducir el colesterol', '10 mg una vez al día', 'Dolor muscular, debilidad', 'MediCorp'),
('Loratadina', 'Antihistamínico para alergias', '10 mg una vez al día', 'Somnolencia, sequedad bucal', 'Pharmaceuticals Ltd.'),
('Metformina', 'Hipoglucemiante oral para diabetes tipo 2', '500 mg dos veces al día', 'Náuseas, diarrea', 'BioPharma'),
('Amitriptilina', 'Antidepresivo tricíclico', '25 mg antes de acostarse', 'Sedación, aumento de peso', 'Health Solutions'),
('Warfarina', 'Anticoagulante oral', 'Dosificación variable según INR', 'Sangrado, hematomas', 'PharmaCo'),
('Ciprofloxacino', 'Antibiótico de amplio espectro', '500 mg cada 12 horas', 'Náuseas, diarrea', 'MediGen'),
('Diazepam', 'Ansiolítico y anticonvulsivante', '5 mg dos veces al día', 'Somnolencia, mareos', 'PharmaCare'),
('Enalapril', 'Inhibidor de la enzima convertidora de angiotensina (IECA)', '5 mg una vez al día', 'Tos seca, mareos', 'Health Solutions'),
('Losartán', 'Antagonista del receptor de angiotensina II (ARA II)', '50 mg una vez al día', 'Hipotensión, hiperpotasemia', 'Pharma Inc.'),
('Tramadol', 'Analgésico opioide', '50 mg cada 4-6 horas según necesidad', 'Náuseas, estreñimiento', 'MediCorp'),
('Amlodipino', 'Bloqueador de los canales de calcio', '5 mg una vez al día', 'Edema, hipotensión', 'Pharmaceuticals Ltd.'),
('Furosemida', 'Diurético de asa', '40 mg una vez al día', 'Hipopotasemia, hipotensión', 'BioPharma'),
('Fluoxetina', 'Inhibidor selectivo de la recaptación de serotonina (ISRS)', '20 mg una vez al día', 'Náuseas, insomnio', 'PharmaCo'),
('Digoxina', 'Glicosido cardíaco', '0.125 mg una vez al día', 'Bradicardia, visión borrosa', 'PharmaHealth'),
('Clopidogrel', 'Antiagregante plaquetario', '75 mg una vez al día', 'Hematomas, sangrado', 'Farmalab'),
('Levothyroxine', 'Hormona tiroidea sintética', '50 mcg una vez al día', 'Palpitaciones, pérdida de peso', 'MediGen'),
('Simvastatina', 'Estatinas para reducir el colesterol', '20 mg una vez al día', 'Dolor muscular, debilidad', 'Pharma Inc.'),
('Alprazolam', 'Ansiolítico', '0.25 mg dos veces al día', 'Somnolencia, confusión', 'Health Corp.'),
('Metoprolol', 'Bloqueador beta selectivo', '25 mg dos veces al día', 'Fatiga, mareos', 'PharmaCare'),
('Prednisona', 'Corticosteroide', '5 mg una vez al día', 'Aumento de peso, hipertensión', 'MediCorp'),
('Aspirina', 'Antiinflamatorio no esteroideo (AINE)', '100 mg una vez al día', 'Úlcera péptica, hemorragia gastrointestinal', 'Pharmaceuticals Ltd.'),
('Dipirona', 'Analgésico y antipirético', '500 mg cada 6 horas', 'Reacciones alérgicas, agranulocitosis', 'BioPharma'),
('Clonazepam', 'Antiepiléptico y ansiolítico', '0.5 mg dos veces al día', 'Somnolencia, mareos', 'Pharma Inc.'),
('Ranitidina', 'Antagonista del receptor de histamina H2', '150 mg dos veces al día', 'Cefalea, diarrea', 'Health Solutions'),
('Metronidazol', 'Antibiótico y antiprotozoario', '500 mg cada 8 horas', 'Náuseas, sabor metálico', 'PharmaCo'),
('Tamsulosina', 'Antagonista del receptor alfa-1 adrenérgico', '0.4 mg una vez al día', 'Hipotensión ortostática, eyaculación retrógrada', 'Pharma Inc.'),
('Candesartán', 'Antagonista del receptor de angiotensina II (ARA II)', '8 mg una vez al día', 'Hipotensión, hiperpotasemia', 'MediCorp'),
('Esomeprazol', 'Inhibidor de la bomba de protones', '20 mg una vez al día', 'Dolor abdominal, diarrea', 'Pharmaceuticals Ltd.'),
('Metoclopramida', 'Agonista del receptor de dopamina', '10 mg antes de cada comida', 'Sedación, diarrea', 'PharmaCare'),
('Naproxeno', 'Antiinflamatorio no esteroideo (AINE)', '250 mg cada 12 horas', 'Úlcera péptica, sangrado gastrointestinal', 'Farmalab'),
('Levofloxacino', 'Antibiótico de amplio espectro', '500 mg cada 24 horas', 'Náuseas, diarrea', 'MediGen'),
('Diclofenaco', 'Antiinflamatorio no esteroideo (AINE)', '50 mg tres veces al día', 'Úlcera péptica, sangrado gastrointestinal', 'PharmaHealth'),
('Ceftriaxona', 'Antibiótico de amplio espectro', '1 g una vez al día', 'Diarrea, reacciones alérgicas', 'MediCorp'),
('Clorfenamina', 'Antihistamínico', '4 mg cada 6 horas', 'Sedación, sequedad bucal', 'PharmaCare'),
('Metilprednisolona', 'Corticosteroide', '4 mg una vez al día', 'Retención de líquidos, hipertensión', 'Pharma Inc.'),
('Sildenafil', 'Inhibidor de la fosfodiesterasa tipo 5 (IPDE-5)', '50 mg una hora antes de la actividad sexual', 'Dolor de cabeza, rubor facial', 'Health Corp.'),
('Fluconazol', 'Antifúngico', '150 mg una vez al día', 'Náuseas, dolor abdominal', 'Pharmaceuticals Ltd.'),
('Rosuvastatina', 'Estatinas para reducir el colesterol', '10 mg una vez al día', 'Mialgia, debilidad muscular', 'BioPharma'),
('Citalopram', 'Antidepresivo inhibidor selectivo de la recaptación de serotonina (ISRS)', '20 mg una vez al día', 'Náuseas, insomnio', 'PharmaCo'),
('Hidroclorotiazida', 'Diurético tiazídico', '25 mg una vez al día', 'Hipopotasemia, hiponatremia', 'Health Solutions'),
('Clotrimazol', 'Antifúngico', 'Aplicar en la zona afectada dos veces al día', 'Irritación local, ardor', 'Pharma Inc.'),
('Albuterol', 'Broncodilatador', '2 inhalaciones cada 4-6 horas según necesidad', 'Temblores, taquicardia', 'MediGen'),
('Azelastina', 'Antihistamínico', 'Una pulverización en cada fosa nasal dos veces al día', 'Irritación nasal, cefalea', 'PharmaHealth'),
('Carbamazepina', 'Antiepiléptico y estabilizador del estado de ánimo', '200 mg dos veces al día', 'Sedación, mareos', 'Farmalab'),
('Budesonida', 'Corticosteroide inhalado', 'Dosificación variable según la gravedad del asma', 'Riesgo de candidiasis oral, tos', 'PharmaCare'),
('Fenitoína', 'Antiepiléptico', '300 mg una vez al día', 'Náuseas, vértigo', 'Pharma Inc.'),
('Acetaminofén', 'Analgésico y antipirético', '500 mg cada 6 horas', 'Reacciones alérgicas, problemas hepáticos', 'Health Corp.'),
('Dexametasona', 'Corticosteroide', '4 mg una vez al día', 'Aumento de peso, hipertensión', 'PharmaCo'),
('Duloxetina', 'Antidepresivo inhibidor de la recaptación de serotonina y noradrenalina (IRSN)', '60 mg una vez al día', 'Náuseas, insomnio', 'MediCorp'),
('Aripiprazol', 'Antipsicótico atípico', '10 mg una vez al día', 'Somnolencia, aumento de peso', 'Pharmaceuticals Ltd.'),
('Naproxeno', 'Antiinflamatorio no esteroideo (AINE)', '500 mg cada 12 horas', 'Úlcera péptica, sangrado gastrointestinal', 'BioPharma'),
('Montelukast', 'Antagonista del receptor de leucotrienos', '10 mg una vez al día', 'Dolor de cabeza, somnolencia', 'PharmaCare'),
('Amoxicilina/Ácido clavulánico', 'Antibiótico de amplio espectro', '875/125 mg cada 12 horas', 'Náuseas, diarrea', 'Health Solutions'),
('Pantoprazol', 'Inhibidor de la bomba de protones', '40 mg una vez al día', 'Dolor abdominal, diarrea', 'Pharma Inc.'),
('Levetiracetam', 'Antiepiléptico', '500 mg dos veces al día', 'Somnolencia, mareos', 'PharmaHealth'),
('Ciprofloxacino', 'Antibiótico de amplio espectro', '500 mg cada 12 horas', 'Náuseas, diarrea', 'MediGen'),
('Levothyroxine', 'Hormona tiroidea sintética', '50 mcg una vez al día', 'Palpitaciones, pérdida de peso', 'PharmaCorp'),
('Ibuprofeno', 'Antiinflamatorio no esteroideo (AINE)', '400 mg cada 6 horas', 'Úlcera péptica, sangrado gastrointestinal', 'PharmaHealth'),
('Paracetamol', 'Analgésico y antipirético', '500 mg cada 4-6 horas según necesidad', 'Reacciones alérgicas, problemas hepáticos', 'MediCorp'),
('Omeprazol', 'Inhibidor de la bomba de protones', '20 mg una vez al día', 'Dolor de cabeza, diarrea', 'Pharma Inc.'),
('Amoxicilina', 'Antibiótico de amplio espectro', '500 mg cada 8 horas', 'Náuseas, diarrea', 'PharmaHealth'),
('Omeprazol', 'Inhibidor de la bomba de protones', '20 mg una vez al día', 'Dolor de cabeza, diarrea', 'Pharma Inc.'),
('Atorvastatina', 'Estatinas para reducir el colesterol', '10 mg una vez al día', 'Dolor muscular, debilidad', 'MediCorp');

-- Inserción de datos en la tabla de medicamentos formulados (continuación)
INSERT INTO tbl_ordered_medications (dose, amount, id_patient, id_doctor, id_medicine) VALUES 
('500 mg', 10, 'P003', 3, 3),
('20 mg', 15, 'P004', 4, 4),
('10 mg', 30, 'P005', 5, 5),
('500 mg', 20, 'P006', 6, 6),
('10 mg', 30, 'P007', 7, 7),
('50 mg', 20, 'P008', 8, 8),
('500 mg', 15, 'P009', 9, 9),
('5 mg', 10, 'P010', 10, 10),
('20 mg', 25, 'P011', 11, 11),
('50 mg', 20, 'P012', 12, 12),
('5 mg', 30, 'P013', 13, 13),
('20 mg', 15, 'P014', 14, 14),
('500 mg', 20, 'P015', 15, 15),
('50 mg', 10, 'P016', 16, 16),
('10 mg', 20, 'P017', 17, 17),
('20 mg', 15, 'P018', 18, 18),
('10 mg', 25, 'P019', 19, 19),
('500 mg', 10, 'P020', 20, 20),
('20 mg', 30, 'P001', 31, 31),
('20 mg', 20, 'P002', 32, 32),
('500 mg', 15, 'P003', 33, 33),
('500 mg', 25, 'P009', 9, 49),
('20 mg', 15, 'P005', 5, 50);
