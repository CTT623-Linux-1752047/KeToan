﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WindowsFormsApp1
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class TinhTienLuongEntities : DbContext
    {
        public TinhTienLuongEntities()
            : base("name=TinhTienLuongEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<BANGLUONG> BANGLUONGs { get; set; }
        public virtual DbSet<CHUCDANH> CHUCDANHs { get; set; }
        public virtual DbSet<HISTORY_RESET_DAY_OF_TAKE_LEAVE> HISTORY_RESET_DAY_OF_TAKE_LEAVE { get; set; }
        public virtual DbSet<KHAUTRULUONG> KHAUTRULUONGs { get; set; }
        public virtual DbSet<LOAI_GIO_CONG> LOAI_GIO_CONG { get; set; }
        public virtual DbSet<LOAINGAYNGHI> LOAINGAYNGHIs { get; set; }
        public virtual DbSet<LOAIPHUCAP> LOAIPHUCAPs { get; set; }
        public virtual DbSet<NHANSU> NHANSUs { get; set; }
        public virtual DbSet<NHANVIEN_GIOCONG> NHANVIEN_GIOCONG { get; set; }
        public virtual DbSet<NHANVIEN_LOAINGAYNGHI> NHANVIEN_LOAINGAYNGHI { get; set; }
        public virtual DbSet<NHANVIEN_LOAIPHUCAP> NHANVIEN_LOAIPHUCAP { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<TRANGTHAILAMVIEC> TRANGTHAILAMVIECs { get; set; }
        public virtual DbSet<TYPE_RANGE_HOURS_OT> TYPE_RANGE_HOURS_OT { get; set; }
        public virtual DbSet<NHANVIEN_OT> NHANVIEN_OT { get; set; }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayOFFDayFollowCondition")]
        public virtual IQueryable<fnDisplayOFFDayFollowCondition_Result> fnDisplayOFFDayFollowCondition(Nullable<System.DateTime> ngayBatDau, Nullable<System.DateTime> ngayKetThuc, string hoVaTen)
        {
            var ngayBatDauParameter = ngayBatDau.HasValue ?
                new ObjectParameter("NgayBatDau", ngayBatDau) :
                new ObjectParameter("NgayBatDau", typeof(System.DateTime));
    
            var ngayKetThucParameter = ngayKetThuc.HasValue ?
                new ObjectParameter("NgayKetThuc", ngayKetThuc) :
                new ObjectParameter("NgayKetThuc", typeof(System.DateTime));
    
            var hoVaTenParameter = hoVaTen != null ?
                new ObjectParameter("HoVaTen", hoVaTen) :
                new ObjectParameter("HoVaTen", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayOFFDayFollowCondition_Result>("[TinhTienLuongEntities].[fnDisplayOFFDayFollowCondition](@NgayBatDau, @NgayKetThuc, @HoVaTen)", ngayBatDauParameter, ngayKetThucParameter, hoVaTenParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayOptionStateWorking")]
        public virtual IQueryable<fnDisplayOptionStateWorking_Result> fnDisplayOptionStateWorking()
        {
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayOptionStateWorking_Result>("[TinhTienLuongEntities].[fnDisplayOptionStateWorking]()");
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayOptionTitle")]
        public virtual IQueryable<fnDisplayOptionTitle_Result> fnDisplayOptionTitle()
        {
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayOptionTitle_Result>("[TinhTienLuongEntities].[fnDisplayOptionTitle]()");
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayStaffFollowID")]
        public virtual IQueryable<fnDisplayStaffFollowID_Result> fnDisplayStaffFollowID(Nullable<int> id_NhanVien)
        {
            var id_NhanVienParameter = id_NhanVien.HasValue ?
                new ObjectParameter("id_NhanVien", id_NhanVien) :
                new ObjectParameter("id_NhanVien", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayStaffFollowID_Result>("[TinhTienLuongEntities].[fnDisplayStaffFollowID](@id_NhanVien)", id_NhanVienParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayStaffFollowName")]
        public virtual IQueryable<fnDisplayStaffFollowName_Result> fnDisplayStaffFollowName(string hoVaTen)
        {
            var hoVaTenParameter = hoVaTen != null ?
                new ObjectParameter("HoVaTen", hoVaTen) :
                new ObjectParameter("HoVaTen", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayStaffFollowName_Result>("[TinhTienLuongEntities].[fnDisplayStaffFollowName](@HoVaTen)", hoVaTenParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayTitleOFFDay")]
        public virtual IQueryable<fnDisplayTitleOFFDay_Result> fnDisplayTitleOFFDay()
        {
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayTitleOFFDay_Result>("[TinhTienLuongEntities].[fnDisplayTitleOFFDay]()");
        }
    
        public virtual int sp_alterdiagram(string diagramname, Nullable<int> owner_id, Nullable<int> version, byte[] definition)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var versionParameter = version.HasValue ?
                new ObjectParameter("version", version) :
                new ObjectParameter("version", typeof(int));
    
            var definitionParameter = definition != null ?
                new ObjectParameter("definition", definition) :
                new ObjectParameter("definition", typeof(byte[]));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_alterdiagram", diagramnameParameter, owner_idParameter, versionParameter, definitionParameter);
        }
    
        public virtual int sp_creatediagram(string diagramname, Nullable<int> owner_id, Nullable<int> version, byte[] definition)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var versionParameter = version.HasValue ?
                new ObjectParameter("version", version) :
                new ObjectParameter("version", typeof(int));
    
            var definitionParameter = definition != null ?
                new ObjectParameter("definition", definition) :
                new ObjectParameter("definition", typeof(byte[]));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_creatediagram", diagramnameParameter, owner_idParameter, versionParameter, definitionParameter);
        }
    
        public virtual int sp_dropdiagram(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_dropdiagram", diagramnameParameter, owner_idParameter);
        }
    
        public virtual ObjectResult<sp_helpdiagramdefinition_Result> sp_helpdiagramdefinition(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_helpdiagramdefinition_Result>("sp_helpdiagramdefinition", diagramnameParameter, owner_idParameter);
        }
    
        public virtual ObjectResult<sp_helpdiagrams_Result> sp_helpdiagrams(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_helpdiagrams_Result>("sp_helpdiagrams", diagramnameParameter, owner_idParameter);
        }
    
        public virtual int sp_renamediagram(string diagramname, Nullable<int> owner_id, string new_diagramname)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var new_diagramnameParameter = new_diagramname != null ?
                new ObjectParameter("new_diagramname", new_diagramname) :
                new ObjectParameter("new_diagramname", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_renamediagram", diagramnameParameter, owner_idParameter, new_diagramnameParameter);
        }
    
        public virtual int sp_upgraddiagrams()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_upgraddiagrams");
        }
    
        public virtual int spCreateOFFDayForStaff(Nullable<int> iDNhanVien, Nullable<int> iDLoaiNgayNghi, Nullable<System.DateTime> ngayBatDau, Nullable<System.DateTime> ngayKetThuc, string lyDo)
        {
            var iDNhanVienParameter = iDNhanVien.HasValue ?
                new ObjectParameter("IDNhanVien", iDNhanVien) :
                new ObjectParameter("IDNhanVien", typeof(int));
    
            var iDLoaiNgayNghiParameter = iDLoaiNgayNghi.HasValue ?
                new ObjectParameter("IDLoaiNgayNghi", iDLoaiNgayNghi) :
                new ObjectParameter("IDLoaiNgayNghi", typeof(int));
    
            var ngayBatDauParameter = ngayBatDau.HasValue ?
                new ObjectParameter("NgayBatDau", ngayBatDau) :
                new ObjectParameter("NgayBatDau", typeof(System.DateTime));
    
            var ngayKetThucParameter = ngayKetThuc.HasValue ?
                new ObjectParameter("NgayKetThuc", ngayKetThuc) :
                new ObjectParameter("NgayKetThuc", typeof(System.DateTime));
    
            var lyDoParameter = lyDo != null ?
                new ObjectParameter("LyDo", lyDo) :
                new ObjectParameter("LyDo", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spCreateOFFDayForStaff", iDNhanVienParameter, iDLoaiNgayNghiParameter, ngayBatDauParameter, ngayKetThucParameter, lyDoParameter);
        }
    
        public virtual int spUpdateDayOfTakeLeaveForStaff()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spUpdateDayOfTakeLeaveForStaff");
        }
    
        public virtual int spUpdateOFFDayForStaff(Nullable<int> iDNhanVienNgayNghi, Nullable<int> iDNhanVien, Nullable<int> iDNgayNghi, Nullable<System.DateTime> ngayBatDau, Nullable<System.DateTime> ngayKetThuc, string lyDo)
        {
            var iDNhanVienNgayNghiParameter = iDNhanVienNgayNghi.HasValue ?
                new ObjectParameter("IDNhanVienNgayNghi", iDNhanVienNgayNghi) :
                new ObjectParameter("IDNhanVienNgayNghi", typeof(int));
    
            var iDNhanVienParameter = iDNhanVien.HasValue ?
                new ObjectParameter("IDNhanVien", iDNhanVien) :
                new ObjectParameter("IDNhanVien", typeof(int));
    
            var iDNgayNghiParameter = iDNgayNghi.HasValue ?
                new ObjectParameter("IDNgayNghi", iDNgayNghi) :
                new ObjectParameter("IDNgayNghi", typeof(int));
    
            var ngayBatDauParameter = ngayBatDau.HasValue ?
                new ObjectParameter("NgayBatDau", ngayBatDau) :
                new ObjectParameter("NgayBatDau", typeof(System.DateTime));
    
            var ngayKetThucParameter = ngayKetThuc.HasValue ?
                new ObjectParameter("NgayKetThuc", ngayKetThuc) :
                new ObjectParameter("NgayKetThuc", typeof(System.DateTime));
    
            var lyDoParameter = lyDo != null ?
                new ObjectParameter("LyDo", lyDo) :
                new ObjectParameter("LyDo", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("spUpdateOFFDayForStaff", iDNhanVienNgayNghiParameter, iDNhanVienParameter, iDNgayNghiParameter, ngayBatDauParameter, ngayKetThucParameter, lyDoParameter);
        }
    
        public virtual int TinhLuongCBTheoThang(string userID, Nullable<System.DateTime> date)
        {
            var userIDParameter = userID != null ?
                new ObjectParameter("UserID", userID) :
                new ObjectParameter("UserID", typeof(string));
    
            var dateParameter = date.HasValue ?
                new ObjectParameter("Date", date) :
                new ObjectParameter("Date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("TinhLuongCBTheoThang", userIDParameter, dateParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayWorkingDaysForStaff")]
        public virtual IQueryable<string> fnDisplayWorkingDaysForStaff(string hoVaTen, Nullable<System.DateTime> thangNamStart, Nullable<System.DateTime> thangNamEnd)
        {
            var hoVaTenParameter = hoVaTen != null ?
                new ObjectParameter("HoVaTen", hoVaTen) :
                new ObjectParameter("HoVaTen", typeof(string));
    
            var thangNamStartParameter = thangNamStart.HasValue ?
                new ObjectParameter("ThangNamStart", thangNamStart) :
                new ObjectParameter("ThangNamStart", typeof(System.DateTime));
    
            var thangNamEndParameter = thangNamEnd.HasValue ?
                new ObjectParameter("ThangNamEnd", thangNamEnd) :
                new ObjectParameter("ThangNamEnd", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<string>("[TinhTienLuongEntities].[fnDisplayWorkingDaysForStaff](@HoVaTen, @ThangNamStart, @ThangNamEnd)", hoVaTenParameter, thangNamStartParameter, thangNamEndParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayWorkingDaysStaffOfMonth")]
        public virtual IQueryable<fnDisplayWorkingDaysStaffOfMonth_Result> fnDisplayWorkingDaysStaffOfMonth(string hoVaTen, Nullable<System.DateTime> thangNam)
        {
            var hoVaTenParameter = hoVaTen != null ?
                new ObjectParameter("HoVaTen", hoVaTen) :
                new ObjectParameter("HoVaTen", typeof(string));
    
            var thangNamParameter = thangNam.HasValue ?
                new ObjectParameter("ThangNam", thangNam) :
                new ObjectParameter("ThangNam", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayWorkingDaysStaffOfMonth_Result>("[TinhTienLuongEntities].[fnDisplayWorkingDaysStaffOfMonth](@HoVaTen, @ThangNam)", hoVaTenParameter, thangNamParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayInfoStaffWorkingDayInMonth")]
        public virtual IQueryable<fnDisplayInfoStaffWorkingDayInMonth_Result> fnDisplayInfoStaffWorkingDayInMonth(Nullable<int> iD_NhanVien, Nullable<System.DateTime> thangNam)
        {
            var iD_NhanVienParameter = iD_NhanVien.HasValue ?
                new ObjectParameter("ID_NhanVien", iD_NhanVien) :
                new ObjectParameter("ID_NhanVien", typeof(int));
    
            var thangNamParameter = thangNam.HasValue ?
                new ObjectParameter("ThangNam", thangNam) :
                new ObjectParameter("ThangNam", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayInfoStaffWorkingDayInMonth_Result>("[TinhTienLuongEntities].[fnDisplayInfoStaffWorkingDayInMonth](@ID_NhanVien, @ThangNam)", iD_NhanVienParameter, thangNamParameter);
        }
    
        [DbFunction("TinhTienLuongEntities", "fnDisplayOT_AmountOTStaffOfMonth")]
        public virtual IQueryable<fnDisplayOT_AmountOTStaffOfMonth_Result> fnDisplayOT_AmountOTStaffOfMonth(string hoVaTen, Nullable<System.DateTime> date)
        {
            var hoVaTenParameter = hoVaTen != null ?
                new ObjectParameter("HoVaTen", hoVaTen) :
                new ObjectParameter("HoVaTen", typeof(string));
    
            var dateParameter = date.HasValue ?
                new ObjectParameter("Date", date) :
                new ObjectParameter("Date", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.CreateQuery<fnDisplayOT_AmountOTStaffOfMonth_Result>("[TinhTienLuongEntities].[fnDisplayOT_AmountOTStaffOfMonth](@HoVaTen, @Date)", hoVaTenParameter, dateParameter);
        }
    }
}
