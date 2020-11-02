using Microsoft.VisualBasic;
using Microsoft.Win32.SafeHandles;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace TinhLuongBackEnd
{
    public class NHANSU
    {
        private int id;
        private string UserID, UserName, HoVaTen,
                        DiaChiThuongTru, DiaChiTamTru, cmnd,
                        GioiTinh, SoTK, TrinhDo, MaSoThue,
                        SoHDLD, LoaiHDLD, ThoiHanLD, SoDT, ChucDanh,
                        TrangThaiLamViec, NguoiPhuTrach, EmailCongTy,
                        NoiLamViec, HoTenNLQ, TinhTrangHonNhan,
                        DiaChiNLQ, MoiQuanHe, GioiTinhNLQ, SdtNLQ; 
        private decimal LuongCB;
        private DateTime NgaySinh, NgaySinhNLQ, NgayBatDau;

        public NHANSU(DataRow row)
        {
            this.id = (int)row["ID"];

            this.UserID = row["UserID"].ToString();
            this.UserName = row["UserName"].ToString();
            this.HoVaTen = row["HoVaTen"].ToString();

            this.DiaChiThuongTru = row["DiaChiThuongTru"].ToString();
            this.DiaChiTamTru = row["DiaChiTamTru"].ToString();
            this.cmnd = row["CMND"].ToString();
            this.SoDT = row["SoDT"].ToString();

            this.GioiTinh = row["GioiTinh"].ToString();
            this.SoTK = row["SoTKNganHang"].ToString();
            this.TrinhDo = row["TrinhDo"].ToString();
            this.MaSoThue = row["MaSoThue"].ToString();

            this.TinhTrangHonNhan = row["TinhTrangHonNhan"].ToString();

            this.SoHDLD = row["SoHDLD"].ToString();
            this.LoaiHDLD = row["LoaiHDLD"].ToString();
            this.ThoiHanLD = row["ThoiHanHDLD"].ToString();
            this.ChucDanh = row["ChucDanh"].ToString();

            this.NguoiPhuTrach = row["NguoiPhuTrach"].ToString();
            this.EmailCongTy = row["EmailCongTy"].ToString();

            this.NoiLamViec = row["NoiLamViec"].ToString();
            this.HoTenNLQ = row["HoTenNguoiLienQuan"].ToString();
            this.TrangThaiLamViec = row["TrangThaiLamViec"].ToString();

            this.DiaChiNLQ = row["DiaChiNguoiLienQuan"].ToString();
            this.MoiQuanHe = row["MoiQuanHe"].ToString();
            this.GioiTinhNLQ = row["GioiTinhNguoiLienQuan"].ToString();
            this.SdtNLQ = row["SDTNguoiLienQuan"].ToString();

            this.LuongCB = (decimal)row["LuongCB"];

            this.NgaySinh = DBNull.Value.Equals(row["NgaySinh"]) ? new DateTime() : (DateTime)row["NgaySinh"];
            this.NgaySinhNLQ = DBNull.Value.Equals(row["NgaySinhNguoiLienQuan"]) ? new DateTime() : (DateTime)row["NgaySinhNguoiLienQuan"];
            this.NgayBatDau = DBNull.Value.Equals(row["NgayBatDau"]) ? new DateTime() : (DateTime)row["NgayBatDau"];
        }
        public NHANSU(NHANSU b)
        {
            this.id = b.ID;
            this.UserID = b.USERID;
            this.UserName = b.USERNAME;
            this.HoVaTen = b.HOVATEN;

            this.GioiTinh = b.GIOITINH;
            this.SoTK = b.SOTK;
            this.TrinhDo = b.TRINHDO;
            this.MaSoThue = b.MASOTHUE;
            this.TinhTrangHonNhan = b.TINHTRANGHONNHAN;

            this.DiaChiThuongTru = b.DIACHITHUONGTRU;
            this.DiaChiTamTru = b.DIACHITAMTRU;
            this.cmnd = b.CMND;

            this.SoHDLD = b.SOHDLD;
            this.LoaiHDLD = b.LOAIHDLD;
            this.ThoiHanLD = b.THOIHANLD;
            this.SoDT = b.SODT;
            this.ChucDanh = b.CHUCDANH;

            this.TrangThaiLamViec = b.TRANGTHAILAMVIEC;
            this.NguoiPhuTrach = b.NGUOIPHUTRACH;
            this.EmailCongTy = b.EMAILCONGTY;
            this.NoiLamViec = b.NOILAMVIEC;

            this.HoTenNLQ = b.HOTENNLQ;
            this.DiaChiNLQ = b.DIACHINLQ;
            this.MoiQuanHe = b.MOIQUANHE;
            this.GioiTinhNLQ = b.GIOITINHNLQ;
            this.SdtNLQ = b.SdtNLQ;

            this.LuongCB = b.LUONGCB;

            this.NgaySinh = b.NGAYSINH;
            this.NgaySinhNLQ = b.NGAYSINHNLQ;
            this.NgayBatDau = b.NGAYBATDAU;
        }
        public NHANSU()
        {
            this.id = -1;
            this.UserID = "";
            this.UserName = "";
            this.HoVaTen = "";

            this.GioiTinh = "";
            this.SoTK = "";
            this.TrinhDo = "";
            this.MaSoThue = "";
            this.TinhTrangHonNhan = "";

            this.DiaChiThuongTru = "";
            this.DiaChiTamTru = "";
            this.CMND = "";

            this.SoHDLD = "";
            this.LoaiHDLD = "";
            this.ThoiHanLD = "";
            this.SoDT = "";
            this.ChucDanh = "";

            this.TrangThaiLamViec = "";
            this.NguoiPhuTrach = "";
            this.EmailCongTy = "";
            this.NoiLamViec = "";

            this.HoTenNLQ = "";
            this.DiaChiNLQ = "";
            this.MoiQuanHe = "";
            this.GioiTinhNLQ = "";
            this.SdtNLQ = "";

            this.LuongCB = 0;

            this.NgaySinh = new DateTime();
            this.NgaySinhNLQ = new DateTime();
            this.NgayBatDau = new DateTime();
        }
        public int ID
        {
            set { this.id = value; }
            get { return this.id; }
        }
        public decimal LUONGCB
        {
            set { this.LuongCB = value; }
            get { return this.LuongCB; }
        }
        public string USERID
        {
            set { this.UserID = value; }
            get { return this.UserID; }
        }
        public string USERNAME
        {
            set { this.UserName = value; }
            get { return this.UserName; }
        }
        public string HOVATEN
        {
            set { this.HoVaTen = value; }
            get { return this.HoVaTen; }
        }
        public string DIACHITHUONGTRU
        {
            set { this.DiaChiThuongTru = value; }
            get { return this.DiaChiThuongTru; }
        }
        public string DIACHITAMTRU
        {
            set { this.DiaChiTamTru = value; }
            get { return this.DiaChiTamTru; }
        }
        public string CMND
        {
            set { this.cmnd = value; }
            get { return this.cmnd; }
        }
        public string GIOITINH
        {
            set { this.GioiTinh = value; }
            get { return this.GioiTinh; }
        }
        public string SOTK
        {
            set { this.SoTK = value; }
            get { return this.SoTK; }
        }
        public string TRINHDO
        {
            set { this.TrinhDo = value; }
            get { return this.TrinhDo; }
        }
        public string MASOTHUE
        {
            set { this.MaSoThue = value; }
            get { return this.MaSoThue; }
        }
        public string TINHTRANGHONNHAN
        {
            set { this.TinhTrangHonNhan = value; }
            get { return this.TinhTrangHonNhan; }
        }
        public string SOHDLD
        {
            set { this.SoHDLD = value; }
            get { return this.SoHDLD; }
        }
        public string LOAIHDLD
        {
            set { this.LoaiHDLD = value; }
            get { return this.LoaiHDLD; }
        }
        public string THOIHANLD
        {
            set { this.ThoiHanLD = value; }
            get { return this.ThoiHanLD; }
        }
        public string SODT
        {
            set { this.SoDT = value; }
            get { return this.SoDT; }
        }
        public string CHUCDANH
        {
            set { this.ChucDanh = value; }
            get { return this.ChucDanh; }
        }
        public string TRANGTHAILAMVIEC
        {
            set { this.TrangThaiLamViec = value; }
            get { return this.TrangThaiLamViec; }
        }
        public string NGUOIPHUTRACH
        {
            set { this.NguoiPhuTrach = value; }
            get { return this.NguoiPhuTrach; }
        }
        public string EMAILCONGTY
        {
            set { this.EmailCongTy = value; }
            get { return this.EmailCongTy; }
        }
        public string NOILAMVIEC
        {
            set { this.NoiLamViec = value; }
            get { return this.NoiLamViec; }
        }
        public string HOTENNLQ
        {
            set { this.HoTenNLQ = value; }
            get { return this.HoTenNLQ; }
        }
        public string DIACHINLQ
        {
            set { this.DiaChiNLQ = value; }
            get { return this.DiaChiNLQ; }
        }
        public string MOIQUANHE
        {
            set { this.MoiQuanHe = value; }
            get { return this.MoiQuanHe; }
        }
        public string GIOITINHNLQ
        {
            set { this.GioiTinhNLQ = value; }
            get { return this.GioiTinhNLQ; }
        }
        public DateTime NGAYSINH
        {
            set { this.NgaySinh = value; }
            get { return this.NgaySinh; }
        }
        public DateTime NGAYSINHNLQ
        {
            set { this.NgaySinhNLQ = value; }
            get { return this.NgaySinhNLQ; }
        }
        public DateTime NGAYBATDAU
        {
            set { this.NgayBatDau = value; }
            get { return this.NgayBatDau; }
        }
        public string SDTNLQ 
        {
            set { this.SdtNLQ = value; }
            get { return this.SdtNLQ; }
        }
    }
}
