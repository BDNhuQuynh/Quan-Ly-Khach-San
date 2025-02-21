create database QLKS
go
use QLKS

CREATE TABLE NHANVIEN
(
    MANV varchar(5) NOT NULL,
    HO nvarchar(10),
    TEN nvarchar(30),
    EMAIL varchar(50),
    GIOITINH nvarchar(3) CHECK (GIOITINH IN ('Nam', N'Nữ')),
    SDTNV varchar(12),
    LUONG float,
    NGAYSINH date,
    NGAYVAOLAM date,
    ISDELETE int default 0,
    ROLENV nvarchar(50) CHECK (ROLENV IN (N'Nhân viên lễ tân', N'Nhân viên kinh doanh', N'Nhân viên kế toán', N'Nhân viên dịch vụ', N'Nhân viên nhân sự')),
    CONSTRAINT PK_NHANVIEN PRIMARY KEY(MANV)
);

CREATE TABLE TAIKHOANNV
(
	MATKNV int identity(1,1) NOT NULL,
	TENDANGNHAP varchar(30) unique,
	MATKHAU varchar(30),
	MANV varchar(5) NOT NULL,
	CONSTRAINT PK_TKNV PRIMARY KEY(MATKNV)
);
alter table TAIKHOANNV
add constraint FK_TKNV_NV foreign key(MANV) references NHANVIEN(MANV)




create table LOAIDICHVU
(
MALDV varchar(5) not null,
TENLDV nvarchar(10),
constraint PK_LOAIDICHVU primary key(MALDV)
)

create table DICHVU
(
MADV varchar(5) not null,
TENDV nvarchar(10),
MALDV varchar(5) not null,
GIA float,
constraint PK_DICHVU primary key(MADV)
)
alter table DICHVU
add constraint FK_DV_LDV foreign key(MALDV) references LOAIDICHVU(MALDV)

create table LOAIPHONG
(
MALOAI varchar(5) not null,
TENLOAI nvarchar(10),
constraint PK_LP primary key(MALOAI)
)

create table PHONG
(
MAPH varchar(5) not null,
TENPH nvarchar(50),
SL int,
TRANGTHAI varchar(10),
GIA float,
SONGUOIO int,
MALOAI varchar(5),
constraint PK_PH primary key(MAPH)
)
alter table PHONG
add constraint FK_PH_MALOAI foreign key(MALOAI) references LOAIPHONG(MALOAI)

create table KHACHHANG
(
MAKH varchar(5) not null,
TENKH nvarchar(30),
CMND varchar(20),
NGAYSINH date,
GIOITINH nvarchar(3) CHECK (GIOITINH IN ('Nam', N'Nữ')),
SDT varchar(12),
constraint PK_KH primary key(MAKH)
)


create table DATPHONGTRUOC
(
MADP varchar(5) not null,
MAPH varchar(5) not null,
MAKH varchar(5) not null,
SONGUOIO int,
YEUCAUDACBIET nvarchar(50),
NGAYDEN date,
NGAYDI date, 
constraint PK_DP primary key(MADP)
)
alter table DATPHONGTRUOC
add 
constraint FK_DP_KH foreign key(MAKH) references KHACHHANG(MAKH),
constraint FK_DP_PH foreign key(MAPH) references PHONG(MAPH)

create table PHIEUDEN
(
MAPD varchar(5) not null,
MAPH varchar(5) not null,
MAKH varchar(5) not null,
MANV varchar(5) not null,
NGAYDEN date,
TINHTRANGHUHAI nvarchar(50),
constraint PK_PD primary key(MAPD)
)
alter table PHIEUDEN
add constraint FK_PD_NV foreign key(MANV) references NHANVIEN(MANV),
constraint FK_PD_KH foreign key(MAKH) references KHACHHANG(MAKH),
constraint FK_PD_PH foreign key(MAPH) references PHONG(MAPH)


create table BANGKEDICHVU
(
MABKDV varchar(5) not null,
MAKH varchar(5) not null,
TONGTIEN float
constraint PK_BKDV primary key(MABKDV)
)
alter table BANGKEDICHVU
add constraint FK_BKDV_KH foreign key(MAKH) references KHACHHANG(MAKH)


create table CHITIETBKDV
(
MACTBKDV varchar(5) not null,
MADV varchar(5) not null,
MABKDV varchar(5) not null,
THOIGIAN date,
constraint PK_CTBKDV primary key(MACTBKDV)
)
alter table CHITIETBKDV
add constraint FK_CTBKDV_DV foreign key(MADV) references DICHVU(MADV),
constraint FK_CTBKDV_BKDV foreign key(MABKDV) references BANGKEDICHVU(MABKDV)


create table LOAIMONAN
(
MALMA varchar(5) not null,
TENLMA nvarchar(10),
constraint PK_LOAIMONAN primary key(MALMA)
)

create table MONAN
(
MAMONAN varchar(5) not null,
TENMONAN nvarchar(10),
THAMMY nvarchar(40),
CACHTRINHBAY nvarchar(40),
THOIGIANBAYTRI int,
MALMA varchar(5) not null,
GIA float,
constraint PK_MONAN primary key(MAMONAN)
)
alter table MONAN
add constraint FK_MA_LMA foreign key(MALMA) references LOAIMONAN(MALMA)

create table HOADONDATTIEC
(
MAHDDT varchar(5) not null,
MAKH varchar(5) not null,
TINHTRANGTHANHTOAN nvarchar(20) CHECK (TINHTRANGTHANHTOAN IN (N'Đã thanh toán', N'Chưa thanh toán')),
TONGTIEN float,
constraint PK_HDDT primary key(MAHDDT)
)
alter table HOADONDATTIEC
add constraint FK_HDDT_KH foreign key(MAKH) references KHACHHANG(MAKH)

create table CHITIETHDDT
(
MACTHDDT varchar(5) not null,
MAMONAN varchar(5) not null,
SOLUONG int,
MAHDDT varchar(5) not null,
constraint PK_CTHDDT primary key(MACTHDDT)
)
alter table CHITIETHDDT
add 
constraint FK_CTHDDT_HDDT foreign key(MAHDDT) references HOADONDATTIEC(MAHDDT),
constraint FK_CTHDDT_MA foreign key(MAMONAN) references MONAN(MAMONAN)

create table HOADON
(
MAHD varchar(5) not null,
MAKH varchar(5) not null,
MANV varchar(5) not null,
NGAYTHU date,
LYDOTHU nvarchar(50),
TONGTIEN float,
constraint PK_HD primary key(MAHD)
)
alter table HOADON
add constraint FK_HD_NV foreign key(MANV) references NHANVIEN(MANV),
constraint FK_HD_KH foreign key(MAKH) references KHACHHANG(MAKH)

create table CHITIETHOADON
(
MACTHD varchar(5) not null,
MAHD varchar(5) not null,
MAPD varchar(5) not null,
TIENTHUKHAC float,
constraint PK_CTHD primary key(MACTHD)
)
alter table CHITIETHOADON add
constraint FK_CTHD_HD foreign key(MAHD) references HOADON(MAHD),
constraint FK_CTHD_PD foreign key(MAPD) references PHIEUDEN(MAPD)


SET DATEFORMAT DMY
INSERT INTO NHANVIEN (MANV, HO, TEN, EMAIL, GIOITINH ,SDTNV, LUONG,NGAYSINH, NGAYVAOLAM, ROLENV) VALUES
('NV001', N'Nguyễn', N'Văn Sơn', 'nguyenvanson@example.com', 'Nam', '0901234567', 8000000,'1990-01-01', '2020-01-01', N'Nhân viên lễ tân'),
('NV002', N'Trần', N'Thị Vân Anh', 'tranthivananh@example.com', N'Nữ', '0902234567',10000000, '1992-02-02', '2021-02-01', N'Nhân viên kinh doanh'),
('NV003', N'Lê', N'Văn Long', 'levanlong@example.com', 'Nam', '0903234567',10500000, '1988-03-03', '2019-03-01', N'Nhân viên kế toán'),
('NV004', N'Phạm', N'Trần Diệu Linh', 'phamtrandieulinh@example.com', N'Nữ', '0904234567', 9000000,'1994-04-04', '2022-04-01', N'Nhân viên dịch vụ'),
('NV005', N'Hoàng', N'Thế Lực', 'hoangtheluc@example.com', 'Nam', '0905234567',12000000, '1995-05-05', '2020-05-01', N'Nhân viên nhân sự'),
('NV006', N'Vũ', N'Thị Trà', 'vuthitra@example.com', N'Nữ', '0906234567',8000000, '1993-06-06', '2021-06-01', N'Nhân viên lễ tân'),
('NV007', N'Ngô', N'Văn Hải', 'ngovanhai@example.com', 'Nam', '0907234567',10000000, '1989-07-07', '2018-07-01', N'Nhân viên kinh doanh');



INSERT INTO TAIKHOANNV(TENDANGNHAP,MATKHAU,MANV) VALUES
('theluc95','123456','NV005')

--- Trigger themMaKhachHang
CREATE TRIGGER themMaKhachHang ON KHACHHANG
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @Makh CHAR(8);

    BEGIN TRAN;

    -- Tạo mã khách hàng dựa trên số lượng khách hàng hiện tại
    SET @Makh = 'KH' + RIGHT('000' + CAST((ISNULL((SELECT MAX(CAST(SUBSTRING(MAKH, 3, LEN(MAKH)-2) AS INT)) FROM KHACHHANG), 0) + 1) AS NVARCHAR(3)), 3);
    
    -- Thêm vào bảng KHACHHANG
    INSERT INTO KHACHHANG (MAKH, TENKH, CMND, NGAYSINH, GIOITINH, SDT) 
    SELECT 
        @Makh, TENKH, CMND, NGAYSINH, GIOITINH, SDT 
    FROM inserted;

    COMMIT TRAN;
END;
--Proc insert KHACHHANG
create proc themKhachHang
	@hoten nvarchar(30), @cmnd varchar(20), @ngaysinh date, @gioitinh nvarchar(3), @sdt varchar(12)
AS
Begin
	insert into KHACHHANG(TENKH, CMND, NGAYSINH, GIOITINH, SDT)
	values (@hoten, @cmnd,@ngaysinh,@gioitinh,@sdt);

END;
GO


DROP PROC themKhachHang

create proc updateKhachHang
	@makh varchar(5), @hoten nvarchar(30), @cmnd varchar(20), @ngaysinh date, @gioitinh nvarchar(3), @sdt varchar(12)
AS
Begin
	update KHACHHANG 
	set TENKH = @hoten, CMND = @cmnd, NGAYSINH =@ngaysinh, GIOITINH=@gioitinh, SDT=@sdt
	where MAKH=@makh

END;
GO

create proc xoaKhachHang
	@makh char (8)
AS
Begin
	delete from KHACHHANG where MAKH=@makh

END;
GO

create proc timKhachHang
	 @tenkh nvarchar (30)
AS
Begin
	select * from KHACHHANG where TENKH=@tenkh
END;
GO

DROP PROC timKhachHang