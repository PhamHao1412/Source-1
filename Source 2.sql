-- Đề số 2 - Thực hành SQL server

-- Câu 1
use master
go
	if exists(select * from sys.databases where name='De2')
	drop database De2
go
	create database De2
go
	use De2
go
--------------------
create table Doi
(	MSDoi int primary key,
	TenDoi varchar(40),
	Phai bit
)
--------------------
create table TranDau
(	MSTD int primary key,
	NgayTD datetime,
	GioBD smalldatetime,	
	GioKT smalldatetime ,
)
--------------------
create table DoiThiDau
(	MSTD int references TRANDAU(MSTD),
	MSDOI int,
	primary key(MSTD,MSDoi),
	foreign key(MSDOI) references Doi(MSDOI),
)

-- Câu 2
go
Alter table TranDau ADD
	check(GioBD < GioKT),
	unique(GioBD,NgayTD)
--------------------
go
insert into Doi values (1,'Hoang Anh Gia Lai','True')
insert into Doi values (2,'Hoang Anh Gia Lai','False')
insert into Doi values (3,'Dong Tam Long An','True')
insert into Doi values (4,'SHB Da Nang','True')
insert into Doi values (5,'SHB Da Nang','False')
insert into Doi values (6,'Dong Nai','False')
insert into TranDau values (1,'10/10/1998','10/10/1998 2:00:00 PM','10/10/1998 4:00:00 PM')
insert into TranDau values (2,'10/10/1998','10/10/1998 5:00:00 PM','10/10/1998 7:00:00 PM')
insert into TranDau values (3,'10/11/1998','10/10/1998 7:00:00 PM','10/10/1998 9:00:00 PM')
insert into TranDau values (4,'10/12/1998','10/10/1998 6:15:00 AM','10/10/1998 8:15:00 AM')
insert into TranDau values (5,'10/12/1998','10/10/1998 3:30:00 PM','10/10/1998 5:30:00 PM')
insert into TranDau values (6,'10/12/1998','10/10/1998 7:00:00 PM','10/10/1998 9:00:00 PM')
insert into DoiThiDau values (1,1)
insert into DoiThiDau values (1,3)
insert into DoiThiDau values (2,1)
insert into DoiThiDau values (2,4)
insert into DoiThiDau values (3,2)
insert into DoiThiDau values (3,5)
------------------

-- Câu 3
go
create view vwDoiChuaThiDau
as
	select * from Doi A
	where A.MSDoi NOT IN (select B.MSDoi from DoiThiDau B)
--------------------
go
create view vwSoTranDau
as
	select NgayTD, SoTD=count(MSTD)
	from TranDau
	group by NgayTD
--------------------
go

-- Câu 4,5

create proc ThongTinTD(@MSTD int)
as
if NOT exists (select * from DoiThiDau where MSTD = @MSTD)
	Begin
		print'Tran dau khong ton tai'
	End
else
	Begin
		select MSTD,DoiThiDau.MSDoi,TenDoi,Phai 
		from DoiThiDau join Doi on DoiThiDau.MSDoi = Doi.MSDoi
		where MSTD = @MSTD
	End

--------------------
go
exec ThongTinTD 2