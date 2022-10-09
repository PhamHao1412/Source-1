CREATE DATABASE QLBH2
USE QLBH2

-----KHÁCH HÀNG-----
CREATE TABLE KHACHHANG
(
	MAKH char(4) not null,
	HOTEN	varchar(40),
	DIACHI varchar(50),
	DT     varchar(20),
	NGSINH smalldatetime ,
	NGDK	smalldatetime,
	DOANHSO money,
	constraint pk_kh primary key(MAKH)
)
------NHÂN VIÊN------
CREATE TABLE NHANVIEN
(
	MANV char(4) not null,
	HOTEN varchar(40),
	DT     varchar(20),
	NGVL	smalldatetime,
	constraint pk_nv primary key(MANV)
)
-------SẢN PHẨM--------
CREATE TABLE SANPHAM
(
	MASP char(4) not null,
	TENSP varchar(40),
	DVT	  varchar(20),
	NUOCSX varchar(40),
	GIA money,
	constraint pk_sp primary key(MASP)
)
-------HÓA ĐƠN--------
CREATE TABLE HOADON
(
	SOHD int not null,
	NGHD smalldatetime,
	MAKH char(4),
	MANV char(4),
	TRIGIA money,
	constraint pk_hd primary key(SOHD)
)
------CHI TIẾT HÓA ĐƠN-------
CREATE TABLE CTHD
(
	SOHD int,
	MASP char(4),
	SL int,
	constraint pk_cthd primary key(SOHD,MASP)
)
----KHÓA NGOẠI CHO BẢNG HÓA ĐƠN--------
ALTER TABLE HOADON ADD CONSTRAINT fk01_HD FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)
ALTER TABLE HOADON ADD CONSTRAINT fk02_HD FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
------KHÓA NGOẠI CHO BẢNG CTHD-------
ALTER TABLE CTHD ADD CONSTRAINT fk01_CTHD FOREIGN KEY(SOHD) REFERENCES HOADON(SOHD)
ALTER TABLE CTHD ADD CONSTRAINT fk02_CTHD FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

SET dateformat dmy
-- KHACHHANG
insert into khachhang values('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','8823451','22/10/1960','22/07/2006',13060000)
insert into khachhang values('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','908256478','03/04/1974','30/07/2006',280000)
insert into khachhang values('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','938776266','12/06/1980','08/05/2006',3860000)
insert into khachhang values('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','917325476','09/03/1965','10/02/2006',250000)
insert into khachhang values('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','8246108','10/03/1950','28/10/2006',21000)
insert into khachhang values('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','8631738','31/12/1981','24/11/2006',915000)
insert into khachhang values('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','916783565','06/04/1971','12/01/2006',12500)
insert into khachhang values('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','938435756','10/01/1971','13/12/2006',365000)
insert into khachhang values('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','8654763','03/09/1979','14/01/2007',70000)
insert into khachhang values('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','8768904','02/05/1983','16/01/2007',67500)

-------------------------------
-- NHANVIEN
insert into nhanvien values('NV01','Nguyen Nhu Nhut','927345678','13/04/2006')
insert into nhanvien values('NV02','Le Thi Phi Yen','987567390','21/04/2006')
insert into nhanvien values('NV03','Nguyen Van B','997047382','27/04/2006')
insert into nhanvien values('NV04','Ngo Thanh Tuan','913758498','24/06/2006')
insert into nhanvien values('NV05','Nguyen Thi Truc Thanh','918590387','20/07/2006')

-------------------------------
-- SANPHAM
insert into sanpham values('BC01','But chi','cay','Singapore',3000)
insert into sanpham values('BC02','But chi','cay','Singapore',5000)
insert into sanpham values('BC03','But chi','cay','Viet Nam',3500)
insert into sanpham values('BC04','But chi','hop','Viet Nam',30000)
insert into sanpham values('BB01','But bi','cay','Viet Nam',5000)
insert into sanpham values('BB02','But bi','cay','Trung Quoc',7000)
insert into sanpham values('BB03','But bi','hop','Thai Lan',100000)
insert into sanpham values('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
insert into sanpham values('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
insert into sanpham values('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
insert into sanpham values('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
insert into sanpham values('TV05','Tap 100 trang','chuc','Viet Nam',23000)
insert into sanpham values('TV06','Tap 200 trang','chuc','Viet Nam',53000)
insert into sanpham values('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
insert into sanpham values('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
insert into sanpham values('ST02','So tay loai 1','quyen','Viet Nam',55000)
insert into sanpham values('ST03','So tay loai 2','quyen','Viet Nam',51000)
insert into sanpham values('ST04','So tay','quyen','Thai Lan',55000)
insert into sanpham values('ST05','So tay mong','quyen','Thai Lan',20000)
insert into sanpham values('ST06','Phan viet bang','hop','Viet Nam',5000)
insert into sanpham values('ST07','Phan khong bui','hop','Viet Nam',7000)
insert into sanpham values('ST08','Bong bang','cai','Viet Nam',1000)
insert into sanpham values('ST09','But long','cay','Viet Nam',5000)
insert into sanpham values('ST10','But long','cay','Trung Quoc',7000)

-------------------------------
-- HOADON
insert into hoadon values(1001,'23/07/2006','KH01','NV01',320000)
insert into hoadon values(1002,'12/08/2006','KH01','NV02',840000)
insert into hoadon values(1003,'23/08/2006','KH02','NV01',100000)
insert into hoadon values(1004,'01/09/2006','KH02','NV01',180000)
insert into hoadon values(1005,'20/10/2006','KH01','NV02',3800000)
insert into hoadon values(1006,'16/10/2006','KH01','NV03',2430000)
insert into hoadon values(1007,'28/10/2006','KH03','NV03',510000)
insert into hoadon values(1008,'28/10/2006','KH01','NV03',440000)
insert into hoadon values(1009,'28/10/2006','KH03','NV04',200000)
insert into hoadon values(1010,'01/11/2006','KH01','NV01',5200000)
insert into hoadon values(1011,'04/11/2006','KH04','NV03',250000)
insert into hoadon values(1012,'30/11/2006','KH05','NV03',21000)
insert into hoadon values(1013,'12/12/2006','KH06','NV01',5000)
insert into hoadon values(1014,'31/12/2006','KH03','NV02',3150000)
insert into hoadon values(1015,'01/01/2007','KH06','NV01',910000)
insert into hoadon values(1016,'01/01/2007','KH07','NV02',12500)
insert into hoadon values(1017,'02/01/2007','KH08','NV03',35000)
insert into hoadon values(1018,'13/01/2007','KH08','NV03',330000)
insert into hoadon values(1019,'13/01/2007','KH01','NV03',30000)
insert into hoadon values(1020,'14/01/2007','KH09','NV04',70000)
insert into hoadon values(1021,'16/01/2007','KH10','NV03',67500)
insert into hoadon values(1022,'16/01/2007',Null,'NV03',7000)
insert into hoadon values(1023,'17/01/2007',Null,'NV01',330000)

-------------------------------
-- CTHD
insert into cthd values(1001,'TV02',10)
insert into cthd values(1001,'ST01',5)
insert into cthd values(1001,'BC01',5)
insert into cthd values(1001,'BC02',10)
insert into cthd values(1001,'ST08',10)
insert into cthd values(1002,'BC04',20)
insert into cthd values(1002,'BB01',20)
insert into cthd values(1002,'BB02',20)
insert into cthd values(1003,'BB03',10)
insert into cthd values(1004,'TV01',20)
insert into cthd values(1004,'TV02',10)
insert into cthd values(1004,'TV03',10)
insert into cthd values(1004,'TV04',10)
insert into cthd values(1005,'TV05',50)
insert into cthd values(1005,'TV06',50)
insert into cthd values(1006,'TV07',20)
insert into cthd values(1006,'ST01',30)
insert into cthd values(1006,'ST02',10)
insert into cthd values(1007,'ST03',10)
insert into cthd values(1008,'ST04',8)
insert into cthd values(1009,'ST05',10)
insert into cthd values(1010,'TV07',50)
insert into cthd values(1010,'ST07',50)
insert into cthd values(1010,'ST08',100)
insert into cthd values(1010,'ST04',50)
insert into cthd values(1010,'TV03',100)
insert into cthd values(1011,'ST06',50)
insert into cthd values(1012,'ST07',3)
insert into cthd values(1013,'ST08',5)
insert into cthd values(1014,'BC02',80)
insert into cthd values(1014,'BB02',100)
insert into cthd values(1014,'BC04',60)
insert into cthd values(1014,'BB01',50)
insert into cthd values(1015,'BB02',30)
insert into cthd values(1015,'BB03',7)
insert into cthd values(1016,'TV01',5)
insert into cthd values(1017,'TV02',1)
insert into cthd values(1017,'TV03',1)
insert into cthd values(1017,'TV04',5)
insert into cthd values(1018,'ST04',6)
insert into cthd values(1019,'ST05',1)
insert into cthd values(1019,'ST06',2)
insert into cthd values(1020,'ST07',10)
insert into cthd values(1021,'ST08',5)
insert into cthd values(1021,'TV01',7)
insert into cthd values(1021,'TV02',10)
insert into cthd values(1022,'ST07',1)
insert into cthd values(1023,'ST04',6)
--1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất.
	SELECT MASP,TENSP
	FROM SANPHAM
	WHERE NUOCSX = 'TRUNG QUOC'
--2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cây”, ”quyển”.
	SELECT MASP,TENSP
	FROM SANPHAM
	WHERE DVT IN ('CAY','QUYEN')
--3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
	SELECT MASP,TENSP
	FROM SANPHAM
	WHERE MASP LIKE 'B%01'
--4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 20.000 đến 30.000.
	SELECT MASP,TENSP
	FROM SANPHAM
	WHERE NUOCSX = 'TRUNG QUOC'
	AND GIA BETWEEN 30000 AND 40000
--5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” hoặc “Thái Lan” sản xuất có giá từ 20.000 đến 30.000.
	SELECT MASP, TENSP, NUOCSX
	FROM SANPHAM
	WHERE (NUOCSX = 'TRUNG QUOC' OR NUOCSX ='THAI LAN')
	AND GIA BETWEEN 30000 AND 40000
--6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
	SET dateformat dmy
	SELECT SOHD,TRIGIA
	FROM HOADON
	WHERE NGHD >='1/1/2007' AND NGHD <= '2/1/2007'
--7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của óa đơn (giảm dần).
	SELECT SOHD, TRIGIA
	FROM HOADON
	WHERE MONTH(NGHD) =1 AND YEAR(NGHD) = 2007
	ORDER BY NGHD ASC , TRIGIA DESC
--8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
	SELECT  K.MAKH ,HOTEN
	FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH = H.MAKH
	WHERE NGHD = '1/1/2007'
9. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyễn Văn A” mua trong háng 10/2006.
	SELECT S.MASP,TENSP
	FROM SANPHAM S INNER JOIN CTHD C ON S.MASP = C.MASP
	AND EXISTS (SELECT *
				FROM HOADON H INNER JOIN CTHD C ON H.SOHD = C.SOHD
				AND MONTH(NGHD) =10 AND YEAR(NGHD) =2006
				AND MAKH IN(SELECT H.MAKH
							FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH = H.MAKH
							WHERE HOTEN = 'NGUYEN VAN A')AND S.MASP = C.MASP )
	SELECT  S.MASP,TENSP
	FROM SANPHAM S INNER JOIN CTHD C ON S.MASP =C.MASP
	AND EXISTS (SELECT * 
				FROM HOADON H INNER JOIN CTHD C ON H.SOHD = C.SOHD
				AND MONTH(NGHD) = 10 AND YEAR(NGHD)=2006
				AND MAKH IN(SELECT H.MAKH
							FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH = H.MAKH
							WHERE HOTEN = 'NGUYEN VAN A') AND S.MASP = C.MASP)
--10. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyễn Văn B” lập trong ngày 28/10/2006.
	SELECT SOHD,TRIGIA
	FROM NHANVIEN N INNER JOIN HOADON H ON N.MANV= H.MANV
	WHERE HOTEN = 'NGUYEN VAN B'
	AND NGHD ='28/10/2006'
--11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
	SELECT SOHD,TENSP
	FROM CTHD C INNER JOIN SANPHAM S ON C.MASP  = S.MASP
	WHERE C.MASP IN ('BB01' , 'BB02')

	SELECT SOHD
	FROM CTHD
	WHERE MASP IN ('BB01' , 'BB02')

--12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20.
	SELECT SOHD , TENSP
	FROM CTHD C INNER JOIN SANPHAM S ON C.MASP = S.MASP
	WHERE C.MASP IN('BB01' , 'BB02')
	AND SL BETWEEN 10 AND 20
13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số ượng từ 10 đến 20.
	SELECT SOHD ,TENSP
	FROM CTHD A INNER JOIN SANPHAM S ON A.MASP = S.MASP
	WHERE A.MASP ='BB01'
	AND SL BETWEEN 10 AND 20
	AND EXISTS(SELECT SOHD,TENSP
				FROM CTHD B INNER JOIN SANPHAM S ON B.MASP = S.MASP
				WHERE B.MASP ='BB02'
				AND SL BETWEEN 10 AND 20
				AND A.SOHD = B.SOHD)
SELECT SOHD
FROM CTHD A
WHERE A.MASP = 'BB01'
AND SL BETWEEN 10 AND 20
AND EXISTS(SELECT *
FROM CTHD B
WHERE B.MASP = 'BB02'
AND SL BETWEEN 10 AND 20
AND A.SOHD = B.SOHD)
14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất hoặc các sản phẩm được bán a trong ngày 1/1/2007.
	SELECT S.MASP,TENSP
	FROM SANPHAM S INNER JOIN CTHD C ON S.MASP = C.MASP
	WHERE NUOCSX = 'TRUNG QUOC'
	AND C.SOHD IN (SELECT DISTINCT C2.SOHD 
				FROM HOADON H INNER JOIN CTHD C2 ON H.SOHD = C2.SOHD
				WHERE NGHD = '1/1/2007')

--15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
	SELECT S.MASP ,TENSP
	FROM SANPHAM S 
	WHERE NOT EXISTS(SELECT *
		FROM SANPHAM S2 INNER JOIN CTHD C ON S2.MASP= C.MASP AND
											S2.MASP = S.MASP)
	SELECT S.MASP , TENSP
	FROM SANPHAM S
	WHERE S.MASP NOT IN(SELECT C.MASP 
						FROM CTHD C INNER JOIN SANPHAM S2 ON C.MASP = S2.MASP)
--16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
	SELECT MASP,TENSP
	FROM SANPHAM S
	WHERE NOT EXISTS (SELECT *
						FROM (SANPHAM S2 INNER JOIN CTHD C ON S2.MASP = C.MASP) INNER JOIN HOADON H ON C.SOHD = H.SOHD
						AND S.MASP = S2.MASP
						AND YEAR(NGHD) = 2006 )
	SELECT S.MASP,TENSP
	FROM SANPHAM S
	WHERE S.MASP NOT IN( SELECT C.MASP
						FROM CTHD C INNER JOIN HOADON H ON C.SOHD = H.SOHD
						WHERE YEAR(NGHD) =2006)
--17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất không bán được trong năm 2006.
	SELECT S.MASP , TENSP ,NUOCSX
	FROM SANPHAM S
	WHERE NUOCSX ='TRUNG QUOC'
AND NOT EXISTS(SELECT C.MASP
					FROM (CTHD C INNER JOIN SANPHAM S2 ON C.MASP =S2.MASP ) INNER JOIN HOADON H ON C.SOHD =H.SOHD
					WHERE YEAR(NGHD) =2006 AND S.MASP = S2.MASP)
	SELECT S.MASP , TENSP,NUOCSX
	FROM SANPHAM S
	WHERE NUOCSX ='TRUNG QUOC'
	AND S.MASP NOT IN(SELECT C.MASP
						FROM CTHD C INNER JOIN HOADON H ON C.SOHD=H.SOHD
						WHERE YEAR(NGHD) = 2006)
18. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
	SELECT COUNT(*) 
	FROM HOADON H
	WHERE MAKH NOT IN(SELECT MAKH
						FROM KHACHHANG K 
						WHERE H.MAKH = K.MAKH)

	SELECT COUNT(*)
	FROM HOADON H
	WHERE NOT EXISTS(SELECT MAKH		
					FROM KHACHHANG K
					WHERE H.MAKH = H.MAKH)
19. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
	SELECT MAX(TRIGIA) AS MAX , MIN(TRIGIA) AS MIN
	FROM HOADON

20. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
	SELECT AVG(TRIGIA) AS [TRỊ GIÁ TRUNG BÌNH]
	FROM HOADON
	WHERE YEAR(NGHD) =2006

21. Tính doanh thu bán hàng trong năm 2006.
	SELECT SUM(TRIGIA) AS [DOANH THU]
	FROM HOADON
	WHERE YEAR(NGHD) =2006
--22. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
--C1
	SELECT  SOHD
	FROM HOADON 
	WHERE TRIGIA = (SELECT TOP 1 TRIGIA
					FROM HOADON
--C2					ORDER BY TRIGIA DESC)
	SELECT SOHD 
	FROM HOADON 
	WHERE TRIGIA = (SELECT MAX(TRIGIA)
					FROM HOADON)
--C3	
	SELECT SOHD
	FROM HOADON 
	WHERE TRIGIA >=ALL (SELECT TRIGIA
						FROM HOADON)

--23. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
	--C1
	SELECT HOTEN
	FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH=H.MAKH
	WHERE SOHD = (SELECT SOHD
					FROM HOADON
					WHERE TRIGIA = (SELECT MAX(TRIGIA)
									FROM HOADON 
									WHERE YEAR(NGHD) =2006))

--C2
	SELECT HOTEN
	FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH=H.MAKH
	WHERE SOHD = (SELECT SOHD
					FROM HOADON
					WHERE TRIGIA = (SELECT TOP 1(TRIGIA)
									FROM HOADON 
									WHERE YEAR(NGHD) =2006
									ORDER BY TRIGIA DESC))
--C3
	SELECT HOTEN
	FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH=H.MAKH
	WHERE SOHD = (SELECT SOHD
					FROM HOADON
					WHERE TRIGIA >=ALL (SELECT (TRIGIA)
									FROM HOADON 
									WHERE YEAR(NGHD) =2006))
--24. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
	SELECT TOP 3 WITH TIES MAKH,HOTEN
	FROM KHACHHANG
	ORDER BY DOANHSO DESC

--25. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
	SELECT MASP ,TENSP 
	FROM SANPHAM 
	WHERE GIA IN(SELECT DISTINCT TOP 3 WITH TIES GIA
				FROM SANPHAM 
				ORDER BY GIA DESC)

--26. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức iá thấp nhất (của tất cả các sản phẩm).
	SELECT MASP ,TENSP 
	FROM SANPHAM 
	WHERE NUOCSX ='TRUNG QUOC' AND
	GIA IN (SELECT DISTINCT TOP 3  GIA
				FROM SANPHAM 
				ORDER BY GIA ASC)

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'THAI LAN' AND GIA IN (SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
28. * In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
	SELECT TOP 3 MAKH , HOTEN
	FROM KHACHHANG
	ORDER BY DOANHSO DESC

	SELECT *
FROM  KHACHHANG
WHERE DOANHSO IN(SELECT TOP 3 DOANHSO
    FROM   KHACHHANG
    ORDER BY   DOANHSO DESC)  
ORDER BY DOANHSO DESC
29. Tính tổng số sản phẩm do “Trung Quốc” sản xuất.
	SELECT COUNT(DISTINCT MASP)
	FROM SANPHAM
	WHERE NUOCSX= 'TRUNG QUOC'
30. Tính tổng số sản phẩm của từng nước sản xuất.
	SELECT COUNT(DISTINCT MASP) AS [TONG SO SAN PHAM],NUOCSX
	FROM SANPHAM
	GROUP BY NUOCSX
31. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
	SELECT MAX(GIA) AS MAX , MIN(GIA) AS MIN , AVG(GIA) AS TB
	FROM SANPHAM
	GROUP BY NUOCSX
32. Tính doanh thu bán hàng mỗi ngày.
	SELECT NGHD, SUM(TRIGIA) AS [DOANH THU]
	FROM HOADON
	GROUP BY NGHD
33. Tính tổng số lượng của từng sản phẩm bán ra trong ngày 28/10/2006.
	SELECT S.MASP , COUNT(DISTINCT MASP) AS TONGSO
	FROM SANPHAM S 
	WHERE S.MASP IN (SELECT C.MASP
				FROM CTHD C INNER JOIN  HOADON H ON H.SOHD =C.SOHD
				WHERE NGHD='28/10/2006')
	GROUP BY MASP

	SELECT S.MASP , COUNT(DISTINCT MASP) AS TONGSO
	FROM SANPHAM S 
	WHERE S.MASP IN (SELECT C.MASP
				FROM CTHD C INNER JOIN  HOADON H ON H.SOHD =C.SOHD
				WHERE MONTH(NGHD)=10 AND YEAR(NGHD)= 2006)
	GROUP BY S.MASP


34. Tính doanh thu bán hàng của từng tháng trong năm 2006.
	SELECT MONTH(NGHD) AS THANG , SUM(TRIGIA) AS DOANHTHU
	FROM HOADON
	WHERE YEAR(NGHD) = 2006
	GROUP BY MONTH(NGHD)
35. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
	SELECT MAKH, HOTEN
	FROM KHACHHANG K
	WHERE MAKH = (SELECT TOP 1 MAKH
				FROM HOADON 
				GROUP BY MAKH
				ORDER BY COUNT(DISTINCT SOHD) DESC)
36. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
	SELECT MASP ,TENSP
	FROM SANPHAM
	WHERE MASP = (SELECT TOP 1 MASP
				FROM CTHD C INNER JOIN HOADON H ON C.SOHD=H.SOHD
				WHERE YEAR(NGHD) = 2006
				GROUP BY MASP
				ORDER BY SUM (SL)ASC)

37. Tháng mấy trong năm 2006, doanh số bán hàng thấp nhất ?
	SELECT TOP 1 MONTH(NGHD) AS [DOANH SO MAX]
	FROM HOADON 
	WHERE YEAR(NGHD) = 2006
	GROUP BY MONTH(NGHD)
	ORDER BY SUM(TRIGIA) ASC

	SELECT TOP 1 MONTH(NGHD) AS THANG_DOANHSO_MAX
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) ASC
--38. Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
-- TIM MAX GIA CUA NUOCSX	
	SELECT NUOCSX ,MAX(GIA) AS MAX
	FROM SANPHAM
	GROUP BY NUOCSX
-- DAT TEN BANG TREN LA B , ROI THUC HIEN KET TRAI
	SELECT B.NUOCSX ,MASP,TENSP
	FROM( SELECT NUOCSX, MAX(GIA) AS MAX
			FROM SANPHAM
			GROUP BY NUOCSX) AS B LEFT JOIN SANPHAM S
			ON S.GIA = B.MAX
			WHERE B.NUOCSX =S.NUOCSX

SELECT B.NUOCSX, MASP, TENSP
FROM (SELECT NUOCSX, MAX(GIA) AS MAX
FROM SANPHAM
GROUP BY NUOCSX) AS B LEFT JOIN SANPHAM S 
ON S.GIA = B.MAX 
WHERE B.NUOCSX = S.NUOCSX

SELECT NUOCSX,MAX(GIA) AS MAX
FROM SANPHAM
GROUP BY NUOCSX


SELECT B.NUOCSX, MASP ,TENSP
FROM (SELECT NUOCSX,MAX(GIA) AS MAX
FROM SANPHAM
GROUP BY NUOCSX) AS B LEFT JOIN SANPHAM S
ON S.GIA=B.MAX
WHERE B.NUOCSX=S.NUOCSX
--Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
	SELECT NUOCSX
	FROM SANPHAM
	GROUP BY NUOCSX
	HAVING COUNT(DISTINCT GIA) >=3

	
39. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
-- ĐÂY LÀ TOP 10 KHÁCH HÀNG CÓ DOANH SỐ CAO NHẤT	
	SELECT TOP 10 MAKH
	FROM KHACHHANG
	ORDER BY DOANHSO DESC
--- ĐÂY LÀ KHÁCH HÀNG VÀ SỐ LẦN MUA
	SELECT MAKH, COUNT(SOHD)
	FROM HOADON
	GROUP BY MAKH
----
SELECT TOP 1 A.MAKH
FROM(SELECT TOP 10 MAKH
	FROM KHACHHANG
	ORDER BY DOANHSO DESC) AS A
	LEFT JOIN
	(SELECT MAKH, COUNT(SOHD) AS SL
	FROM HOADON
	GROUP BY MAKH) AS B
	ON A.MAKH=B.MAKH
	ORDER BY SL DESC
	
SELECT *
FROM KHACHHANG
WHERE MAKH =(SELECT TOP 1 A.MAKH
FROM(SELECT TOP 10 MAKH
	FROM KHACHHANG
	ORDER BY DOANHSO DESC) AS A
	LEFT JOIN
	(SELECT MAKH, COUNT(SOHD) AS SL
	FROM HOADON
	GROUP BY MAKH) AS B
	ON A.MAKH=B.MAKH
	ORDER BY SL DESC)

	SELECT TOP 10 MAKH
	FROM KHACHHANG
	ORDER BY DOANHSO DESC

	SELECT MAKH , COUNT(SOHD)
	FROM HOADON
	GROUP BY MAKH
	
	SELECT TOP 1 A.MAKH
	FROM(SELECT TOP 10 MAKH
	FROM KHACHHANG
	ORDER BY DOANHSO DESC) AS A
	LEFT JOIN
	(SELECT MAKH , COUNT(SOHD) AS SL
	FROM HOADON
	GROUP BY MAKH) AS B
	ON A.MAKH=B.MAKH
	ORDER BY SL DESC

	SELECT *
	FROM KHACHHANG
	WHERE MAKH  =(SELECT TOP 1 A.MAKH
	FROM(SELECT TOP 10 MAKH
	FROM KHACHHANG
	ORDER BY DOANHSO DESC) AS A
	LEFT JOIN
	(SELECT MAKH , COUNT(SOHD) AS SL
	FROM HOADON
	GROUP BY MAKH) AS B
	ON A.MAKH=B.MAKH)

40. *Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau
	SELECT NUOCSX
	FROM SANPHAM
	GROUP BY NUOCSX
	HAVING COUNT(DISTINCT GIA)>=3
--41.	Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
--c1
SELECT H.SOHD 
FROM HOADON H
WHERE year(NGHD)=2006
AND EXISTS(SELECT *
FROM SANPHAM S
WHERE NUOCSX = 'SINGAPORE'
AND  EXISTS(SELECT * 
FROM CTHD C
WHERE C.SOHD = H.SOHD
AND C.MASP = S.MASP))

SELECT H.SOHD
FROM HOADON H
WHERE  EXISTS (SELECT *
	FROM SANPHAM S
	WHERE NUOCSX='SINGAPORE'
	AND EXISTS (SELECT *
				FROM CTHD C
				WHERE C.SOHD=H.SOHD
				AND C.MASP = S.MASP))
SELECT H.SOHD
FROM HOADON H
WHERE NOT EXISTS ( SELECT *
				FROM SANPHAM S
				WHERE NUOCSX='SINGAPORE'
	AND NOT EXISTS (SELECT *
					FROM CTHD C
					WHERE C.SOHD=H.SOHD
					AND S.MASP=C.MASP))
	


----

)


SELECT SOHD
FROM HOADON
WHERE year(NGHD)=2006
and EXISTS
(
    SELECT *
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore' and MASP IN
    (
        SELECT masp 
        FROM CTHD 
        WHERE SOHD = HOADON.SOHD
    )
)
SELECT H.SOHD 
FROM HOADON H
WHERE year(NGHD)=2006
AND EXISTS(SELECT *
FROM SANPHAM S
WHERE NUOCSX = 'SINGAPORE'
AND  EXISTS(SELECT * 
FROM CTHD C
WHERE C.SOHD = H.SOHD
AND C.MASP = S.MASP))	
---
SELECT H.SOHD
FROM HOADON H
WHERE YEAR(NGHD) =2006 
AND  EXISTS( SELECT *
			FROM SANPHAM S
			WHERE NUOCSX='SINGAPORE'
AND MASP IN (SELECT MASP 
			FROM CTHD C
			WHERE  C.SOHD=H.SOHD))

SELECT sp1.NUOCSX
FROM SANPHAM sp1,
(
    SELECT sp.NUOCSX, sp.GIA, count(sp.MASP) SL
    FROM SANPHAM sp
    GROUP BY sp.NUOCSX, sp.GIA
) groupgia
 
WHERE groupgia.NUOCSX = SP1.NUOCSX AND groupgia.GIA = sp1.GIA
group by sp1.NUOCSX
HAVING count(groupgia.SL)>=3

SELECT SP1.NUOCSX
FROM SANPHAM SP1,
(
	SELECT SP.NUOCSX,SP.GIA,COUNT(SP.MASP) SL
	FROM SANPHAM SP
	GROUP BY SP.NUOCSX, SP.GIA
)GROUPGIA

WHERE GROUPGIA.NUOCSX =SP1.NUOCSX AND GROUPGIA.GIA=SP1.GIA
GROUP BY SP1.NUOCSX
HAVING COUNT(GROUPGIA.SL) >=3

SELECT NUOCSX
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(GIA) >=3



SELECT hd1.MAKH, DS1.HOTEN
FROM 
(
    SELECT TOP 10 kh1.MAKH, KH1.HOTEN
    FROM KHACHHANG kh1
    WHERE kh1.MAKH is not null
    ORDER BY kh1.DOANHSO DESC
) DS1, HOADON hd1
WHERE DS1.MAKH = hd1.MAKH
GROUP BY hd1.MAKH, DS1.HOTEN
 
HAVING COUNT(HD1.SOHD)>=
ALL(
 
    SELECT count(hd.SOHD)
    FROM 
    (
        SELECT TOP 10 kh.MAKH
        FROM KHACHHANG kh
        WHERE kh.MAKH is not null
        ORDER BY kh.DOANHSO DESC
    ) DS, HOADON hd
    WHERE DS.MAKH = hd.MAKH
    GROUP BY hd.MAKH 
)