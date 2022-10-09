use QLSP
Câu 4: Tạo các Function sau:
1.	Function F1 có 2 tham số vào là: tên sản phẩm, năm. Function cho biết: số lượng xuất kho của tên sản phẩm đó trong năm này. (Chú ý: Nếu tên sản phẩm đó không tồn tại thì phải trả về 0)
create function F1(@TenSP nvarchar(50), @Nam int)
returns int
as
begin
	declare @Tong int
	if not exists (select * from SANPHAM ---nếu ko tồn tại sản phẩm
				   where TENSP=@TenSP)
		set @Tong=0 --gán
	else
		select @Tong=sum(SOLUONG) --gán
		from PHIEUXUAT P, CTPX C, SANPHAM S
		where P.MAPX=C.MAPX and C.MASP=S.MASP
		and TENSP=@TenSP and year(NGAYLAP)=@Nam
		group by C.MASP
	return @Tong
end
--
select dbo.F1(N'Xi măng',2010)
select dbo.F1(N'Gạch',2010)
2.	Function F2 có 1 tham số nhận vào là mã nhân viên. Function trả về số lượng phiếu xuất của nhân viên truyền vào.
Nếu nhân viên này không tồn tại thì trả về 0.
create function F2(@MANV char(5))
returns int
as
begin
	declare @SLPX int
	--Ta cần lấy 2 bảng NV và PX, đếm trong PX có bao nhiêu mã NV
	if (select count(*) from NHANVIEN
		where MANV=@MANV)=0 --ko có NV nào
		set @SLPX=0
	else
		select @SLPX=count(MAPX)
		from NHANVIEN N, PHIEUXUAT P
		where N.MANV=P.MANV and P.MANV=@MANV
	return @SLPX
end
--
select dbo.F2('NV01')
select dbo.F7(2)
select dbo.F2('NV10')
3.	Function F3 có 1 tham số vào là năm, trả về danh sách các sản phẩm được xuất trong năm truyền vào. 
create function F3(@Nam int)
returns table as return
	    select distinct TENSP
		from SANPHAM S, PHIEUXUAT P,CTPX C
		where S.MASP=C.MASP and P.MAPX=C.MAPX and year(NGAYLAP)=@Nam


select *from F3 (2010)
select *from F3 (2011)
select *from F3 (2012)

4.	Function F4 có một tham số vào là mã nhân viên để trả về danh sách các phiếu xuất của nhân viên đó. 
Nếu mã nhân viên không truyền vào thì trả về tất cả các phiếu xuất.
create function F4(@MANV char(5))
returns table as return
	select MAPX
	from PHIEUXUAT P
	where MANV = iif(@MANV is NULL , MANV , @MANV)

select * from F4('NV01')
select * from F4('NV02')
select * from F4('NV03')
select * from F4(NULL)



5.	Function F5 để cho biết tên nhân viên của một phiếu xuất có mã phiếu xuất là tham số truyền vào.

create function F5(@MAPX int)
returns nvarchar(50)
as
begin
	declare @TENNV nvarchar(50)
	select @TENNV=HOTEN
	from NHANVIEN N , PHIEUXUAT P
	where N.MANV = P.MANV and MAPX = @MAPX
	return @TENNV
end
select dbo.F5(3)
select dbo.F5(1)
select dbo.F5(2)

6.	Function F6 để cho biết danh sách các phiếu xuất từ ngày T1 đến ngày T2. (T1, T2 là tham số truyền vào). Chú ý: T1 <= T2.
create function F6(@T1 int , @T2 int)
returns table as return
	select MAPX
	from PHIEUXUAT
	where DAY(NGAYLAP) between @T1 and @T2

select * from F6(1,3)
select * from F6(1,12)
select * from F6(1,15)
select * from F6(1,30)
7.	Function F7 để cho biết ngày xuất của một phiếu xuất với mã phiếu xuất là tham số truyền vào.

create function F7(@MAPX int)
returns date
as
begin
	declare @NGAYXUAT date
	select @NGAYXUAT =NGAYLAP
	from PHIEUXUAT
	where MAPX = @MAPX
return @NGAYXUAT
end

--
select dbo.F7(1)
select dbo.F7(2)
select dbo.F7(3)
select dbo.F7(4)

Câu 5: Tạo các Procedure sau:
1.	Procedure tên là P1 cho có 2 tham số sau:
•	1 tham số nhận vào là: tên sản phẩm.
•	1 tham số trả về cho biết: tổng số lượng xuất kho của tên sản phẩm này trong năm 2010 (Không viết lại truy vấn, hãy sử dụng Function F1 ở câu 4 để thực hiện)
create proc P1 @TENSP nvarchar(50), @SLXK int output
as
begin
	 set @SLXK = dbo.F1(@TENSP, 2010) --gọi lại hàm F1 ở trên
end
--
--gọi thủ tục
declare @SL int
exec P1 N'Xi măng', @SL output --khi gọi cũng có out sau biến
print @SL

2.	Procedure tên là P2 có 2 tham số sau:
•	1 tham số nhận vào là: tên sản phẩm.
•	1 tham số trả về cho biết: tổng số lượng xuất kho của tên sản phẩm này trong khoảng thời gian từ đầu tháng 4/2010 đến hết tháng 6/2010 (Chú ý: Nếu tên sản phẩm này không tồn tại thì trả về 0)
alter proc P2 @TenSP nvarchar(50), @Tong int output
as
begin
		set @Tong=0 --gán

		select @Tong=sum(SOLUONG) --gán
		from PHIEUXUAT P, CTPX C, SANPHAM S
		where P.MAPX=C.MAPX and C.MASP=S.MASP
		and TENSP=@TenSP and year(NGAYLAP)= 2010 and  month(NGAYLAP)between 4 and 6
		group by C.MASP
	return isnull(@tong,0)
end
declare @SL int
exec P2 N'Gạo nàng hương', @SL output --khi gọi cũng có out sau biến
print @SL
3.	Procedure tên là P3 chỉ có duy nhất 1 tham số nhận vào là tên sản phẩm. 
Trong Procedure này có khai báo 1 biến cục bộ được gán giá trị là: số lượng xuất kho của tên sản phẩm này trong khoảng thời gian từ đầu tháng 4/2010 đến hết tháng 6/2010.
Việc gán trị này chỉ được thực hiện bằng cách gọi Procedure P2.
create proc P3 @TenSP nvarchar(50),@SLXK int output
as
begin
	 set @SLXK = exec P2(@TENSP, ) --gọi lại hàm F1 ở trên
end
4.	Procedure P4 để INSERT một record vào trong table LOAI. Giá trị các field là tham số truyền vào.



5.	Procedure P5 để DELETE một record trong Table NhânViên theo mã nhân viên. Mã NV là tham số truyền vào.


