create table Salesman(
  Salesman_ID int primary key,
  Name varchar(20),
  City varchar(20),
  Commision varchar(20)
);

insert into Salesman values(&Salesman_ID,'&Name','&City','&Commission');

create table Customer(Customer_ID int primary key,
Cust_Name varchar(20),
City varchar(20),
Grade int,
Salesman_ID references Salesman(Salesman_ID) on delete set null
);

insert into Customer values(&Customer_ID,'&Cust_Name','&City',&Grade,&Salesman_ID);

create table Orders(Ord_No int primary key,
Purchase_Amt Number,
Ord_Date date,
Customer_ID references Customer(Customer_ID)on delete set null,
Salesman_ID references Salesman(Salesman_ID) on delete set null
);

insert into Orders values(&Ord_No,'&Purchase','&Ord_Date',&Customer_ID,&Salesman_ID);

Questions:
1)Select Grade,count(Customer_ID) from Customer group by Grade having Grade>(select avg(Grade) from Customer where City='Banglore');
2)Select Salesman_ID,Name from Salesman A where 1<(select count(*) from Customer C where  C.Salesman_ID = A.Salesman_ID);
3)Select S.Salesman_ID,Name,Customer_ID,Commision from Salesman S , Customer C where S.City=C.City
  UNION   
  Select S.Salesman,S.Name,NO_MATCH,Customer_ID,Commision from Salesman S,Customer C where Not City = any(select City from Customer);
4)Create view E_Salesman as Select B.Ord_date,A.Salesman_ID,A.Name from Salesman A,Orders B where A.Salesman_ID=B.Salesman_ID and
  B.Purchase_amt=(Select max(Purchase_amt)from Orders C where C.Ord_date = B.Ord_date);
5)delete from Salesman where Salesman_ID=1000;


3)SELECT S.Salesman_ID, S.Name, C.Customer_ID, S.CommisioN FROM Salesman S, Customer C WHERE S.City = C.City UNION
SELECT S.Salesman_ID, S.Name, NULL AS Customer_ID, S.Commision FROM Salesman S WHERE NOT EXISTS (SELECT 1 FROM Customer C WHERE C.City = S.City);

 SELECT * FROM E_Salesman;
ORD_DATE  SALESMAN_ID NAME
--------- ----------- ------------------
04-MAY-17        1000 John
20-JAN-17        2000 Ravi
13-APR-17        3000 Kumar
09-MAR-17        2000 Ravi

