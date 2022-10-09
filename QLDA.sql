create database QLDA
on
(
	name='QLSV_Data',
	filename='D:\Database\QLDA.MDF'
)
log on
(
	name='QLDA_Log',
	filename='D:\Database\QLDA.LDF'
)
use QLDA
create table NCC
(
	MANCC char(5) primary key,
	TEN nvarchar(40),
	HESO int,
	THPHO varchar(20)
)
create table VATTU 
(
	MAVT char(5)primary key,
	TEN nvarchar(40),
	MAU varchar(15),
	TRLUONG float,
	THPHO varchar(20)

)
create table DUAN
(
	MADA char(5)primary key,
	TEN nvarchar(40),
	THPHO varchar(20),
)
create table CC
(
	MANCC char(5),
	MAVT char(5),
	MADA char(5),
	SLUONG int
	primary key(MANCC,MAVT,MADA),
	foreign key (MANCC) references NCC(MANCC)
	on update cascade
	on delete cascade,
	foreign key (MAVT) references VATTU(MAVT)
	on update cascade
	on delete cascade,
	foreign key (MADA) references DUAN(MADA)
	on update cascade
	on delete cascade
)
14)	Cho biết mã số các vật tư được cung cấp bởi nhiều hơn một nhà cung cấp.
select MAVT ,count(MANCC) as [Số lượng nhà cung cấp]
from  CC n
group by MAVT
 having count(MANCC)>1
15)	Với mỗi vật tư cho biết mã số và tổng số lượng được cung cấp cho các dự án.
 select MAVT , sum(SLUONG) as [Tổng số lượng cung cấp]
 from   CC C
 group by MAVT
16)	Cho biết tổng số các dự án được cung cấp vật tư bởi nhà cung cấp S1.
 select count(MADA) as[Tổng các dự án cung cấp bởi S1]
 from CC C
 where  MANCC ='S1'
17)	Cho biết tổng số lượng vật tư P1 được cung bởi nhà cung cấp S1.
select sum(SLuong) as [Tổng số lượng vật tư]
from CC
where MaNCC like 'S1' and MaVT like 'P1'


18)	Với mỗi vật tư được cung cấp cho một dự án, cho biết mã số, tên vật tư, tên dự án và tổng số lượng vật tư tương ứng.
 select V.MAVT,V.TEN as [Tên Vật tư],D.TEN as [Tên dự án],sum(SLUONG) as [Tổng số lượng vật tư]
 from VATTU v,DUAN D,CC c
 where V.MAVT=C.MAVT and D.MADA=C.MADA
 group by V.MAVT,V.TEN,D.TEN
19)	Cho biết mã số, tên các vật tư và tên dự án có số lượng vật tư trung bình cung cấp cho dự án lớn hơn 350.
 select V.MAVT,V.TEN as [Tên Vật tư],avg(SLUONG),D.TEN as [Tên dự án]
 from VATTU v,DUAN D,CC c
 where V.MAVT=C.MAVT and D.MADA=C.MADA 
group by V.MAVT,V.TEN as [Tên Vật tư],D.TEN as [Tên dự án]
having avg(SLUONG) > 350
20)	Cho biết tên các dự án được cung cấp vật tư bởi nhà cung cấp S1.
 select TEN
 FROM DUAN D, CC C
 WHERE d.MADA=c.MADA AND MANCC='S1'


 30)	Cho biết mã số và tên các nhà cung cấp cung cấp vật tư P1 cho một dự án nào đó với số lượng lớn hơn số lượng trung bình của vật tư P1 được cung cấp cho dự án đó.
 32)	Cho biết mã số và tên các dự án được cung cấp toàn bộ vật tư bởi nhà cung cấp S1
 select D.MADA,TEN
 from DUAN D,CC C
 where D.MADA=C.MADA and MANCC='S1'
 34)	Cho biết mã số và tên các vật tư được cung cấp cho tất cả các dự án tại TpHCM.
 select MAVT,TEN
 from VATTU
 where THPHO='TpHCM'
 36)	Cho biết mã số và tên các dự án được cung cấp tất cả các vật tư có thể được cung cấp bởi nhà cung cấp S1.
 select D.MADA,TEN
 from DUAN D, CC C
 where D.MADA=C.MADA and MANCC='S1' 
 37)	Cho biết tất cả các thành phố mà nơi đó có ít nhất một nhà cung cấp, trữ ít nhất một vật tư hoặc có ít nhất một dự án.
 select D.THPHO
 from DUAN D,VATTU V,NCC N,CC C
 where D.MADA=C.MADA and V.MAVT=C.MAVT and N.MANCC=C.MANCC
 having count(MANCC,MADA,MAVT)>1
 41)	Cho biết tên các thành phố trữ nhiều hơn 5 vật tư có quy cách màu đỏ
 select THPHO
 from VATTU
 where MAU='DO'
 group by THPHO
 having count(TRLUONG) > 5

		