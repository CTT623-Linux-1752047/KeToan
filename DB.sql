USE [master]
GO
/****** Object:  Database [TinhTienLuong]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnCalculteOFFDayTakeLeaveAStaffForMonth]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnCalculteOFFDayTakeLeaveAStaffForMonth]
(
	@ID_NhanVien int, 
	@ThangNam datetime
)
RETURNS INT AS
BEGIN 
	DECLARE @Result int;
	SET @Result =( 
					SELECT 
						COUNT(NHANVIEN_LOAINGAYNGHI.ID) 
					FROM 
						NHANSU,
						NHANVIEN_LOAINGAYNGHI 
					WHERE 
						ID_NhanVien = @ID_NhanVien
						AND 
						(NHANVIEN_LOAINGAYNGHI.NgayBatDau <= DATEADD (dd, -1, DATEADD(mm, DATEDIFF(mm, 0, @ThangNam) + 1, 0)) AND NgayKetThuc >= DATEADD(mm, DATEDIFF(mm, 0, @ThangNam), 0))
						AND(
								ID_LoaiNgayNghi = 1 OR
								ID_LoaiNgayNghi = 2 )
						AND			
						NHANSU.ID = NHANVIEN_LOAINGAYNGHI.ID_NhanVien
						AND 
						NHANSU.TrangThaiLamViec != 1)
	RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnCheckOffDayDuplicate]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnFullMonthsSeparation]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[NHANSU]    Script Date: 1/15/2021 5:18:45 PM ******/
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
	[Km] [float] NULL,
	[SoNguoiPhuThuoc] [int] NULL,
	[PayBack] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN_GIOCONG]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayWorkingDaysForStaff]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayWorkingDaysStaffOfMonth]    Script Date: 1/15/2021 5:18:45 PM ******/
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
		NHANSU.ID,
		WFH, 
		LEAVES
	FROM NHANSU
	LEFT JOIN
	(
		SELECT 
			NHANVIEN_GIOCONG.ID_NhanVien,
			COUNT	(CASE	WHEN ID_GioCong = 1 THEN 1
							ELSE NULL
					END) AS WFH,
			SUM	(CASE	WHEN ID_GioCong = 2 THEN 8 - (DATEDIFF(HOUR, NHANVIEN_GIOCONG.NgayGioBatDau, NHANVIEN_GIOCONG.NgayGioKetThuc) - 1)
					END) AS LEAVES
		FROM 
			NHANVIEN_GIOCONG 
		WHERE 
			(
			MONTH(NHANVIEN_GIOCONG.NgayGioBatDau) = MONTH(@ThangNam)
			AND 
			MONTH(NHANVIEN_GIOCONG.NgayGioKetThuc) = MONTH(@ThangNam)
			)
		GROUP BY NHANVIEN_GIOCONG.ID_NhanVien
	) WORKINGDAYS ON NHANSU.ID = WORKINGDAYS.ID_NhanVien
	WHERE 
	NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
	AND NHANSU.TrangThaiLamViec != 1
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayInfoStaffWorkingDayInMonth]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayInfoStaffWorkingDayInMonth]
(
	@ID_NhanVien int, 
	@ThangNam datetime
)
RETURNS TABLE RETURN 
	SELECT 
		ID,
		ID_NhanVien, 
		ID_GioCong,
		NgayGioBatDau, 
		NgayGioKetThuc
	FROM 
		NHANVIEN_GIOCONG
	WHERE 
		NHANVIEN_GIOCONG.ID_NhanVien = @ID_NhanVien
		AND 
		MONTH(NHANVIEN_GIOCONG.NgayGioBatDau) = MONTH(@ThangNam)
		AND 
		YEAR(NHANVIEN_GIOCONG.NgayGioBatDau) = YEAR(@ThangNam)
		AND 
		MONTH(NHANVIEN_GIOCONG.NgayGioKetThuc) = MONTH(@ThangNam)
		AND 
		YEAR(NHANVIEN_GIOCONG.NgayGioKetThuc) = YEAR(@ThangNam)
GO
/****** Object:  Table [dbo].[TYPE_RANGE_HOURS_OT]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TYPE_RANGE_HOURS_OT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RangeHours] [nchar](255) NULL,
	[PercentAmountOT] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN_OT]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_OT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateDangKy] [date] NOT NULL,
	[SoGioOT] [float] NOT NULL,
	[ID_Project] [int] NULL,
	[ID_NhanVien] [int] NULL,
	[ID_Range_Hours_OT] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOT_AmountOTStaffOfMonth]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnDisplayOT_AmountOTStaffOfMonth]
(
	@HoVaTen nvarchar(255),
	@Date date
)
RETURNS TABLE RETURN
	SELECT	NHANSU.ID,
			NHANSU.HoVaTen, 
			OTStaff.C1 AS '17h - 21h', 
			OTStaff.C2 AS '21h - 5h', 
			OTStaff.C3 AS 'Saturday & Sunday', 
			OTStaff.C1 + OTStaff.C2 + OTStaff.C3 AS 'Total hours',
			OTStaff.AmountC1 AS 'Amount 17h - 21h', 
			OTStaff.AmountC2 AS 'Amount 21h - 5h',
			OTStaff.AmountC3 AS 'Amount Saturday & Sunday',
			OTStaff.AmountC1 + OTStaff.AmountC2 + OTStaff.AmountC3 AS 'TotalWithoutTax',
			(NHANSU.LuongCB * (OTStaff.C1 + OTStaff.C2 + OTStaff.C3)) * 1.0 / 176 AS 'Tax',
			(OTStaff.AmountC1 + OTStaff.AmountC2 + OTStaff.AmountC3) - ((NHANSU.LuongCB * (OTStaff.C1 + OTStaff.C2 + OTStaff.C3)) * 1.0 / 176) AS 'TotalAmountWithTax'
	FROM
		NHANSU LEFT JOIN (
							SELECT	NHANVIEN_OT.ID_NhanVien, 
									SUM(CASE	WHEN ID_Range_Hours_OT = 1 THEN
													(SoGioOT) 
												ELSE 0
									END) AS C1,
									SUM(CASE	WHEN ID_Range_Hours_OT = 3 THEN
													(SoGioOT) 
												ELSE 0
									END) AS C2,
									SUM(CASE	WHEN ID_Range_Hours_OT = 4 THEN
													(SoGioOT) 
												ELSE 0
									END) AS C3,
									SUM(CASE	WHEN ID_Range_Hours_OT = 1 THEN
													((NHANSU.LuongCB / 176 )* SoGioOT * PercentAmountOT)
												ELSE 0
									END) AS AmountC1,
									SUM(CASE	WHEN ID_Range_Hours_OT = 3 THEN
													((NHANSU.LuongCB / 176 ) * SoGioOT * PercentAmountOT)
												ELSE 0
									END) AS AmountC2,
									SUM(CASE	WHEN ID_Range_Hours_OT = 4 THEN
													((NHANSU.LuongCB / 176 ) * SoGioOT * PercentAmountOT)
												ELSE 0
									END) AS AmountC3
							FROM
								NHANVIEN_OT 
									LEFT JOIN TYPE_RANGE_HOURS_OT ON NHANVIEN_OT.ID_Range_Hours_OT = TYPE_RANGE_HOURS_OT.ID
									LEFT JOIN NHANSU ON NHANSU.ID = NHANVIEN_OT.ID_NhanVien
							WHERE 
								MONTH(DateDangKy) = MONTH(@Date)
								AND 
								YEAR(DateDangKy) = YEAR(@Date)
							GROUP BY NHANVIEN_OT.ID_NhanVien
					) AS OTStaff ON OTStaff.ID_NhanVien = NHANSU.ID
	WHERE NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
	AND
	NHANSU.TrangThaiLamViec != 1
GO
/****** Object:  Table [dbo].[PHUCAP]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHUCAP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PC_CoDinh] [money] NULL,
	[CongThuc] [nchar](255) NULL,
	[TenPhuCap] [nvarchar](255) NULL,
	[MoTa] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHANVIEN_PHUCAP]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_PHUCAP](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_NhanVien] [int] NOT NULL,
	[ID_PhuCap] [int] NOT NULL,
	[ThangNam] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAmountBenefit]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetAmountBenefit]
(
	@HoVaTen nvarchar(255), 
	@Startdate date, 
	@LoaiPhuCap int ,
	@Enddate date
)
RETURNS TABLE RETURN 
	SELECT 
		tmpPhuCap.PC_CoDinh
	FROM NHANSU
	LEFT JOIN (	SELECT 
					NHANVIEN_PHUCAP.ID_NhanVien, 
					NHANVIEN_PHUCAP.ThangNam, 
					PHUCAP.PC_CoDinh, 
					PHUCAP.TenPhuCap
				FROM NHANVIEN_PHUCAP
				LEFT JOIN PHUCAP ON NHANVIEN_PHUCAP.ID_PhuCap = PHUCAP.ID
				WHERE 
				NHANVIEN_PHUCAP.ID_PhuCap = @LoaiPhuCap
				AND 
				NHANVIEN_PHUCAP.ThangNam >= @Startdate
				AND 
				NHANVIEN_PHUCAP.ThangNam <= @Enddate
				) AS tmpPhuCap ON tmpPhuCap.ID_NhanVien = NHANSU.ID
	WHERE NHANSU.TrangThaiLamViec != 1 AND NHANSU.HoVaTen LIKE N'%' + @HoVaTen + '%'
GO
/****** Object:  Table [dbo].[LOAINGAYNGHI]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[NHANVIEN_LOAINGAYNGHI]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOFFDayFollowCondition]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayTitleOFFDay]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[TRANGTHAILAMVIEC]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOptionStateWorking]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayStaffFollowName]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayStaffFollowID]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[CHUCDANH]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOptionTitle]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[BANGLUONG]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGLUONG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_NhanVien] [int] NOT NULL,
	[LuongThang] [datetime] NULL,
	[TongOT] [float] NULL,
	[TongKhauTru] [money] NULL,
	[PIT] [money] NULL,
	[ThucNhan] [money] NULL,
	[TongTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BAOHIEM_THUE]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAOHIEM_THUE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoaiBaoHiem] [nvarchar](255) NULL,
	[PhanTramBaoHiem] [float] NULL,
	[MoTa] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FORMULA_OF_PAYROLL]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMULA_OF_PAYROLL](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type_Of_Salary] [nchar](1) NULL,
	[Code] [nchar](255) NULL,
	[FullName] [nchar](255) NULL,
	[Formula] [nvarchar](max) NULL,
	[Delete_Date] [date] NULL,
	[Insert_Date] [date] NULL,
	[Update_Date] [date] NULL,
 CONSTRAINT [PK_FORMULA_OF_PAYROLL] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[KHAUTRULUONG]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[LOAI_GIO_CONG]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  Table [dbo].[NHANVIEN_BAOHIEM_THUE]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN_BAOHIEM_THUE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ID_NhanVien] [int] NULL,
	[ID_BaoHiem_Thue] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BAOHIEM_THUE] ON 

INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (1, N'Healthy_Insurance_Staff', 0.015, N'Bảo hiểm sức khỏe cá nhân')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (2, N'Social_Insurance_Staff', 0.08, N'Bảo hiểm xã hội cá nhân ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (3, N'Unemployted_Insurance_Staff', 0.01, N'Bảo hiểm thất nghiệp cá nhân ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (4, N'Healthy_Insurance_Enterprise', 0.03, N'Bảo hiểm sức khỏe công ty ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (5, N'Social_Insurance_Enterprise', 0.175, N'Bảo hiểm xã hội công ty ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (6, N'Unemployted_Insurance_Enterprise', 0.01, N'Bảo hiểm thất nghiệp công ty ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (7, N'Times', 20, N'Số lần ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (8, N'Min_Salary', 1490000, N'Mức lương tối thiểu ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (9, N'Min _Salary_Of_Region', 4420000, N'Mức lương tối thiểu theo từng vùng ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (10, N'Personal_Deduction', 11000000, N'Thuế khấu trừ cá nhân ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (11, N'Dependent_Person_Deduction', 4400000, N'Thuế khấu trừ người phụ thuộc ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (12, N'Percent_PIT_Level_1', 0.05, N'Thuế suất bậc 1')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (13, N'Percent_PIT_Level_2', 0.1, N'Thuế suất bậc 2')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (14, N'Percent_PIT_Level_3', 0.15, N'Thuế suất bậc 3')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (15, N'Percent_PIT_Level_4', 0.2, N'Thuế suất bậc 4')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (16, N'Percent_PIT_Level_5', 0.25, N'Thuế xuất bậc 5')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (17, N'Percent_PIT_Level_6', 0.3, N'Thuế suất bậc 6')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (18, N'Percent_PIT_Level_7', 0.35, N'Thuế suất bậc 7')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (20, N'Amount_PIT_Level_3', 750000, N'Thu nhập tính thuế bậc 3')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (21, N'Amount_PIT_Level_4', 1650000, N'Thu nhập tính thuế bậc 4')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (22, N'Amount_PIT_Level_5', 3250000, N'Thu nhập tính thuế bậc 5')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (23, N'Amount_PIT_Level_6', 5850000, N'Thu nhập tính thuế bậc 6')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (24, N'Amount_PIT_Level_7', 9850000, N'Thu nhập tính thuế bậc 7')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (26, N'Amount_PIT_Level_1', 0, N'Thu nhập tính thuế bậc 1')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (27, N'Amount_PIT_Level_2', 250000, N'Thu nhập tính thuế bậc 2 ')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (28, N'Range_Salary_PIT_Mark_1', 5000000, N'Mốc thu nhập 1')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (29, N'Range_Salary_PIT_Mark_2', 10000000, N'Mốc thu nhập 2')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (30, N'Range_Salary_PIT_Mark_3', 18000000, N'Mốc thu nhập 3')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (31, N'Range_Salary_PIT_Mark_4', 32000000, N'Mốc thu nhập 4')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (32, N'Range_Salary_PIT_Mark_5', 52000000, N'Mốc thu nhập 5')
INSERT [dbo].[BAOHIEM_THUE] ([ID], [LoaiBaoHiem], [PhanTramBaoHiem], [MoTa]) VALUES (33, N'Range_Salary_PIT_Mark_6', 80000000, N'Mốc thu nhập 6')
SET IDENTITY_INSERT [dbo].[BAOHIEM_THUE] OFF
GO
SET IDENTITY_INSERT [dbo].[CHUCDANH] ON 

INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (6, N'None')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (7, N'Dev')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (8, N'PM')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (9, N'Manager')
INSERT [dbo].[CHUCDANH] ([ID], [TenChucDanh]) VALUES (10, N'Admin')
SET IDENTITY_INSERT [dbo].[CHUCDANH] OFF
GO
SET IDENTITY_INSERT [dbo].[FORMULA_OF_PAYROLL] ON 

INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (1, N'D', N'BenefitWFH                                                                                                                                                                                                                                                     ', N'Work from home                                                                                                                                                                                                                                                 ', N'PC_2 * OTH_33                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (2, N'D', N'GasParking                                                                                                                                                                                                                                                     ', N'Benefit gasoline, parking                                                                                                                                                                                                                                      ', N'( PC_1 * 2 * OTH_37 + PC_8 ) * OTH_32                                                                                                                                                                                                              ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (3, N'D', N'ReponsiJapanese                                                                                                                                                                                                                                                ', N'Responsi and japanese                                                                                                                                                                                                                                          ', N'PC_3 + PC_4 + PC_5 + PC_6 + PC_7 + PC_9 + PC_10 + PC_11 + PC_12 + PC_13                                                                                                                                                                                        ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (4, N'D', N'Payback                                                                                                                                                                                                                                                        ', N'Pay Back                                                                                                                                                                                                                                                       ', N'NV_PayBack                                                                                                                                                                                                                                                     ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (5, N'A', N'SalaryDeduction                                                                                                                                                                                                                                                ', N'Salary Deduction                                                                                                                                                                                                                                               ', N'( OTH_34 + OTH_3 ) / 176 * OTH_36                                                                                                                                                                                                             ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (6, N'A', N'TotalAmount                                                                                                                                                                                                                                                    ', N'Total Amount                                                                                                                                                                                                                                                   ', N'( OTH_34 + OTH_3 ) * OTH_35 / 22 - OTH_5 + OTH_4 + OTH_2                                                                                                                                                                                              ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (7, N'A', N'TotalAmountInVND                                                                                                                                                                                                                                               ', N'Total Amount In VND                                                                                                                                                                                                                                            ', N'(OTH_6 + OTH_1)                                                                                                                                                                                                                                                ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (8, N'A', N'AmountOTNightWeekdays                                                                                                                                                                                                                                          ', N'Amount OT 17-21h Weekdays                                                                                                                                                                                                                                      ', N'( OTH_34 / 176 ) * OT_1 * NV_1                                                                                                                                                                                                                             ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (9, N'A', N'AmountOTMidnightWeekdays                                                                                                                                                                                                                                       ', N'Amount OT 21-5h Weekdays                                                                                                                                                                                                                                       ', N'( OTH_34 / 176 ) * OT_3 * NV_3                                                                                                                                                                                                                             ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (10, N'A', N'AmountOTWeekendNoMidNight                                                                                                                                                                                                                                      ', N'Amount Saturday and Sunday without 21-5h                                                                                                                                                                                                                       ', N'( OTH_34 / 176 ) * OT_4 * NV_4                                                                                                                                                                                                                             ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (11, N'A', N'AmountOTWeekendMidNight                                                                                                                                                                                                                                        ', N'Amount Saturday and Sunday 21-5h                                                                                                                                                                                                                               ', N'( OTH_34 / 176 ) * OT_5 * NV_5                                                                                                                                                                                                                             ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (12, N'A', N'AmountOTHolidays                                                                                                                                                                                                                                               ', N'Amount OT Holidays                                                                                                                                                                                                                                             ', N'( TOH_34 / 176 ) * OT_6 * NV_6                                                                                                                                                                                                                             ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (13, N'A', N'AmountOT                                                                                                                                                                                                                                                       ', N'Salary OT                                                                                                                                                                                                                                                      ', N'OTH_8 + OTH_9 + OTH_10 + OTH_11 + OTH_12                                                                                                                                                                                                                       ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (14, N' ', N'TotalHoursOT                                                                                                                                                                                                                                                   ', N'Total Hours OT                                                                                                                                                                                                                                                 ', N'NV_1 + NV_3 + NV_4 + NV_5 + NV_6                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (15, N'B', N'TaxableOT                                                                                                                                                                                                                                                      ', N'Taxable OT                                                                                                                                                                                                                                                     ', N'OTH_34 * 0 / 176                                                                                                                                                                                                                                      ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (16, N'A', N'OTDedcution                                                                                                                                                                                                                                                    ', N'OT Deduction                                                                                                                                                                                                                                                   ', N'OTH_13 - OTH_15                                                                                                                                                                                                                                                ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (17, N'C', N'SalaryForInsurance                                                                                                                                                                                                                                             ', N'SalaryForInsurance                                                                                                                                                                                                                                             ', N'IF( OTH_7 < ( BH_TH_7 * BH_TH_8 ) , OTH_7 , BH_TH_7 * BH_TH_8 )                                                                                                                                                                                                ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (18, N'C', N'SalaryForUnemploytedInsurance                                                                                                                                                                                                                                  ', N'Salary For Unemployted Indusrance                                                                                                                                                                                                                              ', N'IF( OTH_7 < ( BH_TH_7 * BH_TH_9 ) , OTH_7 , BH_TH_7 * BH_TH_9 )                                                                                                                                                                                                ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (19, N'C', N'HealthInsuranceEmployee                                                                                                                                                                                                                                        ', N'Healthy insurance employee                                                                                                                                                                                                                                     ', N'OTH_17 * BH_TH_1                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (20, N'C', N'SocialInsuranceEmployee                                                                                                                                                                                                                                        ', N'Social Insurance Employee                                                                                                                                                                                                                                      ', N'OTH_17 * BH_TH_2                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (21, N'C', N'UnemployedInsurance                                                                                                                                                                                                                                            ', N'Unemployed Insurance employee                                                                                                                                                                                                                                  ', N'OTH_18 * BH_TH_3                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (22, N'C', N'HealthInsuranceEnterprise                                                                                                                                                                                                                                      ', N'Health Insurance Enterprise                                                                                                                                                                                                                                    ', N'OTH_17 * BH_TH_4                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (23, N'C', N'SocialInsuranceEnterprise                                                                                                                                                                                                                                      ', N'Social Insurance Enterprise                                                                                                                                                                                                                                    ', N'OTH_17 * BH_TH_5                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (24, N'C', N'UnemployedInsuranceEnterprise                                                                                                                                                                                                                                  ', N'Unemployed Insurance Enterprise                                                                                                                                                                                                                                ', N'OTH_18 * BH_TH_6                                                                                                                                                                                                                                               ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (25, N'C', N'TotalInsuranceEmployee                                                                                                                                                                                                                                         ', N'Total Insurance Employee                                                                                                                                                                                                                                       ', N'OTH_19 + OTH_20 + OTH_21                                                                                                                                                                                                                                       ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (26, N'C', N'TotalInsuranceEnterprise                                                                                                                                                                                                                                       ', N'Total Insurance Enterprise                                                                                                                                                                                                                                     ', N'OTH_22 + OTH_23 + OTH_24                                                                                                                                                                                                                                       ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (27, N'C', N'PersonalDeduction                                                                                                                                                                                                                                              ', N'Personal Deduction                                                                                                                                                                                                                                             ', N'BH_TH_10                                                                                                                                                                                                                                                       ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (28, N'C', N'PayerFamilyConditionsDeduction                                                                                                                                                                                                                                 ', N'Payer''s family conditions deduction                                                                                                                                                                                                                            ', N'OTH_38 * BH_TH_11                                                                                                                                                                                                                                    ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (29, N'C', N'TaxableIncome                                                                                                                                                                                                                                                  ', N'Taxable Income                                                                                                                                                                                                                                                 ', N'IF ( OTH_7 - OTH_4 - OTH_25 - OTH_27 - OTH_28 - OTH_16 > 0 , OTH_7 - OTH_4 - OTH_25 - OTH_27 - OTH_28 - OTH_16 , 0 )                                                                                                                                 ', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (30, N'C', N'PITPayable                                                                                                                                                                                                                                                     ', N'PIT Payable                                                                                                                                                                                                                                                    ', N'IF ( OTH_29 > BH_TH_33 , ( OTH_29 * BH_TH_18 - BH_TH_24 ) , IF ( OTH_29 > BH_TH_32 , ( OTH_29 * BH_TH_17 - BH_TH_23 ) , IF ( OTH_29 > BH_TH_31 , ( OTH_29 * BH_TH_16 - BH_TH_22 ) , IF ( OTH_29 > BH_TH_30 , ( OTH_29 * BH_TH_15 - BH_TH_21 ) , IF ( OTH_29 > BH_TH_29 , ( OTH_29 * BH_TH_14 - BH_TH_20 ) , IF ( OTH_29 > BH_TH_28 , ( OTH_29 * BH_TH_13 - BH_TH_27 ) , ( OTH_29 * BH_TH_12 ) ) ) ) ) ) )', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (31, N'A', N'Payement                                                                                                                                                                                                                                                       ', N'Payement                                                                                                                                                                                                                                                       ', N'OTH_7 - OTH_30  - OTH_25', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (32, NULL, N'AtWorks                                                                                                                                                                                                                                                        ', N'At works                                                                                                                                                                                                                                                       ', N'AtWorks', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (33, NULL, N'WFHDays                                                                                                                                                                                                                                                        ', N'Days WFH                                                                                                                                                                                                                                                       ', N'WFHDays', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (34, N'A', N'SalaryBasic                                                                                                                                                                                                                                                    ', N'Salary Basic                                                                                                                                                                                                                                                   ', N'NV_LuongCB', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (35, NULL, N'WorkingDays                                                                                                                                                                                                                                                    ', N'Working Days                                                                                                                                                                                                                                                   ', N'WorkingDays', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (36, NULL, N'LeaveHours                                                                                                                                                                                                                                                     ', N'Leave Hours                                                                                                                                                                                                                                                    ', N'LeaveHours', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (37, NULL, N'Km                                                                                                                                                                                                                                                             ', N'Km                                                                                                                                                                                                                                                             ', N'NV_Km', NULL, NULL, NULL)
INSERT [dbo].[FORMULA_OF_PAYROLL] ([ID], [Type_Of_Salary], [Code], [FullName], [Formula], [Delete_Date], [Insert_Date], [Update_Date]) VALUES (38, NULL, N'DependantPersonal                                                                                                                                                                                                                                              ', N'Number Dependant personal                                                                                                                                                                                                                                      ', N'NV_NguoiPhuThuoc', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[FORMULA_OF_PAYROLL] OFF
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
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (51, 3, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (52, 6, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (53, 12, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (54, 15, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (55, 18, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (56, 21, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (57, 24, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (58, 27, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (59, 30, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (60, 51, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (61, 52, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (62, 53, CAST(N'2020-12-01' AS Date), 1)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (63, 4, CAST(N'2020-12-01' AS Date), NULL)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (64, 7, CAST(N'2020-12-01' AS Date), NULL)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (65, 8, CAST(N'2020-12-01' AS Date), NULL)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (66, 10, CAST(N'2020-12-01' AS Date), NULL)
INSERT [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE] ([ID], [ID_NhanVien], [ThangNam], [ID_LoaiNgayNghi]) VALUES (67, 11, CAST(N'2020-12-01' AS Date), NULL)
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

INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (1, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn1', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2015-08-10' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1963-10-26' AS Date), N'Nam', 10, CAST(N'2017-01-01' AS Date), 5, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (2, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường1', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', NULL, N'Độc thân ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-12-10' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 30000000.0000, NULL, N'0932795397          ', NULL, NULL, CAST(N'1900-01-01' AS Date), NULL, 12, CAST(N'2019-01-01' AS Date), 6, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (3, N'10179     ', N'trangntt 1', N'Nguyễn Thị Thùy Trang1', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, CAST(N'2022-01-01' AS Date), 7, 4, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (4, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn2', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-23' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), NULL, 2, CAST(N'2022-01-01' AS Date), 8, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (5, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường2', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 3, 43, N'truongnn@allexceed.co.jp', CAST(N'2016-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 12, CAST(N'2018-01-01' AS Date), 20, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (6, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Tran2', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 2, CAST(N'2022-01-01' AS Date), 30, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (7, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn3', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 3, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), NULL, 2, CAST(N'2022-01-01' AS Date), 10, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (8, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường3', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 2, CAST(N'2022-01-01' AS Date), 9, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (9, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang3', CAST(N'1999-11-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 414, CAST(N'2020-01-01' AS Date), 18, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (10, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn4', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, NULL, N'toanlm@allexceed.co.jp', CAST(N'2020-11-13' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nam', 2, CAST(N'2022-01-01' AS Date), 6, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (11, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường4', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 3, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 2, CAST(N'2022-01-01' AS Date), 7, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (12, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang4', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 9, 3, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (13, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn5', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL, 4, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (14, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường5', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 6, 3, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (15, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang5', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 1, 4, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (16, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn6', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL, 3, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (17, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường6', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 4, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (18, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang6', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 7, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (19, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn7', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL, 8, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (20, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường7', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 5, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (21, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang7', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 9, 3, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (22, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn8', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', N'                    ', N'Độc thân', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-11-02' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0902500191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ', 0, NULL, 1, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (23, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường8', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 4, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (24, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang9', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 3, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (25, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn9', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, NULL, N'toanlm@allexceed.co.jp', CAST(N'2020-11-13' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'0902500191', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nam', 0, NULL, 7, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (26, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường9', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 4, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (27, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang9', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 6, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (28, N'00001     ', N'toanlm    ', N'Lư Mạnh Toàn10', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'025699517           ', N'Nam', N'1017317271          ', N'Đại Học', NULL, N'Độc thân ', N'000005              ', N'TH0001              ', 18, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-12-16' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'Lư Chí Minh ', N'0961502191          ', N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM', N'Cha - Con ', CAST(N'1900-01-01' AS Date), N'Nữ ', 0, NULL, 5, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (29, N'10175     ', N'truongnn  ', N'Nguyễn Nhật Trường10', CAST(N'1998-05-25' AS Date), N'258 Hòa Hảo p5 q10 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025542513           ', N'Nam', N'4797932087363       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'445                 ', N'TH1002              ', 24, N'0932795397          ', 7, 2, 43, N'truongnn@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 4, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (30, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang10', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ', N'4797932896457       ', N'Đại Học', N'                    ', N'Chưa kết hôn ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 2, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 1, NULL, 2, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (31, N'00011     ', N'hieutc    ', N'Từ Công Hiếu', CAST(N'1998-02-23' AS Date), N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'49/2/4 Khánh Hôi p3 q4 tp.HCM', N'025699517           ', N'Nam', N'4797932973363       ', N'Đại Học', N'                    ', N'Đã kết hôn', N'440                 ', N'TH1001              ', 12, N'0961502191          ', 7, 2, 43, N'toanlm@allexceed.co.jp', CAST(N'2020-10-27' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, N'', N'                    ', N'', N'', CAST(N'1900-01-01' AS Date), N'', 0, NULL, 8, 4, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (32, N'00036     ', N'hbhbsdbisd', N'trtyrt', CAST(N'2020-10-12' AS Date), N'yrtyrty45', N'rtyrtyrt', N'3264848             ', N'Nam', N'68949804984         ', N'rtyrty', N'1198456             ', N'Chưa kết hôn ', N'549889              ', N'wwe548778           ', 18, N'02586786867         ', 7, 2, 43, N'eqweqwdfgdfd', CAST(N'2020-10-27' AS Date), N'efwewerwe', 10000000.0000, N'weqweoqwhei', N'3516897046          ', N'lknjki', N'fwif', CAST(N'1900-01-01' AS Date), N'Nam', 322, NULL, 15, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (33, N'101157    ', N'tructn    ', N'Nguyễn Thanh Trúc', CAST(N'1998-11-04' AS Date), N'', N'', N'                    ', N'Nữ ', N'                    ', N'', N'                    ', N'Độc thân ', N'                    ', N'                    ', 0, N'                    ', 7, 3, 43, N'trcutn@allexceed.co.jp', CAST(N'2020-11-10' AS Date), N'', 8500000.0000, N'', N'                    ', N'', N'Cha - Con ', CAST(N'2020-11-04' AS Date), N'Nam', 402, NULL, 20, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (38, N'100857    ', N'Trucnt    ', N'Nguyễn Thanh Trúc1', CAST(N'1999-11-04' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 2, 43, NULL, CAST(N'2020-11-04' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-04' AS Date), NULL, 402, NULL, 26, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (42, N'10175     ', N'a         ', N'Nguyễn Văn A', CAST(N'1999-11-10' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 7, 2, 43, N'a@allexceed.co.jp', CAST(N'2020-11-10' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-10' AS Date), NULL, 402, NULL, 18, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (43, N'1002654   ', N'hungmh    ', N'Mạch Huệ Hùng', CAST(N'1999-11-10' AS Date), NULL, NULL, NULL, N'Nam', NULL, NULL, NULL, N'Độc thân ', NULL, NULL, 0, NULL, 8, 2, 57, N'hungmd@allexceed.co.jp', CAST(N'2020-12-21' AS Date), NULL, 30000000.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-10' AS Date), NULL, 402, NULL, 16, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (51, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang11', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 1, NULL, 17, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (52, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang12', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 1, NULL, 23, 2, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (53, N'10179     ', N'trangntt  ', N'Nguyễn Thị Thùy Trang13', CAST(N'1999-12-28' AS Date), N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'47-48 Lê Thị Riêng p.Phạm Ngũ Lão q1 tp.HCM', N'027896517           ', N'Nữ ', N'4797932896457       ', N'Đại Học', NULL, N'Độc thân ', N'450                 ', N'TH1003              ', 12, N'0902502191          ', 7, 4, 43, N'trangntt@allexceed.co.jp', CAST(N'2020-11-11' AS Date), N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM', 8500000.0000, NULL, N'0902502191          ', NULL, NULL, CAST(N'9998-12-31' AS Date), NULL, 1, NULL, 21, 3, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (54, N'106659    ', N'c         ', N'Nguyễn Văn C', CAST(N'1999-11-11' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Độc thân ', NULL, NULL, 0, NULL, 7, 3, 57, N'c@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-11' AS Date), NULL, 402, NULL, 20, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (55, N'1002547   ', N'tynv      ', N'NGUYỄN VĂN TÝ ', CAST(N'1998-11-13' AS Date), NULL, NULL, NULL, N'Nam', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 7, 1, NULL, N'ty@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-13' AS Date), NULL, 402, NULL, 26, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (56, N'100245    ', N'tynv      ', N'Nguyễn Văn Tý1', CAST(N'1998-11-13' AS Date), NULL, NULL, NULL, N'Nam', NULL, NULL, NULL, N'Độc thân ', NULL, NULL, 0, NULL, 9, 4, 57, N'ty@allexceed.co.jp', CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-13' AS Date), NULL, 402, NULL, 13, 1, NULL)
INSERT [dbo].[NHANSU] ([ID], [UserID], [UserName], [HoVaTen], [NgaySinh], [DiaChiThuongTru], [DiaChiTamTru], [CMND], [GioiTinh], [SoTKNganHang], [TrinhDo], [MaSoThue], [TinhTrangHonNhan], [SoHDLD], [LoaiHDLD], [ThoiHanHDLD], [SoDT], [ChucDanh], [TrangThaiLamViec], [NguoiPhuTrach], [EmailCongTy], [NgayBatDau], [NoiLamViec], [LuongCB], [HoTenNguoiLienQuan], [SDTNguoiLienQuan], [DiaChiNguoiLienQuan], [MoiQuanHe], [NgaySinhNguoiLienQuan], [GioiTinhNguoiLienQuan], [SoNgayNghiPhep], [NgayResetNghiCoPhep], [Km], [SoNguoiPhuThuoc], [PayBack]) VALUES (57, N'000000    ', N'allexceed ', N'None', CAST(N'1900-11-13' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 6, 1, 43, NULL, CAST(N'2020-11-13' AS Date), NULL, 0.0000, NULL, NULL, NULL, NULL, CAST(N'2020-11-13' AS Date), NULL, 402, NULL, 16, 4, NULL)
SET IDENTITY_INSERT [dbo].[NHANSU] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ON 

INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (1, 1, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (2, 1, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (3, 1, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (4, 1, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (5, 1, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (6, 1, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (7, 1, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (8, 1, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (9, 1, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (10, 1, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (11, 1, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (12, 2, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (13, 2, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (14, 2, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (15, 2, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (16, 2, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (17, 2, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (18, 2, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (19, 2, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (20, 2, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (21, 2, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (22, 2, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (23, 3, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (24, 3, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (25, 3, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (26, 3, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (27, 3, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (28, 3, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (29, 3, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (30, 3, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (31, 3, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (32, 3, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (33, 3, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (34, 4, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (35, 4, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (36, 4, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (37, 4, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (38, 4, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (39, 4, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (40, 4, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (41, 4, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (42, 4, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (43, 4, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (44, 4, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (45, 5, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (46, 5, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (47, 5, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (48, 5, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (49, 5, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (50, 5, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (51, 5, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (52, 5, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (53, 5, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (54, 5, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (55, 5, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (56, 6, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (57, 6, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (58, 6, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (59, 6, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (60, 6, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (61, 6, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (62, 6, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (63, 6, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (64, 6, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (65, 6, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (66, 6, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (67, 7, 1)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (68, 7, 2)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (69, 7, 3)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (70, 7, 4)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (71, 7, 5)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (72, 7, 6)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (73, 7, 7)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (74, 7, 8)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (75, 7, 9)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (76, 7, 10)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (77, 7, 11)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (78, 1, 17)
INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] ([ID], [ID_NhanVien], [ID_BaoHiem_Thue]) VALUES (79, 1, 18)
SET IDENTITY_INSERT [dbo].[NHANVIEN_BAOHIEM_THUE] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN_GIOCONG] ON 

INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (4, CAST(N'2020-11-25T00:00:00.000' AS DateTime), 43, CAST(N'2020-11-24T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (5, CAST(N'2020-11-19T00:00:00.000' AS DateTime), 43, CAST(N'2020-11-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (6, CAST(N'2020-11-20T00:00:00.000' AS DateTime), 43, CAST(N'2020-11-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (7, CAST(N'2020-11-25T17:00:44.000' AS DateTime), 1, CAST(N'2020-11-25T09:00:44.000' AS DateTime), 2)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (8, CAST(N'2020-11-25T17:15:32.000' AS DateTime), 43, CAST(N'2020-11-25T09:00:32.000' AS DateTime), 2)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (10, CAST(N'2020-12-01T17:30:29.000' AS DateTime), 1, CAST(N'2020-12-01T09:55:29.000' AS DateTime), 2)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (15, CAST(N'2020-12-08T18:00:00.000' AS DateTime), 3, CAST(N'2020-12-08T09:00:00.000' AS DateTime), 1)
INSERT [dbo].[NHANVIEN_GIOCONG] ([ID], [NgayGioKetThuc], [ID_NhanVien], [NgayGioBatDau], [ID_GioCong]) VALUES (16, CAST(N'2020-12-08T17:34:28.000' AS DateTime), 2, CAST(N'2020-12-08T09:00:28.000' AS DateTime), 2)
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
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1068, CAST(N'2020-11-02T00:00:00.000' AS DateTime), 1, 2, CAST(N'2020-11-02T00:00:00.000' AS DateTime), N'Nghỉ Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1084, CAST(N'2020-11-02T00:00:00.000' AS DateTime), 1, 2, CAST(N'2020-11-02T00:00:00.000' AS DateTime), N'Nghi Sinh Nhật')
INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] ([ID], [NgayBatDau], [ID_NhanVien], [ID_LoaiNgayNghi], [NgayKetThuc], [LyDo]) VALUES (1085, CAST(N'2020-11-23T00:00:00.000' AS DateTime), 1, 3, CAST(N'2020-11-30T00:00:00.000' AS DateTime), N'Nghi Không Phép Theo Tháng')
SET IDENTITY_INSERT [dbo].[NHANVIEN_LOAINGAYNGHI] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN_OT] ON 

INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (1, CAST(N'2020-12-02' AS Date), 5, NULL, 2, 1)
INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (2, CAST(N'2020-12-02' AS Date), 7, NULL, 3, 4)
INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (4, CAST(N'2020-12-03' AS Date), 7, NULL, 2, 1)
INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (5, CAST(N'2020-12-05' AS Date), 7, NULL, 2, 4)
INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (6, CAST(N'2020-12-06' AS Date), 5, NULL, 2, 4)
INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (7, CAST(N'2020-12-05' AS Date), 7, NULL, 1, 4)
INSERT [dbo].[NHANVIEN_OT] ([ID], [DateDangKy], [SoGioOT], [ID_Project], [ID_NhanVien], [ID_Range_Hours_OT]) VALUES (10, CAST(N'2020-05-12' AS Date), 6, NULL, 2, 4)
SET IDENTITY_INSERT [dbo].[NHANVIEN_OT] OFF
GO
SET IDENTITY_INSERT [dbo].[NHANVIEN_PHUCAP] ON 

INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (1, 3, 2, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (2, 3, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (3, 1, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (4, 2, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (5, 3, 3, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (6, 43, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (7, 43, 2, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (8, 43, 3, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (9, 10, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (10, 4, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (11, 6, 1, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (12, 7, 4, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (13, 8, 5, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (14, 15, 6, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (15, 16, 5, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (16, 43, 10, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (17, 1, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (18, 3, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (19, 2, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (20, 43, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (21, 10, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (22, 4, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (23, 6, 8, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (25, 1, 2, CAST(N'2020-12-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (26, 5, 1, CAST(N'2021-01-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (27, 4, 2, CAST(N'2021-01-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (28, 4, 3, CAST(N'2021-01-01' AS Date))
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (29, 7, 1, NULL)
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (30, 8, 1, NULL)
INSERT [dbo].[NHANVIEN_PHUCAP] ([ID], [ID_NhanVien], [ID_PhuCap], [ThangNam]) VALUES (31, 5, 2, NULL)
SET IDENTITY_INSERT [dbo].[NHANVIEN_PHUCAP] OFF
GO
SET IDENTITY_INSERT [dbo].[PHUCAP] ON 

INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (1, 1000.0000, N'Số Km * Gía Xăng * 2 * Số ngày làm tại công ty                                                                                                                                                                                                                 ', N'Benefit_Gasoline', N'Phụ cấp xăng xe ')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (2, 20000.0000, N'Số ngày làm WFH * phụ cấp WFH                                                                                                                                                                                                                                  ', N'Benefit_WFH', N'Phụ cấp làm việc tại nhà ')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (3, 4700000.0000, N'Phụ cấp tiếng nhật N1                                                                                                                                                                                                                                          ', N'Benefit_ Japanese_N1', N'Phụ cấp tiếng nhật N1 ')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (4, 2350000.0000, N'Phụ cấp tiếng nhật N2                                                                                                                                                                                                                                          ', N'Benefit_Japanese_N2 ', N'Phụ cấp tiếng nhật N2')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (5, 1175000.0000, N'Phụ cấp tiếng nhật N3                                                                                                                                                                                                                                          ', N'Benefit_Japanese_N3 ', N'Phụ cấp tiếng nhật N3')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (6, 235000.0000, N'Phụ cấp tiếng nhật N4                                                                                                                                                                                                                                          ', N'Benefit_Japanese_N4 ', N'Phụ cấp tiếng nhật N4')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (7, 2350000.0000, N'Phụ cấp tiếng nhật Other                                                                                                                                                                                                                                       ', N'Benefit_Japanese_Other', N'Phụ cấp tiếng nhật Other')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (8, 6000.0000, N'Phụ cấp giữ xe * Số ngày làm tại công ty                                                                                                                                                                                                                       ', N'Benefit_Parking ', N'Phụ cấp giữ xe')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (9, 9400000.0000, N'Phụ cấp manager                                                                                                                                                                                                                                                ', N'Benefit_Manager', N'Phụ cấp manager ')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (10, 4700000.0000, N'Phụ cấp Project Manager                                                                                                                                                                                                                                        ', N'Benefit_Project_Manager', N'Phụ cấp Project Manager')
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (11, 4700000.0000, NULL, N'Benefit_Chief_Accountant', NULL)
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (12, 4700000.0000, NULL, N'Benefit_Chief_Administrator', NULL)
INSERT [dbo].[PHUCAP] ([ID], [PC_CoDinh], [CongThuc], [TenPhuCap], [MoTa]) VALUES (13, 1175000.0000, N'Phụ cấp Leader                                                                                                                                                                                                                                                 ', N'Benefit_Leader', N'Phụ cấp Leader')
SET IDENTITY_INSERT [dbo].[PHUCAP] OFF
GO
SET IDENTITY_INSERT [dbo].[TRANGTHAILAMVIEC] ON 

INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (1, N'Nghỉ việc')
INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (2, N'Chính Thức')
INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (3, N'Trainning')
INSERT [dbo].[TRANGTHAILAMVIEC] ([ID], [TenTrangThai]) VALUES (4, N'Thực tập')
SET IDENTITY_INSERT [dbo].[TRANGTHAILAMVIEC] OFF
GO
SET IDENTITY_INSERT [dbo].[TYPE_RANGE_HOURS_OT] ON 

INSERT [dbo].[TYPE_RANGE_HOURS_OT] ([ID], [RangeHours], [PercentAmountOT]) VALUES (1, N'17h - 21h / 5h-8h weekdays                                                                                                                                                                                                                                     ', 1.5)
INSERT [dbo].[TYPE_RANGE_HOURS_OT] ([ID], [RangeHours], [PercentAmountOT]) VALUES (3, N'21h-5h weekdays                                                                                                                                                                                                                                                ', 1.8)
INSERT [dbo].[TYPE_RANGE_HOURS_OT] ([ID], [RangeHours], [PercentAmountOT]) VALUES (4, N'Weekends (without 21h- 5h)                                                                                                                                                                                                                                     ', 2)
INSERT [dbo].[TYPE_RANGE_HOURS_OT] ([ID], [RangeHours], [PercentAmountOT]) VALUES (5, N'21h - 5h weekends                                                                                                                                                                                                                                              ', 2.3)
INSERT [dbo].[TYPE_RANGE_HOURS_OT] ([ID], [RangeHours], [PercentAmountOT]) VALUES (6, N'Holidays                                                                                                                                                                                                                                                       ', 3)
SET IDENTITY_INSERT [dbo].[TYPE_RANGE_HOURS_OT] OFF
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
ALTER TABLE [dbo].[NHANVIEN_BAOHIEM_THUE]  WITH CHECK ADD FOREIGN KEY([ID_BaoHiem_Thue])
REFERENCES [dbo].[BAOHIEM_THUE] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_BAOHIEM_THUE]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
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
ALTER TABLE [dbo].[NHANVIEN_OT]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_OT]  WITH CHECK ADD FOREIGN KEY([ID_Range_Hours_OT])
REFERENCES [dbo].[TYPE_RANGE_HOURS_OT] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_PHUCAP]  WITH CHECK ADD FOREIGN KEY([ID_NhanVien])
REFERENCES [dbo].[NHANSU] ([ID])
GO
ALTER TABLE [dbo].[NHANVIEN_PHUCAP]  WITH CHECK ADD FOREIGN KEY([ID_PhuCap])
REFERENCES [dbo].[PHUCAP] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[spCreateOFFDayForStaff]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetBenefit]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetBenefit] 
(	
	@ID_NhanVien int, 
	@ID_PhuCap int
)
AS 
BEGIN 
	DECLARE @result DECIMAL
	IF not exists (	SELECT PC_CoDinh 
					FROM 
						NHANVIEN_PHUCAP
						LEFT JOIN PHUCAP ON NHANVIEN_PHUCAP.ID_PhuCap = PHUCAP.ID
					WHERE 
						NHANVIEN_PHUCAP.ID_NhanVien = @ID_NhanVien
						AND 
						NHANVIEN_PHUCAP.ID_PhuCap = @ID_PhuCap)
						SET @result = 0
	else 
		SET @result = (	SELECT ISNULL(PC_CoDinh, 0)
						FROM 
							NHANVIEN_PHUCAP
							LEFT JOIN PHUCAP ON NHANVIEN_PHUCAP.ID_PhuCap = PHUCAP.ID
						WHERE
							NHANVIEN_PHUCAP.ID_NhanVien = @ID_NhanVien
							AND 
							NHANVIEN_PHUCAP.ID_PhuCap = @ID_PhuCap)
	select @result
END 
GO
/****** Object:  StoredProcedure [dbo].[spGetInfoStaff]    Script Date: 1/15/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetInfoStaff]
(	
	@nameColumn nchar(255), 
	@IDNhanVien int
)
AS
BEGIN
	DECLARE @result DECIMAL 
	IF not exists (	SELECT 
						@nameColumn
					FROM 
						NHANSU 
					WHERE 
						ID = @IDNhanVien)
		SET @result = 0;
	ELSE 
		SET @result = (	SELECT 
							@nameColumn
						FROM 
							NHANSU 
						WHERE 
							ID = @IDNhanVien)

	SELECT @result
END 
GO
/****** Object:  StoredProcedure [dbo].[spUpdateDayOfTakeLeaveForStaff]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateOFFDayForStaff]    Script Date: 1/15/2021 5:18:45 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TinhLuongCBTheoThang]    Script Date: 1/15/2021 5:18:45 PM ******/
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
