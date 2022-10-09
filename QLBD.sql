create database QLBD
on
(
	name='QLBD_Data',
	filename='D:\Database\QLBD.MDF'
)
log on
(
	name='QLBD_Log',
	filename='D:\Database\QLBD.LDF'
)
use QLBD
create table SAN
(
	MaSan	char(3)	primary key,
	TenSan	nvarchar(50),
	DiaChi	nvarchar(50)
)
create table DOI
(
	MaDoi char(3) primary key,
	TenDoi nvarchar(50),

)
create table TRANDAU
(
	MaTD char(2) primary key,
	MaSan char(3),
	Ngay date,
	Gio time,
	foreign key (MaSan) references SAN(MaSan)
	on update cascade --Sửa Mã lớp trong LOP thì Mã lớp trong SV sửa theo

)
drop table SAN
create table CT_TRANDAU
(
	MaTD char(2),
	MaDoi char (3),
	primary key (MaTD,MaDoi),
	SoBanThang tinyint check(SoBanThang >=0)
	foreign key (MaTD) references TRANDAU(MaTD)
	on update cascade
	on delete cascade,
	foreign key (MaDoi) references DOI(MaDoi)
	on update cascade
	on delete cascade
)
drop table CT_TRANDAU

1
select D.MaDoi , TenDoi , count(*) as[Số trận đấu]
from DOI D ,  CT_TRANDAU CT
where D.MaDoi = CT.MaDoi
group by D.MaDoi , TenDoi
2
select A.MATD , A.MADOI + '- ' + B.MADOI as [Trận đấu],
	   str(A.SOBANTHANG,2) + ' -' +
	   str(B.SOBANTHANG,2) as[Tỉ số]
from CT_TRANDAU A , CT_TRANDAU B
where A.MATD = B.MATD and A.MADOI>B.MADOI
3
-Giải câu 3
select a.MaTD, a.MaDoi, [Điểm] = 
							  case 
							  when  a.SoBanThang > b.SoBanThang then 3
							  when  a.SoBanThang = b.SoBanThang then 1
							  else 0
							  end
from CT_TranDau a, CT_TranDau b
where a.MaTD=b.MaTD and a.maDoi<>b.MaDoi
--dùng iif
select a.MaTD, a.MaDoi, [Điểm] = iif(a.SoBanThang > b.SoBanThang, 3,
									iif(a.SoBanThang = b.SoBanThang, 1, 0))
from CT_TranDau a, CT_TranDau b
where a.MaTD=b.MaTD and a.maDoi<>b.MaDoi
4
select D.MaDoi,TenDoi,sum(SoBanThang)as [Tổng số điểm]
from DOI D,CT_TRANDAU a,CT_TranDau b
where D.MaDoi= CT.MaDoi and a.MaTD=b.MaTD and a.maDoi<>b.MaDoi
group by D.MaDoi,TenDoi