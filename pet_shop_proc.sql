--1通过存储过程统计客户购买商品信息
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




--2若有人请辞职,找另一个人替代工作
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


--3创建存储过程,查询是否有一半程序员的工资在6000元之上
--如果不到分别每次给每个店员加薪300元,至之一半店员的工资达到6000以上
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
print '共加工资'+convert(varchar(10), @addsalary)+'元'
end

exec pet3'6000'
select * from payroll
select * from empoyees


--4通过存储过程实现进货
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
if exists (select * from stock where gId=@gId) --判断当前商品有没有进货记录
begin
update stock
set goodsin=goodsin+@Number,present+=@Number
where gId=@gId 
end 
else --这个商品从来没有过进货记录，那么就应该添加新的存在信息
begin
insert into stock values(@gId,@gname,@priceIn,'0',@Number,'0',@Number,@eId,@tId)  
end
end

declare  @gId char(8),@gname char(20),@priceIn char(10),@Number int,@eId char(8),@tId char(8)
exec pet4 'g001','猫饲料1','30',20,'e007','t001'
exec pet4 'g015','猫饲料3','40',20,'e007','t001'
select * from stock
update stock set goodsout='0' where gId='g014'




--5通过存储过程计算卖出商品所得利润
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



--6通过查询过程查找员工信息
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
print '员工号:'+@eId+'员工名：'+@ename +'职位：'+@position+'电话：'+@tel+'工资：'+@salary
end
else
begin
print'该员工不存在'
end
end


exec pet6'e001'


--7通过存储过程实现非宠物类商品退货
alter proc pet7
@pgId char(8),@number char(8)--输入退货商品号与数量
as
declare @cId char(8),@price int,@num char(8)
begin
select @price=price,@num=numbers--查找要退货的商品价格与购买总数
from petgoods
where pgId=@pgId
select @cId=cid--查找要退货的客户号
from ident
where iId=(
select iId
from petgoods
where pgId=@pgId)
end
if(@number=@num)--如果要退货的商品与购买总数相等，删除该记录
begin
delete from petgoods
where pgId=@pgId
if exists (select * from petgoods
          where iId=
          (select iId
          from ident where cId=@cId))--如果该客户在普通商品还有其它订单
begin
update ident --更新订单总价格
set allprice=cast(allprice as int)-cast(@price as int)*cast(@num as int)
where cid=@cId
print '退货成功，已把客户信息更新'
end
else if exists (select * from pets--如果该客户在普通商品没有其它订单，但宠物商品还有其它订单
				  where iId=(
				  select iId
				  from ident where cId=@cId))
begin
update ident --更新订单总价格
set allprice=cast(allprice as int)-cast(@price as int)*cast(@num as int)
where cid=@cId
print '退货成功，已把客户信息更新'
end
else--如果该客户都没有商品了
begin
delete from ident where cId=@cId--删除在订单的记录
delete from customer where cId=@cId--删除在客户表的订单
print '该客户退货后已无其它订单，已把该客户从数据库中删除'
end
end
else if(@number <@num)
begin
update petgoods set numbers=@number where pgId=@pgId
end


declare @pgId char(8),@number char(8)
exec pet7'pg002','2'
select * from petgoods

--更新客户信息
create proc pet8 
@cId char(8), @cname char(20),@tel char(11),@gender char(2)
as
begin
update customer
set cname=@cname,tel=@tel,gender=@gender
where cId=@cId
end

declare @cId char(8), @cname char(20),@tel char(11),@gender char(2)
exec pet8'c005','顾客9','12594687563','女'
select * from customer