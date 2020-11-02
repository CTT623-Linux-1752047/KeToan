using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TinhLuongBackEnd;

namespace WindowsFormsApp1
{
    public partial class RegisterUser : Form
    {
        public RegisterUser()
        {
            InitializeComponent();
            this.btnAddInfoEmployee.Show();
            this.btnRepairInfoEmployee.Hide();
        }
        public RegisterUser(int index)
        {
            InitializeComponent();
            this.btnAddInfoEmployee.Hide();
            this.btnRepairInfoEmployee.Show();
            CONNECT_DB conn = new CONNECT_DB();
            string query = "SELECT * FROM NHANSU WHERE ID = " + index;
            DataSet ds = conn.GetDBToDS(query, "Employee");
            conn.CloseDB();
            DataTable dt = ds.Tables["Employee"];
            NHANSU a = new NHANSU(dt.Rows[0]);
            DisplayData(a);
        }
        public void DisplayData(NHANSU a)
        {
            //điền các trường vào form
            //thông tin nhân viên
            this.txtName.Text = a.HOVATEN;
            this.txtIdentify.Text = a.CMND;
            this.txtTemporaryAdd.Text = a.DIACHITAMTRU;
            this.txtPermanentAdd.Text = a.DIACHITHUONGTRU;
            this.level.Text = a.TRINHDO;
            this.txtNumBank.Text = a.SOTK;
            this.birth.Value = a.NGAYSINH;
            this.txtPhonePer.Text = a.SODT;
            if (a.GIOITINH == "Nam")
            {
                this.txtSex.SetSelected(0, true);
                this.txtSex.SetItemChecked(0, true);
            }
            else
            {
                this.txtSex.SetSelected(1, true);
                this.txtSex.SetItemChecked(1, true);
            }
            if (a.TINHTRANGHONNHAN == "Đã kết hôn")
            {
                this.checkTinhTrangHonNhan.SetSelected(1, true);
                this.checkTinhTrangHonNhan.SetItemChecked(1, true);
            }
            else
            {
                this.checkTinhTrangHonNhan.SetSelected(0, true);
                this.checkTinhTrangHonNhan.SetItemChecked(0, true);
            }
            this.txtPhonePer.Text = a.SODT;

            //thông tin người liên quan
            this.txtNamePerRela.Text = a.HOTENNLQ;
            this.txtAddPerRela.Text = a.DIACHINLQ;
            this.txtPhonePerRela.Text = a.SDTNLQ;
            this.birthPerRela.Value = (a.NGAYSINHNLQ < new DateTime(1975, 01, 01)) ? new DateTime(9998, 12, 31) : a.NGAYSINHNLQ;
            if (a.GIOITINHNLQ == "Nam")
            {
                this.checkSexPerRela.SetSelected(1, true);
                this.checkSexPerRela.SetItemChecked(1, true);
            }
            else if (a.GIOITINHNLQ == "Nữ")
            {
                this.checkSexPerRela.SetSelected(0, true);
                this.checkSexPerRela.SetItemChecked(0, true);
            }
            else
                ;
            this.txtRelationship.Text = a.MOIQUANHE;

            //thông tin công việc 
            this.txtUserID.Text = a.USERID;
            this.txtUserID.Enabled = false;
            this.txtUserName.Text = a.USERNAME;
            this.txtSuperviser.Text = a.NGUOIPHUTRACH;
            this.txtTitle.Text = a.CHUCDANH;
            this.txtStateWorking.Text = a.TRANGTHAILAMVIEC;
            this.txtEmailCo.Text = a.EMAILCONGTY;
            this.txtAddCo.Text = a.NOILAMVIEC;
            this.txtSalary.Text = a.LUONGCB.ToString("#,##0.###");
            this.txtNumLarbourContract.Text = a.SOHDLD;
            this.txtTitleLabourContract.Text = a.LOAIHDLD;
            this.txtDateLimit.Text = a.THOIHANLD;
        }
        private void btnAddInfoEmployee_Click(object sender, EventArgs e)
        {
            string birthPer = (this.birth.Value == DateTime.Today) ? null : this.birth.Value.ToString("yyyy/MM/dd").Replace("/", "");
            string dayStartWorking = (this.dateStartWorking.Value < new DateTime(0001, 01, 01) || this.dateStartWorking.Value > new DateTime(9998, 12, 31)) ? null : this.dateStartWorking.Value.ToString("yyyy/MM/dd").Replace("/", "");
            string birthPerRel = (this.birthPerRela.Value == DateTime.Today) ? null : this.birthPerRela.Value.ToString("yyyy/MM/dd").Replace("/", "");
            string query = "INSERT INTO NHANSU(UserID, UserName, HoVaTen, NgaySinh, DiaChiThuongTru, DiaChiTamTru, CMND, GioiTinh," +
                "SoTKNganHang, TrinhDo, MaSoThue, SoHDLD, LoaiHDLD, ThoiHanHDLD, ChucDanh, TrangThaiLamViec, NgayBatDau, EmailCongTy," +
                "LuongCB, TinhTrangHonNhan, NguoiPhuTrach, SoDT, NoiLamViec, HoTenNguoiLienQuan, SDTNguoiLienQuan, DiaChiNguoiLienQuan, MoiQuanHe," +
                "NgaySinhNguoiLienQuan, GioiTinhNguoiLienQuan) VALUES ('" +
                this.txtUserID.Text.Replace("  ","") + "','" + this.txtUserName.Text.Replace("  ", "") + "',N'" + this.txtName.Text.Replace("  ", "") + "','" + birthPer + "',N'" + this.txtPermanentAdd.Text.Replace("  ", "") + "',N'" +
                this.txtTemporaryAdd.Text.Replace("  ", "") + "','" + this.txtIdentify.Text.Replace("  ", "") + "',N'" + this.txtSex.Text.Replace("  ", "") + "','" + this.txtNumBank.Text.Replace("  ", "") + "',N'" + this.level.Text.Replace("  ", "") + "','" +
                this.textTaxCode.Text.Replace("  ", "") + "','" + this.txtNumLarbourContract.Text.Replace("  ", "") + "','" + this.txtTitleLabourContract.Text.Replace("  ", "") + "','" + this.txtDateLimit.Text.Replace("  ", "") + "',N'" +
                this.txtTitle.Text.Replace("  ", "") + "',N'" + this.txtStateWorking.Text.Replace("  ", "") + "','" + dayStartWorking + "','" + this.txtEmailCo.Text.Replace("  ", "") + "'," + this.txtSalary.Text.Replace("  ", "") + ",N'" +
                this.checkTinhTrangHonNhan.SelectedItem + "',N'" + this.txtSuperviser.Text.Replace("  ", "") + "','" + this.txtPhonePer.Text.Replace("  ", "") + "',N'" + this.txtAddCo.Text.Replace("  ", "") + "',N'" + this.txtNamePerRela.Text.Replace("  ", "") + "','" +
                this.txtPhonePerRela.Text.Replace("  ", "") + "',N'" + this.txtAddPerRela.Text.Replace("  ", "") + "',N'" + this.txtRelationship.Text.Replace("  ", "") + "','" + birthPerRel + "',N'" + this.checkSexPerRela.SelectedItem + "')";
            CONNECT_DB conn = new CONNECT_DB();
            MessageBox.Show(query);
            conn.ExecuteNonQuery(query);
            Close();
        }

        private void btnRepairInfoEmployee_Click(object sender, EventArgs e)
        {
            string birthOfPersonalRelation = this.birthPerRela.Value >= new DateTime(9998, 12, 31) ? null : this.birthPerRela.Value.ToString("yyyy/MM/dd");
            string query = "UPDATE NHANSU SET UserName = '" + this.txtUserName.Text.Replace("  ","") +
                 "', HoVaTen = N'" + this.txtName.Text.Replace("  ", "") + "', NgaySinh = '" + this.birth.Value.ToString("yyyy/MM/dd").Replace("/", "") +
                 "', DiaChiThuongTru = N'" + this.txtPermanentAdd.Text.Replace("  ", "") + "', DiaChiTamTru = N'" + this.txtTemporaryAdd.Text.Replace("  ", "") +
                 "', CMND = '" + this.txtIdentify.Text.Replace("  ", "") + "', GioiTinh = N'" + this.txtSex.SelectedItem +
                 "', SoTKNganHang = '" + this.txtNumBank.Text.Replace("  ", "") + "', TrinhDo = N'" + this.level.Text.Replace("  ", "") + "', MaSoThue ='" + this.textTaxCode.Text.Replace("  ", "") +
                 "', TinhTrangHonNhan = N'" + this.checkTinhTrangHonNhan.SelectedItem + "', SoHDLD = '" + this.txtNumLarbourContract.Text.Replace("  ", "") +
                 "', LoaiHDLD = '" + this.txtTitleLabourContract.Text.Replace("  ", "") + "', ThoiHanHDLD = " + this.txtDateLimit.Text.Replace("  ", "") + ", SoDT = '" + this.txtPhonePer.Text.Replace("  ","") +
                 "', ChucDanh = N'" + this.txtTitle.Text.Replace("  ", "") + "', TrangThaiLamViec = N'" + this.txtStateWorking.Text.Replace("  ", "") + "', NguoiPhuTrach = N'" + this.txtSuperviser.Text.Replace("  ", "") +
                 "', EmailCongTy = '" + this.txtEmailCo.Text.Replace("  ", "") + "', NgayBatDau ='" + this.dateStartWorking.Value.ToString("yyyy/MM/dd").Replace("/", "") +
                 "', NoiLamViec = N'" + this.txtAddCo.Text.Replace("  ", "") + "', LuongCB = " + this.txtSalary.Text.Replace("  ", "").Replace(",", "") + ",HoTenNguoiLienQuan = N'" + this.txtNamePerRela.Text.Replace("  ", "") +
                 "', SDTNguoiLienQuan = '" + this.txtPhonePerRela.Text.Replace("  ", "") + "', DiaChiNguoiLienQuan = N'" + this.txtPhonePerRela.Text.Replace("  ", "") + "', MoiQuanHe = N'" + this.txtRelationship.Text.Replace("  ", "") +
                 "', NgaySinhNguoiLienQuan = '" + birthOfPersonalRelation + "', GioiTinhNguoiLienQuan = N'" + this.checkSexPerRela.SelectedItem +
                 "' WHERE UserID = " + this.txtUserID.Text;
            //string query = "UPDATE NHANSU SET UserName = 'toanlm', HoVaTen = N'Lư Mạnh Toàn',NgaySinh = '19980223', DiaChiThuongTru = N'49/2/4 Khánh Hội p.3 q.4 tp.HCM', DiaChiTamTru = N'49/2/4 Khánh Hôi p.3 q.4 tp.HCM',CMND = '025699517', GioiTinh = N'Nam', SoTKNganHang = '1017317271', MaSoThue = '0931421', SoHDLD = '000005',LoaiHDLD = 'TH0001', ThoiHanHDLD = 18, ChucDanh = N'dev', TrangThaiLamViec = N'Chinh Thức', NgayBatDau = '20201001',EmailCongTy = 'toanlm@allexceed.co.jp', LuongCB = 8500000, TrinhDo = N'Đai Học', NguoiPhuTrach = N'Mạch Huệ Hùng', SoDT = '0961502191', NoiLamViec = N'56-58-60 Hai Bà Trưng p.Bến Nghé q.1 tp.HCM' WHERE UserID = 00001";
            CONNECT_DB conn = new CONNECT_DB();
            conn.ExecuteNonQuery(query);
            //MessageBox.Show(query);
            conn.CloseDB();
            Close();
        }
    }
}
