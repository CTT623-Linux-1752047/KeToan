use TinhTienLuong

--Create table 

CREATE TABLE NHANSU(
	ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, 

	UserID nchar(10) NOT NULL, 
	UserName nchar(10) NOT NULL, 
	HoVaTen nvarchar(50) NOT NULL, 
	NgaySinh date NOT NULL,   --OKE
	DiaChiThuongTru nvarchar(255),
	
	DiaChiTamTru nvarchar(255),
	CMND nchar(20),
	GioiTinh nvarchar(10),
	SoTKNganHang nchar(20),
	TrinhDo nvarchar(50),

	MaSoThue nchar(20) NOT NULL,
	TinhTrangHonNhan nvarchar(50),
	SoHDLD nchar(20) NOT NULL,
	LoaiHDLD nchar(20) NOT NULL,
	ThoiHanHDLD int,

	SoDT nchar(20),
	ChucDanh nvarchar(50),
	TrangThaiLamViec nvarchar(50) NOT NULL,
	NguoiPhuTrach nvarchar(255),
	EmailCongTy nvarchar(255) NOT NULL,

	NgayBatDau date NOT NULL,
	NoiLamViec nvarchar(255),
	LuongCB money NOT NULL,
	HoTenNguoiLienQuan nvarchar(255),
	SDTNguoiLienQuan nchar(20),

	DiaChiNguoiLienQuan nvarchar(255),
	MoiQuanHe nvarchar(50),
	NgaySinhNguoiLienQuan date,
	GioiTinhNguoiLienQuan nvarchar(10),
);go
CREATE TABLE NHANVIEN_OT(
	ID int IDENTITY(1,1) PRIMARY KEY,
	NgayThangNam date NOT NULL, 
	SoGioOT float NOT NULL,
	DuAnOT nvarchar(255),
	ID_NhanVien int FOREIGN KEY REFERENCES NHANSU(ID),
);go
CREATE TABLE NHAVIEN_GIOCONG(
	ID int IDENTITY(1,1) PRIMARY KEY,
	Ngay date NOT NULL, 
	ID_NhanVien int FOREIGN KEY REFERENCES NHANSU(ID),
	ThoiGianDiTreVeSom float NOT NULL,
);
 go
 CREATE TABLE LOAINGAYNGHI(
	ID int IDENTITY(1,1) PRIMARY KEY,
	LoaiNgayNghi nchar(20),
	TenNgayNghi nvarchar(50),
	ThoiGian float,
 );
 go 
 CREATE TABLE NHANVIEN_LOAINGAYNGHI(
	ID int IDENTITY(1,1) PRIMARY KEY, 
	NgayThangNam date, 
	ID_NhanVien int FOREIGN KEY REFERENCES NHANSU(ID),
	ID_LoaiNgayNghi int FOREIGN KEY REFERENCES LOAINGAYNGHI(ID),
 );
 go
 CREATE TABLE KHAUTRULUONG(
	ID int IDENTITY(1,1) PRIMARY KEY, 
	ThangNam date NOT NULL,
	ID_NhanVien int FOREIGN KEY REFERENCES NHANSU(ID),
	BHYT float,
	BHXH float, 
	BHTN float,
	ThueTNCN float, 
	NgayNghi float,
 );
 go
 CREATE TABLE LOAIPHUCAP(
	ID int IDENTITY(1,1) PRIMARY KEY, 
	LoaiPhuCap nchar(20),
	TenPhuCap nvarchar(50),
 );
 go
 CREATE TABLE NHANVIEN_LOAIPHUCAP ( 
	ID int IDENTITY(1,1) PRIMARY KEY, 
	ID_NhanVien int FOREIGN KEY REFERENCES NHANSU(ID) NOT NULL,
	ID_LOAIPHUCAP int FOREIGN KEY REFERENCES LOAIPHUCAP(ID) NOT NULL,
	Thang int,
 );
 go
CREATE TABLE BANGLUONG(
	ID int IDENTITY(1,1) PRIMARY KEY, 
	ID_NhanVien int FOREIGN KEY REFERENCES NHANSU(ID) NOT NULL, 
	LuongThang float, 
	TongPhuCap float, 
	TongKhauTruLuong float, 
	TongOT float, 
	ThucNhan float,
);go
ALTER TABLE NHANSU ALTER COLUMN NgaySinh date
ALTER TABLE NHANSU ALTER COLUMN NgaySinhNguoiLienQuan date
ALTER TABLE NHANVIEN_LOAINGAYNGHI ALTER COLUMN NgayThangNam datetime
ALTER TABLE NHANVIEN_LOAINGAYNGHI ADD NgayKetThuc datetime
ALTER TABLE NHANVIEN_LOAINGAYNGHI ADD LyDo nvarchar(255)
ALTER TABLE NHANSU ALTER COLUMN NgaySinh Date NULL
ALTER TABLE NHANSU ALTER COLUMN MaSoThue nchar(20) NULL
ALTER TABLE NHANSU ALTER COLUMN SoHDLD nchar(20) NULL
ALTER TABLE NHANSU ALTER COLUMN LoaiHDLD nchar(20) NULL
ALTER TABLE NHANSU ALTER COLUMN TrangThaiLamViec nvarchar(50) NULL
ALTER TABLE NHANSU ALTER COLUMN EmailCongTy nvarchar(255) NULL
ALTER TABLE NHANSU ALTER COLUMN NgayBatDau date NULL
ALTER TABLE NHANSU ALTER COLUMN LuongCB money NULL
ALTER TABLE NHANSU ALTER COLUMN HoVaTen nvarchar(50) NOT NULL
sp_rename 'NHANVIEN_LOAINGAYNGHI.NgayThangNam', 'NgayBatDau', 'COLUMN'

--Insert thông tin nhân viên 
SET IDENTITY_INSERT NHANSU ON
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(1,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(2,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(3,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(4,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(5,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(6,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(7,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(8,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(9,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')

INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(10,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(11,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(12,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(13,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(14,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(15,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(16,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(17,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(18,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(19,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(20,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(21,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(22,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(23,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(24,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(25,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(26,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(27,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(28,'00001','toanlm',N'Lư Manh Toàn', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(29,'10175','truongnn',N'Nguyễn Nhật Trường', '19980525',
					N'258 Hòa Hảo p5 q10 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025542513','Nam',
					'4797932087363','MST010','445','TH1002',24,
					'dev','Chính Thức','20201017','truongnn@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0932795397',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')
INSERT INTO NHANSU(ID,UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES(30,'10179','trangntt',N'Nguyễn Thị Thùy Trang', '19991228',
					N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM',N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', '027896517',N'Nữ',
					'4797932896457','MST015','450','TH1003',12,
					'dev','Trainnie','20201001','trangntt@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0902502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')


SET IDENTITY_INSERT NHANSU OFF



--insert thông tin loại ngày nghỉ 
SET IDENTITY_INSERT LOAINGAYNGHI ON
INSERT INTO LOAINGAYNGHI(ID,LoaiNgayNghi,TenNgayNghi,ThoiGian)
		VALUES (1,'Co Phep',N'Nghỉ Sinh Nhật',1)
INSERT INTO LOAINGAYNGHI(ID,LoaiNgayNghi,TenNgayNghi,ThoiGian)
		VALUES (2 ,'Co Phep',N'Nghỉ Có Phép Theo Tháng',1)
INSERT INTO LOAINGAYNGHI(ID,LoaiNgayNghi,TenNgayNghi,ThoiGian)
		VALUES (3, 'Khong Phep', N'Nghi Không Phép Theo Tháng', 1)
INSERT INTO LOAINGAYNGHI(ID,LoaiNgayNghi,TenNgayNghi,ThoiGian)
		VALUES (4, 'Co Phep',N'Nghỉ Quốc Khánh 2/9 ', 1)
INSERT INTO LOAINGAYNGHI(ID,LoaiNgayNghi,TenNgayNghi,ThoiGian)
		VALUES (5, 'Co Phep',N'Nghỉ Tết Nguyên Đáng ', 8)
SET IDENTITY_INSERT LOAINGAYNGHI OFF

--insert ngày nghỉ cho nhân viên 
SET IDENTITY_INSERT NHANVIEN_LOAINGAYNGHI ON
INSERT INTO NHANVIEN_LOAINGAYNGHI(ID,NgayThangNam,ID_NhanVien,ID_LoaiNgayNghi)
		VALUES (1,'20201005',1,2)
INSERT INTO NHANVIEN_LOAINGAYNGHI(ID,NgayThangNam,ID_NhanVien,ID_LoaiNgayNghi)
		VALUES (2,'20201015',1,3)
INSERT INTO NHANVIEN_LOAINGAYNGHI(ID,NgayThangNam,ID_NhanVien,ID_LoaiNgayNghi)
		VALUES (3,'20200902',1,4)
SET IDENTITY_INSERT NHANVIEN_LOAINGAYNGHI OFF

--NgayThangNam, HoVaTen, LoaiNgayNghi,TenNgayNghi,ThoiGian  AND ID_NhanVien = NHANSU.ID
SELECT SUM(ThoiGian) FROM NHANVIEN_LOAINGAYNGHI,LOAINGAYNGHI WHERE NHANVIEN_LOAINGAYNGHI.ID_LoaiNgayNghi = LOAINGAYNGHI.ID

SET IDENTITY_INSERT NHAVIEN_GIOCONG ON
INSERT INTO NHAVIEN_GIOCONG(ID,Ngay,ID_NhanVien,ThoiGianDiTreVeSom)
		VALUES(1,'20201018',1,0.5)
INSERT INTO NHAVIEN_GIOCONG(ID,Ngay,ID_NhanVien,ThoiGianDiTreVeSom)
		VALUES(2,'20201015',1,1)
INSERT INTO NHAVIEN_GIOCONG(ID,Ngay,ID_NhanVien,ThoiGianDiTreVeSom)
		VALUES(3,'20201015',1,0.25)
SET IDENTITY_INSERT NHAVIEN_GIOCONG OFF

EXEC TinhLuongCBTheoThang '00001', '20201001'

SELECT * FROM KHAUTRULUONG
alter table KHAUTRULUONG drop column NgayNghi
ALTER TABLE NHANSU ALTER COLUMN HoVaTen nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AI

SELECT * FROM NHANSU WHERE NHANSU.HoVaTen LIKE N'%Tr__g%'

PRINT NCHAR(UNICODE(N'%o%'))

INSERT INTO NHANSU(UserID,UserName,HoVaTen,NgaySinh,
					DiaChiThuongTru,DiaChiTamTru,CMND,GioiTinh,
					SoTKNganHang,MaSoThue,SoHDLD,LoaiHDLD,ThoiHanHDLD,
					ChucDanh,TrangThaiLamViec,NgayBatDau,EmailCongTy,
					LuongCB,TrinhDo,NguoiPhuTrach,SoDT,NoiLamViec)
			VALUES('00011','hieutc',N'Từ Công Hiếu', '19980223',
					N'49/2/4 Khánh Hôi p3 q4 tp.HCM',N'49/2/4 Khánh Hôi p3 q4 tp.HCM', '025699517','Nam',
					'4797932973363','MST009','440','TH1001',12,
					'dev','Trainnie','20201001','toanlm@allexceed.co.jp',
					8500000.00,N'Đại Học',N'Mạch Huệ Hùng','0961502191',N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM')

UPDATE NHANSU SET UserName = 'toanlm', HoVaTen = N'Lư Mạnh Toàn',NgaySinh = '19980223',
					DiaChiThuongTru = N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', DiaChiTamTru = N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM',
					CMND = '025699517', GioiTinh = N'Nam', SoTKNganHang = '1017317271', MaSoThue = '0931421', SoHDLD = '000005',
					LoaiHDLD = 'TH0001', ThoiHanHDLD = 18, ChucDanh = N'dev', TrangThaiLamViec = N'Chinh Thức', NgayBatDau = '20201001',
					EmailCongTy = 'toanlm@allexceed.co.jp', LuongCB = 8500000, TrinhDo = N'Đai Học', NguoiPhuTrach = N'Mạch Huệ Hùng', 
					SoDT = '0961502191', NoiLamViec = N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', HoTenNguoiLienQuan = N''
WHERE UserID = 00001


INSERT INTO LOAINGAYNGHI(LoaiNgayNghi,TenNgayNghi,ThoiGian) VALUES (N'Không Phép',N'Nghỉ không phép ',Null)

INSERT INTO NHANVIEN_LOAINGAYNGHI(ID_NhanVien, ID_LoaiNgayNghi)

