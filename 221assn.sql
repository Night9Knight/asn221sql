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

CREATE TABLE EMPLOYEE_STATUS(
    STATUS_ID VARCHAR2(10) PRIMARY KEY,
    STATUS_NAME VARCHAR2(30) NOT NULL
);

CREATE TABLE EMPLOYEE_POSITION(
    POSITION_ID VARCHAR2(10) PRIMARY KEY,
    POSITION_NAME VARCHAR2(30) NOT NULL,
    POSITION_BASIC_SALARY NUMBER NOT NULL
);

CREATE TABLE DEPARTMENT(
    department_id VARCHAR2(10) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(30) NOT NULL 
);

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

DROP TABLE ATTENDENCE;
DROP TABLE OVERTIME;
DROP TABLE APPLIED_LEAVE;
DROP TABLE LEAVE_APPLICATION;
DROP TABLE HOLIDAY;
DROP TABLE EMPLOYEE_HOLIDAY;

CREATE TABLE ATTENDENCE(
    EMPLOYEE_ID VARCHAR2(10),
    ATTEND_CODE VARCHAR2(4),
    WORK_DATE DATE,
    PRESENT_STAT CHAR(1),
    INTIME TIMESTAMP,
    OUTTIME TIMESTAMP,
    CONSTRAINT ATTEND_PK PRIMARY KEY (EMPLOYEE_ID, ATTEND_CODE),
    CONSTRAINT OUTTIME_CHECK CHECK (OUTTIME>INTIME),
    FOREIGN KEY (Employee_id) REFERENCES EMPLOYEE(Employee_id)
);

CREATE TABLE OVERTIME(
    EMPLOYEE_ID VARCHAR2(10),
    OT_ID VARCHAR2(4),
    OT_DATE DATE,
    OT_HOURS INT,
    OT_MANAGER VARCHAR2(4),
    CONSTRAINT OT_PK PRIMARY KEY (EMPLOYEE_ID, OT_ID),
    FOREIGN KEY (Employee_id) REFERENCES EMPLOYEE(Employee_id)
);

CREATE TABLE APPLIED_LEAVE(
    LEAVE_ID VARCHAR2(4),
    LEAVE_DESC VARCHAR2(10),
    DAYS NUMBER(4,0),
    PAY_STAT CHAR(1),
    CONSTRAINT LEAVE_PK PRIMARY KEY (LEAVE_ID)
);

CREATE TABLE LEAVE_APPLICATION(
    EMPLOYEE_ID VARCHAR2(10),
    LEAVE_ID VARCHAR(4),
    APP_ID NUMBER(4,2),
    LEAVE_FROM DATE,
    LEAVE_TO DATE,
    LEAVE_MANAGER VARCHAR2(4),
    CONSTRAINT LEA_EMP_PK PRIMARY KEY (EMPLOYEE_ID, LEAVE_ID, APP_ID),
    CONSTRAINT LEA_EMP_FK FOREIGN KEY (LEAVE_ID)
    REFERENCES APPLIED_LEAVE,
    FOREIGN KEY (Employee_id) REFERENCES EMPLOYEE(Employee_id)
);

CREATE TABLE HOLIDAY(
    HOL_ID VARCHAR2(4),
    HOL_DES VARCHAR2(12),
    HOL_STARTDATE DATE,
    HOL_ENDDATE DATE,
    CONSTRAINT HOL_PK PRIMARY KEY (HOL_ID),
    CONSTRAINT HOLDAY_CK CHECK (HOL_ENDDATE > HOL_STARTDATE)
);

CREATE TABLE EMPLOYEE_HOLIDAY(
    EMPLOYEE_ID VARCHAR(10),
    HOL_ID VARCHAR2(4),
    LINE_NUM NUMBER(4,0),
    CONSTRAINT EMP_HOL_PK PRIMARY KEY(HOL_ID, LINE_NUM),
    CONSTRAINT EMP_HOL_FK FOREIGN KEY(HOL_ID)
    REFERENCES HOLIDAY,
    CONSTRAINT EMP_HOL_EMPFK FOREIGN KEY (EMPLOYEE_ID)
    REFERENCES EMPLOYEE
);

DROP TABLE ALLOWANCE;
DROP TABLE INCENTIVE;
DROP TABLE DEDUCTION;
DROP TABLE PAYSLIP;
DROP TABLE PAYSLIP_ALLOWANCE;
DROP TABLE PAYSLIP_INCENTIVE;
DROP TABLE PAYSLIP_DEDUCTION;

CREATE TABLE ALLOWANCE(
Allowance_id VARCHAR(4) PRIMARY KEY,
Allowance_name VARCHAR(30) NOT NULL,
Allowance_amount NUMBER(4,2) NOT NULL
);

CREATE TABLE INCENTIVE(
Incentive_id VARCHAR(4) PRIMARY KEY,
Incentive_name VARCHAR(30) NOT NULL
);

CREATE TABLE DEDUCTION(
Deduction_id VARCHAR(4) PRIMARY KEY,
Deduction_name VARCHAR(30) NOT NULL,
Deduction_rate NUMBER(2,2) NOT NULL
);

CREATE TABLE PAYSLIP(
Payslip_num NUMBER PRIMARY KEY,
Employee_id VARCHAR(10) NOT NULL,
Pay_date DATE NOT NULL,
Total_allowance NUMBER NOT NULL,
Total_incentive NUMBER NOT NULL,
Total_deduction NUMBER NOT NULL,
Total_salary NUMBER NOT NULL,
FOREIGN KEY (Employee_id) REFERENCES EMPLOYEE(Employee_id)
);

CREATE TABLE PAYSLIP_ALLOWANCE(
Payslip_num NUMBER,
Allowance_id VARCHAR(4),
PRIMARY KEY (Payslip_num, Allowance_id),
FOREIGN KEY (Payslip_num) REFERENCES PAYSLIP(Payslip_num),
FOREIGN KEY (Allowance_id) REFERENCES ALLOWANCE(Allowance_id)
); 

CREATE TABLE PAYSLIP_INCENTIVE(
Payslip_num NUMBER,
Incentive_id VARCHAR(4),
PRIMARY KEY (Payslip_num, Incentive_id),
FOREIGN KEY (Payslip_num) REFERENCES PAYSLIP(Payslip_num),
FOREIGN KEY (Incentive_id) REFERENCES INCENTIVE(Incentive_id)
);

CREATE TABLE PAYSLIP_DEDUCTION(
Payslip_num NUMBER,
Deduction_id VARCHAR(4),
PRIMARY KEY (Payslip_num, Deduction_id),
FOREIGN KEY (Payslip_num) REFERENCES PAYSLIP(Payslip_num),
FOREIGN KEY (Deduction_id) REFERENCES DEDUCTION(Deduction_id)
); 

DROP TABLE EMPLOYEE_TRAINING;
DROP TABLE EMPLOYEE_PROJECT;
DROP TABLE TRAINING;
DROP TABLE COMPLETED_PROJECT;
DROP TABLE TRAINING_TYPE;
DROP TABLE PROJECT_TYPE;


CREATE TABLE TRAINING_TYPE(
TRAINING_TYPE_ID VARCHAR(10) NOT NULL PRIMARY KEY,
TRAINING_TYPE_DESC VARCHAR(20) NOT NULL
);

CREATE TABLE TRAINING (
TRAINING_ID VARCHAR(10) NOT NULL PRIMARY KEY,
TRAINING_NAME VARCHAR(30) NOT NULL,
START_DATE DATE NOT NULL,
END_DATE DATE NOT NULL,
TRAINING_LOCATION VARCHAR(20) NOT NULL,
TRAINING_TYPE_ID VARCHAR(10) NOT NULL,
TRAINING_STATUS CHAR(1) NOT NULL,
TRAINING_DETAILS VARCHAR(30),
CONSTRAINT TRAIN_DATE_CK CHECK(START_DATE<END_DATE),
CONSTRAINT TRAIN_STATUS_CK CHECK(TRAINING_STATUS IN('P','F','X')),
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
CONSTRAINT PROJ_DATE_CK CHECK(START_DATE<COMPLETED_DATE),
CONSTRAINT PROJ_STATUS_CK CHECK(TRAINING_STATUS IN('P','F')),
CONSTRAINT PROJ_COMP_DATE_CK CHECK(COMPLETED_DATE<=SYSDATE),
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
s