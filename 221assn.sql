DROP TABLE ATTENDENCE;
DROP TABLE OVERTIME;
DROP TABLE LEAVE_APPLICATION;
DROP TABLE EMPLOYEE_HOLIDAY;
DROP TABLE APPLIED_LEAVE;
DROP TABLE HOLIDAY;

DROP TABLE EMPLOYEE_TRAINING;
DROP TABLE EMPLOYEE_PROJECT;
DROP TABLE TRAINING;
DROP TABLE COMPLETED_PROJECT;
DROP TABLE TRAINING_TYPE;
DROP TABLE PROJECT_TYPE;

DROP TABLE PAYSLIP_ALLOWANCE;
DROP TABLE PAYSLIP_INCENTIVE;
DROP TABLE PAYSLIP_DEDUCTION;
DROP TABLE ALLOWANCE;
DROP TABLE INCENTIVE;
DROP TABLE DEDUCTION;
DROP TABLE PAYSLIP;

DROP TABLE EMPLOYEE_SKILL;
DROP TABLE EMPLOYEE_PROLANG;
DROP TABLE EMPLOYEE;
DROP TABLE BANK;
DROP TABLE EMPLOYEE_STATUS;
DROP TABLE EMPLOYEE_POSITION;
DROP TABLE DEPARTMENT;
DROP TABLE QUALIFICATION;
DROP TABLE SKILL;
DROP TABLE PROGRAMMING_LANGUAGE;

CREATE TABLE Bank (
    Bank_id VARCHAR2(10) PRIMARY KEY,
    Bank_name VARCHAR2(30) NOT NULL
);
--PREDEFINED BANK
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('MBBE','Maybank');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('CIBB','CIMB BANK');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('CITI','CITIBANK');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('PBBE','PUBLIC BANK BERHAD');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('RHBB','RHB BANK BERHAD');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('HLBB','HONG LEONG BANK BERHAD');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('ARBK','AMBANK');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('BKRM','BANK RAKYAT');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('UOVB','UNITED OVERSEAS BANK');
INSERT INTO BANK (BANK_ID,BANK_NAME) VALUES ('BSNA','BANK SIMPANAN NASIONAL BERHAD');
COMMIT;

CREATE TABLE EMPLOYEE_STATUS(
    STATUS_ID VARCHAR2(10) PRIMARY KEY,
    STATUS_NAME VARCHAR2(30) NOT NULL
);
--PREDEFINED EMPLOYEE STATUS
INSERT INTO EMPLOYEE_STATUS (STATUS_ID,STATUS_NAME) VALUES ('S01','ACTIVE');
INSERT INTO EMPLOYEE_STATUS (STATUS_ID,STATUS_NAME) VALUES ('S02','LONG LEAVE');
INSERT INTO EMPLOYEE_STATUS (STATUS_ID,STATUS_NAME) VALUES ('S03','RETIRE');
INSERT INTO EMPLOYEE_STATUS (STATUS_ID,STATUS_NAME) VALUES ('S04','LEFT COMPANY');
INSERT INTO EMPLOYEE_STATUS (STATUS_ID,STATUS_NAME) VALUES ('S05','MEDICAL LEAVE');

CREATE TABLE EMPLOYEE_POSITION(
    POSITION_ID VARCHAR2(10) PRIMARY KEY,
    POSITION_NAME VARCHAR2(30) NOT NULL,
    POSITION_BASIC_SALARY NUMBER NOT NULL
);
--PREDEFINED EMPLOYEE POSITION
INSERT INTO EMPLOYEE_POSITION (POSITION_ID, POSITION_NAME,POSITION_BASIC_SALARY) VALUES ('P001', 'CEO',12000);
INSERT INTO EMPLOYEE_POSITION (POSITION_ID, POSITION_NAME,POSITION_BASIC_SALARY) VALUES ('P002', 'Manager',5000);
INSERT INTO EMPLOYEE_POSITION (POSITION_ID, POSITION_NAME,POSITION_BASIC_SALARY) VALUES ('P003', 'Software Engineer',5000);
INSERT INTO EMPLOYEE_POSITION (POSITION_ID, POSITION_NAME,POSITION_BASIC_SALARY) VALUES ('P004', 'Technical Specialist',4000);
INSERT INTO EMPLOYEE_POSITION (POSITION_ID, POSITION_NAME,POSITION_BASIC_SALARY) VALUES ('P005', 'Application Developer',4000);
COMMIT;

CREATE TABLE DEPARTMENT(
    department_id VARCHAR2(10) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(30) NOT NULL
);
--PREDEFINED DEPARTMENT
INSERT INTO DEPARTMENT (department_id,DEPARTMENT_NAME) VALUES ('D00','ADMINISTRATION');
INSERT INTO DEPARTMENT (department_id,DEPARTMENT_NAME) VALUES ('D01','R&D');
INSERT INTO DEPARTMENT (department_id,DEPARTMENT_NAME) VALUES ('D02','TESTING');
INSERT INTO DEPARTMENT (department_id,DEPARTMENT_NAME) VALUES ('D03','FINANCE');
INSERT INTO DEPARTMENT (department_id,DEPARTMENT_NAME) VALUES ('D04','TECHNICAL SUPPORT');
INSERT INTO DEPARTMENT (department_id,DEPARTMENT_NAME) VALUES ('D05','HR');
COMMIT;

CREATE TABLE QUALIFICATION(
    QUALIFICATION_ID VARCHAR2(10) PRIMARY KEY,
    QUALIFICATION_NAME VARCHAR2(30) NOT NULL
);

CREATE TABLE SKILL(
    SKILL_ID VARCHAR2(10) PRIMARY KEY,
    SKILL_NAME VARCHAR2(30) NOT NULL
);

CREATE TABLE PROGRAMMING_LANGUAGE(
    PROLANG_ID VARCHAR2(10) PRIMARY KEY,
    PROLANG_NAME VARCHAR2(50) NOT NULL,
    PROLANG_TYPE VARCHAR2(25)
);

CREATE TABLE EMPLOYEE(
    EMPLOYEE_ID VARCHAR2(10) PRIMARY KEY,
    QUALIFICATION_ID VARCHAR2(10),
    STATUS_ID VARCHAR2(10),
    POSITION_ID VARCHAR2(10),
    department_id VARCHAR2(10),
    Bank_id VARCHAR2(10),
    BANK_NUMBER INTEGER,
    EMP_FNAME VARCHAR2(20) NOT NULL,
    EMP_LNAME VARCHAR2(20) NOT NULL,
    EMAIL_ADDRESS VARCHAR2(50),
    PHONE_NUM INTEGER,
    CONSTRAINT EMP_QUALI_ID_FK FOREIGN KEY (QUALIFICATION_ID) REFERENCES QUALIFICATION(QUALIFICATION_ID),
    CONSTRAINT EMP_STA_ID_FK FOREIGN KEY (STATUS_ID) REFERENCES EMPLOYEE_STATUS(STATUS_ID),
    CONSTRAINT EMP_POS_ID_FK FOREIGN KEY (POSITION_ID) REFERENCES EMPLOYEE_POSITION(POSITION_ID),
    CONSTRAINT EMP_DEP_ID_FK FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT(DEPARTMENT_ID),
    CONSTRAINT EMP_BANK_ID_FK FOREIGN KEY (BANK_ID) REFERENCES BANK(BANK_ID)
);


CREATE TABLE EMPLOYEE_SKILL(
    EMPLOYEE_ID VARCHAR2(10),
    SKILL_ID VARCHAR2(10),
    CONSTRAINT EMP_SKILL_EMP_ID_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID),
    CONSTRAINT EMP_SKILL_SKILL_ID_FK FOREIGN KEY (SKILL_ID) REFERENCES SKILL (SKILL_ID),
    CONSTRAINT EMP_SKILL_PK PRIMARY KEY(EMPLOYEE_ID, SKILL_ID)
);

CREATE TABLE EMPLOYEE_PROLANG(
    EMPLOYEE_ID VARCHAR2(10),
    PROLANG_ID VARCHAR2(10),
    CONSTRAINT EMP_PROLANG_EMP_ID_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID),
    CONSTRAINT EMP_PROLANG_PROLANG_ID_FK FOREIGN KEY (PROLANG_ID) REFERENCES PROGRAMMING_LANGUAGE (PROLANG_ID),
    CONSTRAINT EMP_PROLANG_PK PRIMARY KEY(EMPLOYEE_ID, PROLANG_ID)
);



CREATE TABLE ATTENDENCE(
    ATTEND_CODE VARCHAR2(4),
    EMPLOYEE_ID VARCHAR2(10),
    INTIME TIMESTAMP,
    OUTTIME TIMESTAMP,
    STATUS CHAR(1) DEFAULT 'P',
    CONSTRAINT ATTEND_PK PRIMARY KEY (ATTEND_CODE),
    CONSTRAINT OUTTIME_CHECK CHECK (OUTTIME>INTIME),
    CONSTRAINT ATTEND_FK FOREIGN KEY (EMPLOYEE_ID)
    REFERENCES EMPLOYEE
);

CREATE TABLE OVERTIME(
    EMPLOYEE_ID VARCHAR2(10),
    OT_ID VARCHAR2(4),
    OT_DATE DATE DEFAULT SYSDATE,
    OT_HOURS INT CHECK (OT_HOURS <= 5),
    OT_MANAGER VARCHAR2(10) NOT NULL,
    CONSTRAINT OT_PK PRIMARY KEY (EMPLOYEE_ID, OT_ID),
    CONSTRAINT OT_FK FOREIGN KEY (EMPLOYEE_ID)
    REFERENCES EMPLOYEE
);

CREATE TABLE APPLIED_LEAVE(
    LEAVE_ID VARCHAR2(4),
    LEAVE_DESC VARCHAR2(30),
    PAY_STAT CHAR(1) CHECK (PAY_STAT='P' OR PAY_STAT='N'),
    CONSTRAINT LEAVE_PK PRIMARY KEY (LEAVE_ID)
);

CREATE TABLE LEAVE_APPLICATION(
    EMPLOYEE_ID VARCHAR2(10),
    LEAVE_ID VARCHAR(4),
    APP_ID NUMBER(4,2),
    LEAVE_FROM DATE DEFAULT SYSDATE,
    LEAVE_TO DATE DEFAULT SYSDATE,
    LEAVE_MANAGER VARCHAR2(10) NOT NULL,
    CONSTRAINT LEA_EMP_PK PRIMARY KEY (EMPLOYEE_ID, LEAVE_ID, APP_ID),
    CONSTRAINT LEA_EMP_FK FOREIGN KEY (LEAVE_ID)
    REFERENCES APPLIED_LEAVE,
    CONSTRAINT LEA_FK FOREIGN KEY (EMPLOYEE_ID)
    REFERENCES EMPLOYEE,
    CONSTRAINT LEAVE_UN UNIQUE (EMPLOYEE_ID, LEAVE_FROM),
    CONSTRAINT LEAVE_CK CHECK (LEAVE_FROM > LEAVE_TO)
);

CREATE TABLE HOLIDAY(
    HOL_ID VARCHAR2(4),
    HOL_DES VARCHAR2(20) NOT NULL,
    HOL_STARTDATE DATE DEFAULT SYSDATE,
    HOL_ENDDATE DATE DEFAULT SYSDATE,
    CONSTRAINT HOL_PK PRIMARY KEY (HOL_ID),
    CONSTRAINT HOLDAY_CK CHECK (HOL_ENDDATE >= HOL_STARTDATE)
);

CREATE TABLE EMPLOYEE_HOLIDAY(
    HOL_ID VARCHAR2(4),
    EMPLOYEE_ID VARCHAR2(10),
    LINE_NUM NUMBER(4,0),
    CONSTRAINT EMP_HOL_PK PRIMARY KEY(HOL_ID, EMPLOYEE_ID, LINE_NUM),
    CONSTRAINT EMP_HOL_FK FOREIGN KEY(HOL_ID)
    REFERENCES HOLIDAY,
    CONSTRAINT EMP_FK FOREIGN KEY (EMPLOYEE_ID)
    REFERENCES EMPLOYEE
);

INSERT INTO APPLIED_LEAVE (LEAVE_ID, LEAVE_DESC, PAY_STAT) VALUES ('L001', 'SICK LEAVE', 'P');
INSERT INTO APPLIED_LEAVE (LEAVE_ID, LEAVE_DESC, PAY_STAT) VALUES ('L002', 'MATERNAL LEAVE', 'P');
INSERT INTO APPLIED_LEAVE (LEAVE_ID, LEAVE_DESC, PAY_STAT) VALUES ('L003', 'COURT OR IMPRISONMENT', 'N');
INSERT INTO APPLIED_LEAVE (LEAVE_ID, LEAVE_DESC, PAY_STAT) VALUES ('L004', 'NO VALID REASON', 'N');
INSERT INTO APPLIED_LEAVE (LEAVE_ID, LEAVE_DESC, PAY_STAT) VALUES ('L005', 'ANNUAL LEAVE', 'P');
Commit;



CREATE TABLE ALLOWANCE(
Allowance_id VARCHAR(6) PRIMARY KEY,
Allowance_name VARCHAR(40) NOT NULL,
Allowance_amount NUMBER(6,2) NOT NULL
);
CREATE TABLE INCENTIVE(
Incentive_id VARCHAR(6) PRIMARY KEY,
Incentive_name VARCHAR(40) NOT NULL
);
CREATE TABLE DEDUCTION(
Deduction_id VARCHAR(6) PRIMARY KEY,
Deduction_name VARCHAR(40) NOT NULL,
Deduction_rate NUMBER(4,2) NOT NULL
);
CREATE TABLE PAYSLIP(
Payslip_num VARCHAR(10) PRIMARY KEY,
Employee_id VARCHAR(10) NOT NULL,
Pay_date DATE NOT NULL,
Total_allowance NUMBER,
Total_incentive NUMBER,
Total_deduction NUMBER,
Total_salary NUMBER DEFAULT(1),
FOREIGN KEY (Employee_id) REFERENCES EMPLOYEE(Employee_id)
);
CREATE TABLE PAYSLIP_ALLOWANCE(
Payslip_num VARCHAR(10),
Allowance_id VARCHAR(6),
PRIMARY KEY (Payslip_num, Allowance_id),
FOREIGN KEY (Payslip_num) REFERENCES PAYSLIP(Payslip_num),
FOREIGN KEY (Allowance_id) REFERENCES ALLOWANCE(Allowance_id)
);
CREATE TABLE PAYSLIP_INCENTIVE(
Payslip_num VARCHAR(10),
Incentive_id VARCHAR(6),
Incentive_amount NUMBER(6,2),
PRIMARY KEY (Payslip_num, Incentive_id),
FOREIGN KEY (Payslip_num) REFERENCES PAYSLIP(Payslip_num),
FOREIGN KEY (Incentive_id) REFERENCES INCENTIVE(Incentive_id)
);
CREATE TABLE PAYSLIP_DEDUCTION(
Payslip_num VARCHAR(10),
Deduction_id VARCHAR(6),
PRIMARY KEY (Payslip_num, Deduction_id),
FOREIGN KEY (Payslip_num) REFERENCES PAYSLIP(Payslip_num),
FOREIGN KEY (Deduction_id) REFERENCES DEDUCTION(Deduction_id)
);

--ALLOWANCE FIXED DATABASE
INSERT INTO ALLOWANCE (Allowance_id, Allowance_name, Allowance_amount) VALUES ('AL_PET', 'Petrol Allowance', 100);
INSERT INTO ALLOWANCE (Allowance_id, Allowance_name, Allowance_amount) VALUES ('AL_PAR', 'Parking Allowance', 100);
INSERT INTO ALLOWANCE (Allowance_id, Allowance_name, Allowance_amount) VALUES ('AL_MEA', 'Meal Allowance', 100);
INSERT INTO ALLOWANCE (Allowance_id, Allowance_name, Allowance_amount) VALUES ('AL_MED', 'Mediacal Allowance', 500);
INSERT INTO ALLOWANCE (Allowance_id, Allowance_name, Allowance_amount) VALUES ('AL_GYM', 'Gym Allowance', 200);
COMMIT;
--INCENTIVE FIXED DATABASE
INSERT INTO INCENTIVE (Incentive_id, Incentive_name) VALUES ('IN_PRO', 'Project Completion');
INSERT INTO INCENTIVE (Incentive_id, Incentive_name) VALUES ('IN_EMP', 'Employee of the Month');
INSERT INTO INCENTIVE (Incentive_id, Incentive_name) VALUES ('IN_BON', 'Year End Bonus');
COMMIT;
--DEDUCTION FIXED DATABASE
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('EPF_1', 'EPF FOR Salary<=5k of Employee Type', 11);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('EPF_2', 'EPF FOR Salary<=5k of Employer Type', 13);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('EPF_3', 'EPF FOR Salary>5k of Employee Type', 11);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('EPF_4', 'EPF FOR Salary>5k of Employer Type', 12);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('SOCSO', 'Social Security Organization Tax', 1.75);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('EIS', 'Employee Insurance System', 0.2);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_1', 'Income Tax FOR Net Income<5k', 0);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_2', 'Income Tax FOR Net Income 5k-20k', 1);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_3', 'Income Tax FOR Net Income 20k-35k', 3);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_4', 'Income Tax FOR Net Income 35k-50k', 8);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_5', 'Income Tax FOR Net Income 50k-70k', 14);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_6', 'Income Tax FOR Net Income 70k-100k', 21);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_7', 'Income Tax FOR Net Income 100k-250k', 24);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_8', 'Income Tax FOR Net Income 250k-400k', 24.5);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_9', 'Income Tax FOR Net Income 400k-600k', 25);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_10', 'Income Tax FOR Net Income 600k-1M', 26);
INSERT INTO DEDUCTION (Deduction_id, Deduction_name, Deduction_rate) VALUES ('INC_11', 'Income Tax FOR Net Income>1M', 28);
COMMIT;




CREATE TABLE TRAINING_TYPE(
TRAINING_TYPE_ID VARCHAR(10) NOT NULL PRIMARY KEY,
TRAINING_TYPE_DESC VARCHAR(20) NOT NULL
);

CREATE TABLE TRAINING (
TRAINING_ID VARCHAR(10) NOT NULL PRIMARY KEY,
TRAINING_NAME VARCHAR(40) NOT NULL,
START_DATE DATE NOT NULL,
END_DATE DATE NOT NULL,
TRAINING_LOCATION VARCHAR(20) NOT NULL,
TRAINING_TYPE_ID VARCHAR(10) NOT NULL,
TRAINING_STATUS CHAR(1) NOT NULL,
TRAINING_DETAILS VARCHAR(30),
CONSTRAINT TRAINING_TYPE_FK FOREIGN KEY(TRAINING_TYPE_ID) REFERENCES
TRAINING_TYPE(TRAINING_TYPE_ID)
);

CREATE TABLE PROJECT_TYPE(
PROJECT_TYPE_ID VARCHAR(10) NOT NULL PRIMARY KEY,
PROJECT_TYPE_DESC VARCHAR(20) NOT NULL
);

CREATE TABLE COMPLETED_PROJECT(
PROJECT_ID VARCHAR(10) NOT NULL PRIMARY KEY,
PROJECT_NAME VARCHAR(30) NOT NULL,
START_DATE DATE NOT NULL,
COMPLETED_DATE DATE NOT NULL,
PROJECT_TYPE_ID VARCHAR(10) NOT NULL,
PROJECT_STATUS CHAR(1) NOT NULL,
PROJECT_DETAILS VARCHAR(30),
CONSTRAINT PROJECT_TYPE_FK FOREIGN KEY(PROJECT_TYPE_ID) REFERENCES
PROJECT_TYPE(PROJECT_TYPE_ID)
);

CREATE TABLE EMPLOYEE_TRAINING(
TRAINING_ID VARCHAR(10),
EMPLOYEE_ID VARCHAR(10),
CONSTRAINT TRAINING_EMPLOYEE_COMPK PRIMARY KEY(TRAINING_ID,EMPLOYEE_ID),
CONSTRAINT TRAINING_FK FOREIGN KEY(TRAINING_ID) REFERENCES
TRAINING(TRAINING_ID),
CONSTRAINT TRAIN_EMPLOYEE_FK FOREIGN KEY(EMPLOYEE_ID) REFERENCES
EMPLOYEE(EMPLOYEE_ID)
);

CREATE TABLE EMPLOYEE_PROJECT(
PROJECT_ID VARCHAR(10),
EMPLOYEE_ID VARCHAR(10),
CONSTRAINT PROJECT_EMPLOYEE_COMPK PRIMARY KEY(PROJECT_ID,EMPLOYEE_ID),
CONSTRAINT PROJECT_FK FOREIGN KEY(PROJECT_ID) REFERENCES
COMPLETED_PROJECT(PROJECT_ID),
CONSTRAINT PROJ_EMPLOYEE_FK FOREIGN KEY(EMPLOYEE_ID) REFERENCES
EMPLOYEE(EMPLOYEE_ID)
);

COMMIT;
