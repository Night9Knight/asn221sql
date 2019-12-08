--TRG ADD ROW PAYSLIP_ALLOWANCE TRIGGER TTL_ALLOWANCE

CREATE OR REPLACE TRIGGER TRG_PAYSLIP_ALLOWANCE
AFTER DELETE OR INSERT OR UPDATE ON PAYSLIP_ALLOWANCE
BEGIN
    UPDATE PAYSLIP SET TOTAL_ALLOWANCE=(
    SELECT SUM(ALLOWANCE_AMOUNT) FROM PAYSLIP_ALLOWANCE LEFT JOIN ALLOWANCE ON PAYSLIP_ALLOWANCE.ALLOWANCE_ID=ALLOWANCE.ALLOWANCE_ID
    WHERE PAYSLIP.PAYSLIP_NUM=PAYSLIP_ALLOWANCE.PAYSLIP_NUM
    GROUP BY PAYSLIP_ALLOWANCE.PAYSLIP_NUM
    );
    UPDATE PAYSLIP SET TOTAL_ALLOWANCE=0 WHERE TOTAL_ALLOWANCE IS null;

END;
/

--TRG CHANGE ALLOWANCE_AMOUNT

CREATE OR REPLACE TRIGGER TRG_ALLOWANCE
AFTER DELETE OR INSERT OR UPDATE ON ALLOWANCE
BEGIN
    UPDATE PAYSLIP SET TOTAL_ALLOWANCE=(
    SELECT SUM(ALLOWANCE_AMOUNT) FROM PAYSLIP_ALLOWANCE LEFT JOIN ALLOWANCE ON PAYSLIP_ALLOWANCE.ALLOWANCE_ID=ALLOWANCE.ALLOWANCE_ID
    WHERE PAYSLIP.PAYSLIP_NUM=PAYSLIP_ALLOWANCE.PAYSLIP_NUM
    GROUP BY PAYSLIP_ALLOWANCE.PAYSLIP_NUM
    );
    UPDATE PAYSLIP SET TOTAL_ALLOWANCE=0 WHERE TOTAL_ALLOWANCE IS null;


END;
/

--TRG ADD ROW PAYSLIP_INCENTIVE OR CHANGE INCENTIVE_AMOUNT TRIGGER TTL_INCENTIVE

CREATE OR REPLACE TRIGGER TRG_PAYSLIP_INCENTIVE
AFTER DELETE OR INSERT OR UPDATE ON PAYSLIP_INCENTIVE
BEGIN
    UPDATE PAYSLIP SET TOTAL_INCENTIVE=(
    SELECT SUM(INCENTIVE_AMOUNT) FROM PAYSLIP_INCENTIVE
    WHERE PAYSLIP.PAYSLIP_NUM=PAYSLIP_INCENTIVE.PAYSLIP_NUM
    GROUP BY PAYSLIP_INCENTIVE.PAYSLIP_NUM
    );
    UPDATE PAYSLIP SET TOTAL_INCENTIVE=0 WHERE TOTAL_INCENTIVE IS null;
END;
/

--TRG ADD ROW PAYSLIP_DEDUCTION

CREATE OR REPLACE TRIGGER TRG_PAYSLIP_DEDUCTION
AFTER DELETE OR INSERT OR UPDATE ON PAYSLIP_DEDUCTION
BEGIN
    UPDATE PAYSLIP SET TOTAL_DEDUCTION=(
    SELECT SUM(DEDUCTION_RATE) FROM PAYSLIP_DEDUCTION LEFT JOIN DEDUCTION ON PAYSLIP_DEDUCTION.DEDUCTION_ID=DEDUCTION.DEDUCTION_ID
    WHERE PAYSLIP.PAYSLIP_NUM=PAYSLIP_DEDUCTION.PAYSLIP_NUM
    GROUP BY PAYSLIP_DEDUCTION.PAYSLIP_NUM
    );
    UPDATE PAYSLIP SET TOTAL_DEDUCTION=0 WHERE PAYSLIP.TOTAL_DEDUCTION IS null;

END;
/

--TRG CHANGE DEDUCTION_AMOUNT

CREATE OR REPLACE TRIGGER TRG_DEDUCTION
AFTER DELETE OR INSERT OR UPDATE ON DEDUCTION
BEGIN
    UPDATE PAYSLIP SET TOTAL_DEDUCTION=(
    SELECT SUM(DEDUCTION_RATE) FROM PAYSLIP_DEDUCTION LEFT JOIN DEDUCTION ON PAYSLIP_DEDUCTION.DEDUCTION_ID=DEDUCTION.DEDUCTION_ID
    WHERE PAYSLIP.PAYSLIP_NUM=PAYSLIP_DEDUCTION.PAYSLIP_NUM
    GROUP BY PAYSLIP_DEDUCTION.PAYSLIP_NUM
    );
    UPDATE PAYSLIP SET TOTAL_DEDUCTION=0 WHERE TOTAL_DEDUCTION IS null;
END;
/
--TRG SET VALUE OF TTL_SALARY

CREATE OR REPLACE TRIGGER TRG_SALARY
AFTER INSERT OR UPDATE OF TOTAL_ALLOWANCE, TOTAL_INCENTIVE, TOTAL_DEDUCTION ON PAYSLIP
BEGIN
    UPDATE PAYSLIP a SET TOTAL_SALARY=(
    SELECT SALARY+ TOTAL_ALLOWANCE +TOTAL_INCENTIVE-TOTAL_DEDUCTION FROM(
    SELECT b.EMPLOYEE_ID, SALARY, DECODE(TOTAL_ALLOWANCE,null,0,TOTAL_ALLOWANCE) as TOTAL_ALLOWANCE,
    DECODE(TOTAL_INCENTIVE,null,0,TOTAL_INCENTIVE) as TOTAL_INCENTIVE , DECODE(TOTAL_DEDUCTION,null,0,TOTAL_DEDUCTION) as TOTAL_DEDUCTION
    FROM PAYSLIP b
        LEFT JOIN EMPLOYEE ON b.EMPLOYEE_ID=EMPLOYEE.EMPLOYEE_ID
        LEFT JOIN EMPLOYEE_POSITION ON EMPLOYEE.POSITION_ID=EMPLOYEE_POSITION.POSITION_ID
       ) c WHERE c.EMPLOYEE_ID=a.EMPLOYEE_ID);
END;
/

--TRG ATTENDENCE LATE 
CREATE OR REPLACE TRIGGER LATE_TGR
    BEFORE
    INSERT OR UPDATE OF INTIME,OUTTIME ON ATTENDENCE
    FOR each ROW
BEGIN
IF ((:NEW.OUTTIME-:NEW.INTIME)< INTERVAL '8' HOUR) THEN
   :NEW.STATUS:='L';
   END IF;
END;
/
