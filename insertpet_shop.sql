alter table goodtype alter column tname char(20)
alter table payroll add position char(20)
alter table empoyees 
add constraint _positionId foreign key(positionId) references positions(positionId)
alter table pets drop  column gname
alter table goodtype drop  column gender
select * from goodtype
select * from pets
select * from petgoods
select * from stock




insert into goodtype values('t001','ʳƷ��');
insert into goodtype values('t002','ϴ����');
insert into goodtype values('t003','ҽҩ��');
insert into goodtype values('t004','������');
insert into goodtype values('t006','�����þ���');

insert into customer values('c001','�˿�1','13293848391','Ů');
insert into customer values('c002','�˿�2','13293848392','��');
insert into customer values('c003','�˿�3','13293848393','��');
insert into customer values('c004','�˿�4','13293848394','Ů');
insert into customer values('c005','�˿�5','13293848395','��');
insert into customer values('c006','�˿�6','13293848396','Ů');
insert into customer values('c007','�˿�7','13293848397','Ů');
insert into customer values('c008','�˿�8','13293848398','Ů');


insert into positions values('p001','�ŵ꾭��');
insert into positions values('p002','�ۻ�Ա');
insert into positions values('p003','�ۺ�Ա');
insert into positions values('p004','�ֿ����Ա');


insert into payroll values('pay001','8000','2000','10000','�ŵ꾭��');
insert into payroll values('pay002','5000','1000','6000','�ۻ�Ա');
insert into payroll values('pay003','4500','500','5000','�ۺ�Ա');
insert into payroll values('pay004','3000','500','3500','�ֿ����Ա');


insert into empoyees values('e001','Ա��1','13158964351','p001','pay001');
insert into empoyees values('e002','Ա��2','13158964353','p002','pay002');
insert into empoyees values('e003','Ա��3','13158964354','p002','pay002');
insert into empoyees values('e004','Ա��4','13158964355','p002','pay002');
insert into empoyees values('e005','Ա��5','13158964356','p003','pay003');
insert into empoyees values('e006','Ա��6','13158964357','p003','pay003');
insert into empoyees values('e007','Ա��7','13158964358','p004','pay004');


insert into ident values('i001','c001','5000','e003');
insert into ident values('i002','c002','3000','e002');
insert into ident values('i003','c003','500','e003');
insert into ident values('i004','c004','15000','e002');
insert into ident values('i005','c005','1000','e004');



insert into stock values('g001','è����1','30','80','200','80','120','e007','t001');
insert into stock values('g002','è����2','15','50','200','70','130','e007','t001');
insert into stock values('g003','������1','40','100','200','88','112','e007','t001');
insert into stock values('g004','������2','45','120','200','65','135','e007','t001');
insert into stock values('g005','�����þ�1','15','80','200','88','112','e007','t006');
insert into stock values('g006','�����þ�2','70','180','200','77','123','e007','t006');
insert into stock values('g007','����ϴ��Ʒ1','60','180','200','44','156','e007','t002');
insert into stock values('g008','����ϴ��Ʒ2','135','280','200','66','134','e007','t002');
insert into stock values('g009','�ո����۶�è','1200','3000','10','7','3','e007','t004');
insert into stock values('g010','Ӣ����ëè','1500','3500','10','6','4','e007','t004');
insert into stock values('g011','��żè','5000','13000','80','4','6','e007','t004');
insert into stock values('g012','��ʿ��Ȯ','1000','200','10','5','5','e007','t004');
insert into stock values('g013','��������Ȯ','1000','2500','10','6','4','e007','t004');
insert into stock values('g014','ѩ����Ȯ','1000','2500','10','4','6','e007','t004');



insert into petgoods values('pg001','i001','g001','è����1','80','2');
insert into petgoods values('pg002','i001','g006','�����þ�2','150','1');
insert into petgoods values('pg003','i002','g002','è����2','50','3');
insert into petgoods values('pg004','i003','g005','�����þ�1','80','1');
insert into petgoods values('pg005','i003','g007','ϴ����Ʒ1','180','1');
insert into petgoods values('pg006','i004','g008','ϴ����Ʒ2','280','2');
insert into petgoods values('pg007','i005','g002','è����2','50','5');
insert into petgoods values('pg008','i005','g006','�����þ�2','80','5');
insert into petgoods values('pg009','i001','g007','ϴ����Ʒ1','80','2');

insert into pets values('p001','i001','g009','�ո����۶�è','1','����','������','3000');
insert into pets values('p002','i002','g011','��żè','1','����','������','13000');
insert into pets values('p003','i004','g012','��ʿ��','1','����','����','2000');
insert into pets values('p004','i005','g013','��������','1','����','������','2500');

insert into massage values('c001','������Ʒ����������','e005');
insert into massage values('c001','�����������������','e006');
insert into massage values('c001','������ϴ����Ʒ���ë','e006');
insert into massage values('c001','������ߵ�ɫ','e005');