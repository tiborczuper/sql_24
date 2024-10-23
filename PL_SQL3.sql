DECLARE
    TYPE t_rec IS RECORD(
        w_count NUMBER(38),
        min_avg_sal_job_id EMPLOYEES.JOB_ID%TYPE,
        low_sal_w_count NUMBER(38)
    );
    workers_rec t_rec;
    name_of_min_sal_job JOBS.JOB_TITLE%TYPE;
    percent_of_low_sal_workers NUMBER(10);
    FUNCTION get_workers(dep_id DEPARTMENTS.DEPARTMENT_ID%TYPE) RETURN t_rec IS
        rec t_rec;
    BEGIN
        SELECT COUNT(EMPLOYEE_ID) INTO rec.w_count FROM EMPLOYEES WHERE DEPARTMENT_ID = dep_id;
        SELECT JOB_ID INTO rec.min_avg_sal_job_id
        FROM (
            SELECT JOB_ID
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = dep_id
            GROUP BY JOB_ID
            ORDER BY AVG(SALARY) ASC
        )
        WHERE ROWNUM = 1;
        SELECT COUNT(*) INTO rec.low_sal_w_count FROM EMPLOYEES WHERE DEPARTMENT_ID = dep_id AND JOB_ID = rec.min_avg_sal_job_id;
        RETURN rec;
    END get_workers;
BEGIN     
    workers_rec := get_workers(30);
    SELECT JOB_TITLE INTO name_of_min_sal_job FROM JOBS WHERE JOB_ID = workers_rec.min_avg_sal_job_id;
    SELECT (workers_rec.low_sal_w_count/COUNT(*))*100 INTO percent_of_low_sal_workers FROM EMPLOYEES WHERE DEPARTMENT_ID = 30;
    DBMS_OUTPUT.PUT_LINE(name_of_min_sal_job|| ' részlegen a dolgozók '||percent_of_low_sal_workers|| '%-a dolgozik');
END;

/

DECLARE
    TYPE t_men_ids IS TABLE OF EMPLOYEES.MANAGER_ID%TYPE;
    managers t_men_ids;
    v_men_ids t_men_ids;

    m_name VARCHAR(200);
    
    FUNCTION get_managers(emp_count NUMBER) RETURN t_men_ids IS
        v_men_ids t_men_ids := t_men_ids();
    BEGIN
        SELECT MANAGER_ID 
        BULK COLLECT INTO v_men_ids FROM(
            SELECT MANAGER_ID FROM EMPLOYEES GROUP BY MANAGER_ID HAVING COUNT(*) > emp_count
        );
        RETURN v_men_ids;
    END get_managers;
    
    
BEGIN
    managers := get_managers(7);
    FOR i IN 1..managers.COUNT LOOP
        SELECT FIRST_NAME||' '||LAST_NAME INTO m_name FROM EMPLOYEES WHERE EMPLOYEE_ID = managers(i);
        DBMS_OUTPUT.PUT_LINE(m_name);
    END LOOP;
END;