


CREATE TABLE Department(
    DepartmentName VARCHAR(300) PRIMARY KEY,
    BuildingNr INTEGER

);

CREATE TABLE Employee(
    EmployeeID INTEGER NOT NULL PRIMARY KEY,
    PhoneNR INTEGER NOT NULL,
    MentorID VARCHAR(300),
    DepartmentName VARCHAR(300),
    FOREIGN KEY (DepartmentName) REFERENCES Department(DepartmentName),
    FOREIGN KEY (MentorID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Workers(
    DepartmentName VARCHAR(300),
    EmployeeID INTEGER,
    PRIMARY KEY (DepartmentName,EmployeeID),
    StartDate DATE
);



CREATE TABLE NURSE(
    NurseID INTEGER PRIMARY KEY,
    Degree VARCHAR(300),
    FOREIGN KEY (NurseID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Doctor(
    DoctorID INTEGER PRIMARY KEY,
    RoomNr INTEGER,
    Specialization VARCHAR(30)[],
    FOREIGN KEY (DoctorID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Patient(
    PatientID INTEGER PRIMARY KEY,
    AGE INTEGER,
    NAME VARCHAR(30),
    DIAGNOSIS VARCHAR(30000)[],
);

CREATE TABLE Treating (
    DoctorID INTEGER,
    PatientID INTEGER,
    PRIMARY KEY (DoctorID, PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
