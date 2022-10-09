create database QLBH
on
(
	name='QLBH_Data',
	filename='D:\Database\QLBH.MDF'
)
log on
(
	name='QLBH_Log',
	filename='D:\Database\QLBH.LDF'
)
use QLBH
Câu 3: Tạo các view sau:
1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng
tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view V1
as 
	select MAKH,TENKH,DIACHI,DT,EMAIL
	from KHACHHANG
	where DIACHi=N'Tân Bình'

select *
from V1
2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng,
địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại.
create view V2 ([Mã KH] , [Tên KH],[Địa Chỉ],Email)
as
	select	MAKH,TENKH,DIACHI,EMAIL
	from KHACHHANG
	Where DT is NULL
select *
from V2
3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
create view V3 
as
	select MAKH,TENKH,DIACHI,DT,email
	from KHACHHANG
	where DT is null and EMAIL is null
select *
from V3

4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
	create view V4 
as
	select MAKH,TENKH,DIACHI,DT,EMAIL
	from KHACHHANG
	where DT is not null and EMAIL is not null
select *
from V4
5.	Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư và giá mua.
	 create view V5
as
	select MAVT,TENVT,GIAMUA
	from VATTU
	where DVT like 'Cái%'
select *
from V5
DROP view v5
6.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
	CREATE VIEW V6
as
	SELECT MAVT,TENVT,DVT,GIAMUA
	FROM VATTU
	WHERE GIAMUA>25000
select *
from V6

7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
create view V7
as
	select MAVT,TENVT,DVT,GIAMUA
	from VATTU
	where TENVT like 'Gạch%'
select *
from V7
8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư
đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
create view V8
as
	select MAVT,TENVT,DVT,GIAMUA
	from VATTU
	where GIAMUA between 20000 and  40000
select *
from V8
9.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
create view V9 ([Mã HD],[Ngày lập hóa đơn],[Tên khách hàng],[Địa chỉ khách hàng],[Số điện thoại])
with encryption
as
	select MAHD,NGAY,TENKH,DIACHI,DT
	from KHACHHANG K, HOADON H
	where K.MAKH=H.MAKH 

Select *
from V9
10.	Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2010.
SET dateformat DMY
	create view V10
as
	select MAHD,TENKH,DIACHi,DT
	from KHACHHANG K,HOADON H
	
	where K.MAKH=H.MAKH and NGAY='25/5/2010'
select *
from V10

11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
	SET dateformat DMY
	create view V11
as
	select MAHD,NGAY,TENKH,DIACHi,DT
	from KHACHHANG K, HOADON H
	WHERE K.MAKH = H.MAKH AND MONTH(NGAY) = 6 AND YEAR(NGAY) = 2010
	select *
from V11
drop view v11

12.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2010.
	ALTER VIEW V12
AS
	SELECT TENKH,DIACHI,DT,NGAY
	FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH = H.MAKH
	WHERE MONTH(NGAY) = 5 AND YEAR(NGAY)=2010
SELECT *
FROM V12


13.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
	ALTER VIEW V13
AS
	SELECT TENKH,DIACHI,DT
	FROM KHACHHANG K
	WHERE K.MAKH  NOT IN ( SELECT H.MAKH
	 FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH =H.MAKH
	 WHERE MONTH(NGAY) = 6 AND YEAR(NGAY)=2010)
SELECT *
FROM V13

14.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).
	create view V14
as
	select C.MAHD,V.MAVT,TENVT,DVT,GIABAN,GIAMUA,SL,(GIAMUA*SL) as [Giá trị mua],(GIABAN*SL) as [Giá trị ban]
	from VATTU V,HOADON H,CTHD C
	where V.MAVT=C.MAVT and H.MAHD=C.MAHD
select *
from V14
15.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
	create view V15
as
	select C.MAHD,V.MAVT,TENVT,DVT,GIABAN,GIAMUA,SL,(GIAMUA*SL) as [Giá trị mua],(GIABAN*SL) as [Giá trị bán]
	from VATTU V,HOADON H,CTHD C
	where V.MAVT=C.MAVT and H.MAHD=C.MAHD 
	group by C.MAHD,V.MAVT,TENVT,DVT,GIABAN,GIAMUA,SL
	having (GIABAN*SL) >= (GIABAN*SL)
select *
from V15
16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.
	create view V16
as
	select C.MAHD,V.MAVT,TENVT,DVT,GIABAN,GIAMUA,SL,(GIAMUA*SL) as [Giá trị mua],(GIABAN*SL) as [Giá trị bán] ,(GIABAN*SL)-((GIABAN*SL)*0.1) as [KHUYEN MAI 10%]
	from VATTU V,HOADON H,CTHD C
	where V.MAVT=C.MAVT and H.MAHD=C.MAHD 
	group by C.MAHD,V.MAVT,TENVT,DVT,GIABAN,GIAMUA,SL,
	having (GIABAN*SL) >100
select *
from V16
17.	Tìm ra những mặt hàng chưa bán được.
	create view V17
as

18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
	select C.MAHD,H.NGAY,TENKH,DIACHi,DT,TENVT,DVT,GIAMUA,GIABAN,SL,(GIAMUA*SL) as [Giá trị mua],(GIABAN*SL) as [Giá trị bán]
	from KHACHHANG K,VATTU V,CTHD C,HOADON H
	where K.MAKH=H.MAKH and H.MAHD=C.MAHD and C.MAVT=V.MAVT
19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
	SELECT C.MAHD,NGAY,TENKH,DIACHI,DT,TENVT,DVT,GIAMUA,GIABAN,SL, (GIAMUA*SL) AS [Gía trị mua], (GIABAN*SL) as [Giá trị bán]
	FROM KHACHHANG K , HOADON H, CTHD C, VATTU V
	WHERE K.MAKH = H.MAKH AND H.MAHD=C.MAHD AND C.MAVT = V.MAVT AND MONTH(NGAY) = 8 AND YEAR(NGAY) = 2010
	
20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
	SELECT C.MAHD,NGAY,TENKH,DIACHI,DT,TENVT,DVT,GIAMUA,GIABAN,SL, (GIAMUA*SL) AS [Gía trị mua], (GIABAN*SL) as [Giá trị bán]
	FROM KHACHHANG K , HOADON H, CTHD C, VATTU V
	WHERE K.MAKH = H.MAKH AND H.MAHD=C.MAHD AND C.MAVT = V.MAVT AND
	YEAR(Ngay) =2010 and (MONTH(Ngay) between 5 and 8)
	
21.	Lấy ra danh sách các hóa đơn gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
	select H.MAHD ,NGAY,TENKH,DT,DIACHI,sum(SL*GIABAN) as [Tổng trị hóa đơn]
	from KHACHHANG K,HOADON H,CTHD C
	where K.MAKH=H.MAKH and C.MAHD=H.MAHD
	group by NGAY,TENKH,DIACHI,H.MAHD,DT
22.	Lấy ra hóa đơn có tổng trị giá lớn nhất gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
	create view V22	
	as
		select top 1 with ties
	H.MAHD, TENKH,DIACHI, sum(SL*GIABAN) as [Tổng trị hóa đơn]
	from KHACHHANG K, HOADON H, CTHD C
	where K.MAKH=H.MAKH and H.MAHD=C.MAHD
	group by H.MAHD, TENKH,DIACHI
	order by [Tổng trị hóa đơn] desc
Select *
from V22
23.	Lấy ra hóa đơn có tổng trị giá lớn nhất trong tháng 5/2010 gồm các thông tin: Số hóa đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hóa đơn.
	ALTER VIEW V23
AS
	SELECT TOP 1 WITH TIES
	H.MAHD, TENKH , DIACHI, SUM(SL*GIABAN) AS [Tổng trị giá hóa đơn]
	FROM KHACHHANG K, HOADON H, CTHD C
	WHERE K.MAKH=H.MAKH AND H.MAHD=C.MAHD AND MONTH(NGAY) = 5 AND YEAR(NGAY)=2010
	GROUP BY H.MAHD , TENKH, DIACHI
	ORDER BY [Tổng trị giá hóa đơn] DESC
SELECT *
FROM V23
	
24.	Đếm xem mỗi khách hàng có bao nhiêu hóa đơn.
	create view V24
as
	select count(MAHD) as[Số hóa đơn],TENKH
	from KHACHHANG K,HOADON H
	where k.MAKH=H.MAKH
	group by TENKH
select *
from V24
25.	Đếm xem mỗi khách hàng, mỗi tháng có bao nhiêu hóa đơn.
	CREATE VIEW V25
AS
	SELECT COUNT(MAHD) AS [Số hóa đơn], TENKH
	FROM KHACHHANG K , HOADON H
	WHERE K.MAKH = H.MAKH 
	GROUP BY TENKH , MONTH(NGAY)
SELECT *
FROM V25

26.	Lấy ra các thông tin của khách hàng có số lượng hóa đơn mua hàng nhiều nhất.
	create view V26
as
	select top 1 count(MAHD) as [Số lượng hóa đơn] ,TENKH,K.MAKH
	from KHACHHANG K,HOADON H
	where k.MAKH=H.MAKH 
	group by TENKH,K.MAKH
	order by count(MAHD) desc
	
select *
from V26

27.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
	create view V27
as
	select top 1 sum(SL) as [Số lượng mua hàng],K.MAKH,TENKH
	from KHACHHANG K, HOADON H,CTHD C
	where K.MAKH=H.MAKH and C.MAHD=H.MAHD
	group by K.MAKH,TENKH
	order by sum(SL) desc
select *
from V27
28.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hóa đơn nhất.
	create view V26
as
	select top 1 with ties count(MAHD) as [Số lượng hóa đơn] ,V.MAVT,TENVT
	from VATTU V,CTHD C
	where  C.MAVT=V.MAVT
	group by V.MAVT,TENVT
	order by count(MAHD) desc
	
select *
from V26

29.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
	create view V29
as
	select top 1 sum(SL) as [Số lượng mua hàng],V.MAVT,TENVT
	from VATTU V,CTHD C
	where  C.MAVT=V.MAVT
	group by V.MAVT,TENVT
	order by sum(SL) desc
select *
from V29
30.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ, số lượng hóa đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hóa đơn để trống)

1.	Lấy ra danh các khách hàng đã mua hàng trong ngày X, với X là tham số truyền vào.
create proc P1 @X date
as
	select K.MAKH, TENKH, MAHD, convert(varchar(10), NGAY, 103) as NGAY
	from KHACHHANG K, HOADON H
	where K.MAKH=H.MAKH and NGAY=@X
--gọi thủ tục
exec P1 '25/5/2010'
exec P1 '26/5/2010'
2.	Lấy ra danh sách khách hàng có tổng trị giá các đơn hàng lớn hơn X (X là tham số).
	create proc P2 @X float
as
	select K.MAKH,TenKH,sum(SL*GIABAN) as [Tổng tiền đã mua]
	from KHACHHANG K , HOADON H , CTHD C
	where K.MAKH=H.MAKH and C.MAHD=H.MAHD
	group by K.MAKH,TenKH
	having sum(SL*GIABAN)>@X
exec P2 5000000
3.	Lấy ra danh sách X khách hàng có tổng trị giá các đơn hàng lớn nhất (X là tham số).
create proc P3 @X int
as
	select top (@X) with ties
	K.MAKH,TenKH,sum(SL*GIABAN) as [Tổng tiền đã mua]
	from KHACHHANG K , HOADON H , CTHD C
	where K.MAKH=H.MAKH and C.MAHD=H.MAHD
	group by K.MAKH,TenKH
	order by [Tổng tiền đã mua] desc

--
exec P3 3
exec P3 2
exec P3 1
4.Lấy ra danh sách X mặt hàng có số lượng bán lớn nhất (X là tham số).
drop proc P4
create proc P4 @X int as
	select top (@X) with ties V.MAVT,TENVT ,sum(SL) as[Số lượng đã bán]
	from VATTU V, CTHD C
	where V.MAVT=C.MAVT
	group by V.MAVT,TENVT
	order by sum(SL) desc

--
exec P4 4
exec P4 3
exec P4 2
exec P4 1
5.Lấy ra danh sách X mặt hàng bán ra có lãi ít nhất (X là tham số).
drop proc P5
create proc P5 @X int as
	select top 1 with ties  
	 V.MAVT,TENVT, sum(SL*(GIABAN-GIAMUA)) as[Tiền lãi]
	from CTHD C , VATTU V
	where  C.MAVT=V.MAVT 
	group by V.MAVT,TENVT
	order by  [Tiền lãi] asc

--
exec P5 4
exec P5 3
exec P5 2
exec P5 1

6.Lấy ra danh sách X đơn hàng có tổng trị giá lớn nhất (X là tham số).
drop proc P6
create proc P6 @X int
as
	select top 1 with ties
	 H.MAHD,NGAY,sum(SL*GIABAN-KHUYENMAI) as [Tổng trị giá]
	from  HOADON H , CTHD C
	where C.MAHD=H.MAHD
	group by H.MAHD,NGAY
	order by [Tổng trị giá] desc

--
exec P6 4
exec P6 3
exec P6 2
exec P6 1
7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
create proc P7
as 
	update CTHD
	set KHUYENMAI = iif(SL>500,0.1,iif(SL >100,0.05,0))*SL*GIABAN
exec P7
8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư
đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
create proc P8
as 
	update VATTU
	set SLTON= SLTON -(select sum(SL)
						from CTHD C
						where VATTU.MAVT=C.MAVT-- để biết tính cho vật tư nào
						group by MAVT)
exec P8
9.	Tính trị giá cho mỗi hóa đơn.
create proc P9
as
	update HOADON
	set TONGTG = (select sum(SL*GIABAN-KHUYENMAI)
				  from CTHD C
				  where HOADON.MAHD=C.MAHD --để biết cho HOADON nào
				  group by MAHD)
--gọi P9
exec P9
10.	Tạo ra table KH_VIP có cấu trúc giống với cấu trúc table KHACHHANG. 
Lưu các khách hàng có tổng trị giá của tất cả các đơn hàng >=10.000.000 
vào table KH_VIP.
create proc P10
as
	select K.MAKH, TENKH, sum(TONGTG) as [Tổng trị giá các đơn hàng]
	into KH_VIP --cho phép đổ dữ liệu vào 1 bảng mới
	from KHACHHANG K, HOADON H
	where K.MAKH=H.MAKH
	group by K.MAKH, TENKH
	having sum(TONGTG)>=10000000

	exec P10

	Câu 5: Tạo các function sau:
1.	Viết hàm tính doanh thu của năm, với năm là tham số truyền vào.
create function F1(@Nam int)
returns float 
as
begin
	declare @tong float
	select @tong=sum(TONGTG)
	from HOADON
	where year(NGAY)=@Nam
	return isnull(@tong,0)--nếu tổng bằng null thi tra VE 0
end
--
print dbo.F1(2010)
select dbo.F1(2010)
select dbo.F1(2011)
2.	Viết hàm tính doanh thu của tháng, năm, với tháng và năm là 2 tham số truyền vào.
alter function F2(@Thang int,@Nam int)
returns float 
as
begin
	declare @tong float
	select @tong=sum(TONGTG)
	from HOADON
	where  month(NGAY)=@Thang and year(NGAY)=@Nam
	return isnull(@tong,0)
end
print dbo.F2(05,2010)
select dbo.F2(05,2010)
select dbo.F2(06,2010)
3.	Viết hàm tính doanh thu của khách hàng với mã khách hàng là tham số truyền vào.
drop function F3
create function F3(@MaKhach char(4))
	returns float 
	as
	begin
		declare @Tong float
		select @Tong=sum(TONGTG)
		from HOADON
		where MAKH = @MaKhach
		return isnull(@Tong,0)
	end
select dbo.F3('KH01')
select dbo.F3('KH02')
select dbo.F3('KH03')
select dbo.F3('KH04')
select dbo.F3('KH05')
select dbo.F3('KH06')
select dbo.F3('KH07')

4.	Viết hàm tính tổng số lượng bán được cho từng mặt hàng theo tháng, năm nào đó. Với mã hàng, tháng và năm là các tham số truyền vào
nếu tháng không nhập vào tức là tính 
alter function F4(@MaVT char(5) , @Nam int,@Thang int)
	returns float 
	as
	begin
		declare @Tong bigint
		select @Tong=sum(SL)
		from HOADON H , CTHD C
		where C.MAHD=H.MAHD and MAVT=@MaVT
		and month(NGAY)=iif (@Thang is NULL ,month(NGAY),@Thang )
		and year(NGAY)=@Nam
		return @tong
				
	end

	select dbo.F4('VT01',2010,5)
	select dbo.F4('VT01',2010,null)

	5.	Viết hàm tính lãi ((giá bán – giá mua) * số lượng bán được) cho từng mặt hàng, với mã mặt hàng là tham số truyền vào
	Nếu mã mặt hàng không truyền vào thì tính cho tất cả các mặt hàng.
alter function F5(@MaVT char(4))
	returns float
	as
	begin
		declare @lai float
		select @lai=sum((GIABAN-GIAMUA-KHUYENMAI)*SL)
		from  CTHD C ,VATTU V
		where V.MAVT=C.MAVT and
		V.MAVT=iif(@MaVT is NULL ,V.MAVT , @MaVT)
		group by V.MAVT
		return isNULL (@Lai,0)
	end

select dbo.F5('VT01')
select dbo.F5(Null)
select dbo.F5('VT02')
1.	Thực hiện việc kiểm tra các ràng buộc khóa ngoại.
2.	Không cho phép CASCADE DELETE trong các ràng buộc khóa ngoại. Ví dụ không cho phép xóa các HOADON nào có SOHD còn trong table CTHD.
--Thử viết trigger xem khi lập 1 hóa đơn cho KH, nếu KH chưa có thì ko cho phép
create trigger Kiem_tra_KH on HOADON
after insert, update
as
	if not exists 
		(select * from KHACHHANG
		 where MAKH=(select MAKH from inserted)) --lấy MAKH do user nhập vào
	begin
		print(N'Khách hàng này chưa có')
		rollback tran
	end
3.	Không cho phép user nhập vào hai vật tư có cùng tên.
alter trigger Ko_cho_phep_2_VT_trungung_ten on VATTU
for insert, update
as
begin
 declare @TENVT nvarchar(30), @MAVT varchar(5)
 select @TENVT=TENVT, @MAVT=MAVT from inserted
 if exists
	(select * from VATTU 
	 where TENVT like RTRIM(@TENVT) and @MAVT<>MAVT) --trùng tên và khác mã
 begin  
	print N'Tên vật tư này đã tồn tại!'
	rollback tran
 end
end
4.	Khi user đặt hàng thì KHUYENMAI là 5% nếu SL > 100, 10% nếu SL > 500.
create trigger Cap_nhap_Khuyen_Mai on CTHD
for insert , update
as
begin
	declare @SL int 
	select @SL = SL from inserted
	update CTHD set KHUYENMAI = iif(@SL>500,0.1,iif(@SL>100,0.05,0))*SL*GIABAN
end
5.	Chỉ cho phép mua các mặt hàng có số lượng tồn lớn hơn hoặc bằng số lượng cần mua và tính lại số lượng tồn mỗi khi có đơn hàng.
6.	Không cho phép user xóa một lúc nhiều hơn một vật tư.
7.	Mỗi hóa đơn cho phép bán tối đa 5 mặt hàng.
8.	Mỗi hóa đơn có tổng trị giá tối đa 50000000.
9.	Không được phép bán hàng lỗ quá 50%.
10.	Chỉ bán mặt hàng Gạch (các loại gạch) với số lượng là bội số của 100.


