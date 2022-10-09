--Bài thực hành DLVN:
--B1) Tạo database
create database DLVN
on
	(--định nghĩa file chứa dữ liệu (primary data file)
		name='DLVN_DATA',
		filename='D:\Database\DLVN.MDF'
	)
log on
	(--định nghĩa file nhật ký (transaction log file)
		name='DLVN_LOG',
		filename='D:\Database\DLVN.LDF'
	)
--B2) Tạo các table với khóa chính, khóa ngoại và ràng buộc toàn vẹn
--Trước tiên, ta chọn database hiện hành (mặc định, DB hiện hành là master)
use DLVN
--
create table TINH_TP
(
	MA_T_TP		varchar(3)	primary key, --định nghĩa khóa chính
	TEN_T_TP	nvarchar(20),
	DT			float,
	DS			bigint,
	MIEN		nvarchar(10)
)
create table BIENGIOI
(
	NUOC		nvarchar(15),	--n: unicode
	MA_T_TP		varchar(3)		--khóa ngoại,có cùng kiểu dl và độ rộng so với khóa chính
	--khóa chính gồm 2 thuộc tính
	primary key (NUOC,MA_T_TP)
	--định nghĩa khóa ngoại
	foreign key (MA_T_TP) references TINH_TP(MA_T_TP)
	on update cascade --nếu MA_T_TP ở bảng TINH_TP sửa thì MA_T_TP trong bảng BIENGIOI
						--cũng sửa theo
	on delete no action	--cascade | set null
)
create table LANGGIENG
(
	MA_T_TP	varchar(3),
	LG		varchar(3), --LG chính là MA_T_TP
	--kh1a chính gồm 2 thuộc tính
	primary key (MA_T_TP,LG),
	--định nghĩa 2 khóa ngoại
	foreign key (MA_T_TP) references TINH_TP(MA_T_TP),
	foreign key (LG) references TINH_TP(MA_T_TP)
)
--B3) Tạo Database Diagram: mối quan hệ giữa các bảng:
--1) R-Click vào DLVN, chọn Proerties => Chọn Files, tại mục Owner, bấm vào nút ...
--=> Bấm nút Browse... => Chọn ser có tên [NT AUTHORITY\SYSTEM] => OK.
--2) R-Click vào Database Diagrams => Chọn New Database Digrams => Lần lượt nhấn Add
--để đưa 3 bảng vào. Lưu Database Diagram.

--B4) Nhập dữ liệu cho các bảng: Lưu ý, bảng nào tạo trước thì nhập trước.
--Ta copy và paste cho nhanh. R-Click vào bảng, chọn Edit Top 200 Rows.
--Chú ý: với dl của bảng TINH_TP, ta nên copy và dán vào excel, sau đó mới copy
--từ excel và dán vào bảng.

--B5) Truy vấn dữ liệu:
--1.	Xuất ra tên tỉnh, TP cùng với dân số của tỉnh, TP:
--a) Có diện tích >= 5000 Km2
select	TEN_T_TP, DS	--3
from	TINH_TP			--1
where	DT>=5000		--2
--b) Có diện tích >= [input] (SV nhập một số bất kỳ từ bàn phím)
select	TEN_T_TP, DS	--3
from	TINH_TP			--1
where	DT>=10000		--2
--2.	Xuất ra tên tỉnh, TP cùng với diện tích của tỉnh, TP:
--a) Thuộc miền Bắc
select TEN_T_TP,DT
from TINH_TP
where MIEN=N'Bắc'--Điều kiện để lọc dữ liệu. N: Unicode.
--b) Thuộc miền [input] (SV nhập một miền bất kỳ từ bàn phím)
select TEN_T_TP,DT
from TINH_TP
where MIEN='NAM'
--3.	Xuất ra các Tên tỉnh, TP biên giới thuộc miền [input] (SV cho một miền bất kỳ)
select DISTINCT TEN_T_TP,NUOC
from TINH_TP,BIENGIOI
where MIEN='NAM'
--4.	Cho biết diện tích trung bình của các tỉnh, TP (Tổng DT/Tổng số tỉnh_TP).
select sum(DT) --tổng DT
from TINH_TP
--
select count(MA_T_TP)--đếm MÃ
from TINH_TP
--
select count(TEN_T_TP) 
from TINH_TP
--
select count(DT)
from TINH_TP
--
select count(*)--đếm số dòng, ko quan tâm đến cột
from TINH_TP
--
select avg(DT) as N' Diện tích trung bình'
from TINH_TP
-- HOẶC
select sum(DT)/count(*) as N'Diện tích trung bình' --as: alias - bí danh
from TINH_TP
--5.	Cho biết dân số cùng với tên tỉnh của các tỉnh, TP có diện tích > 7000 Km2.t
select TEN_T_TP,DT
from TINH_TP
where DT>7000
--6.	Cho biết dân số cùng với tên tỉnh của các tỉnh miền ‘Bắc’.
select TEN_T_TP,DT
from TINH_TP
where MIEN=N'BẮC'
--7.	Cho biết mã các nước là biên giới của các tỉnh miền ‘Nam’.
select  NUOC,TEN_T_TP
from BIENGIOI,TINH_TP
where MIEN='NAM'
--8.	Cho biết diện tích trung bình của các tỉnh, TP. (Sử dụng hàm)
select avg(DT) as [Diện tích trung bình]
from TINH_TP
--9.	Cho biết mật độ dân số (DS/DT) cùng với tên tỉnh, TP của tất cả các tỉnh, TP.
select DS,DT,TEN_T_TP
from TINH_TP
--10.	Cho biết tên các tỉnh, TP láng giềng của tỉnh 'Long An'.
--Ý tưởng: 
--Cách 1) Xem trong bảng LANGGIENG, nếu cột LG có giá trị là 'LA' thì giá trị
--của cột MA_T_TP chính là láng giềng của nó.
select MA_T_TP
from LANGGIENG
where LG='LA'
--c1

select TEN_T_TP,LG
from TINH_TP,LANGGIENG
where TINH_TP.MA_T_TP=LANGGIENG.MA_T_TP--kết bảng
and LG='LA'
--Làm sao biết 'Long An' có mã là 'LA'?
select TEN_T_TP
from TINH_TP,LANGGIENG
where TINH_TP.MA_T_TP=LANGGIENG.MA_T_TP
and LG=(select MA_T_TP
		from TINH_TP
		where TEN_T_TP='Long An')
select TEN_T_TP
from TINH_TP,LANGGIENG
where TINH_TP.MA_T_TP=LANGGIENG.MA_T_TP
and LG=(select LG
		from TINH_TP
		where MA_T_TP='LA')
--11.	Cho biết số lượng các tỉnh, TP giáp với ‘CPC’.
select count(TEN_T_TP)
from TINH_TP,BIENGIOI
where TINH_TP.MA_T_TP=BIENGIOI.MA_T_TP
and NUOC='CPC'
--12.	Cho biết tên những tỉnh, TP có diện tích lớn nhất.
select TEN_T_TP
from TINH_TP
where DT=(select MAX(DT)
			from TINH_TP)
group by TEN_T_TP
--13.	Cho biết tỉnh, TP có mật độ DS đông nhất.
select TEN_T_TP
from TINH_TP
where DS=(select MAX(DS)
			from TINH_TP)
group by TEN_T_TP
--14.	Cho biết tên những tỉnh, TP giáp với hai nước biên giới khác nhau.
select TEN_T_TP,count(NUOC) as [Số biên giới]
from BIENGIOI B,TINH_TP T
where B.MA_T_TP=T.MA_T_TP
group by TEN_T_TP
having count(NUOC)>=2
-- In ra tên tỉnh,TP có 5 nước láng giềng trở lên
select TEN_T_TP,count(LG) as [Số láng giềng]
from LANGGIENG L,TINH_TP T
where L.MA_T_TP=T.MA_T_TP
group by TEN_T_TP
having count(LG)>=5
--Nâng cao: In ra tên tỉnh, TP có nhiều láng giềng nhất.
select TEN_T_TP,count (LG) as[ Số láng giềng]
from TINH_TP T, LANGGIENG L
where T.MA_T_TP=L.MA_T_TP
group by TEN_T_TP
having count(LG)>=ALL
(
	select count(LG)
	from TINH_TP T,LANGGIENG L
	where T.MA_T_TP=L.MA_T_TP
	group by TEN_T_TP
)
--c2 Tìm max select con
select TEN_T_TP,count(LG) as[Số láng giềng]
from TINH_TP T, LANGGIENG L
where T.MA_T_TP=L.MA_T_TP
group by TEN_T_TP
having count(LG)=
(
	select max ([Số Láng giềng])
	from (select count(LG) as [Số Láng giềng]
		from TINH_TP T, LANGGIENG L
		where T.MA_T_TP=L.MA_T_TP
		group by TEN_T_TP) as Temp
)
--c3
select TEN_T_TP,count(LG) as [Số láng giềng]
from TINH_TP T, LANGGIENG L
where T.MA_T_TP=L.MA_T_TP
group by TEN_T_TP
having count(LG)=(
select TEN_T_TP, [Số LG]
from TINH_TP T,  (select top 1 with ties T.MA_T_TP, count(LG) as [Số LG]
				  from TINH_TP T, LANGGIENG L
				  where T.MA_T_TP=L.MA_T_TP
				  group by T.MA_T_TP
				  order by  count(LG) DESC) as Temp
where T.MA_T_TP=Temp.MA_T_TP
)
--c3 
select top 1 with ties TEN_T_TP,count(LG) as[Số láng giềng]
from TINH_TP T,LANGGIENG L
where T.MA_T_TP=L.MA_T_TP
group by TEN_T_TP
order by count(LG) DESC
--15.	Cho biết danh sách các miền cùng với các tỉnh, TP trong các miền đó.\
select TEN_T_TP,MIEN
from  TINH_TP 
order by MIEN
--16.	Cho biết tên những tỉnh, TP có nhiều láng giềng nhất.
select top 1 with ties TEN_T_TP,count(LG) as[Số láng giềng]
from TINH_TP T,LANGGIENG L
where T.MA_T_TP=L.MA_T_TP
group by TEN_T_TP
order by count(LG) DESC
--17.	Cho biết những tỉnh, TP có diện tích nhỏ hơn diện tích trung bình của tất cả tỉnh, TP.
select MA_T_TP,TEN_T_TP,DT
from TINH_TP
where DT <
(
	select AVG(DT)
	from TINH_TP)
--18.	Cho biết tên những tỉnh, TP giáp với các tỉnh, TP ở miền ‘Nam’ và không phải là 
select T.MA_T_TP,TEN_T_TP,MIEN
from TINH_TP T,LANGGIENG L
where T.MA_T_TP=L.MA_T_TP and MIEN <>'NAM'
and LG in
(
	select distinct LG
	from LANGGIENG L,TINH_TP T
	where T.MA_T_TP=L.MA_T_TP and MIEN='NAM'
)
--19.	Cho biết tên những tỉnh, TP có diện tích lớn hơn tất cả các tỉnh, TP láng giềng của nó.
select T1.TEN_T_TP,DT
from TINH_TP T1
where T1.DT >=ALL
(
	select T2.DT
	from TINH_TP T2,LANGGIENG L
	where T2.MA_T_TP=L.MA_T_TP
	and l.MA_T_TP=T1.MA_T_TP
)
--20.	Cho biết tên những tỉnh, TP mà ta có thể đến bằng cách đi từ ‘TP.HCM’ 
--xuyên qua ba tỉnh khác nhau và cũng khác với điểm xuất phát, nhưng láng giềng với nhau
select 'HCM' as [Xuất phát],L1.LG,L2.LG,L3.LG
from TINH_TP T, LANGGIENG L1, LANGGIENG L2, LANGGIENG L3
where T.MA_T_TP='HCM' and T.MA_T_TP=L1.MA_T_TP--xuất phát 
	and L1.LG=L2.MA_T_TP and L2.LG=L3.MA_T_TP
	--ko quay lại đích
	and L2.LG<>'HCM' and L3.LG<>'HCM' and L1.LG<>L3.LG



