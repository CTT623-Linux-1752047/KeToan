//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class NHANSU
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NHANSU()
        {
            this.BANGLUONGs = new HashSet<BANGLUONG>();
            this.HISTORY_RESET_DAY_OF_TAKE_LEAVE = new HashSet<HISTORY_RESET_DAY_OF_TAKE_LEAVE>();
            this.KHAUTRULUONGs = new HashSet<KHAUTRULUONG>();
            this.NHANVIEN_BAOHIEM_THUE = new HashSet<NHANVIEN_BAOHIEM_THUE>();
            this.NHANVIEN_OT = new HashSet<NHANVIEN_OT>();
            this.NHANVIEN_LOAINGAYNGHI = new HashSet<NHANVIEN_LOAINGAYNGHI>();
            this.NHANVIEN_PHUCAP = new HashSet<NHANVIEN_PHUCAP>();
            this.NHANVIEN_GIOCONG = new HashSet<NHANVIEN_GIOCONG>();
        }
    
        public int ID { get; set; }
        public string UserID { get; set; }
        public string UserName { get; set; }
        public string HoVaTen { get; set; }
        public Nullable<System.DateTime> NgaySinh { get; set; }
        public string DiaChiThuongTru { get; set; }
        public string DiaChiTamTru { get; set; }
        public string CMND { get; set; }
        public string GioiTinh { get; set; }
        public string SoTKNganHang { get; set; }
        public string TrinhDo { get; set; }
        public string MaSoThue { get; set; }
        public string TinhTrangHonNhan { get; set; }
        public string SoHDLD { get; set; }
        public string LoaiHDLD { get; set; }
        public Nullable<int> ThoiHanHDLD { get; set; }
        public string SoDT { get; set; }
        public Nullable<int> ChucDanh { get; set; }
        public Nullable<int> TrangThaiLamViec { get; set; }
        public Nullable<int> NguoiPhuTrach { get; set; }
        public string EmailCongTy { get; set; }
        public Nullable<System.DateTime> NgayBatDau { get; set; }
        public string NoiLamViec { get; set; }
        public Nullable<decimal> LuongCB { get; set; }
        public string HoTenNguoiLienQuan { get; set; }
        public string SDTNguoiLienQuan { get; set; }
        public string DiaChiNguoiLienQuan { get; set; }
        public string MoiQuanHe { get; set; }
        public Nullable<System.DateTime> NgaySinhNguoiLienQuan { get; set; }
        public string GioiTinhNguoiLienQuan { get; set; }
        public Nullable<int> SoNgayNghiPhep { get; set; }
        public Nullable<System.DateTime> NgayResetNghiCoPhep { get; set; }
        public Nullable<double> Km { get; set; }
        public Nullable<int> SoNguoiPhuThuoc { get; set; }
        public Nullable<decimal> PayBack { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BANGLUONG> BANGLUONGs { get; set; }
        public virtual CHUCDANH CHUCDANH1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<HISTORY_RESET_DAY_OF_TAKE_LEAVE> HISTORY_RESET_DAY_OF_TAKE_LEAVE { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<KHAUTRULUONG> KHAUTRULUONGs { get; set; }
        public virtual TRANGTHAILAMVIEC TRANGTHAILAMVIEC1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NHANVIEN_BAOHIEM_THUE> NHANVIEN_BAOHIEM_THUE { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NHANVIEN_OT> NHANVIEN_OT { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NHANVIEN_LOAINGAYNGHI> NHANVIEN_LOAINGAYNGHI { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NHANVIEN_PHUCAP> NHANVIEN_PHUCAP { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NHANVIEN_GIOCONG> NHANVIEN_GIOCONG { get; set; }
    }
}
