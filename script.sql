USE [master]
GO
/****** Object:  Database [TinhTienLuong]    Script Date: 11/27/2020 5:37:41 PM ******/
CREATE DATABASE [TinhTienLuong]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TinhTienLuong', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TinhTienLuong.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TinhTienLuong_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TinhTienLuong_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TinhTienLuong] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TinhTienLuong].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TinhTienLuong] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TinhTienLuong] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TinhTienLuong] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TinhTienLuong] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TinhTienLuong] SET ARITHABORT OFF 
GO
ALTER DATABASE [TinhTienLuong] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TinhTienLuong] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TinhTienLuong] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TinhTienLuong] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TinhTienLuong] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TinhTienLuong] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TinhTienLuong] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TinhTienLuong] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TinhTienLuong] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TinhTienLuong] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TinhTienLuong] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TinhTienLuong] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TinhTienLuong] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TinhTienLuong] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TinhTienLuong] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TinhTienLuong] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TinhTienLuong] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TinhTienLuong] SET RECOVERY FULL 
GO
ALTER DATABASE [TinhTienLuong] SET  MULTI_USER 
GO
ALTER DATABASE [TinhTienLuong] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TinhTienLuong] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TinhTienLuong] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TinhTienLuong] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TinhTienLuong] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TinhTienLuong', N'ON'
GO
ALTER DATABASE [TinhTienLuong] SET QUERY_STORE = OFF
GO
USE [TinhTienLuong]
GO
/****** Object:  UserDefinedFunction [dbo].[fnCheckOffDayDuplicate]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnCheckOffDayDuplicate] 
(
	@IDNhanVien int ,
	@IDLoaiNgayNghi int,
	@NgayBatDau datetime,
	@NgayKetThuc datetime,
	@LyDo nvarchar(255)
)
RETURNS INT AS 
BEGIN 
	RETURN(	SELECT COUNT(ID)
			FROM 
				NHANVIEN_LOAINGAYNGHI 
			WHERE 
				ID_NhanVien = @IDNhanVien AND 
				ID_LoaiNgayNghi = @IDLoaiNgayNghi AND 
				NgayBatDau = @NgayBatDau AND 
				NgayKetThuc = @NgayKetThuc AND
				LyDo = @LyDo)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnFullMonthsSeparation]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnFullMonthsSeparation] 
(
    @DateA DATETIME,
    @DateB DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT

    DECLARE @DateX DATETIME
    DECLARE @DateY DATETIME

    IF(@DateA < @DateB)
    BEGIN
        SET @DateX = @DateA
        SET @DateY = @DateB
    END
    ELSE
    BEGIN
        SET @DateX = @DateB
        SET @DateY = @DateA
    END

    SET @Result = (
                    SELECT 
                    CASE 
                        WHEN DATEPART(DAY, @DateX) > DATEPART(DAY, @DateY)
                        THEN DATEDIFF(MONTH, @DateX, @DateY) - 1
                        ELSE DATEDIFF(MONTH, @DateX, @DateY)
                    END
                    )

    RETURN @Result
END
GO
/****** Object:  Table [dbo].[NHANSU]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANSU](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [nchar](10) NOT NULL,
	[UserName] [nchar](10) NOT NULL,
	[HoVaTen] [nvarchar](50) NOT NULL,
	[NgaySinh] [date] NULL,
	[DiaChiThuongTru] [nvarchar](255) NULL,
	[DiaChiTamTru] [nvarchar](255) NULL,
	[CMND] [nchar](20) NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[SoTKNganHang] [nchar](20) NULL,
	[TrinhDo] [nvarchar](50) NULL,
	[MaSoThue] [nchar](20) NULL,
	[TinhTrangHonNhan] [nvarchar](50) NULL,
	[SoHDLD] [nchar](20) NULL,
	[LoaiHDLD] [nchar](20) NULL,
	[ThoiHanHDLD] [int] NULL,
	[SoDT] [nchar](20) NULL,
	[ChucDanh] [int] NULL,
	[TrangThaiLamViec] [int] NULL,
	[NguoiPhuTrach] [int] NULL,
	[EmailCongTy] [nvarchar](255) NULL,
	[NgayBatDau] [date] NULL,
	[NoiLamViec] [nvarchar](255) NULL,
	[LuongCB] [money] NULL,
	[HoTenNguoiLienQuan] [nvarchar](255) NULL,
	[SDTNguoiLienQuan] [nchar](20) NULL,
	[DiaChiNguoiLienQuan] [nvarchar](255) NULL,
	[MoiQuanHe] [nvarchar](50) NULL,
	[NgaySinhNguoiLienQuan] [date] NULL,
	[GioiTinhNguoiLienQuan] [nvarchar](10) NULL,
	[SoNgayNghiPhep] [int] NULL,
	[NgayResetNghiCoPhep] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN_GIOCONG]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_GIOCONG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NgayGioKetThuc] [datetime] NULL,
	[ID_NhanVien] [int] NULL,
	[NgayGioBatDau] [datetime] NULL,
	[ID_GioCong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayWorkingDaysForStaff]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayWorkingDaysForStaff]
(
	@HoVaTen nvarchar(255),
	@ThangNamStart date,
	@ThangNamEnd date
)
RETURNS TABLE RETURN 
	SELECT
		NHANSU.HoVaTen
	FROM 
		NHANVIEN_GIOCONG, NHANSU
	WHERE 
		NHANVIEN_GIOCONG.ID_NhanVien = NHANSU.ID
		AND 
		NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
GO
/****** Object:  Table [dbo].[NHANVIEN_LOAINGAYNGHI]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_LOAINGAYNGHI](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NgayBatDau] [datetime] NULL,
	[ID_NhanVien] [int] NULL,
	[ID_LoaiNgayNghi] [int] NULL,
	[NgayKetThuc] [datetime] NULL,
	[LyDo] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayWorkingDaysStaffOfMonth]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayWorkingDaysStaffOfMonth]
(
	@HoVaTen nvarchar(255),
	@ThangNam date
)
RETURNS TABLE RETURN 
	SELECT 
		HoVaTen, 
		WFH, 
		LEAVES, 
		TotalOFFDays
	FROM 
	(
		SELECT 
			NHANSU.HoVaTen ,
			NHANVIEN_GIOCONG.ID_NhanVien,
			COUNT	(CASE	WHEN ID_GioCong = 1 THEN 1
							ELSE NULL
					END) AS WFH,
			SUM	(CASE	WHEN ID_GioCong = 2 THEN DATEDIFF(HOUR, NHANVIEN_GIOCONG.NgayGioBatDau, NHANVIEN_GIOCONG.NgayGioKetThuc) - 1
					END) AS LEAVES
		FROM 
			NHANVIEN_GIOCONG INNER JOIN NHANSU ON NHANVIEN_GIOCONG.ID_NhanVien = NHANSU.ID
		WHERE 
			(
			MONTH(NHANVIEN_GIOCONG.NgayGioBatDau) = MONTH(@ThangNam)
			AND 
			MONTH(NHANVIEN_GIOCONG.NgayGioKetThuc) = MONTH(@ThangNam)
			)
			AND 
			NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
		GROUP BY NHANSU.HoVaTen, NHANVIEN_GIOCONG.ID_NhanVien			
	) WORKINGDAYS
	LEFT JOIN 
	(
		SELECT 
			NHANSU.HoVaTen as t1 , NHANVIEN_LOAINGAYNGHI.ID_NhanVien as t2,
			COUNT(NHANVIEN_LOAINGAYNGHI.ID) as TotalOFFDays
		FROM 
			NHANVIEN_LOAINGAYNGHI
			INNER JOIN NHANSU ON NHANSU.ID = NHANVIEN_LOAINGAYNGHI.ID_NhanVien
		WHERE 
		(
			MONTH(NHANVIEN_LOAINGAYNGHI.NgayBatDau) = MONTH(@ThangNam) 
			AND 
			MONTH(NHANVIEN_LOAINGAYNGHI.NgayKetThuc) = MONTH(@ThangNam)
		)
		AND 
		NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
		GROUP BY NHANSU.HoVaTen, NHANVIEN_LOAINGAYNGHI.ID_NhanVien
	) SOMETHING ON WORKINGDAYS.ID_NhanVien = SOMETHING.t2
GO
/****** Object:  Table [dbo].[LOAINGAYNGHI]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAINGAYNGHI](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoaiNgayNghi] [nchar](20) NULL,
	[TenNgayNghi] [nvarchar](50) NULL,
	[ThoiGian] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOFFDayFollowCondition]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayOFFDayFollowCondition]
(	
	@NgayBatDau datetime,
	@NgayKetThuc datetime, 
	@HoVaTen nvarchar(255)
)
RETURNS TABLE RETURN 
	SELECT 
		NHANVIEN_LOAINGAYNGHI.ID,
		NHANSU.UserName, 
		NHANSU.UserID,
		NHANSU.HoVaTen,
		NHANVIEN_LOAINGAYNGHI.NgayBatDau,
		NHANVIEN_LOAINGAYNGHI.NgayKetThuc, 
		NHANVIEN_LOAINGAYNGHI.ID_LoaiNgayNghi, 
		NHANVIEN_LOAINGAYNGHI.ID_NhanVien,
		NHANVIEN_LOAINGAYNGHI.LyDo
	FROM 
		((NHANVIEN_LOAINGAYNGHI
			INNER JOIN NHANSU ON NHANSU.ID = NHANVIEN_LOAINGAYNGHI.ID_NhanVien)
			INNER JOIN LOAINGAYNGHI ON LOAINGAYNGHI.ID = NHANVIEN_LOAINGAYNGHI.ID_LoaiNgayNghi)
	WHERE
		(NHANVIEN_LOAINGAYNGHI.NgayKetThuc >= @NgayBatDau AND NHANVIEN_LOAINGAYNGHI.NgayBatDau <= @NgayKetThuc)
		AND 
		NHANSU.TrangThaiLamViec != 1
		AND 
		NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayTitleOFFDay]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayTitleOFFDay] 
(
)
RETURNS TABLE RETURN 
	SELECT * 
	FROM 
		LOAINGAYNGHI
GO
/****** Object:  Table [dbo].[TRANGTHAILAMVIEC]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRANGTHAILAMVIEC](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenTrangThai] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOptionStateWorking]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayOptionStateWorking]
(
)
RETURNS TABLE RETURN 
	SELECT * 
	FROM 
		TRANGTHAILAMVIEC
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayStaffFollowName]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayStaffFollowName]
(
	@HoVaTen nvarchar(255)
)
RETURNS TABLE RETURN 
	SELECT *
	FROM 
		NHANSU
	WHERE 
		NHANSU.TrangThaiLamViec != 1
		AND 
		NHANSU.HoVaTen LIKE N'%'+ @HoVaTen + '%'
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayStaffFollowID]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayStaffFollowID] 
(
	@id_NhanVien int 
)
RETURNS TABLE RETURN 
	SELECT 
		NVPhuTrach.HoVaTen AS NguoiPhuTrach,
		NVPhuTrach.ID, 
		NV.HoVaTen,
		NV.UserID, 
		NV.UserName,
		NV.TrinhDo,
		NV.TrangThaiLamViec,
		NV.TinhTrangHonNhan,
		NV.ThoiHanHDLD, 
		NV.SoTKNganHang,
		NV.SoHDLD,
		NV.SoDT,
		NV.SDTNguoiLienQuan,
		NV.NoiLamViec, 
		NV.NgaySinhNguoiLienQuan, 
		NV.NgaySinh, 
		NV.NgayBatDau, 
		NV.MoiQuanHe, 
		NV.MaSoThue, 
		NV.LuongCB, 
		NV.ChucDanh, 
		NV.CMND, 
		NV.DiaChiNguoiLienQuan,
		NV.DiaChiTamTru, 
		NV.DiaChiThuongTru, 
		NV.EmailCongTy,
		NV.GioiTinh, 
		NV.GioiTinhNguoiLienQuan, 
		NV.HoTenNguoiLienQuan,
		NV.LoaiHDLD
	FROM NHANSU AS NVPhuTrach
		INNER JOIN NHANSU AS NV on NV.NguoiPhuTrach = NVPhuTrach.ID
	WHERE 
	NV.TrangThaiLamViec != 1
	AND 
	NV.ID = @id_NhanVien
GO
/****** Object:  Table [dbo].[CHUCDANH]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHUCDANH](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenChucDanh] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOptionTitle]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayOptionTitle]
(
)
RETURNS TABLE RETURN 
	SELECT * 
	FROM 
		CHUCDANH
GO
/****** Object:  Table [dbo].[BANGLUONG]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGLUONG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_NhanVien] [int] NOT NULL,
	[LuongThang] [float] NULL,
	[TongPhuCap] [float] NULL,
	[TongKhauTruLuong] [float] NULL,
	[TongOT] [float] NULL,
	[ThucNhan] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_NhanVien] [int] NULL,
	[ThangNam] [date] NULL,
	[ID_LoaiNgayNghi] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHAUTRULUONG]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHAUTRULUONG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ThangNam] [date] NOT NULL,
	[ID_NhanVien] [int] NULL,
	[BHYT] [float] NULL,
	[BHXH] [float] NULL,
	[BHTN] [float] NULL,
	[ThueTNCN] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAI_GIO_CONG]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAI_GIO_CONG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoaiGioCong] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAIPHUCAP]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAIPHUCAP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoaiPhuCap] [nchar](20) NULL,
	[TenPhuCap] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN_LOAIPHUCAP]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_LOAIPHUCAP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_NhanVien] [int] NOT NULL,
	[ID_LOAIPHUCAP] [int] NOT NULL,
	[Thang] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN_OT]    Script Date: 11/27/2020 5:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_OT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NgayThangNam] [date] NOT NULL,
	[SoGioOT] [float] NOT NULL,
	[DuAnOT] [nvarchar](255) NULL,
	[ID_NhanVien] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CHUCDANH] ON 

INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (6, N'None')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (7, N'Dev')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (8, N'PM')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (9, N'Manager')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (10, N'Admin')
SET IDENTITY_INSERT [dbo].[CHUCDANH] OFF
GO
SET IDENTITY_INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ON 

INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (29, 3, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (30, 4, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (31, 6, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (32, 7, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (33, 8, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (34, 10, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (35, 11, CAST(N'2020-11-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (36, 1, CAST(N'2020-01-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (37, 2, CAST(N'2020-01-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (38, 5, CAST(N'2020-01-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (39, 9, CAST(N'2020-01-01' AS Date), 2)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (40, 1, CAST(N'2020-02-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (41, 33, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (42, 38, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (43, 42, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (44, 43, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (45, 54, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (46, 55, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (47, 56, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (48, 57, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (49, 57, CAST(N'2020-11-23' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (50, 9, CAST(N'2020-11-23' AS Date), 1)
SET IDENTITY_INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] OFF
GO
SET IDENTITY_INSERT [dbo].[LOAI_GIO_CONG] ON 

INSERT [dbo].[LOAI_GIO_CONG] ([ID], [LoaiGioCong]) VALUES (1, N'Work from home ')
INSERT [dbo].[LOAI_GIO_CONG] ([ID], [LoaiGioCong]) VALUES (2, N'Đi sớm về trễ ')
SET IDENTITY_INSERT [dbo].[LOAI_GIO_CONG] OFF
GO
SET IDENTITY_INSERT [dbo].[LOAINGAYNGHI] ON 

INSERT [dbo].[LOAINGAYNGHI] ([ID], [LoaiNgayNghi], [TenNgayNghi], [ThoiGian]) VALUES (1, N'Co Phep             ', N'Nghỉ Sinh Nhật', 1)
INSERT [dbo].[LOAINGAYNGHI] ([ID], [LoaiNgayNghi], [TenNgayNghi], [ThoiGian]) VALUES (2, N'Co Phep             ', N'Nghỉ Có Phép Theo Tháng', NULL)
INSERT [dbo].[LOAINGAYNGHI] ([ID], [LoaiNgayNghi], [TenNgayNghi], [ThoiGian]) VALUES (3, N'Khong Phep          ', N'Nghi Không Phép Theo Tháng', NULL)
INSERT [dbo].[LOAINGAYNGHI] ([ID], [LoaiNgayNghi], [TenNgayNghi], [ThoiGian]) VALUES (4, N'Co Phep             ', N'Nghỉ Quốc Khánh 2/9 ', 1)
INSERT [dbo].[LOAINGAYNGHI] ([ID], [LoaiNgayNghi], [TenNgayNghi], [ThoiGian]) VALUES (5, N'Co Phep             ', N'Nghỉ Tết Nguyên Đáng ', 8)
INSERT [dbo].[LOAINGAYNGHI] ([ID], [LoaiNgayNghi], [TenNgayNghi], [ThoiGian]) VALUES (6, N'Co Phep             ', N'Nghỉ 30/4 ', 1)
SET IDENTITY_INSERT [dbo].[LOAINGAYNGHI] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANSU] ON 

INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (1, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn1', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2015-08-10' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1963-10-26' AS Date), N'Nam', 10, CAST(N'2017-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (2, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường1', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', NULL, N'Độc thân ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2018-01-01' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0932795397          ', NULL, NULL, CAST(N'1900-01-01' AS Date), NULL, 12, CAST(N'2019-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (3, N'10179     ', N'trangntt 1', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (4, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn4', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-23' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), NULL, 1, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (5, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 3, 43, N'truongnn@allexceed.co.jp', CAST(N'2016-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 12, CAST(N'2018-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (6, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 1, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (7, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 3, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), NULL, 1, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (8, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (9, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-11-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 13, CAST(N'2020-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (10, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, NULL, N'toanlm@allexceed.co.jp', CAST(N'2020-11-13' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nam', 1, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (11, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 3, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, CAST(N'2022-01-01' AS Date))
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (12, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (13, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (14, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (15, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (16, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (17, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (18, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (19, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (20, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (21, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (22, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (23, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (24, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (25, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, NULL, N'toanlm@allexceed.co.jp', CAST(N'2020-11-13' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nam', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (26, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (27, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (28, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (29, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (30, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (31, N'00011     ', N'hieutc    ', N'Từ Công Hiếu', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025699517           ', N'Nam', N'4797932973363       ', N'Đại Học', N'                    ', N'Đã kết hôn', N'440                 ', N'TH1001              ', 12, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (32, N'00036     ', N'hbhbsdbisd', N'trtyrt', CAST(N'2020-10-12' AS Date), N'yrtyrty45', N'rtyrtyrt', N'3264848             ', N'Nam', N'68949804984         ', N'rtyrty', N'1198456             ', N'Chưa kết hôn ', N'549889              ', N'wwe548778           ', 18, N'02586786867         ', 7, 2, 43, N'eqweqwdfgdfd', CAST(N'2020-10-27' AS Date), N'efwewerwe', 10000000.0000, N'weqweoqwhei', N'3516897046          ', N'lknjki', N'fwif', CAST(N'1900-01-01' AS Date), N'Nam', 261, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (33, N'101157    ', N'tructn    ', N'Nguyễn Thanh Trúc', CAST(N'1998-11-04' AS Date), N'', N'', N'                    ', N'Nữ ', N'                    ', N'', N'                    ', N'Độc thân ', N'                    ', N'                    ', 0, N'                    ', 7, 3, 43, N'trcutn@allexceed.co.jp', CAST(N'2020-11-10' AS Date), N'', 8500000.0000, N'', N'                    ', N'', N'Cha - Con ', CAST(N'2020-11-04' AS Date), N'Nam', 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (38, N'100857    ', N'Trucnt    ', N'Nguyễn Thanh Trúc ', CAST(N'1999-11-04' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 2, 43, NULL, CAST(N'2020-11-04' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-04' AS Date), NULL, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (42, N'10175     ', N'a         ', N'Nguyễn Văn A', CAST(N'1999-11-10' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 7, 2, 43, N'a@allexceed.co.jp', CAST(N'2020-11-10' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-10' AS Date), NULL, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (43, N'1002654   ', N'hungmh    ', N'Mạch Huệ Hùng', CAST(N'1999-11-10' AS Date), NULL, NULL, NULL, N'Nam', NULL, NULL, NULL, N'Độc thân ', NULL, NULL, 0, NULL, 8, 2, 57, N'hungmd@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-10' AS Date), NULL, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (51, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (52, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (53, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 0, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (54, N'106659    ', N'c         ', N'Nguyễn Văn C', CAST(N'1999-11-11' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Độc thân ', NULL, NULL, 0, NULL, 7, 3, 57, N'c@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-11' AS Date), NULL, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (55, N'1002547   ', N'tynv      ', N'NGUYỄN VĂN TÝ ', CAST(N'1998-11-13' AS Date), NULL, NULL, NULL, N'Nam', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 7, 1, NULL, N'ty@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-13' AS Date), NULL, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (56, N'100245    ', N'tynv      ', N'NGUYỄN VĂN TÝ', CAST(N'1998-11-13' AS Date), NULL, NULL, NULL, N'Nam', NULL, NULL, NULL, N'Độc thân ', NULL, NULL, 0, NULL, 9, 4, 57, N'ty@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-13' AS Date), NULL, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep]) VALUES (57, N'000000    ', N'allexceed ', N'None', CAST(N'1900-11-13' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 6, 1, 43, NULL, CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-13' AS Date), NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[NHANSU] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN_GIOCONG] ON 

INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (4, CAST(N'2020-11-25T00:00:00.000' AS DateTime), 43, CAST(N'2020-11-24T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (5, CAST(N'2020-11-19T00:00:00.000' AS DateTime), 43, CAST(N'2020-11-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (6, CAST(N'2020-11-20T00:00:00.000' AS DateTime), 43, CAST(N'2020-11-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (7, CAST(N'2020-11-25T17:00:44.000' AS DateTime), 1, CAST(N'2020-11-25T09:00:44.000' AS DateTime), 2)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (8, CAST(N'2020-11-25T17:15:32.000' AS DateTime), 43, CAST(N'2020-11-25T09:00:32.000' AS DateTime), 2)
SET IDENTITY_INSERT [dbo].[NHANVIEN_GIOCONG] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ON 

INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (68, CAST(N'2020-11-09T00:00:00.000' AS DateTime), 1, 2, CAST(N'2020-12-05T00:00:00.000' AS DateTime), N'Nghỉ thai sản')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (69, CAST(N'2020-11-09T00:00:00.000' AS DateTime), 5, 1, CAST(N'2020-11-10T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (70, CAST(N'2020-11-09T00:00:00.000' AS DateTime), 2, 1, CAST(N'2020-11-10T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (71, CAST(N'2020-02-09T00:00:00.000' AS DateTime), 1, 1, CAST(N'2020-02-10T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (72, CAST(N'2020-11-09T00:00:00.000' AS DateTime), 3, 1, CAST(N'2020-11-10T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (73, CAST(N'2020-11-14T00:00:00.000' AS DateTime), 5, 1, CAST(N'2020-11-15T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (74, CAST(N'2020-11-14T00:00:00.000' AS DateTime), 3, 1, CAST(N'2020-11-15T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1062, CAST(N'2020-11-26T00:00:00.000' AS DateTime), 4, 1, CAST(N'2020-11-27T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1063, CAST(N'2020-11-20T00:00:00.000' AS DateTime), 16, 3, CAST(N'2020-11-21T00:00:00.000' AS DateTime), N'Nghi Không Phép Theo Tháng')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1064, CAST(N'2020-11-18T00:00:00.000' AS DateTime), 3, 1, CAST(N'2020-11-19T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1068, CAST(N'2020-11-02T00:00:00.000' AS DateTime), 1, 2, CAST(N'2020-11-03T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1084, CAST(N'2020-11-02T00:00:00.000' AS DateTime), 1, 2, CAST(N'2020-11-03T00:00:00.000' AS DateTime), N'Nghi Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1085, CAST(N'2020-11-23T00:00:00.000' AS DateTime), 1, 3, CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Nghi Không Phép Theo Tháng')
SET IDENTITY_INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] OFF
GO
SET IDENTITY_INSERT [dbo].[TRANGTHAILAMVIEC] ON 

INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (1, N'Nghỉ việc')
INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (2, N'Chính Thức')
INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (3, N'Trainning')
INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (4, N'Thực tập')
SET IDENTITY_INSERT [dbo].[TRANGTHAILAMVIEC] OFF
GO
ALTER TABLE [dbo].[BANGLUONG]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[KHAUTRULUONG]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[NHANSU]  WITH CHECK ADD FOREIGN KEY([ChucDanh])
REFERENCES [dbo].[CHUCDANH] ([ID])
GO
ALTER TABLE [dbo].[NHANSU]  WITH CHECK ADD FOREIGN KEY([TrangThaiLamViec])
REFERENCES [dbo].[TRANGTHAILAMVIEC] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_GIOCONG]  WITH CHECK ADD FOREIGN KEY([ID_GioCong])
REFERENCES [dbo].[LOAI_GIO_CONG] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_GIOCONG]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_LOAINGAYNGHI]  WITH CHECK ADD FOREIGN KEY([ID_LoaiNgayNghi])
REFERENCES [dbo].[LOAINGAYNGHI] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_LOAINGAYNGHI]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_LOAIPHUCAP]  WITH CHECK ADD FOREIGN KEY([ID_LOAIPHUCAP])
REFERENCES [dbo].[LOAIPHUCAP] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_LOAIPHUCAP]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_OT]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[spCreateOFFDayForStaff]    Script Date: 11/27/2020 5:37:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCreateOFFDayForStaff]
(
	@IDNhanVien int ,
	@IDLoaiNgayNghi int,
	@NgayBatDau datetime,
	@NgayKetThuc datetime,
	@LyDo nvarchar(255)
)
AS 
BEGIN 
	IF NOT EXISTS (SELECT 1 FROM NHANVIEN_LOAINGAYNGHI WHERE ID_NhanVien = @IDNhanVien AND ID_LoaiNgayNghi = @IDLoaiNgayNghi AND NgayBatDau = @NgayBatDau AND NgayKetThuc = @NgayKetThuc AND LyDo = @LyDo)
		BEGIN
			--Lay so ngay nghi --
			DECLARE @SoNgayNghiConLai int 
			SET @SoNgayNghiConLai = (SELECT SoNgayNghiPhep FROM NHANSU WHERE NHANSU.ID = @IDNhanVien)
			--Lay Thang Nam NS , Thang Nam NS + 1 va Thang Nam hien tai
			DECLARE @MonthOfBirth int
			SET @MonthOfBirth = MONTH((SELECT NgaySinh FROM NHANSU WHERE ID = @IDNhanVien))
			DECLARE @NextMonthOfBirth int
			SET @NextMonthOfBirth = MONTH(DATEADD(MONTH,1,(SELECT NgaySinh FROM NHANSU WHERE ID = @IDNhanVien)))
			DECLARE @MonthNow int
			SET @MonthNow = MONTH(GETDATE())
			--KT Ngay nghi co phep co phu hop hay khong
			IF( @IDLoaiNgayNghi = 2 AND @SoNgayNghiConLai > 0)
				BEGIN
					INSERT INTO NHANVIEN_LOAINGAYNGHI( ID_NhanVien, ID_LoaiNgayNghi, NgayBatDau, NgayKetThuc, LyDo)
					VALUES (@IDNhanVien, @IDLoaiNgayNghi, @NgayBatDau, @NgayKetThuc, @LyDo )
				--Update lai so ngay nghi
					UPDATE NHANSU SET SoNgayNghiPhep = SoNgayNghiPhep - 1 WHERE ID = @IDNhanVien
				END
			--KT Dang Ki ngay nghi Sinh Nhat co hop le hay khong 
			ELSE IF ( @IDLoaiNgayNghi = 1 AND (@MonthOfBirth = @MonthNow OR @NextMonthOfBirth = @MonthNow))
				BEGIN 
					INSERT INTO NHANVIEN_LOAINGAYNGHI(ID_NhanVien, ID_LoaiNgayNghi, NgayBatDau, NgayKetThuc, LyDo )
					VALUES (@IDNhanVien, @IDLoaiNgayNghi, @NgayBatDau, @NgayKetThuc, @LyDo )
				-- Update So Ngay Nghi co phep
					UPDATE NHANSU SET SoNgayNghiPhep = SoNgayNghiPhep - 1 WHERE ID = @IDNhanVien
				END 
			--Neu ngay nghi khong thuoc loai ngay nghi co phep thi tao bth thuong 
			ELSE IF(@IDLoaiNgayNghi != 2 AND @IDLoaiNgayNghi != 1 )
				BEGIN 
					INSERT INTO NHANVIEN_LOAINGAYNGHI(ID_NhanVien, ID_LoaiNgayNghi, NgayBatDau, NgayKetThuc, LyDo)
					VALUES (@IDNhanVien, @IDLoaiNgayNghi, @NgayBatDau, @NgayKetThuc, @LyDo )
				END 
			ELSE 
				BEGIN
					RETURN -1
				END 
		END
	ELSE 
		BEGIN 
			RETURN -1
		END 
END		
GO
/****** Object:  StoredProcedure [dbo].[spUpdateDayOfTakeLeaveForStaff]    Script Date: 11/27/2020 5:37:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROC [dbo].[spUpdateDayOfTakeLeaveForStaff]
AS 
BEGIN 
	--Cap Nhat So Ngay Nghi Co Phep cho tat ca NV 
	UPDATE NHANSU
	SET SoNgayNghiPhep = SoNgayNghiPhep + 1
	WHERE ID IN (SELECT 
						ID
					FROM 
						NHANSU 
					WHERE 
						(MONTH(NHANSU.NgaySinh) = MONTH(GETDATE()) OR MONTH(NHANSU.NgaySinh) + 1 = MONTH(GETDATE()))
						AND ID NOT IN	(SELECT 
											ID_NhanVien
										FROM 
											HISTORY_RESET_DAY_OF_TAKE_LEAVE 
										WHERE 
											HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_NhanVien IN ( SELECT 
																								ID 
																							FROM 
																								NHANSU 
																							WHERE 
																								MONTH(GETDATE()) = MONTH(NHANSU.NgaySinh)
																							)
							AND 
							(
								MONTH(GETDATE()) = MONTH(ThangNam)
							))
			)
	-- Ghi vao bang lich su la da cap nhat lai ngay nghi SN co phep 
	INSERT INTO HISTORY_RESET_DAY_OF_TAKE_LEAVE(ID_NhanVien, ThangNam, ID_LoaiNgayNghi)
	SELECT 
		ID, GETDATE() , 1
	FROM 
		NHANSU 
	WHERE 
		MONTH(NgaySinh) = MONTH(GETDATE())
		AND 
		ID NOT IN (	SELECT 
						ID_NhanVien
					FROM 
						HISTORY_RESET_DAY_OF_TAKE_LEAVE
					WHERE 
						HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_LoaiNgayNghi = 1
						AND 
						YEAR(HISTORY_RESET_DAY_OF_TAKE_LEAVE.ThangNam) = YEAR(GETDATE())
					)
	UPDATE NHANSU
	SET SoNgayNghiPhep = SoNgayNghiPhep - 1 
	WHERE ID IN (	SELECT 
						ID
					FROM 
						NHANSU 
					WHERE 
						(MONTH(NgaySinh) < MONTH(DATEADD(MONTH, -2, GETDATE())))
						AND ID IN (	SELECT 
										HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_NhanVien 
									FROM 
										HISTORY_RESET_DAY_OF_TAKE_LEAVE
									WHERE 
										HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_LoaiNgayNghi = 1 
										AND 
										YEAR(ThangNam) = YEAR(GETDATE())
									)
						AND ID NOT IN (	SELECT 
											ID_NhanVien 
										FROM 
											NHANVIEN_LOAINGAYNGHI 
										WHERE 
											ID_LoaiNgayNghi = 1		
											AND 
											YEAR(GETDATE()) = YEAR(NHANVIEN_LOAINGAYNGHI.NgayBatDau)
										)
				)
	-- Cap nhat so ngay phep danh cho NV lam viec < 12 thang 
	UPDATE NHANSU 
	SET SoNgayNghiPhep = SoNgayNghiPhep + 1
	WHERE ID  IN (	SELECT 
						ID 
					FROM 
						NHANSU 
					WHERE 
						GETDATE() < NHANSU.NgayResetNghiCoPhep
						AND ID NOT IN	(SELECT 
											ID_NhanVien
										FROM 
											HISTORY_RESET_DAY_OF_TAKE_LEAVE 
										WHERE 
											HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_NhanVien IN ( SELECT 
																								ID 
																							FROM 
																								NHANSU 
																							WHERE 
																								GETDATE() < NHANSU.NgayResetNghiCoPhep
																							)
							AND 
							(
								YEAR(GETDATE()) = YEAR(ThangNam) 
								AND 
								MONTH(GETDATE()) = MONTH(ThangNam)
							))
			)		
	INSERT INTO HISTORY_RESET_DAY_OF_TAKE_LEAVE (ID_NhanVien, ThangNam) 
		SELECT 
			ID , DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)
		FROM 
			NHANSU
		WHERE 
			GETDATE() < NHANSU.NgayResetNghiCoPhep
			AND ID NOT IN	(SELECT 
								ID_NhanVien
							FROM 
								HISTORY_RESET_DAY_OF_TAKE_LEAVE 
							WHERE 
								HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_NhanVien IN ( SELECT 
																					ID 
																				FROM 
																					NHANSU 
																				WHERE 
																					GETDATE() < NHANSU.NgayResetNghiCoPhep
																				)
							AND 
							(
								YEAR(GETDATE()) = YEAR(ThangNam) 
								AND 
								MONTH(GETDATE()) = MONTH(ThangNam)
							))
	-- Cap nhat so ngay nghi cho NV lam viec > 12 thang 
	UPDATE NHANSU
	SET SoNgayNghiPhep = SoNgayNghiPhep + 12
	WHERE ID IN (SELECT 
					ID 
				FROM 
					NHANSU 
				WHERE 
					GETDATE() >= NHANSU.NgayResetNghiCoPhep
					AND ID NOT IN	(SELECT 
							ID_NhanVien
						FROM 
							HISTORY_RESET_DAY_OF_TAKE_LEAVE 
						WHERE 
							HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_NhanVien IN ( SELECT 
																				ID 
																			FROM 
																				NHANSU 
																			WHERE 
																				GETDATE() >= NHANSU.NgayResetNghiCoPhep
																			)
							AND 
							(
								YEAR(GETDATE()) = YEAR(ThangNam) 
							)))
	INSERT INTO HISTORY_RESET_DAY_OF_TAKE_LEAVE (ID_NhanVien, ThangNam) 
		SELECT 
			ID , DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)
		FROM 
			NHANSU
		WHERE 
			GETDATE() >= NHANSU.NgayResetNghiCoPhep
			AND ID NOT IN	(SELECT 
								ID_NhanVien
							FROM 
								HISTORY_RESET_DAY_OF_TAKE_LEAVE 
							WHERE 
								HISTORY_RESET_DAY_OF_TAKE_LEAVE.ID_NhanVien IN ( SELECT 
																					ID 
																				FROM 
																					NHANSU 
																				WHERE 
																					GETDATE() >= NHANSU.NgayResetNghiCoPhep
																				)
							AND 
							(
								YEAR(GETDATE()) = YEAR(ThangNam) 
							))
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateOFFDayForStaff]    Script Date: 11/27/2020 5:37:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spUpdateOFFDayForStaff]
(
	@IDNhanVienNgayNghi int, 
	@IDNhanVien int, 
	@IDNgayNghi int, 
	@NgayBatDau datetime, 
	@NgayKetThuc datetime, 
	@LyDo nvarchar(255)
)
AS 
	BEGIN 
		UPDATE 
			NHANVIEN_LOAINGAYNGHI
		SET 
			ID_LoaiNgayNghi = @IDNgayNghi, 
			NgayBatDau = @NgayBatDau,
			NgayKetThuc = @NgayKetThuc, 
			LyDo = @LyDo
		WHERE 
			ID_NhanVien = @IDNhanVien
			AND 
			ID = @IDNhanVienNgayNghi
	END 
GO
/****** Object:  StoredProcedure [dbo].[TinhLuongCBTheoThang]    Script Date: 11/27/2020 5:37:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TinhLuongCBTheoThang]
(
	@UserID nchar(10),
	@Date date
)
AS
BEGIN 
	DECLARE @LuongCBThang money
	DECLARE @LuongNgay money
	SET @LuongNgay = (SELECT NHANSU.LuongCB FROM NHANSU WHERE NHANSU.UserID = @UserID) / 22
	DECLARE @NgayNghi int
	SET @NgayNghi = (SELECT SUM(ThoiGian) FROM NHANVIEN_LOAINGAYNGHI, LOAINGAYNGHI, NHANSU WHERE NHANVIEN_LOAINGAYNGHI.ID_LoaiNgayNghi = LOAINGAYNGHI.ID AND NHANSU.UserID = @UserID AND NHANVIEN_LOAINGAYNGHI.NgayThangNam > @Date)
	DECLARE @DiTreVeSom float 
	SET @DiTreVeSom = (SELECT SUM(ThoiGianDiTreVeSom) FROM NHAVIEN_GIOCONG, NHANSU WHERE NHANSU.UserID = @UserID AND NHANSU.ID = NHAVIEN_GIOCONG.ID_NhanVien AND NHAVIEN_GIOCONG.Ngay > @Date) /24
	DECLARE @Month int
	SET @Month = (SELECT DAY(EOMONTH(@Date)) AS DAY)
	if(@Month = 31) 
		SET @LuongCBThang = @LuongNgay * (23 - @NgayNghi - @DiTreVeSom )
	else 
		SET @LuongCBThang = @LuongNgay * (22 - @NgayNghi - @DiTreVeSom )
	PRINT @LuongCBThang
END
GO
USE [master]
GO
ALTER DATABASE [TinhTienLuong] SET  READ_WRITE 
GO
