create database QLSV
on
(
	name='QLSV_Data',
	filename='D:\Database\QLSV.MDF'
)
log on
(
	name='QLSV_Log',
	filename='D:\Database\QLSV.LDF'
)
use QLSV
drop database  QLBANGHANG
--2) Tạo các bảng
create table LOP
(
	MaLop	char(7)	primary key,
	TenLop	nvarchar(50),
	SiSo	tinyint check(SiSo>0)
)
drop table DIEMSV
create table MONHOC
(
	MaMH	char(6)	primary key,
	TenMH	nvarchar(50),
	TCLT	tinyint	check(TCLT>0),
	TCTH	tinyint	check(TCTH>=0)
)
drop table SINHVIEN
create table SINHVIEN
(
	MSSV	char(6) primary key,
	HoTen	nvarchar(50),
	NTNS	date,
	Phai	bit default 1, --mặc định người dùng ko nhập thì ghi 1
	MaLop	char(7),
	--đ/n khóa ngoại
	foreign key (MaLop) references LOP(MaLop)
	on update cascade --Sửa Mã lớp trong LOP thì Mã lớp trong SV sửa theo
	on delete set null --Xóa Mã lớp trong LOP thì Mã lớp trong SV là null
)
drop table DIEMSV
create table DIEMSV
(
	MSSV	char(6),
	MaMH	char(6),
	--đ/n khóa chính
	primary key (MSSV,MaMH),
	Diem	decimal(3,1) check (Diem between 0 and 10),
	--decimal(3,1): số thực có độ dài=3, lấy 1 số lẻ,
	--1 dấu thập phân => phần nguyên còn 1 con số
	--đ/n 2 khóa ngoại
	foreign key (MSSV) references SINHVIEN(MSSV)
	on update cascade
	on delete cascade,
	foreign key (MaMH) references MONHOC(MaMH)
	on update cascade
	on delete cascade
)
--3) Tạo database diagram
--4) Nhập dữ liệu theo thứ tự các bảng đã tạo
--Nếu xóa dữ liệu thì xóa theo thứ tự ngược lại
delete from LOP
delete from SINHVIEN
delete from MONHOC
--Nhập liệu:
--Chú ý dữ liệu dạng số thập phân:
3.5				3,5
3,500,000		3.500.000
								--Anh/Mỹ		Pháp/Việt
--Dấu thập phân (decimal symbol):	.				,
--Dấu phân cách hàng  ngàn:			,				.
--(digits grouping symbol)
--Dấu phân cách giữa các đối số:	,				;
--5) Thực hiện các câu hỏi sau bằng ngôn ngữ SQL:
1-	Thêm một dòng mới vào bảng SINHVIEN với giá trị:
insert into SINHVIEN values('190001', N'Đào Thị Tuyết Hoa', 
							'08/03/2001', 0, '19DTH02')
select *from SINHVIEN
set dateformat dmy --chuyển trạng thái soạn thảo từ dạng
--tháng/ngày/năm sang ngày/tháng/năm. Chỉ chạy đúng 1 lần
--khi mới khởi động SQL.
update SINHVIEN set NTNS='08/03/2001'
where MSSV='190001'
2-	Hãy đổi tên môn học 'Lý thuyết đồ thị' thành 'Toán rời rạc'.
select *from MONHOC
--
update MONHOC
set TenMH=N'Toán rời rạc'
where TenMH=N'Lý thuyết đồ thị'
3-	Hiển thị tên các môn học không có thực hành.
select TenMH
from MONHOC
where TCTH=0
4-	Hiển thị tên các môn học vừa có lý thuyết, vừa có thực hành.
select TenMH
from MONHOC
where TCLT>0 and TCTH>0
5-	In ra tên các môn học có ký tự đầu của tên là chữ 'C'.
select TenMH
from MONHOC
where TenMH like 'C%'
6-	Liệt kê thông tin những sinh viên mà họ chứa chữ 'Thị'.
select *from SINHVIEN
select HoTen
from SINHVIEN
where HoTen like N'%Thị%'
7-	In ra 2 lớp có sĩ số đông nhất (bằng nhiều cách). 
Hiển thị: Mã lớp, Tên lớp, Sĩ số. Nhận xét?
select top 2 with ties *
from LOP
order by SiSo DESC

select *from LOP
select top 1 with ties*
from (
    select top 3 with ties* 
    from LOP
    order by SiSo) Toptwo
order by SiSo desc

8-	In danh sách SV theo từng lớp: MSSV, Họ tên SV, Năm sinh, Phái (Nam/Nữ).
select MaLop, MSSV, HoTen, NTNS, Phai 
from SINHVIEN
order by MaLop
--Sửa lại:
select MaLop, MSSV, HoTen, convert(varchar(10), NTNS, 103) as NTNS, Phai
from SINHVIEN
order by MaLop
--Xử lý Phái là Nam hoặc Nữ:
--Cách 1:
select MaLop, MSSV, HoTen, convert(varchar(10), NTNS, 103) as NTNS, 
		case when Phai=0 then N'Nữ'
		else 'Nam'
		end as NTNS
from SINHVIEN
order by MaLop
--Cách 2:
select MaLop,MSSV,HoTen,convert(varchar(10),NTNS,103) as NTNS,
	iif(Phai=0, N'Nữ','Nam')as Phái
from SINHVIEN
order by MaLop
9-	Cho biết những sinh viên có tuổi ≥ 20, thông tin gồm: 
Họ tên sinh viên, Ngày sinh, Tuổi.
--Tuổi=year(getdate())-year(NTNS)
select HoTen,NTNS,year(getdate())-year(NTNS) as [Tuổi]
from SINHVIEN
--CÁCH KHÁC
select HoTen,NTNS,datediff(yy,NTNS,getdate()) as N'Tuổi'
from SINHVIEN
10-	Liệt kê tên các môn học SV đã dự thi nhưng chưa có điểm.
select TenMH,Diem
from MONHOC,DIEMSV
where MONHOC.MaMH=DIEMSV.MaMH and Diem is NULL
11-	Liệt kê kết quả học tập của SV có mã số 170001. Hiển thị:
MSSV, HoTen, TenMH, Diem.
select  S.MSSV,HoTen,TenMH,Diem
from SINHVIEN S,DIEMSV D,MONHOC M
where  S.MSSV= D.MSSV and  D.MaMH=M.MaMH and D.MSSV='170001'
12-	Liệt kê tên sinh viên và mã môn học mà sv đó đăng ký với điểm trên 7 điểm.
select MaMH,HoTen,Diem
from SINHVIEN,DIEMSV
where SINHVIEN.MSSV=DIEMSV.MSSV and Diem >7
13-	Liệt kê tên môn học cùng số lượng SV đã học và đã có điểm.
select TenMH,count (MSSV) as [Số lượng]
from MONHOC,DIEMSV
where MONHOC.MaMH=DIEMSV.MaMH and Diem is not null
group by TenMH
14-	Liệt kê tên SV và điểm trung bình của SV đó.
select HoTen,cast(AVG(Diem) as decimal(3,1)) as [Điểm Trung Bình]
from SINHVIEN S,DIEMSV D
where S.MSSV=D.MSSV
group by HoTen
15-	Liệt kê tên sinh viên đạt điểm cao nhất của môn học 'Kỹ thuật lập trình'.
--c1 
select HoTen
from SINHVIEN S,MONHOC M,DIEMSV D
where S.MSSV=D.MSSV and M.MaMH=D.MaMH and TenMH =N'Kỹ Thuật Lập Trình'
and Diem=(select max(Diem)
			from DIEMSV D, MONHOC M
			where D.MaMH=M.MaMH and TenMH=N'Kỹ Thuật Lập Trình'
			)
--c2
select top 1 with ties HoTen
from SinhVien S, DiemSV D, MONHOC M
where S.MSSV = D.MSSV and D.MaMH=M.MaMH and TenMH = N'Kỹ Thuật Lập Trình'
order by Diem DESC
--c3
select HoTen
from SINHVIEN S,MONHOC M,DIEMSV D
where S.MSSV=D.MSSV and M.MaMH=D.MaMH and TenMH =N'Kỹ Thuật Lập Trình'and
Diem >= all
(select (Diem)
from DIEMSV D, MONHOC M
where D.MaMH=M.MaMH and TenMH=N'Kỹ Thuật Lập Trình'	)
group by HoTen
	
16-	Liệt kê tên SV có điểm trung bình cao nhất.
--Cách 1:
select HoTen, avg(Diem) as [ĐTB cao nhất]
from SinhVien S, DiemSV D
where S.MSSV = D.MSSV
group by HoTen
having avg(Diem) >= all
(
	select avg(Diem)
	from SinhVien S, DiemSV D
	where S.MSSV = D.MSSV
	group by HoTen
)
--Cách 2:
select top 1 with ties HoTen, avg(Diem) as [ĐTB cao nhất]
from SinhVien S, DiemSV D
where S.MSSV = D.MSSV
group by HoTen
order by avg(Diem) DESC
17.
select HoTen
from SINHVIEN s ,DIEMSV D 
where S.MSSV=D.MSSV not in (DIEMSV)
18-	Cho biết sinh viên có năm sinh cùng với sinh viên tên ‘Danh’.
select Hoten ,year(NTNS) as [Năm sinh]
from SINHVIEN
where year(NTNS) in
(select year(NTNS)
from SINHVIEN
where HoTen like N'%Danh')

19-	Cho biết tổng sinh viên và tổng số sinh viên nữ.

select count(*) as [Tổng Sinh Viên],
		count(iif(Phai=0,N'Nữ',NULL)) as [Tổng sinh viên nữ]
from SINHVIEN

20-	Cho biết danh sách các sinh viên rớt ít nhất 1 môn.
select S.MSSV,HoTen,count (*) as [Số môn rớt]
from SINHVIEN S,DIEMSV D
where S.MSSV=D.MSSV and Diem<5
group by S.MSSV,HoTen
having count(*)>=1
21-	Cho biết MSSV, Họ tên SV đã học và có điểm ít nhất 3 môn.
select S.MSSV,HoTen,count(*) as [Số môn có điểm]
from SINHVIEN S,DIEMSV D
where S.MSSV=D.MSSV and Diem is not null
group by S.MSSV,Hoten
having count(*)>=3
22-	In danh sách sinh viên có điểm môn 'Kỹ thuật lập trình' cao nhất 
theo từng lớp.
select MaLop,max(Diem) as [Điểm cao nhất của môn KTLT]
from SINHVIEN S,DIEMSV D, MONHOC M
where S.MSSV=D.MSSV and D.MaMH=M.MaMH and TenMH =N'Kỹ thuật lập trình'
group by MaLop
23-	In danh sách sinh viên có điểm cao nhất theo từng môn, từng lớp.
select TenMH,MaLop, max(Diem) as [Điểm cao nhất]
from SINHVIEN S,DIEMSV D,MONHOC M
where S.MSSV=D.MSSV and D.MaMH=M.MaMH
group by TenMH,MaLop
24-	Cho biết những sinh viên đạt điểm cao nhất của từng môn.
select Hoten,D.MaMH,Diem
from SINHVIEN S, DIEMSV D,
( select max(Diem) as[Điểm cao nhất],D.MaMH
	from DIEMSV D
	group by D.MaMH

)as [Maxtheomon]
where D.MaMH=Maxtheomon.MaMH and D.Diem=Maxtheomon.[Điểm cao nhất]
and S.MSSV=D.MSSV
25-	Cho biết MSSV, Họ tên SV chưa đăng ký học môn nào.
select MSSV,Hoten
from SINHVIEN
where MSSV not in
(
	select distinct MSSV
	from DIEMSV

)
--c2
select MSSV,Hoten
from SINHVIEN S
where not exists
(
	select *
	from DIEMSV D
	where D.MSSV=S.MSSV

)
--c3 count
select MSSV,Hoten
from SINHVIEN S
where
(
	select count(*)
	from DIEMSV D
	where D.MSSV=S.MSSV

)=0
--26-	Danh sách sinh viên có tất cả các điểm đều 10.
select S.MSSV,Hoten,Diem,TenMH
from SINHVIEN S,DIEMSV D,MONHOC M
where S.MSSV=D.MSSV and M.MaMH=D.MaMH and Diem >=10
27-	Đếm số sinh viên nam, nữ theo từng lớp.
select Malop,SosvNam=sum(iif(Phai=1,1,0)),SosvNu=sum(iif(Phai=0,1,0))
from SINHVIEN
group by Malop


with Bangtam as (select MSSV,Hoten,max(Diem) from SINHVIEN
				group by MSSV,Hoten)
28-	Cho biết những sinh viên đã học tất cả các môn nhưng 
không rớt môn nào. --Phép chia
select S.MSSV, HoTen, count(*) as [Số môn rớt]
from SINHVIEN S, DIEMSV D
where S.MSSV=D.MSSV and DIEM>5
		(
			select (*)
			from DIEMSV D
			where S.MSSV=D.MSSV
		)
group by S.MSSV, HoTen
select HoTen, count( D.MaMH) as [Tổng số môn đã học và Đậu]
from SINHVIEN S, DIEMSV D, MONHOC M
where S.MSSV = D.MSSV and D.MaMH=M.MaMH and Diem>=5
group by HoTen, Diem
having count(D.MaMH) = --Tổng số môn đã học và đậu bằng tổng số môn học
					   --thì SV đó đã học hết
	(select count(*)
	from MONHOC)
29-	Xóa tất cả những sinh viên chưa dự thi môn nào.
30-	Cho biết những môn đã được tất cả các sinh viên đăng ký học. --Phép chia





