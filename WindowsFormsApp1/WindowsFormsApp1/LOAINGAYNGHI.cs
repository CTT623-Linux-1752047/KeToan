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
    
    public partial class LOAINGAYNGHI
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LOAINGAYNGHI()
        {
            this.NHANVIEN_LOAINGAYNGHI = new HashSet<NHANVIEN_LOAINGAYNGHI>();
        }
    
        public int ID { get; set; }
        public string LoaiNgayNghi1 { get; set; }
        public string TenNgayNghi { get; set; }
        public Nullable<double> ThoiGian { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NHANVIEN_LOAINGAYNGHI> NHANVIEN_LOAINGAYNGHI { get; set; }
    }
}
