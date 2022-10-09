
*/

-- Đề số 1 - Thực hành SQL Server

use master
go
	if exists(select * from sys.databases where name='De1')
	drop database De1
go
	create database De1
go
x`
go
--------------------
--Câu 1 : Tạo TABLE
create table SinhVien
(	MSSV int identity(1,1) primary key,
	Lop varchar(10),
	Ho varchar(10),
	Ten varchar(30),
	NgaySinh datetime,
	Nu bit
)
--------------------
create table MonHoc
(	MSMon int identity(1,1) primary key,
	TenMon varchar(30)
)
--------------------
create table DiemThi
(	MSSV int,
	MSMon int,
	LanThi int,
	Diem int,
	primary key(MSSV,MSMon,LanThi),
	foreign key(MSSV) references SinhVien(MSSV),
	foreign key(MSMon) references MonHoc(MSMon),
)
--Câu 2 : Bổ sung ràng buộc
go
Alter table DiemThi	ADD
	default 1 for LanThi,
	check(Diem between 0 and 10)
--------------------
insert into SinhVien values ('07ct112','Nguyen','Hoang Long','11/10/1989','True')
insert into SinhVien values ('07ct112','Le','Ngoc Nam','11/10/1989','True')
insert into SinhVien values ('07ct112','Le','Thanh Phuc','12/25/1989','True')
	--------------------
insert into MonHoc values ('SQL 2005')
insert into MonHoc values ('TTHCM')
	--------------------
insert into DiemThi values(1,1,1,10)
	--------------------
insert into DiemThi values(2,1,1,7)
insert into DiemThi values(2,1,2,9)
	--------------------
insert into DiemThi values(3,1,1,8)
insert into DiemThi values(3,2,1,2)
insert into DiemThi values(3,2,2,6)
insert into DiemThi values(3,2,3,10)
--------------------
--Câu 3.1) Tạo view vwLanThiCuoi
go
create view vwLanThiCuoi
as
	select MSSV, MSMon, LanThi=max(LanThi)
	from DiemThi
	group by MSSV, MSMon	
--------------------
--Câu 3.2) Tạo view vwDiemThiCuoi
go
create view vwDiemThiCuoi
as
with BangTam AS(select MSSV, MSMon, LanThiMax=max(LanThi) from DiemThi
					group by MSSV, MSMon) 
select D.*
from BangTam B join DiemThi D on (B.MSSV=D.MSSV and B.MSMon=D.MSMon and B.LanThiMAX =D.LanThi)
--------------------
--Câu 4 : Tạo trigger
GO
create trigger itrg_AutoLanThi on DiemThi
for INSERT
AS
	declare @MSSV int
	declare @MSMon int
	select @MSSV = MSSV,@MSMon = MSMon from inserted
	if NOT EXISTS (select * from DiemThi where MSSV=@MSSV and MSMon=@MSMon)
		begin
			print'MSSV them vao khong ton tai'
			rollback tran
			return
		end
	update DiemThi set DiemThi.LanThi = DiemThi.LanThi + 1
	from INSERTED I where I.MSSV=@MSSV and I.MSMon=@MSMon
--------------------
--Câu 5 : Tạo thủ tục
go
create proc ThongTinSV(@MSSV int=1)
as
Begin
	select MSMon,LanThi,Diem
	from DiemThi
	where MSSV = @MSSV
End
--------------------
go
exec ThongTinSV 3
go
insert into DiemThi(MSSV,MSMon,Diem) values(4,1,7)
