USE [TinhTienLuong]
GO
/****** Object:  UserDefinedFunction [dbo].[fnCalculteOFFDayTakeLeaveAStaffForMonth]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnCheckOffDayDuplicate]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnFullMonthsSeparation]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[NHANSU]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[NHANVIEN_GIOCONG]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayWorkingDaysForStaff]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[NHANVIEN_LOAINGAYNGHI]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayWorkingDaysStaffOfMonth]    Script Date: 12/4/2020 5:31:21 PM ******/
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
		ID_NhanVien,
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
			SUM	(CASE	WHEN ID_GioCong = 2 THEN 8 - (DATEDIFF(HOUR, NHANVIEN_GIOCONG.NgayGioBatDau, NHANVIEN_GIOCONG.NgayGioKetThuc) - 1)
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
		NHANSU.HoVaTen LIKE N'%'+ @HoVaTen + '%'
		GROUP BY NHANSU.HoVaTen, NHANVIEN_LOAINGAYNGHI.ID_NhanVien
	) SOMETHING ON WORKINGDAYS.ID_NhanVien = SOMETHING.t2
GO
/****** Object:  UserDefinedFunction [dbo].[fnDisplayInfoStaffWorkingDayInMonth]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[TYPE_RANGE_HOURS_OT]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[NHANVIEN_OT]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOT_AmountOTStaffOfMonth]    Script Date: 12/4/2020 5:31:21 PM ******/
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
GO
/****** Object:  Table [dbo].[LOAINGAYNGHI]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOFFDayFollowCondition]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayTitleOFFDay]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[TRANGTHAILAMVIEC]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOptionStateWorking]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayStaffFollowName]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayStaffFollowID]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[CHUCDANH]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnDisplayOptionTitle]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[BANGLUONG]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[HISTORY_RESET_DAY_OF_TAKE_LEAVE]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[KHAUTRULUONG]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[LOAI_GIO_CONG]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[LOAIPHUCAP]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  Table [dbo].[NHANVIEN_LOAIPHUCAP]    Script Date: 12/4/2020 5:31:21 PM ******/
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
ALTER TABLE [dbo].[NHANVIEN_OT]  WITH CHECK ADD FOREIGN KEY([ID_Range_Hours_OT])
REFERENCES [dbo].[TYPE_RANGE_HOURS_OT] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[spCreateOFFDayForStaff]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateDayOfTakeLeaveForStaff]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateOFFDayForStaff]    Script Date: 12/4/2020 5:31:21 PM ******/
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
/****** Object:  StoredProcedure [dbo].[TinhLuongCBTheoThang]    Script Date: 12/4/2020 5:31:21 PM ******/
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
