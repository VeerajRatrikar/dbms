###University Database
CREATE TABLE STUDENT1(SNUM INT PRIMARY KEY,SNAME VARCHAR(20),MAJOR VARCHAR(20),LEV VARCHAR(20),AGE INT);
CREATE TABLE FACULTY(FID INT PRIMARY KEY,FNAME VARCHAR(20),DEPTID INT);
CREATE TABLE CLASS(CNAME VARCHAR(20) PRIMARY KEY , MEETSAT VARCHAR(20),ROOM VARCHAR(20),FID REFERENCES FACULTY(FID) ON DELETE SET NULL);
CREATE TABLE ENROLLED(SNUM REFERENCES STUDENT1(SNUM),CNAME REFERENCES CLASS(CNAME));

INSERT INTO STUDENT1 VALUES(&SNUM,'&SNAME','&MAJOR','&LEV',&AGE);
INSERT INTO FACULTY VALUES(&FID,'&FNAME',&DEPTID);
INSERT INTO CLASS VALUES('&CNAME','&MEETSATA','&ROOM',&FID);
INSERT INTO ENROLLED VALUES(&SNUM,'&CNAME');


a) Find the names of all Juniors (level = JR) who are enrolled in a class taught by Rakesh. 
Select Distinct S.Snum, S.Sname from Student S,Class C, Enrolled E,Faculty F where S.Snum =
E.Snum and E.Cname = C.Cname and C.Fid = F.Fid and F.Fname = 'Rakesh' and S.Lev = 'JR' order by
Snum;

b) Find the age of the oldest student who is either a history major or enrolled in a course taught by Ravi.
Select MAX(S.age) as Age from Student S where (S.Major = 'History') OR S.Snum in (Select E.Snum
from Class C , Enrolled E, Faculty F where E.cname = C.cname and C.Fid = F.Fid and F.Fname =
'Ravi');
c) Find the names of all students who are enrolled in two classes that meet at the same time.
Select Distinct S.Sname from Student S where S.Snum in (Select E1.Snum from Enrolled
E1,Enrolled E2, Class C1, Class C2 where E1.snum = E2.snum and E1.cname <> E2.cname and
E1.cname = C1.cname and E2.cname = C2.cname and C1.meets_at = C2.meets_at);

d) For each faculty member that has taught classes only in room R128, print the faculty member’s name and the total number of classes she or he has taught. 
Select Distinct F.Fname , count(*) as CourseCount from CLass C , Faculty F where C.FID not in
(Select Fid from Class where Room IN (Select Room from Class where Room!= 'R128')) AND C.Fid =
F.Fid group by F.Fname;

e) Create a view that contains the details of students along with the name of the courses enrolled
