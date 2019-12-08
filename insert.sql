--TEST EMPLOYEE_POSITION DATABASE
INSERT INTO EMPLOYEE_POSITION (Position_id, Position_name, Salary) VALUES ('S1', 'S1', 5000);
INSERT INTO EMPLOYEE_POSITION (Position_id, Position_name, Salary) VALUES ('S2', 'S2', 7000);
INSERT INTO EMPLOYEE_POSITION (Position_id, Position_name, Salary) VALUES ('S3', 'S3', 10000);
COMMIT;
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
INSERT INTO INCENTIVE (Incentive_id, Incentive_name) VALUES ('IN_YEA', 'Year End Bonus');
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
--TEST EMPLOYEE Data
INSERT INTO EMPLOYEE (Employee_id, Position_id) VALUES ('AA01', 'S1');
INSERT INTO EMPLOYEE (Employee_id, Position_id) VALUES ('AA02', 'S2');
INSERT INTO EMPLOYEE (Employee_id, Position_id) VALUES ('AA03', 'S3');
INSERT INTO EMPLOYEE (Employee_id, Position_id) VALUES ('AA04', 'S2');
INSERT INTO EMPLOYEE (Employee_id, Position_id) VALUES ('AA05', 'S1');
COMMIT;
--PAYSLIP Data
INSERT INTO PAYSLIP (Payslip_num, Employee_id, Pay_date, Total_allowance, Total_incentive, Total_deduction, Total_salary) VALUES ('AA01_1119', 'AA01', '01-NOV-19',1,0,0,0);
INSERT INTO PAYSLIP (Payslip_num, Employee_id, Pay_date, Total_allowance, Total_incentive, Total_deduction, Total_salary) VALUES ('AA02_1119', 'AA02', '01-NOV-19',2,0,0,0);
INSERT INTO PAYSLIP (Payslip_num, Employee_id, Pay_date, Total_allowance, Total_incentive, Total_deduction, Total_salary) VALUES ('AA03_1119', 'AA03', '01-NOV-19',3,0,0,0);
INSERT INTO PAYSLIP (Payslip_num, Employee_id, Pay_date, Total_allowance, Total_incentive, Total_deduction, Total_salary) VALUES ('AA04_1119', 'AA04', '01-NOV-19',4,0,0,0);
INSERT INTO PAYSLIP (Payslip_num, Employee_id, Pay_date, Total_allowance, Total_incentive, Total_deduction, Total_salary) VALUES ('AA05_1119', 'AA05', '01-NOV-19',5,0,0,0);
COMMIT;
--PAYSLIP_ALLOWANCE Data
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA01_1119', 'AL_PET');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA01_1119', 'AL_PAR');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA01_1119', 'AL_MEA');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA01_1119', 'AL_MED');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA01_1119', 'AL_GYM');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA02_1119', 'AL_PAR');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA02_1119', 'AL_MEA');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA02_1119', 'AL_MED');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA02_1119', 'AL_GYM');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA03_1119', 'AL_MEA');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA03_1119', 'AL_MED');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA03_1119', 'AL_GYM');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA04_1119', 'AL_MED');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA04_1119', 'AL_GYM');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA05_1119', 'AL_PET');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA05_1119', 'AL_PAR');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA05_1119', 'AL_MEA');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA05_1119', 'AL_MED');
INSERT INTO PAYSLIP_ALLOWANCE (Payslip_num, Allowance_id) VALUES ('AA05_1119', 'AL_GYM');
COMMIT;
--PAYSLIP_INCENTIVE Data
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA01_1119', 'IN_PRO', 100);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA01_1119', 'IN_EMP', 150);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA01_1119', 'IN_YEA', 130);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA02_1119', 'IN_PRO', 100);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA02_1119', 'IN_EMP', 150);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA03_1119', 'IN_PRO', 100);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA04_1119', 'IN_PRO', 100);
INSERT INTO PAYSLIP_INCENTIVE (Payslip_num, Incentive_id, Incentive_amount) VALUES ('AA04_1119', 'IN_EMP', 150);
COMMIT;
--PAYSLIP_DEDUCTION Data
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA01_1119', 'EPF_1');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA01_1119', 'SOCSO');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA01_1119', 'EIS');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA01_1119', 'INC_1');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA02_1119', 'EPF_1');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA02_1119', 'SOCSO');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA02_1119', 'EIS');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA02_1119', 'INC_2');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA03_1119', 'EPF_1');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA03_1119', 'EIS');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA03_1119', 'INC_3');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA04_1119', 'EPF_1');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA04_1119', 'SOCSO');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA04_1119', 'EIS');
INSERT INTO PAYSLIP_DEDUCTION (Payslip_num, Deduction_id) VALUES ('AA04_1119', 'INC_4');
COMMIT;