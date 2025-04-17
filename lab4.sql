###Airline/Flight Database
CREATE TABLE FLIGHTS(FLNO INT PRIMARY KEY,SOURCE VARCHAR(20),DESTINATION VARCHAR(20),DISTANCE INT,DEPARTTIME VARCHAR(10),ARRIVALTIME VARCHAR(10),PRICE INT);
CREATE TABLE AIRCRAFT(AID INT PRIMARY KEY,ANAME VARCHAR(20),CRUSINGRANGE INT);
CREATE TABLE EMPLOYEES(EID INT PRIMARY KEY,ENAME VARCHAR(20),SALARY INT);
CREATE TABLE CERTIFIED(EID REFERENCES EMPLOYEES(EID),AID REFERENCES AIRCRAFT(AID));

INSERT INTO FLIGHTS VALUES(&FLNO,'&SOURCE','&DESTINATION',&DISTANCE,'&DEPARTTIME','&ARRIVALTIME',&PRICE);
INSERT INTO AIRCRAFT VALUES(&AID,'&ANAME',&CRUSINGRANGE);
INSERT INTO EMPLOYEES VALUES(&EID,'&ENAME',&SALARY);
INSERT INTO CERTIFIED VALUES(&EID,&AID);

a) Find the names of aircraft such that all pilots certified to operate them earn more than $80,000. 
select Aname from AirCraft A, Employees E, Certified C where A.Aid = C.Aid and E.Eid = C.Eid and E.Salary > 80000; 

b) For each pilot who is certified for more than three aircraft, find the eid and the maximum cruisingrange of the aircraft for which she or he is certified. 
select E.Eid, Max(CrusingRange) from Employees E, Certified C, AirCraft A where
E.Eid=C.Eid and A.Aid = C.Aid group by E.Eid having count(*) > 3; 

c) For all aircraft with cruisingrange over 1000 miles, find the name of the aircraft and the average salary of all pilots certified for this aircraft.
select A.Aname ,avg(Salary) from Employees E, Certified C , Aircraft A where C.Eid = E.Eid and A.Aid = C.Aid and A.CrusingRange>1000 group by A.Aname; 

d) Print the enames of pilots who can operate planes with cruising range greater than 3000 miles but are not certified on any Boeing aircraft.
(select Ename from Employees E, Certified C where C.Aid in
( select A.Aid from Aircraft A, Certified C where A.Aid not in
( select Aid from Aircraft where Aname = 'boeing' or CrusingRange=3000)
group by A.Aid
) and E.Eid = C.Eid)
Minus
(select ename from Employees E, Certified C where C.Aid in (
select A.Aid from Aircraft A, Certified C where A.Aid in
(select Aid from Aircraft where Aname = 'boeing')
group by A.Aid) and E.Eid = C.Eid);

e) Print the name and salary of every nonpilot whose salary is more than the average salary for pilots
select Eid, Ename, Salary from Employees where salary > (select avg(salary) from
Employees) and Eid not in ( select Eid from Certified); 


->SELECT ANAME FROM AIRCRAFT A, EMPLOYEES E, CERTIFIED C WHERE A.AID = C.AID AND E.EID = C.EID AND E.SALARY > 80000;
ANAME
----------
DISHAN
KINGFISHER
DECCAN
GOIBIBO
->SELECT E.EID, MAX(CRUSINGRANGE) FROM EMPLOYEES E, CERTIFIED C, AIRCRAFT A WHERE E.EID = C.EID AND A.AID = C.AID 
GROUP BY E.EID HAVING COUNT(*) > 3;
->SELECT A.ANAME, AVG(SALARY) FROM EMPLOYEES E, CERTIFIED C, AIRCRAFT A WHERE C.EID = E.EID AND A.AID = C.AID 
AND A.CRUSINGRANGE > 1000 GROUP BY A.ANAME;
ANAME                AVG(SALARY)
-------------------- -----------
KINGFISHER                150000
DISHAN                    150000
DECCAN                    112500
->
(SELECT ENAME FROM EMPLOYEES E, CERTIFIED C WHERE C.AID IN (SELECT A.AID FROM AIRCRAFT A, CERTIFIED C 
WHERE A.AID NOT IN (SELECT AID FROM AIRCRAFT WHERE ANAME = 'Boeing' OR CRUSINGRANGE = 3000) 
GROUP BY A.AID) AND E.EID = C.EID) MINUS 
(SELECT ENAME FROM EMPLOYEES E, CERTIFIED C WHERE C.AID IN (SELECT A.AID FROM AIRCRAFT A, CERTIFIED C 
WHERE A.AID IN (SELECT AID FROM AIRCRAFT WHERE ANAME = 'Boeing') GROUP BY A.AID) AND E.EID = C.EID);
ENAME
--------------------
BHASKAR
DISHAN KRISHNA
SHIVAKUMAR

->SELECT EID, ENAME, SALARY FROM EMPLOYEES WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES) 
AND EID NOT IN (SELECT EID FROM CERTIFIED);
