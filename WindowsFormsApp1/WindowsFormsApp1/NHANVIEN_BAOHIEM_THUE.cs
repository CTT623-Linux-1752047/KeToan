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
    
    public partial class NHANVIEN_BAOHIEM_THUE
    {
        public int ID { get; set; }
        public Nullable<int> ID_NhanVien { get; set; }
        public Nullable<int> ID_BaoHiem_Thue { get; set; }
    
        public virtual BAOHIEM_THUE BAOHIEM_THUE { get; set; }
        public virtual NHANSU NHANSU { get; set; }
    }
}