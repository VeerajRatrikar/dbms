###Company Database
CREATE DATABASE COMPANY;
USE COMPANY;

CREATE TABLE DEPTS(DNAME VARCHAR(20),DNO INT PRIMARY KEY,MGRSTRDATE DATE);
CREATE TABLE EMP(SSN INT PRIMARY KEY,FNAME VARCHAR(20),LNAME VARCHAR(20),ADDRESS VARCHAR(20),SEX CHAR(1),SALARY INT,SUPERSSN REFERENCES EMP(SSN) ON DELETE CASCADE,DNO REFERENCES DEPTS(DNO) ON DELETE CASCADE);
ALTER TABLE DEPTS ADD MGRSSN REFERENCES EMP(SSN) ON DELETE SET NULL;
CREATE TABLE DEPLOC(DNO REFERENCES DEPTS(DNO),DLOC VARCHAR(20));
CREATE TABLE PRJ(PNO INT PRIMARY KEY,PNAME VARCHAR(20),PLOC VARCHAR(20),DNO REFERENCES DEPTS(DNO));
CREATE TABLE WORK(SSN REFERENCES EMP(SSN),PNO REFERENCES PRJ(PNO),HOURS INT);

INSERT INTO DEPTS VALUES('&DNAME',&DNO,'&MGRSTRDATE');
INSERT INTO EMP VALUES(&SSN,'&FNAME','&LNAME','&ADDRESS','&SEX',&SALARY,&SUPERSSN,&DNO);
ALTER TABLE DEPTS ADD MGRSSN REFERENCES EMP(SSN) ON DELETE SET NULL;

INSERT INTO DEPLOC VALUES(&DNO,'&DLOC');
INSERT INTO PRJ VALUES(&PNO,'&PNAME','&PLOC',&DNO);
INSERT INTO WORK VALUES(&SSN,&PNO,&HOURS);

 UPDATE DEPTS SET MGRSSN='333' WHERE DNO=1;
 UPDATE DEPTS SET MGRSSN='111' WHERE DNO=2;
 UPDATE DEPTS SET MGRSSN='444' WHERE DNO=3;
 UPDATE DEPTS SET MGRSSN='555' WHERE DNO=4;
 UPDATE DEPTS SET MGRSSN='777' WHERE DNO=5;

a) Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that Controls the project.
Select distinct p.pno from Prj p, Depts d, Emp e where e.dno=d.dno and d.dno = p.dno and
(e.lname = 'scott' or d.mgrssn in (select ssn from Emp where lname='scott'));

b) Show the resulting salaries if every employee working on the ‘IoT’ project is Given a 10 percent
raise.
Select e.ssn , e.fname,e.lname, 1.1*e.salary as raisedsal from emp e , prj p, work w where
p.pname = 'IOT' and p.pno = w.pno and e.ssn = w.ssn;

c) Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department
Select sum(salary) as sumsal, avg(salary) as avgsal, min(salary) as minsal, max(salary) as
maxsal from Emp e, Depts d where e.dno = d.dno and d.dname='Accounts';

d) Retrieve the name of each employee who works on the entire projects controlled bydepartment number 5.
select e.fname , e.lname from Emp e where not exists ((select pno from Prj where dno='5')
minus (select pno from WORK where e.ssn=ssn));

e) For each department that has more than five employees, retrieve the department numberand the number of its employees who are making more than Rs. 6,00,000. 
select d.dno,d.dname,e.fname,e.lname ,count(*) as noofemp from Emp e, Depts d where
e.dno=d.dno and e.salary>600000 and d.dno in(select e1.dno from Emp e1 group by e1.dno
having count(*)>5) group by d.dno,d.dname,e.fname,e.lname;
