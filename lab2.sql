create table Salesman(
  Salesman_ID int primary key,
  Name varchar(20),
  City varchar(20),
  Commision varchar(20)
);

insert into Salesman values(&Salesman_ID,'&Name','&City','&Commission');
