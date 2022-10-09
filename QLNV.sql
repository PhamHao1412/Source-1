--Phạm Anh Hào
--2011064226
create database QLNV
on
(
	name='QLNV_Data',
	filename='D:\Database\QLNV.MDF'
)
log on
(
	name='QLNV_Log',
	filename='D:\Database\QLNV.LDF'
)
use QLNV
create table NHANVIEN
(
	MANV char(4) primary key,
	TENNV nvarchar(30) ,
	MAVT char(4) ,
	MAPB char(4),
	
	LUONG bigint check(Luong >=4000000),
	NGAYVL date, 

	foreign key (MAVT) references VITRI(MAVT)
	on update cascade
	on delete cascade,
	foreign key (MAPB) references PHONGBAN(MAPB)
	on update cascade
	on delete cascade,

)
create table PHONGBAN
(
	MAPB char(4) primary key,
	TENPB nvarchar(10),
	DIACHI nvarchar(40),
	NGAYTL date,
	MANV char(4)
)
create table VITRI
(
	MAVT char(4) primary key,
	MOTA nvarchar(30)
)
--CAU 3
select N.MANV , TENNV
from NHANVIEN N, PHONGBAN P
where N.MAPB=P.MAPB and P.TENPB = N'Đào Tạo'
group by N.MANV , TENNV
ORDER BY TENNV ASC
4
select TENNV,NGAYTL
FROM NHANVIEN
WHERE 

--CAU 6
select TENPB , LUONG
from PHONGBAN P , NHANVIEN N
where P.MANV = N.MANV and LUONG > 500000


