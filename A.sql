-- drop tables

DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE DEPT_LOCATIONS CASCADE CONSTRAINTS;
DROP TABLE PROJECT CASCADE CONSTRAINTS;
DROP TABLE WORKS_ON CASCADE CONSTRAINTS;
DROP TABLE DEPENDENT CASCADE CONSTRAINTS;

-- create and populate tables

CREATE TABLE EMPLOYEE
(
	Fname		VARCHAR(20),
	Minit		CHAR(1),
	Lname		VARCHAR(20),
	Ssn		CHAR(9),
	Bdate		DATE,
	Address		VARCHAR(30),
	Sex		CHAR(1),
	Salary		NUMBER(5),
	Super_Ssn	CHAR(9),
	Dno		NUMBER(1),

	PRIMARY KEY (Ssn),
		
	FOREIGN KEY (Super_ssn)
		REFERENCES EMPLOYEE (Ssn)
);

INSERT INTO EMPLOYEE VALUES ('James', 'E', 'Borg', '888665555', DATE '1937-11-10', '450 Stone, Houston, TX', 'M', 55000, NULL, 1);
INSERT INTO EMPLOYEE VALUES ('Jennifer', 'S', 'Wallace', '987654321', DATE '1941-06-20', '291 Berry, Bellaire, Tx', 'F', 37000, '888665555', 4);
INSERT INTO EMPLOYEE VALUES ('Franklin', 'T', 'Wong', '333445555', DATE '1955-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5);
INSERT INTO EMPLOYEE VALUES ('John', 'B', 'Smith', '123456789', DATE '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Alicia', 'J', 'Zelaya', '999887777', DATE '1968-01-19', '3321 castle, Spring, TX', 'F', 25000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('Ramesh', 'K', 'Narayan', '666884444', DATE '1920-09-15', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Joyce', 'A', 'English', '453453453', DATE '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5);
INSERT INTO EMPLOYEE VALUES ('Ahmad', 'V', 'Jabbar', '987987987', DATE '1969-03-29', '980 Dallas, Houston, TX', 'M', 22000, '987654321', 4);
INSERT INTO EMPLOYEE VALUES ('Melissa', 'M', 'Jones', '808080808', DATE '1970-07-10', '1001 Western, Houston, TX', 'F', 27500, '333445555', 5);

CREATE TABLE DEPARTMENT
(
	Dname		VARCHAR(20),
	Dnumber		NUMBER(1),
	Mgr_ssn		CHAR(9),
	Mgr_start_date	DATE,
	
	PRIMARY KEY (Dnumber),

	FOREIGN KEY (Mgr_ssn)
		REFERENCES EMPLOYEE (Ssn)
);

INSERT INTO DEPARTMENT VALUES ('Research', 5, '333445555', DATE '1988-05-22');
INSERT INTO DEPARTMENT VALUES ('Administration', 4, '987654321', DATE '1995-01-01');
INSERT INTO DEPARTMENT VALUES ('Headquarters', 1, '888665555', DATE '1981-06-19');

-- this alter is needed to allow PROJECT and DEPARTMENT to reference each other

ALTER TABLE EMPLOYEE ADD FOREIGN KEY (Dno) REFERENCES DEPARTMENT (Dnumber);

CREATE TABLE DEPT_LOCATIONS
(
	Dnumber		NUMBER(1),
	Dlocation	VARCHAR(20),
	
	PRIMARY KEY (Dnumber, Dlocation),

	FOREIGN KEY (Dnumber)
		REFERENCES DEPARTMENT (Dnumber)
);

INSERT INTO DEPT_LOCATIONS VALUES (1, 'Houston');
INSERT INTO DEPT_LOCATIONS VALUES (4, 'Stafford');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Bellaire');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Sugarland');
INSERT INTO DEPT_LOCATIONS VALUES (5, 'Austin');

CREATE TABLE PROJECT
(
	Pname		VARCHAR(20),
	Pnumber		NUMBER(2),
	Plocation	VARCHAR(20),
	Dnum		NUMBER(1),

	PRIMARY KEY (Pnumber),
	
	FOREIGN KEY (Dnum)
		REFERENCES DEPARTMENT (Dnumber)
);

INSERT INTO PROJECT VALUES ('ProductX', 1, 'Bellaire', 5);
INSERT INTO PROJECT VALUES ('ProductY', 2, 'Sugarland', 5);
INSERT INTO PROJECT VALUES ('ProductZ', 3, 'Houston', 5);
INSERT INTO PROJECT VALUES ('Computerization', 10, 'Stafford', 4);
INSERT INTO PROJECT VALUES ('Reorganization', 20, 'Houston', 1);
INSERT INTO PROJECT VALUES ('Newbenefits', 30, 'Stafford', 4);

CREATE TABLE WORKS_ON
(
	Essn		CHAR(9),
	Pno		NUMBER(2),
	Hours		NUMBER(3,1),
	
	PRIMARY KEY (Essn, Pno),

	FOREIGN KEY (Essn)
		REFERENCES EMPLOYEE (Ssn),

	FOREIGN KEY (Pno)
		REFERENCES PROJECT(Pnumber)
);

INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.0);
INSERT INTO WORKS_ON VALUES ('123456789', 2, 8.0);
INSERT INTO WORKS_ON VALUES ('453453453', 1, 20.0);
INSERT INTO WORKS_ON VALUES ('453453453', 2, 20.0);
INSERT INTO WORKS_ON VALUES ('333445555', 1, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 2, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 3, 5.0);
INSERT INTO WORKS_ON VALUES ('333445555', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 20, 10.0);
INSERT INTO WORKS_ON VALUES ('333445555', 30, 5.0);
INSERT INTO WORKS_ON VALUES ('999887777', 30, 30.0);
INSERT INTO WORKS_ON VALUES ('999887777', 10, 10.0);
INSERT INTO WORKS_ON VALUES ('987987987', 10, 35.0);
INSERT INTO WORKS_ON VALUES ('987987987', 30, 5.0);
INSERT INTO WORKS_ON VALUES ('987654321', 30, 20.0);
INSERT INTO WORKS_ON VALUES ('987654321', 20, 15.0);
INSERT INTO WORKS_ON VALUES ('888665555', 20, 10.0);

CREATE TABLE DEPENDENT
(
	Essn		CHAR(9),
	Dependent_name	VARCHAR(20),
	Sex		CHAR(1),
	Bdate		DATE,
	Relationship 	VARCHAR(10),

	PRIMARY KEY (Essn, Dependent_name),

	FOREIGN KEY (Essn)
		REFERENCES EMPLOYEE (Ssn)
);

INSERT INTO DEPENDENT VALUES ('333445555', 'Alice', 'F', DATE '1986-04-05', 'Daughter');
INSERT INTO DEPENDENT VALUES ('333445555', 'Theodore', 'M', DATE '1983-10-25', 'Son');
INSERT INTO DEPENDENT VALUES ('333445555', 'Joy', 'F', DATE '1958-05-03', 'Spouse');
INSERT INTO DEPENDENT VALUES ('987654321', 'Abner', 'M', DATE '1988-01-04', 'Son');
INSERT INTO DEPENDENT VALUES ('987654321', 'Jennifer', 'F', DATE '1988-01-04', 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'John', 'M', DATE '1988-02-28', 'Son');
INSERT INTO DEPENDENT VALUES ('123456789', 'Alice', 'F', DATE '1988-12-30', 'Daughter');
INSERT INTO DEPENDENT VALUES ('123456789', 'Elizabeth', 'F', DATE '1967-05-05', 'Spouse');
INSERT INTO DEPENDENT VALUES ('453453453', 'Joyce', 'F', DATE '1990-04-05', 'Daughter');
--end of actual table data

--1. [2pt] Retrieve the names of all employees who work on at least one of the projects. 
--(In other words, look at the list  of projects given in the PROJECT table, and retrieve the names of all employees 
--who work on at least one of them.)
SELECT Fname,Lname FROM Employee emp--the main attr we're looking for
INNER JOIN Works_ON worked ON emp.Ssn = worked.Essn--new table has the data we want
INNER JOIN Project proj ON worked.Pno = proj.pnumber--not needed but helps, proj helps make the attr in worked table more legit
GROUP BY Fname,Lname HAVING (Count(Essn)>1 OR Count(Essn)=1);--group to show what we want


--2. [2pt] For each department, retrieve the department number, department name, and the average salary of all employees 
--working in that department.  Order the output by department number in ascending order.--note: group by before order by
SELECT Dnumber,Dname,AVG(emp.Salary) FROM Department dpt --main attr we want to display
INNER JOIN Employee emp ON dpt.Dnumber = emp.Dno--where we get employee info, connected with department by dpt number
GROUP BY Dnumber,Dname--since we want to summarize by department
ORDER BY dpt.Dnumber ;


--3. [3pt] List the last names of all department managers who have no dependents.--tables: employee, department, dependent
SELECT Lname FROM Employee emp--main info
INNER JOIN Department dpt ON emp.ssn = dpt.mgr_ssn --who are the managers, connected by ssn, helps know who managers are and make their ssn legit
MINUS--difference with...
SELECT Lname FROM Employee emp--main info
INNER JOIN Department dpt ON emp.ssn = dpt.mgr_ssn--connect with managers to see who mangers are
INNER JOIN Dependent dpn ON emp.ssn = dpn.Essn; --managers with depdents
--who are managers with dependents versus no depdendents


--4. [3pt] Determine the department that has the employee with the lowest salary among all employees. For this department 
--retrieve the names of all employees. Write one query for this question using subquery.--table department, employee
SELECT dpt.Dname AS "Department",emp.fname AS "First Name",emp.lname AS "Last Name" FROM Department dpt -- department adn the employees in wanted dpt
INNER JOIN Employee emp ON dpt.dnumber = emp.Dno--we want this table because it has info about employees
WHERE dpt.Dname = (--CONDITION about dpt using subquery: where there's employee with lowest salary in all
    SELECT dpt.Dname FROM Department dpt--about department
    INNER JOIN Employee emp ON dpt.dnumber = emp.Dno--info about employee
    WHERE emp.salary = (--what about the empoyee
        SELECT MIN(salary)FROM Employee --lowest salary in all?
    )--dpt with lowest payed employee
);


--5. [2pt] Find the total number of employees and the total number of dependents for every department (the number of
--dependents for a department is the sum of the number of dependents for each employee working for that department). 
--Return the result as department name, total number of employees, and total number of dependents
SELECT dpt.Dname AS "Department Name" --we're looking for this and sorting by this
,COUNT(Fname) AS "Number of Employees by Department", --number of employees in department
SUM(empDependents) AS "Number of dependents in department" FROM Department dpt -- number of dependents by employee in department
INNER JOIN Employee emp ON dpt.Dnumber = emp.Dno--will help get to number of employees in a department
LEFT OUTER JOIN --we want the departments with no dependents too, inner join will not give all departments
    (SELECT Essn, COUNT(Dependent_name) AS empDependents  --alias for summing the dpn number to get whole department num dpn
        FROM Dependent GROUP BY Essn) empDep ON emp.ssn = empDep.Essn --number of dependents by employee inside ()
GROUP BY dpt.Dname;--we're looking for numbers by department so it'd make sense to sort by this
/*
SELECT COUNT(dpn.Dependent_name) dpnCount FROM Department dpt --inner join with bottom query later
INNER JOIN Employee emp ON dpt.dnumber = emp.dno
INNER JOIN Dependent dpn ON emp.ssn = dpn.essn
GROUP BY dpt.Dname;--number of dependents by department

SELECT Essn, COUNT(Dependent_name) FROM Dependent
GROUP BY Essn;--nuber of depedents by employee
*/


--6. [3pt] Determine if, in the company, male employees earn more than female employees.

--On average, male employees earn more than female employees
SELECT Sex AS "Employee sex", AVG(Salary) FROM Employee emp
GROUP BY Sex;


--7. [5pt] Retrieve the names of employees whose salary is within $20,000 of the salary of the employee who is paid the most 
--in the company (e.g., if the highest salary in the company is $80,000, retrieve the names of all employees that make at 
--least $60,000).
SELECT Fname,Lname FROM Employee --we're looking for employees names
WHERE 
Salary > (
        (SELECT MAX(Salary) FROM Employee)-20000--what's the limit salary we're looking for to get range of employee salaries desired
        )
AND 
Salary < (
        (SELECT MAX(Salary) FROM Employee)--what's the highest salary earned in the relation?
        );
--employee whose salary is highest
--SELECT Fname,Lname,Salary FROM Employee WHERE Salary = 
--(SELECT MAX(Salary) FROM Employee);


--8. [5pt] Find the names and addresses of all employees whose departments have no location in Houston (that is, whose
--departments do not have a Dlocation of Houston) but who work on at least one project that is located in Houston (that is, 
--who work on at least one project that has a Plocation of Houston). Note that the first condition is not equivalent to the 
--employee's department having some Dlocation that is not in Houston -- the department must not have any Dlocation that is 
--in Houston in order to be included in the result.
--Dlocation != Houston, works_on table count(pNo) >=1 and Plocation =Houston,
SELECT DISTINCT FName,Lname,Address FROM Employee emp --everyone in no houston department
INNER JOIN --need to find the commonality between employee and the different tables, like where these people work and such
    (SELECT dpt.Dnumber FROM Department dpt ---finding department with no location in houston
        LEFT OUTER JOIN  --because we need all possibe department numbers
            (SELECT dpt.Dnumber FROM Department dpt ---finding department with location in houston
                INNER JOIN Dept_Locations dptLoc ON dpt.Dnumber = dptLoc.Dnumber
                WHERE Dlocation = 'Houston') dptHouston --alias subquery to be more easily usable
        
    ON dpt.Dnumber = dptHouston.Dnumber --we're using Dnumber in the subquery
    WHERE dptHouston.Dnumber IS NULL) dptNoHouston ON emp.Dno = dptNoHouston.Dnumber --using Dnumber in subquery here too
    
INNER JOIN Works_ON wkOn ON wkOn.Essn = emp.ssn--worked on project
INNER JOIN Project proj ON proj.Pnumber = wkOn.PNo--legit project, helps legitimize project number column in wkOn table
WHERE proj.Plocation = 'Houston';--project location in houston
