create database MAYBAY
on
(
	name='MayBay_Data',
	filename='D:\Database\MAYBAY.MDF'
)
log on
(
	name='MayBay_Log',
	filename='D:\Database\MAYBAY.LDF'
)
use MAYBAY
create table MAYBAY
(
	MAMB int primary key,
	Loai varchar(50),
	TamBay int
)

create table CHUYENBAY
(
	MACB char(5) primary key,
	GADI varchar(50),
	GADEN varchar(50),
	DODAI int,
	GIODI time,
	GIODEN time,
	CHIPHI int,
	MAMB int,
	foreign key(MAMB) references MAYBAY(MAMB)
	on update cascade
	on delete set NULL

)
create table NHANVIEN
(
	MANV char(9) primary key,
	TEN nvarchar(50),
	LUONG int
)
create table CHUNGNHAN
(
	MANV char(9),
	MAMB int,
	primary key(MANV,MAMB),
	foreign key (MANV) references NHANVIEN(MANV)
	on update cascade
	on delete cascade,
	foreign key (MAMB) references MAYBAY(MAMB)
	on update cascade
	on delete cascade

)
--1)Cho biết các chuyến bay đi Đà Lạt (DAD).
select * 
from CHUYENBAY 
where GADEN='DAD'
--2)Cho biết các loại máy bay có tầm bay lớn hơn 10,000km.
select MAMB,Loai
from MAYBAY
where TamBay > 10000
--3)Tìm các nhân viên có lương nhỏ hơn 10,000.
select MANV,TEN
from NHANVIEN
where LUONG <10000
--4)Cho biết các chuyến bay có độ dài đường bay nhỏ hơn 10.000km và lớn hơn 8.000km.
select C.*
from MAYBAY M,CHUYENBAY C
where M.MAMB=C.MAMB and TamBay in (
	select MAMB
	from MAYBAY
	where TamBay < 100000 and TamBay > 8000
 )
 group by 
 --18)Với mỗi ga có chuyến bay xuất phát từ đó cho biết có bao nhiêu chuyến bay khởi hành từ ga đó.
select GADI,count(MACB) as [Số chuyên xuất phát]
from CHUYENBAY
group by GADI
--19)Với mỗi ga có chuyến bay xuất phát từ đó cho biết tổng chi phí phải trả cho phi công lái các chuyến bay khởi hành từ ga đó.
select GADI,sum(LUONG) as [Tổng chi phí phải trả]
from CHUYENBAY C, MAYBAY M,CHUNGNHAN CH,NHANVIEN N
where C.MAMB=M.MAMB and M.MAMB=CH.MAMB and CH.MANV=N.MANV
group by GADI 
20)	Với mỗi địa điểm xuất phát cho biết có bao nhiêu chuyến bay có thể 
khởi hành trước 12:00.
select GaDi, count(MaCB) as [Số chuyến khởi hành]
from CHUYENBAY
where GioDi < '12:00'
group by GaDi
21)	Cho biết mã số của các phi công chỉ lái được 3 loại máy bay.
select MaNV, count(Loai) as [Loại máy bay]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV
having count(Loai) = 3
22)	Với mỗi phi công có thể lái nhiều hơn 3 loại máy bay, cho biết mã số 
phi công và tầm bay lớn nhất của các loại máy bay mà phi công đó có thể lái.
select MaNV, max(TamBay) as [Tầm bay lớn nhất]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV
having count(Loai) > 3
23)	Với mỗi phi công cho biết mã số phi công và tổng số loại máy bay mà 
phi công đó có thể lái.
select MaNV, count(Loai) as [Tổng số loại máy bay]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV 
24)	Cho biết mã số của các phi công có thể lái được nhiều loại máy bay nhất.
--Cách 1: >=ALL
select MaNV, count(Loai) as [Tổng số loại máy bay]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV 
having count(Loai) >= ALL
	(
		select count(Loai)
		from ChungNhan C, MayBay M
		where C.MaMB=M.MaMB
		group by MaNV
	)
--Cách 2:
select top 1 with ties MaNV, count(Loai) as [Tổng số loại máy bay]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV
order by count(Loai) desc
25)	Cho biết mã số của các phi công có thể lái được ít loại máy bay nhất.
--Cách 1: >=ALL
select MaNV, count(Loai) as [Tổng số loại máy bay]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV 
having count(Loai) <= ALL
	(
		select count(Loai)
		from ChungNhan C, MayBay M
		where C.MaMB=M.MaMB
		group by MaNV
	)
--Cách 2:
select top 1 with ties MaNV, count(Loai) as [Tổng số loại máy bay]
from ChungNhan C, MayBay M
where C.MaMB=M.MaMB
group by MaNV
order by count(Loai) asc --ko ghi asc cũng được, vì mặc nhiên là asc

--26)Tìm các nhân viên không phải là phi công
--c1
select *
from NHANVIEN 
where MANV not in(select distinct MANV
	from CHUNGNHAN
)
--c2

--27)Cho biết mã số của các nhân viên có lương cao nhất.
--c1
select top 1 with ties MANV,LUONG as [Lương cao nhất]
from NHANVIEN
order by LUONG DESC
--c2
select MANV,LUONG as [Lương cao nhất]
from NHANVIEN
where LUONG =(select max(LUONG)
			from NHANVIEN
			)
--c3
select MANV,LUONG as [Lương cao nhất]
from NHANVIEN
where LUONG >= all(select LUONG 
					from NHANVIEN)

--28)Cho biết tổng số lương phải trả cho các phi công.
select TEN,sum(LUONG) as [Tổng số lương phải trả]
from NHANVIEN N ,CHUYENBAY C,CHUNGNHAN CH
Where N.MANV=CH.MANV and CH.MAMB=C.MAMB
group by TEN
--cau 29
select  C.*
from CHUYENBAY C,MAYBAY M
where C.MAMB=M.MAMB and Loai like '%Boeing%'
--39
select N.MANV,TEN,Count(Loai) as [Tổng số loại máy bay]
from NHANVIEN N, MAYBAY M,CHUNGNHAN CH
where N.MANV=CH.MANV and M.MAMB=CH.MAMB
group by N.MANV,TEN
--40
select N.MANV,TEN,Count(Loai) as [Tổng số loại máy bay Boeing]
from NHANVIEN N, MAYBAY M,CHUNGNHAN CH
where N.MANV=CH.MANV and M.MAMB=CH.MAMB and Loai like '%Boeing%'
group by N.MANV,TEN

--42
select Loai,count(MACB) as [Tổng chuyến bay không thực hiện]
from MAYBAY M,CHUYENBAY C
where M.MAMB=C.MAMB and DODAI
not in(
select DODAI
from CHUYENBAY)
group by Loai
--55
select MACB,GIODI,GIODEN 
FROM CHUYENBAY
where GIODEN='16:00:00'
Câu 3: Tạo các view theo yêu cầu sau:
1.	Cho biết mã sản phẩm, tên sản phẩm, tổng số lượng xuất của từng sản phẩm trong năm 2010.
Lấy dữ liệu từ View này sắp xếp tăng dần theo tên sản phẩm.
create view V1
as
	select S.MASP,TENSP,sum(SOLUONG) [Tổng số lượng]
	from SANPHAM S,CTPX C,PHIEUXUAT P
	where S.MASP=C.MASP and P.MAPX=C.MAPX and year(NGAYLAP)=2010
	group by S.MASP,TENSP

select *
from V1
order by TENSP ASC
2.	Cho biết mã sản phẩm, tên sản phẩm, tên loại sản phẩm mà đã được bán từ ngày 1/1/2010 đến 30/6/2010.
alter view V2
as
	select S.MASP,TENSP
	from SANPHAM S,CTPX C,PHIEUXUAT P
	where S.MASP=C.MASP and P.MAPX=C.MAPX and NGAYLAP between' 2010-1-1 'and '2010-6-30'


select *
from V2

3.	Cho biết số lượng sản phẩm trong từng loại sản phẩm gồm các thông tin: mã loại sản phẩm, tên loại sản phẩm, số lượng các sản phẩm.
create view V3
as
	select S.MASP,TENSP,sum(SOLUONG) [Số lượng SP]
	from SANPHAM S,CTPX C
	where S.MASP=C.MASP 
	group by S.MASP,TENSP

select *
from V3

4.	Cho biết tổng số lượng phiếu xuất trong tháng 6 năm 2010.
create view V4
as
	select count(MAPX) [Số lượng phiếu xuất trong 06/2010]
	from  PHIEUXUAT 
	where  month(NGAYLAP)=6 and year(NGAYLAP)=2010

select *
from V4

5.	Cho biết thông tin về các phiếu xuất mà nhân viên có mã NV01 đã xuất.
create view V5
as
	select MAPX,NGAYLAP
	from PHIEUXUAT 
	where MANV='NV01'
select *
from V5
6.	Cho biết danh sách nhân viên nam có tuổi trên 25 nhưng dưới 30.
create view V6
as
	select MANV,HOTEN
	from NHANVIEN
	where PHAI = 1 and year(getdate())-year(NGAYSINH) between 25 and 30

select *
from V6
7.	Thống kê số lượng phiếu xuất theo từng nhân viên.
create view V7
as	
	select HOTEN,count(MAPX) [Số lượng phiếu xuất]
	from NHANVIEN N,PHIEUXUAT P
	where N.MANV=P.MANV 
	group by HOTEN
select *
from V7
8.	Thống kê số lượng sản phẩm đã xuất theo từng sản phẩm.
create view V8
as
	select 
	from 
9.	Lấy ra tên của nhân viên có số lượng phiếu xuất lớn nhất.
create view V9
as
	select top 1 with ties HOTEN ,count(C.MAPX) [Số lượng phiếu xuất]
	from NHANVIEN N , PHIEUXUAT P ,CTPX C
	where N.MANV=P.MANV and P.MAPX=C.MAPX
	group by HOTEN
	order by count(C.MAPX) Desc
select *
from V9
10.	Lấy ra tên sản phẩm được xuất nhiều nhất trong năm 2010.
create view V10
as
	select top 1 with ties TENSP,sum(SOLUONG) [Sản phẩm xuất nhiều nhất 2010]
	 from PHIEUXUAT P ,CTPX C,SANPHAM S
	where  P.MAPX=C.MAPX and S.MASP=C.MASP and year(NGAYLAP) = 2010
	group by TENSP
	order by sum(SOLUONG) Desc
select *
from V10 */