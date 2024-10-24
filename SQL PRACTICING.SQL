--BASIC QUERIES


-- Find all employees
SELECT * FROM Employee;

-- Find all clients
SELECT * FROM CLIENT;

-- Find all employees ordered by salary
SELECT * FROM EMPLOYEE
ORDER BY SALARY DESC;

-- Find all employees ordered by sex then name
SELECT * FROM EMPLOYEE
ORDER BY SEX, FIRST_NAME;

-- Find the first 5 employees in the table
SELECT * FROM EMPLOYEE LIMIT 5;

-- Find the first and last names of all employees
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEE;

-- Find the forename and surnames names of all employees
SELECT FIRST_NAME AS FORNAME, LAST_NAME AS SURNAME FROM EMPLOYEE;

-- Find out all the different genders
SELECT DISTINCT SEX FROM EMPLOYEE;

-- Find all male employees
SELECT * FROM EMPLOYEE
WHERE SEX = 'M';

-- Find all employees at branch 2
SELECT * FROM EMPLOYEE
WHERE BRANCH_ID = 2
order by asc salary;

-- Find all employee's id's and names who were born after 1969
SELECT EMP_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEE
WHERE BIRTH_DAY > '1970-01-01';

-- Find all female employees at branch 2
SELECT * FROM EMPLOYEE WHERE BRANCH_ID = 2 AND SEX = 'F';

-- Find all employees who are female & born after 1969 or who make over 80000
SELECT * FROM EMPLOYEE 
WHERE (SEX = 'F'
AND BIRTH_DAY > '1970-01-01') OR SALARY > 80000;

SELECT *
FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

-- Find all employees born between 1970 and 1975
SELECT * 
FROM EMPLOYEE WHERE BIRTH_DAY 
BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David
SELECT * 
FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');



--FUNCTIONS

-- Find the number of employees
SELECT COUNT(EMP_ID) FROM EMPLOYEE;

-- Find the average of all employee's salaries
SELECT AVG(SALARY) FROM EMPLOYEE;

-- Find the sum of all employee's salaries
SELECT SUM(SALARY) FROM EMPLOYEE;

-- Find out how many males and females there are
SELECT COUNT(SEX), SEX FROM EMPLOYEE
GROUP BY SEX;

-- Find the total sales of each salesman
SELECT EMP_ID, SUM(TOTAL_SALES) FROM WORKS_WITH
GROUP BY EMP_ID;

-- Find the total amount of money spent by each client
SELECT CLIENT_ID, SUM(TOTAL_SALES) FROM WORKS_WITH
GROUP BY CLIENT_ID;


--WILDCARDS

-- % = any # characters, _ = one character

-- Find any client's who are an LLC
SELECT CLIENT_ID FROM CLIENT WHERE CLIENT_NAME LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT * FROM BRANCH_SUPPLIER
WHERE SUPPLIER_NAME LIKE '%LABEL%';

-- Find any employee born on the 10th day of the month
SELECT * 
FROM EMPLOYEE
WHERE BIRTH_DAY LIKE '_____10%';

-- Find any clients who are schools
SELECT * 
FROM CLIENT
WHERE CLIENT_NAME LIKE '%SCHOOL';


--UNION

-- Find a list of employee and branch names
SELECT FIRST_NAME AS Company_Names
FROM EMPLOYEE
UNION
SELECT BRANCH_NAME FROM BRANCH
UNION
SELECT CLIENT_NAME
FROM CLIENT;

-- Find a list of all clients & branch suppliers' names
SELECT CLIENT_NAME FROM CLIENT
UNION
SELECT SUPPLIER_NAME FROM BRANCH_SUPPLIER;


--Find a list of all money spent or earned by the company

SELECT SALARY
FROM EMPLOYEE
UNION
SELECT TOTAL_SALES
FROM WORKS_WITH;




--JOINS

INSERT INTO BRANCH VALUES(4, 'Buffalo', null, null);

SELECT EMPLOYEE.EMP_ID, EMPLOYEE.FIRST_NAME, BRANCH.BRANCH_NAME
FROM EMPLOYEE
RIGHT JOIN BRANCH
ON BRANCH.MGR_ID = EMPLOYEE.EMP_ID;


--JOIN
--INNER JOIN
--LEFT JOIN
--RIGHT JOIN
--OUTER JOIN

--NESTED QUERIES

--Find names of all employes who have sold over 30,000 to a single client
SELECT FIRST_NAME, LAST_NAME 
FROM EMPLOYEE 
WHERE EMP_ID 
IN (SELECT EMP_ID FROM WORKS_WITH WHERE TOTAL_SALES > 30000);

--Find all client who are handled by the branch
--That Michael Scott manages
--Assume you know Michael's ID
SELECT BRANCH_ID FROM EMPLOYEE WHERE EMP_ID = 102;

SELECT CLIENT_NAME FROM CLIENT WHERE BRANCH_ID 
IN (SELECT BRANCH_ID FROM EMPLOYEE WHERE EMP_ID = 102);

