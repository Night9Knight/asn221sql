DROP TABLE PAYSLIP_ALLOWANCE;
DROP TABLE PAYSLIP_INCENTIVE;
DROP TABLE PAYSLIP_DEDUCTION;
DROP TABLE ALLOWANCE;
DROP TABLE INCENTIVE;
DROP TABLE DEDUCTION;
DROP TABLE PAYSLIP;
DROP TABLE EMPLOYEE;

CREATE TABLE EMPLOYEE(
Employee_id VARCHAR(30) PRIMARY KEY
);
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
Total_allowance NUMBER NOT NULL,
Total_incentive NUMBER NOT NULL,
Total_deduction NUMBER NOT NULL,
Total_salary NUMBER NOT NULL,
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
