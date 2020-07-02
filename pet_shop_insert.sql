--alter table goodtype alter column tname char(20)
--alter table payroll add position char(20)
--alter table empoyees 
--add constraint _positionId foreign key(positionId) references positions(positionId)
--alter table pets drop  column gname
--alter table goodtype drop  column gender
--select * from goodtype
--select * from pets
--select * from petgoods
--select* from ident 

--select * from empoyees
--select * from ident
--select * from petgoods
--select * from pets


insert into goodtype values('t001','食品类');
insert into goodtype values('t002','洗漱类');
insert into goodtype values('t003','医药类');
insert into goodtype values('t004','动物类');
insert into goodtype values('t006','宠物用具类');

insert into customer values('c001','顾客1','13293848391','女');
insert into customer values('c002','顾客2','13293848392','男');
insert into customer values('c003','顾客3','13293848393','男');
insert into customer values('c004','顾客4','13293848394','女');
insert into customer values('c005','顾客5','13293848395','男');
insert into customer values('c006','顾客6','13293848396','女');
insert into customer values('c007','顾客7','13293848397','女');
insert into customer values('c008','顾客8','13293848398','女');


insert into positions values('p001','门店经理');
insert into positions values('p002','售货员');
insert into positions values('p003','售后员');
insert into positions values('p004','仓库管理员');


insert into payroll values('pay001','8000','1200','50','6800','门店经理');
insert into payroll values('pay002','5000','1200','40','3840','售货员');
insert into payroll values('pay003','4500','1200','30','3230','售后员');
insert into payroll values('pay004','3000','1200','60','1860','仓库管理员');


insert into empoyees values('e001','员工1','13158964351','p001','pay001','0','6800');
insert into empoyees values('e002','员工2','13158964353','p002','pay002','0','3840');
insert into empoyees values('e003','员工3','13158964354','p002','pay002','0','3840');
insert into empoyees values('e004','员工4','13158964355','p002','pay002','0','3840');
insert into empoyees values('e005','员工5','13158964356','p003','pay003','0','3230');
insert into empoyees values('e006','员工6','13158964357','p003','pay003','0','3230');
insert into empoyees values('e007','员工7','13158964358','p004','pay004','0','1860');
insert into empoyees values('e008','员工7','13158964358','p004','pay004','0','1860');



insert into ident values('i001','c001','0','e003');
insert into ident values('i002','c002','0','e002');
insert into ident values('i003','c003','0','e003');
insert into ident values('i004','c004','0','e002');
insert into ident values('i005','c005','0','e004');
insert into ident values('i006','c006','0','e003');
insert into ident values('i007','c007','0','e002');
insert into ident values('i008','c008','0','e004');


insert into stock values('g001','猫饲料1','30','80','200','80','120','e007','t001');
insert into stock values('g002','猫饲料2','15','50','200','70','130','e007','t001');
insert into stock values('g003','狗饲料1','40','100','200','88','112','e007','t001');
insert into stock values('g004','狗饲料2','45','120','200','65','135','e007','t001');
insert into stock values('g005','宠物用具1','15','80','200','88','112','e007','t006');
insert into stock values('g006','宠物用具2','70','180','200','77','123','e007','t006');
insert into stock values('g007','宠物洗漱品1','60','180','200','44','156','e007','t002');
insert into stock values('g008','宠物洗漱品2','135','280','200','66','134','e007','t002');
insert into stock values('g009','苏格兰折耳猫','1200','3000','10','7','3','e007','t004');
insert into stock values('g010','英国短毛猫','1500','3500','10','6','4','e008','t004');
insert into stock values('g011','布偶猫','5000','13000','80','4','6','e008','t004');
insert into stock values('g012','哈士奇犬','1000','200','10','5','5','e008','t004');
insert into stock values('g013','拉布拉多犬','1000','2500','10','6','4','e008','t004');
insert into stock values('g014','雪纳瑞犬','1000','2500','10','4','6','e008','t004');


insert into petgoods values('pg001','i001','g001','猫饲料1','80','2','e002');
insert into petgoods values('pg002','i001','g006','宠物用具2','150','1','e002');
insert into petgoods values('pg003','i002','g002','猫饲料2','50','3','e004');
insert into petgoods values('pg004','i003','g005','宠物用具1','80','1','e004');
insert into petgoods values('pg005','i003','g007','洗漱用品1','180','1','e004');
insert into petgoods values('pg006','i004','g008','洗漱用品2','280','2','e002');
insert into petgoods values('pg007','i005','g002','猫饲料2','50','5','e003');
insert into petgoods values('pg008','i005','g006','宠物用具2','80','5','e003');
insert into petgoods values('pg009','i001','g007','洗漱用品1','80','2','e002');
insert into petgoods values('pg010','i006','g002','猫饲料2','50','5','e003');
insert into petgoods values('pg011','i007','g006','宠物用具2','80','5','e003');
insert into petgoods values('pg012','i008','g007','洗漱用品1','80','2','e002');





insert into pets values('p001','i001','g009','苏格兰折耳猫','1','雌性','三个月','血统级','3000','e002');
insert into pets values('p002','i002','g011','布偶猫','1','雌性','三个月','血统级','13000','e004');
insert into pets values('p003','i004','g012','哈士奇','1','雄性','半年','宠物级','2000','e002');
insert into pets values('p004','i005','g013','拉布拉多','1','雄性','三个月','宠物级','2500','e004');
insert into pets values('p005','i006','g014','雪纳瑞犬','1','雄性','半年','宠物级','2500','e002');
insert into pets values('p006','i007','g013','拉布拉多','1','雄性','三个月','宠物级','2500','e004');


insert into massage values('c001','宠物用品质量有问题','e005','6','未解决');
insert into massage values('c002','宠物吃了饲料拉肚子','e006','7','未解决');
insert into massage values('c003','宠物用洗漱用品后掉毛','e006','7','未解决');
insert into massage values('c004','宠物玩具掉色','e005','6','未解决');



