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
