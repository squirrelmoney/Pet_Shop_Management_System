--disable trigger trg_p1 on  petgoods;

--1���������������˿͹�����Ʒʱ�����»�����µĹ˿͡�������Ϣ����ͨ��Ʒ��
create trigger trg_p1
on petgoods
instead of insert
as
declare @cId char(4),@cname char(20)--�˿͵�
declare @pgId char(8),@iId char(8),@price int,@numbers int--��ͨ��Ʒ
declare @allprice int,@eId char(8),@gId char(8),@gname char(20)--������
begin
select @pgId=pgId,@iId=iId,@price=price,@numbers=numbers,@gId=gId,@gname=gname,@eId=eId from inserted --��ȡ�������Ϣ
set @allprice=@price*@numbers
if exists (select pgId from petgoods where iId=@iId)--����Ǿɹ˿ͣ����¶�����Ϣ
begin
update petgoods set numbers =numbers+@numbers where iId=@iId
print '�Ѹ��¹�����Ϣ'
end 
if exists (select iId from ident where iId=@iId)--����Ǿɹ˿ͣ����¶�����Ϣ
begin
update ident set allprice =cast((cast(allprice as int)+@allprice) as char(10)) where iId=@iId 
print '�Ѹ��¶���,�۸�'+cast(@allprice as varchar)
begin
insert into petgoods values(@pgId,@iId,@gId,@gname,@price,@numbers,@eId);
print '�Ѳ��빺���¼'
end
end
else--������¹˿�,�����µĹ˿���Ϣ�붩����Ϣ
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
print '���ǵ���ĵ�'+@cId+'λ�˿�'
end
begin
insert into customer values(@cId,null,null,null)
print '����ӹ˿���ϵͳ���뾡�������Ϣ'
end
begin
insert into ident values(@iId,@cId,@allprice,@eId)
print '�Ѵ�������'
end
begin
insert into petgoods values(@pgId,@iId,@gId,@gname,@price,@numbers,@eId);
print '�Ѳ��빺���¼'
end
end
end



--2��Ա�ɴ��۳���Ʒ�г�ȡ%5��Ϊ����(��ͨ��Ʒ�����¹˿͹���ʱ)
create trigger trg_pet3
on petgoods
after insert
as
declare @reward int,@numbers int,@price int,@eId char(8)
begin
select @numbers=numbers,@price=price,@eId=eId from inserted
set @reward=@numbers*@price*0.05
print '������Ʒ����'+cast(@numbers as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR)
where eId=@eId
print '��������ͨ��Ʒ�пɻ񽱽�Ϊ'+cast(@reward as varchar)
end


--3��Ա�ɴ��۳���Ʒ�г�ȡ%5��Ϊ����(��ͨ��Ʒ�����ɹ˿͹���ʱ)
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
print '������Ʒ����'+cast((cast(@numbers2 as int)-cast(@numbers1 as int) ) as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR)
where eId=@eId
print '�����������пɻ񽱽�Ϊ'+cast(@reward as varchar)
end
end

insert into petgoods values('pg0017','i004','g005','�����þ�1','80','1','e004');
insert into petgoods values('pg0016','i0010','g005','�����þ�1','80','1','e004');
select * from pets
select * from customer
select * from ident






--4���������������˿͹�����Ʒʱ�����»�����µĹ˿͡�������Ϣ�����
create trigger trg_p2
on pets
instead of insert
as
declare @cId char(4),@cname char(20)--�˿͵�
declare @pId char(8),@iId char(8),@price int,@numbers int,@gId char(8),@gname char(20),
@gender char(5),@age char(8),@plevel char(10),@eId char(8)--������Ʒ
declare @allprice int--������
begin
select @pId=pId,@iId=iId,@price=price,@numbers=numbers,@gender=gender,@age=age,@plevel=plevel,
@gId=gId,@gname=gname,@eId=eId from inserted --��ȡ�������Ϣ
set @allprice=@price*@numbers
if exists (select pId from pets where iId=@iId)--����Ǿɹ˿ͣ����¶�����Ϣ
begin
update pets set numbers =numbers+@numbers where iId=@iId
print '�Ѹ��¹�����Ϣ'
end 
if exists (select iId from ident where iId=@iId)--����Ǿɹ˿ͣ����¶�����Ϣ
begin
update ident set allprice =cast((cast(allprice as int)+@allprice) as char(10)) where iId=@iId 
print '�Ѹ��¶���'+cast(@allprice as varchar)
begin
insert into pets values(@pId,@iId,@gId,@gname,@numbers,@gender,@age,@plevel,@price,@eId);
print '�Ѳ��빺���¼'
end
end
else--������¹˿�,�����µĹ˿���Ϣ�붩����Ϣ
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
print '���ǵ���ĵ�'+@cId+'λ�˿�'
end
begin
insert into customer values(@cId,null,null,null)
print '����ӹ˿���ϵͳ���뾡�������Ϣ'
end
begin
insert into ident values(@iId,@cId,@allprice,@eId)
print '�Ѵ�������'
end
begin
insert into pets values(@pId,@iId,@gId,@gname,@numbers,@gender,@age,@plevel,@price,@eId);
print '�Ѳ��빺���¼'
end
end
end
insert into pets values('p008','i001','g014','ѩ����Ȯ','1','����','������','���Ｖ','2500','e003');
insert into pets values('p007','i012','g014','ѩ����Ȯ','1','����','������','���Ｖ','2500','e003');
select * from stock

--5��Ա�ɴ��۳���Ʒ�г�ȡ%8��Ϊ����(����-�¹˿͹���ʱ)
create trigger trg_pet5
on pets
for insert
as
declare @reward int,@numbers int,@price int,@eId char(8)
begin
select @numbers=numbers,@price=price,@eId=eId from inserted
set @reward=@numbers*@price*0.08
print '������Ʒ����'+cast(@numbers as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR)
where eId=@eId
print '�����������пɻ񽱽�Ϊ'+cast(@reward as varchar)
end



--6��Ա�ɴ��۳���Ʒ�г�ȡ%8��Ϊ����(����-�ɹ˿͹���ʱ)
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
print '������Ʒ����'+cast((cast(@numbers2 as int)-cast(@numbers1 as int) )as varchar)
update empoyees set reward=cast((cast(reward as int)+@reward) as CHAR),
finalwages=cast((cast(finalwages as int)+@reward) as CHAR) 
where eId=@eId
print '�����������пɻ񽱽�Ϊ'+cast(@reward as varchar)
end
end








--7�û����֣����������Χ(1~10)���������ʧ��
alter trigger trg_pet7
on massage
instead of insert
as
declare @cId char(8),@massage char(20),@eId char(8),@score int,@states char(10)
begin
select @score=cast(score as int),@cId=cId,@massage=massage ,@eId=eId,@states=states from inserted
if(@score<=0 or @score>10)
begin
print '������۷���������1~10�ֵķ�Χ������ʧ��'
end
else 
begin
insert into massage values(@cId,@massage,@eId,@score,@states)
print '���۳ɹ�'
end
end

insert into massage values('c005','�þ߱���ҧ����','e004','7','�ѽ��');

select * from massage


--8����ۺ��ͻ���������⣬Ա���ɻ��ʵ�%3��Ϊ����
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
if(@states='�ѽ��')
begin
select @reward=reward,@payId=payId from empoyees where eId=@eId
select @basepay=basepay from payroll where payId=@payId
set @reward=cast(@basepay as int)*0.03
update empoyees set finalwages =cast(finalwages as bigint) +cast(@reward as bigint),reward=@reward  where eId=@eId
print '�Ѽӽ���'
print @reward
end
end

update massage set states ='�ѽ��' where cId='c001'
select * from empoyees
select * from massage