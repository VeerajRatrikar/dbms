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
