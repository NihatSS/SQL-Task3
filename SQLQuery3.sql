--select * from Teachers where [Id] > 2

--create view vw_GetTeachers as
--select * from Teachers where [Id] > 2

--select * from dbo.vw_GetTeachers


--create view vw_GetTeachersWithGroups
--as
--select tc.FullName as 'FullName', gr.Name as 'Group' from Teachers tc 
--join TeacherGroups tg
--on tc.Id= tg.TeacherId
--join Groups gr
--on gr.Id= tg.GroupId  


--select * from vw_GetTeachersWithGroups

--create function fn_SumOfNums()
--returns int
--begin
--	return 25+10
--end

--select dbo.fn_SumOfNums()

--create function fn_SumOFNumbers(@num1 int, @num2 int)
--returns int
--begin
--	return @num1+@num2
--end

--select dbo.fn_SumOFNumbers(10,12) as 'Sum'


--create function fn_GetStudentsAvgAge()
--returns int
--begin
--  return (select AVG(Age) from Students)
--end


--select dbo.fn_GetStudentsAvgAge()

--select Sum(Age) from Students where [Id] > 3

--create function fn_GetStudentsAgeSumById(@id int)
--returns int
--begin
--	declare @sum int = (select SUM(Age) from Students where [Id] > @id)
--	return @sum
--end

--select dbo.fn_GetStudentsAgeSumById(4) as 'Sum'

--select dbo.fn_GetStudentsAgeSumById(3) as 'Sum'

--create function fn_GetText(@text nvarchar(100))
--returns nvarchar(100)
--begin
--	return @text
--end


--select dbo.fn_GetText('Salam Cavid muellim')

--create function fn_GetTeachers()
--returns table
--as
--return
--select * from Teachers


--select * from fn_GetTeachers()


--create view vw_GetStudentsByAvgAgeWithContiditon
--as
--select * from Students where [Age] > (select dbo.fn_GetStudentsAvgAge())

--select * from vw_GetStudentsByAvgAgeWithContiditon


--create procedure usp_ShowText
--as
--print 'Salam Cavid muellim'


--exec usp_ShowText

--create procedure usp_ShowTextWithParametr
--@text nvarchar(100)
--as
--print @text

--exec usp_ShowTextWithParametr 'Salam Cavid muellim'

--select * from Teachers

--create procedure usp_AddTeacher
--@FullName nvarchar(100),
--@Address nvarchar(100),
--@Email nvarchar(100),
--@Salary int
--as
--insert into Teachers([FullName],[Address],[Email],[Salary])
--values(@FullName,@Address,@Email,@Salary)

--exec usp_AddTeacher 'Nihat Soltanov', 'Ecemi','nihat@gmail.com',4000  


create procedure usp_DeleteTeacherById
@id int
as 
delete from TeacherGroups where [TeacherId] = @id
delete from Teachers where [Id] = @id


exec usp_DeleteTeacherById 2

select * from Teachers

alter table Teachers
add SoftDeletes bit not null default 0
with values

update Teachers
set SoftDeletes = 1
where [Id] = 3

select * from Teachers where [SoftDeletes] = 'false'


create procedure usp_SoftDeleteTeacherById
@id int
as
update Teachers
set SoftDeletes = 1
where [Id] = @id

exec usp_SoftDeleteTeacherById 4

select * from Teachers

alter table Cities
add SoftDeleted bit not null default 0
with values


create function fn_CitiesCount()
returns int
begin
declare @count int = (select COUNT(*) from Cities)
return @count
end


create procedure usp_SoftDeleteCitiesById
as
update Cities
set SoftDeleted = 1
where [Id] > dbo.fn_CitiesCount()


insert into Cities([Name],[CountryId])
values('Salyan',1),
	  ('New York',null)

exec usp_SoftDeleteCitiesById

select * from Cities

