--disable trigger trg_p1 on  petgoods;

--1创建触发器，当顾客购买商品时，更新或添加新的顾客、订单信息（普通商品）
create trigger trg_p1
on petgoods
instead of insert
as
declare @cId char(4),@cname char(20)--顾客单
declare @pgId char(8),@iId char(8),@price int,@numbers int--普通商品
declare @allprice int,@eId char(8),@gId char(8),@gname char(20)--订单表
begin
select @pgId=pgId,@iId=iId,@price=price,@numbers=numbers,@gId=gId,@gname=gname,@eId=eId from inserted --获取插入的信息
set @allprice=@price*@numbers
if exists (select pgId from petgoods where iId=@iId)--如果是旧顾客，更新订单信息
begin
update petgoods set numbers =numbers+@numbers where iId=@iId
print '已更新购买信息'
end 
if exists (select iId from ident where iId=@iId)--如果是旧顾客，更新订单信息
begin
update ident set allprice =cast((cast(allprice as int)+@allprice) as char(10)) where iId=@iId 
print '已更新订单,价格：'+cast(@allprice as varchar)
begin
insert into petgoods values(@pgId,@iId,@gId,@gname,@price,@numbers,@eId);
print '已插入购买记录'
end
end
else--如果是新顾客,创建新的顾客信息与订单信息
begin
declare @n int
select @n=count(*) from customer 
begin
if(@n<9)
set @cId='c00'+CAST(@n+1 as varchar)
else if(@n<99)
set @cId='c0'+CAST(@n+1 as varchar)
else if(@n<999)
set @cId='c'+CAST(@n+1 as varchar)
print '这是店里的第'+@cId+'位顾客'
end
begin
insert into customer values(@cId,null,null,null)
print '已添加顾客入系统，请尽快更新信息'
end
begin
insert into ident values(@iId,@cId,@allprice,@eId)
print '已创建订单'
end
begin
insert into petgoods values(@pgId,@iId,@gId,@gname,@price,@numbers,@eId);
print '已插入购买记录'
end
end
end



--2店员可从售出商品中抽取%5作为奖金(普通商品——新顾客购买时)
create trigger trg_pet3
on petgoods
after insert
as
declare @reward int,@numbers int,@price int,@eId char(8)
begin
select @numbers=numbers,@price=price,@eId=eId from inserted
set @reward=@numbers*@price*0.05
print '购买商品数：'+cast(@numbers as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR)
where eId=@eId
print '从售卖普通商品中可获奖金为'+cast(@reward as varchar)
end


--3店员可从售出商品中抽取%5作为奖金(普通商品——旧顾客购买时)
create trigger trg_pet4
on petgoods
for update
as
declare @reward int,@numbers int,@price int,@eId char(8)
declare @numbers1 int,@numbers2 int
begin
if update(numbers) 
begin
select @numbers1=numbers,@price=price from deleted
select @numbers2=cast(numbers as int) from inserted 
set @reward=(cast(@numbers2 as int)-cast(@numbers1 as int) )*@price*0.08
print '购买商品数：'+cast((cast(@numbers2 as int)-cast(@numbers1 as int) ) as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR)
where eId=@eId
print '从售卖宠物中可获奖金为'+cast(@reward as varchar)
end
end

insert into petgoods values('pg0017','i004','g005','宠物用具1','80','1','e004');
insert into petgoods values('pg0016','i0010','g005','宠物用具1','80','1','e004');
select * from pets
select * from customer
select * from ident






--4创建触发器，当顾客购买商品时，更新或添加新的顾客、订单信息（宠物）
create trigger trg_p2
on pets
instead of insert
as
declare @cId char(4),@cname char(20)--顾客单
declare @pId char(8),@iId char(8),@price int,@numbers int,@gId char(8),@gname char(20),
@gender char(5),@age char(8),@plevel char(10),@eId char(8)--宠物商品
declare @allprice int--订单表
begin
select @pId=pId,@iId=iId,@price=price,@numbers=numbers,@gender=gender,@age=age,@plevel=plevel,
@gId=gId,@gname=gname,@eId=eId from inserted --获取插入的信息
set @allprice=@price*@numbers
if exists (select pId from pets where iId=@iId)--如果是旧顾客，更新订单信息
begin
update pets set numbers =numbers+@numbers where iId=@iId
print '已更新购买信息'
end 
if exists (select iId from ident where iId=@iId)--如果是旧顾客，更新订单信息
begin
update ident set allprice =cast((cast(allprice as int)+@allprice) as char(10)) where iId=@iId 
print '已更新订单'+cast(@allprice as varchar)
begin
insert into pets values(@pId,@iId,@gId,@gname,@numbers,@gender,@age,@plevel,@price,@eId);
print '已插入购买记录'
end
end
else--如果是新顾客,创建新的顾客信息与订单信息
begin
declare @n int
select @n=count(*) from customer 
begin
if(@n<9)
set @cId='c00'+CAST(@n+1 as varchar)
else if(@n<99)
set @cId='c0'+CAST(@n+1 as varchar)
else if(@n<999)
set @cId='c'+CAST(@n+1 as varchar)
print '这是店里的第'+@cId+'位顾客'
end
begin
insert into customer values(@cId,null,null,null)
print '已添加顾客入系统，请尽快更新信息'
end
begin
insert into ident values(@iId,@cId,@allprice,@eId)
print '已创建订单'
end
begin
insert into pets values(@pId,@iId,@gId,@gname,@numbers,@gender,@age,@plevel,@price,@eId);
print '已插入购买记录'
end
end
end
insert into pets values('p008','i001','g014','雪纳瑞犬','1','雄性','三个月','宠物级','2500','e003');
insert into pets values('p007','i012','g014','雪纳瑞犬','1','雄性','三个月','宠物级','2500','e003');
select * from stock

--5店员可从售出商品中抽取%8作为奖金(宠物-新顾客购买时)
create trigger trg_pet5
on pets
for insert
as
declare @reward int,@numbers int,@price int,@eId char(8)
begin
select @numbers=numbers,@price=price,@eId=eId from inserted
set @reward=@numbers*@price*0.08
print '购买商品数：'+cast(@numbers as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR)
where eId=@eId
print '从售卖宠物中可获奖金为'+cast(@reward as varchar)
end



--6店员可从售出商品中抽取%8作为奖金(宠物-旧顾客购买时)
create trigger trg_pet6
on pets
for update
as
declare @reward int,@numbers1 int,@numbers2 int,@price int,@eId char(8)
begin
if update(numbers) 
begin
select @numbers1=numbers,@price=price from deleted
print @numbers1
select @numbers2=cast(numbers as int) from inserted 
set @reward=(cast(@numbers2 as int)-cast(@numbers1 as int) )*@price*0.08
print '购买商品数：'+cast((cast(@numbers2 as int)-cast(@numbers1 as int) )as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR) 
where eId=@eId
print '从售卖宠物中可获奖金为'+cast(@reward as varchar)
end
end








--7用户评分，如果超出范围(1~10)则插入数据失败
alter trigger trg_pet7
on massage
instead of insert
as
declare @cId char(8),@massage char(20),@eId char(8),@score int,@states char(10)
begin
select @score=cast(score as int),@cId=cId,@massage=massage ,@eId=eId,@states=states from inserted
if(@score<=0 or @score>10)
begin
print '你的评价分数必须在1~10分的范围，评价失败'
end
else 
begin
insert into massage values(@cId,@massage,@eId,@score,@states)
print '评价成功'
end
end

insert into massage values('c005','用具被狗咬坏了','e004','7','已解决');

select * from massage


--8如果售后帮客户解决了问题，员工可获工资的%3作为奖金
create trigger  trg_pets8
on massage
for update
as
declare @cId char(8),@eId char(8),@states char(10),@reward int,@payId char(8),@basepay char(10)
begin
if update(states)
begin
select @eId=eId,@cId=cId,@eId=eId,@states=states from deleted
end
if(@states='已解决')
begin
select @reward=reward,@payId=payId from empoyees where eId=@eId
select @basepay=basepay from payroll where payId=@payId
set @reward=cast(@basepay as int)*0.03
update empoyees set finalwages =cast(finalwages as bigint) +cast(@reward as bigint),reward=@reward  where eId=@eId
print '已加奖金'
print @reward
end
end

update massage set states ='已解决' where cId='c001'
select * from empoyees
select * from massage