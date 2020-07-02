drop table massage;
drop table pets;
drop table petgoods;
drop table ident;
drop table stock;
drop table customer;
drop table goodtype;
drop table empoyees;
drop table payroll;
drop table positions;



create table goodtype(
tId char(8) primary key,
tName char(20)
);

create table customer(
cId char(8) primary key,
cname char(20),
tel char(11),
gender char(2)
);


create table positions(
positionId char(8) primary key,
position char(20)
);

create table payroll(
payId char(8) primary key,
basepay char(10),
insurance char(10),
allowance char(10),
salary char(10),
position char(20)
);


create table empoyees(
eId char(8) primary key,
ename char(20),
tel char(11),
positionId char(8),
payId char(8),
reward char(8),
finalwages char(8),
FOREIGN KEY (positionId) REFERENCES positions(positionId),
FOREIGN KEY (payId) REFERENCES payroll(payId)
);


create table ident(
iId char(8) primary key,
cid char(8),
allprice char(10),
eid char(8),
FOREIGN KEY (eId) REFERENCES empoyees(eId),
FOREIGN KEY (cId) REFERENCES customer(cId)
);


create table stock(
gId char(8) primary key,
gname char(20),
priceIn char(10),
priceout char(10),
goodsin char(10),
goodsout char(10),
present char(20),
eId char(8),
tId char(8)
FOREIGN KEY (eId) REFERENCES empoyees(eId),
FOREIGN KEY (tId) REFERENCES goodtype(tid)
);



create table petgoods(
pgId char(8) primary key,
iId char(8),
gId char(8),
gname char(20),
price char(10),
numbers char(10),
eId char(8)
FOREIGN KEY (iId) REFERENCES ident(iId),
FOREIGN KEY (gId) REFERENCES stock(gId)
)
;
create table pets(
pId char(8) primary key,
iId char(8),
gId char(8),
gname char(20),
numbers char(10),
gender char(5),
age char(8),
plevel char(10),
price char(10),
eId char(8)
FOREIGN KEY (iId) REFERENCES ident(iId),
FOREIGN KEY (gId) REFERENCES stock(gId)
);
create table massage(
cId char(8),
massage char(50) ,
eId char(8),
score char(8),
states char(8),
FOREIGN KEY (cId) REFERENCES customer(cId),
FOREIGN KEY (eId) REFERENCES empoyees(eId)
);


