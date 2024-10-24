SET SERVEROUTPUT ON

DECLARE
    TYPE t_emps IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE;
    FUNCTION get_emps_by_job_and_department(j_id EMPLOYEES.JOB_ID%TYPE, d_id EMPLOYEES.DEPARTMENT_ID%TYPE)
    RETURN t_emps IS emps t_emps;
    BEGIN
        SELECT EMPLOYEE_ID BULK COLLECT INTO emps FROM EMPLOYEES WHERE JOB_ID = j_id AND DEPARTMENT_ID = d_id;
        RETURN emps;
    END get_emps_by_job_and_department;
BEGIN
    FOR c IN (SELECT DISTINCT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES)LOOP
        IF get_emps_by_job_and_department(C.JOB_ID,C.DEPARTMENT_ID).COUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE(c.FIRST_NAME || ' ' || c.LAST_NAME);
        END IF;
    END LOOP;
END;

/

CREATE OR REPLACE FUNCTION get_jobs_of_manager(man_id EMPLOYEES.MANAGER_ID%TYPE)
    RETURN NUMBER IS db NUMBER;
    BEGIN
        SELECT COUNT(DISTINCT JOB_ID) INTO db FROM EMPLOYEES WHERE MANAGER_ID = man_id;
        RETURN db;
    END;
    
/
DECLARE
    m_name VARCHAR(200);
BEGIN
    FOR C IN (SELECT DISTINCT MANAGER_ID FROM EMPLOYEES) LOOP
        IF get_jobs_of_manager(C.MANAGER_ID) >= 5 THEN
            SELECT FIRST_NAME || ' ' || LAST_NAME INTO m_name FROM EMPLOYEES WHERE EMPLOYEE_ID = C.MANAGER_ID;
            DBMS_OUTPUT.PUT_LINE(m_name ||': '||get_jobs_of_manager(C.MANAGER_ID));
        END IF;
    END LOOP;
END;