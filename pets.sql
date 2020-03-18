
create table Goods(
Gno char(4) primary key,
Sale int,
Gname char(20),
)

create table Positions(
Ptno char(8) primary key,
Ptname char(20)
)

create table Customer
(
Cno char(3) primary key,
Cname char(20),
Gender char(2),
Tel char(11),
Mail char(20)
)

create table petsGoods(
PGno char(4) primary key,
Gno char(4),
Count  int,
Sale char(10),
foreign key(Gno) references Goods(Gno)
)

Create table pet(
Pno char(4) primary key,
Gno char(4),
Pname char(20),
Gender char(2),
Age int,
Sale char(10),
Number int,
foreign key(Gno) references Goods(Gno)
)


create table PetsOrder(
Cno char(3),
Gno char(4),
Num int,
pay char(10),
foreign key(Cno) references Customer(Cno),
foreign key(Gno) references Goods(Gno)
)

create table Massage(
Mno char(3) primary key,
Mname char(20),
Cno char(3),
Massage char(10),
Ptno char(8),
foreign key(Cno) references Customer(Cno),
foreign key(Ptno) references Position(Ptno)
)



create table  Menu(
Uno char(4) primary key,
Salary char(10),
Bouns char(10),
Welfare char(10),
Ptno char(8),
 foreign key(Ptno) references Position(Ptno)
)




create table Payroll(
Payno char(4) primary key,
eno char(5),
uno char(4),
Tsalary char(10),
 foreign key(Uno) references menu(Uno)

)

create table Employees(
Eno char(5) primary key,
Ename char(20),
Gender char(2),
Tel char(11),
Ptno char(8),
Payno char(4),
 foreign key(Ptno) references Position(Ptno)
)

