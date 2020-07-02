--1ͨ���洢����ͳ�ƿͻ�������Ʒ��Ϣ
create proc pet1 @cId char(8)
as
begin
select  gname,numbers,price
from petgoods 
where iId in(
select iId  from ident 
where cId=@cId
)union 
select gname,numbers,price
from pets
where iId in(
select iId from ident 
where cId=@cId
)
end

execute pet1 'c001'




--2���������ְ,����һ�����������
create proc pet2
@e1 char(8),@e2 char(8)
as
begin
if exists (select * from ident where eid=@e2)
update ident
set eId=@e1
where eId=@e2
if exists (select * from stock where eid=@e2)
update stock
set eId=@e1
where eId=@e2
if exists (select * from massage where eid=@e2)
update massage
set eId=@e1
where eId=@e2
delete from empoyees where eId=@e2
end

declare @e1 char(8),@e2 char(8)
execute pet2 'e001','e002'
select * from empoyees
select * from ident


--3�����洢����,��ѯ�Ƿ���һ�����Ա�Ĺ�����6000Ԫ֮��
--��������ֱ�ÿ�θ�ÿ����Ա��н300Ԫ,��֮һ���Ա�Ĺ��ʴﵽ6000����
alter proc pet3 
@a char(8)
as
declare @allPeople int,@renshu int,@addsalary int
begin
set @addsalary=0
select @allPeople=count(*) from empoyees
while 1=1
begin
select @renshu=count(*) 
from empoyees 
where payId in(
select payId
from payroll
where salary>=@a)
if @renshu<(@allPeople/2)
begin
update payroll set salary=salary+300,basepay=basepay+300
update empoyees set finalwages=finalwages+300
set @addsalary=@addsalary+300
end
else
begin
break
end
end
print '���ӹ���'+convert(varchar(10), @addsalary)+'Ԫ'
end

exec pet3'6000'
select * from payroll
select * from empoyees


--4ͨ���洢����ʵ�ֽ���
alter proc pet4
@gId char(8),
@gname char(20),
@priceIn char(10),
@Number int,
@eId char(8),
@tId char(8)
as
declare @GNumber int=0
begin 
if exists (select * from stock where gId=@gId) --�жϵ�ǰ��Ʒ��û�н�����¼
begin
update stock
set goodsin=goodsin+@Number,present+=@Number
where gId=@gId 
end 
else --�����Ʒ����û�й�������¼����ô��Ӧ������µĴ�����Ϣ
begin
insert into stock values(@gId,@gname,@priceIn,'0',@Number,'0',@Number,@eId,@tId)  
end
end

declare  @gId char(8),@gname char(20),@priceIn char(10),@Number int,@eId char(8),@tId char(8)
exec pet4 'g001','è����1','30',20,'e007','t001'
exec pet4 'g015','è����3','40',20,'e007','t001'
select * from stock
update stock set goodsout='0' where gId='g014'




--5ͨ���洢���̼���������Ʒ��������
alter proc pet5
@gId char(8)
as
declare @lirun bigint
begin
select @lirun=(cast(goodsin as int)-cast(goodsout as int))*(cast(priceout as int)-cast(priceIn as int))
from stock
where gId=@gId
end
begin
print @lirun
end

exec pet5'g001'



--6ͨ����ѯ���̲���Ա����Ϣ
alter proc pet6
@eId char(8)
as
declare @ename char(10),@position char(10),@tel char(20),@salary char(10)
begin
if exists (select * from empoyees where eId=@eId)
begin
select @ename=ename,@tel=tel
from empoyees
where eId=@eId
select @position =position
from positions 
where positionId=(
select positionId
from empoyees
where eId=@eId)
select @salary=salary 
from payroll
where payId=(
select payId
from empoyees
where eId=@eId)
print 'Ա����:'+@eId+'Ա������'+@ename +'ְλ��'+@position+'�绰��'+@tel+'���ʣ�'+@salary
end
else
begin
print'��Ա��������'
end
end


exec pet6'e001'


--7ͨ���洢����ʵ�ַǳ�������Ʒ�˻�
alter proc pet7
@pgId char(8),@number char(8)--�����˻���Ʒ��������
as
declare @cId char(8),@price int,@num char(8)
begin
select @price=price,@num=numbers--����Ҫ�˻�����Ʒ�۸��빺������
from petgoods
where pgId=@pgId
select @cId=cid--����Ҫ�˻��Ŀͻ���
from ident
where iId=(
select iId
from petgoods
where pgId=@pgId)
end
if(@number=@num)--���Ҫ�˻�����Ʒ�빺��������ȣ�ɾ���ü�¼
begin
delete from petgoods
where pgId=@pgId
if exists (select * from petgoods
          where iId=
          (select iId
          from ident where cId=@cId))--����ÿͻ�����ͨ��Ʒ������������
begin
update ident --���¶����ܼ۸�
set allprice=cast(allprice as int)-cast(@price as int)*cast(@num as int)
where cid=@cId
print '�˻��ɹ����Ѱѿͻ���Ϣ����'
end
else if exists (select * from pets--����ÿͻ�����ͨ��Ʒû��������������������Ʒ������������
				  where iId=(
				  select iId
				  from ident where cId=@cId))
begin
update ident --���¶����ܼ۸�
set allprice=cast(allprice as int)-cast(@price as int)*cast(@num as int)
where cid=@cId
print '�˻��ɹ����Ѱѿͻ���Ϣ����'
end
else--����ÿͻ���û����Ʒ��
begin
delete from ident where cId=@cId--ɾ���ڶ����ļ�¼
delete from customer where cId=@cId--ɾ���ڿͻ���Ķ���
print '�ÿͻ��˻������������������ѰѸÿͻ������ݿ���ɾ��'
end
end
else if(@number <@num)
begin
update petgoods set numbers=@number where pgId=@pgId
end


declare @pgId char(8),@number char(8)
exec pet7'pg002','2'
select * from petgoods

--���¿ͻ���Ϣ
create proc pet8 
@cId char(8), @cname char(20),@tel char(11),@gender char(2)
as
begin
update customer
set cname=@cname,tel=@tel,gender=@gender
where cId=@cId
end

declare @cId char(8), @cname char(20),@tel char(11),@gender char(2)
exec pet8'c005','�˿�9','12594687563','Ů'
select * from customer