using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Globalization;
using System.Runtime.CompilerServices;

namespace WindowsFormsApp1
{
    public partial class THONGTINNHANVIEN : Form
    {
        private bool drag = false;
        private Point start_point = new Point(0, 0);
        private int id;
        public THONGTINNHANVIEN()
        {
            InitializeComponent();
            this.btnAddInfoEmployee.Show();
            this.btnRepairInfoEmployee.Hide();
            this.pictureBox1.Visible = false;
            this.pictureBox2.Visible = false;
        }
        public THONGTINNHANVIEN(int id)
        {
            this.id = id;
            InitializeComponent();
            this.pictureBox1.Visible = false;
            this.pictureBox2.Visible = false;
            this.btnAddInfoEmployee.Hide();
            this.btnRepairInfoEmployee.Show();
            CONNECT_DB conn = new CONNECT_DB();
            string query = "SELECT * FROM NHANSU WHERE ID = " + id;
            DataSet ds = conn.GetDBToDS(query, "Employee");
            conn.CloseDB();
            DataTable dt = ds.Tables["Employee"];
            NHANVIEN a = new NHANVIEN(dt.Rows[0]);
            DisplayData(a);
            
        }
        //btn close windows 
        private void button1_Click_1(object sender, EventArgs e)
        {
            Close();
        }
        public void DisplayData(NHANVIEN a)
        {
            //điền các trường vào form
            //thông tin nhân viên
            this.txtName.Text = a.HOVATEN;
            this.txtIdentify.Text = a.CMND;
            this.txtAddressTemp.Text = a.DIACHITAMTRU;
            this.txtAddressPermanent.Text = a.DIACHITHUONGTRU;
            this.txtLevel.Text = a.TRINHDO;
            this.txtNumBank.Text = a.SOTK;
            this.txtBirth.Value = a.NGAYSINH;
            this.txtPhonePer.Text = a.SODT;
            
            if (a.TINHTRANGHONNHAN == "Đã kết hôn")
            {
                this.ComboBoxStateMarie.SelectedIndex = 1;
            }
            else
            {
                this.ComboBoxStateMarie.SelectedIndex = 0;
            }
            this.txtPhonePer.Text = a.SODT;

            //thông tin người liên quan
            this.txtNamePerRela.Text = a.HOTENNLQ;
            this.txtAddPerRela.Text = a.DIACHINLQ;
            this.txtPhonePerRela.Text = a.SDTNLQ;
            this.birthPerRela.Value = (DateTime.Compare(new DateTime(1800,01,01), a.NGAYSINHNLQ) < 0) ? a.NGAYSINHNLQ : new DateTime(9998, 12, 31);

            if (a.GIOITINHNLQ == "Nam")
                this.checkSexPerRela.SelectedIndex = 0;
            else if (String.Compare(a.GIOITINHNLQ, "Nữ", true) == 0)
                this.checkSexPerRela.SelectedIndex = 1;
            else
                this.checkSexPerRela.SelectedIndex = 2;

            if (a.GIOITINH == "Nam")
            {
                this.pictureBox1.Visible = true;
                this.pictureBox2.Visible = false;
                this.txtSex.SelectedIndex = 0;
            }
            else if (String.Compare(a.GIOITINH,"Nữ",true) == 0)
            {
                this.pictureBox2.Visible = true;
                this.pictureBox1.Visible = false;
                this.txtSex.SelectedIndex = 1;
            }
            else
                this.txtSex.SelectedIndex = 2;
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
            this.txtDateLimit.Text = a.THOIHANLD + "  Tháng";
        }
        // ham thuc hien chuc nang keo tha khi set boder form = none (Khi set thuoc tinh nay form ko the di chuyen vi tri)
        protected override void WndProc(ref Message m)
        {
            switch (m.Msg)
            {
                case 0x84:
                    base.WndProc(ref m);
                    if ((int)m.Result == 0x1)
                        m.Result = (IntPtr)0x2;
                    return;
            }

            base.WndProc(ref m);
        }
        private void THONGTINNHANVIEN_MouseDown(object sender, MouseEventArgs e)
        {
            drag = true;
            start_point = new Point(e.X, e.Y);
        }

        private void THONGTINNHANVIEN_MouseUp(object sender, MouseEventArgs e)
        {
            drag = false;
        }

        private void THONGTINNHANVIEN_MouseMove(object sender, MouseEventArgs e)
        {
            if (drag)
            {
                Point p = PointToScreen(e.Location);
                this.Location = new Point(p.X - start_point.X, p.Y - start_point.Y);
            }
        }

        private void btnRepairInfoEmployee_Click(object sender, EventArgs e)
        {
            string birthPer = (this.txtBirth.Value == DateTime.Today) ? null : this.txtBirth.Value.ToString("yyyy/MM/dd").Replace("/", "");
            string dayStartWorking = (this.dateStartWorking.Value < new DateTime(0001, 01, 01) || this.dateStartWorking.Value > new DateTime(9998, 12, 31)) ? null : this.dateStartWorking.Value.ToString("yyyy/MM/dd").Replace("/", "");
            string birthOfPersonalRelation = this.birthPerRela.Value == new DateTime(9998, 12, 31) ? "NULL" : this.birthPerRela.Value.ToString("yyyy/MM/dd").Replace("/", "") ;
            string sexPersonalRelation = this.checkSexPerRela.SelectedItem == "Không xác định" ? null : this.checkSexPerRela.SelectedItem.ToString(); 
            string sexPer = this.txtSex.SelectedItem == "Không xác định" ? null : this.txtSex.SelectedItem.ToString();
            string query = "UPDATE NHANSU SET UserName = '" + this.txtUserName.Text.Replace("  ", "") +
                 "', HoVaTen = N'" + this.txtName.Text.Replace("  ", "") + "', NgaySinh = '" + birthPer +
                 "', DiaChiThuongTru = N'" + this.txtAddressPermanent.Text.Replace("  ", "") + "', DiaChiTamTru = N'" + this.txtAddressTemp.Text.Replace("  ", "") +
                 "', CMND = '" + this.txtIdentify.Text.Replace("  ", "") + "', GioiTinh = N'" + sexPer +
                 "', SoTKNganHang = '" + this.txtNumBank.Text.Replace("  ", "") + "', TrinhDo = N'" + this.txtLevel.Text.Replace("  ", "") + "', MaSoThue ='" + this.textTaxCode.Text.Replace("  ", "") +
                 "', TinhTrangHonNhan = N'" + this.ComboBoxStateMarie.SelectedItem + "', SoHDLD = '" + this.txtNumLarbourContract.Text.Replace("  ", "") +
                 "', LoaiHDLD = '" + this.txtTitleLabourContract.Text.Replace("  ", "") + "', ThoiHanHDLD = " + this.txtDateLimit.Text.Replace("  ", "").Replace("Tháng", "") + ", SoDT = '" + this.txtPhonePer.Text.Replace("  ", "") +
                 "', ChucDanh = N'" + this.txtTitle.Text.Replace("  ", "") + "', TrangThaiLamViec = N'" + this.txtStateWorking.Text.Replace("  ", "") + "', NguoiPhuTrach = N'" + this.txtSuperviser.Text.Replace("  ", "") +
                 "', EmailCongTy = '" + this.txtEmailCo.Text.Replace("  ", "") + "', NgayBatDau ='" + dayStartWorking +
                 "', NoiLamViec = N'" + this.txtAddCo.Text.Replace("  ", "") + "', LuongCB = " + this.txtSalary.Text.Replace("  ", "").Replace(",", "") + ",HoTenNguoiLienQuan = N'" + this.txtNamePerRela.Text.Replace("  ", "") +
                 "', SDTNguoiLienQuan = '" + this.txtPhonePerRela.Text.Replace("  ", "") + "', DiaChiNguoiLienQuan = N'" + this.txtPhonePerRela.Text.Replace("  ", "") + "', MoiQuanHe = N'" + this.txtRelationship.Text.Replace("  ", "") +
                 "', NgaySinhNguoiLienQuan = '" + birthOfPersonalRelation + "', GioiTinhNguoiLienQuan = N'" + sexPersonalRelation +
                 "' WHERE ID = " + this.id;
            CONNECT_DB conn = new CONNECT_DB();
            DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
            if (confirm == DialogResult.Yes)
            {
                conn.ExecuteNonQuery(query);
                conn.CloseDB();
                Close();
            }
        }
        private NHANVIEN LoadDataForms()
        {
            NHANVIEN a = new NHANVIEN();
            //Đọc thông tin nhân viên từ forms 
                a.HOVATEN = "N'" + this.txtName.Text + "'";
                a.USERID = "'" + this.txtUserID.Text + "'";
                a.USERNAME = "'" + this.txtUserName.Text + "'";
                a.EMAILCONGTY = this.txtEmailCo.Text == "" || this.txtEmailCo.Text == null ? "NULL" : "'" + this.txtEmailCo.Text + "'";

                a.DIACHITHUONGTRU = (this.txtAddressPermanent.Text == "" || this.txtAddressPermanent == null) ? "NULL" : "N'" + this.txtAddressPermanent.Text + "'";
                a.DIACHITAMTRU = this.txtAddressTemp.Text == "" || this.txtAddressTemp == null ? "NULL" : "N'" + this.txtAddressTemp.Text + "'";
                a.CMND = this.txtIdentify.Text == "" || this.txtIdentify.Text == null ? "NULL" : "'" + this.txtIdentify.Text + "'";
                a.SODT = this.txtPhonePer.Text == "" || this.txtPhonePer.Text == null ? "NULL" : "'" + this.txtPhonePer.Text + "'";

                a.TINHTRANGHONNHAN = this.ComboBoxStateMarie.SelectedIndex == -1 ? "NULL" : "N'" + this.ComboBoxStateMarie.SelectedItem.ToString() + "'";
                a.NGAYSINH = this.txtBirth.Value; //*****
                a.GIOITINH = this.txtSex.SelectedIndex == -1 || this.txtSex.SelectedIndex == 2 ? "NULL" : "N'" + this.txtSex.SelectedItem.ToString() + "'";
                a.MASOTHUE = this.textTaxCode.Text == "" || this.textTaxCode.Text == null ? "NULL" : "'" + this.textTaxCode.Text + "'";
                a.SOTK = this.txtNumBank.Text == "" || this.txtNumBank.Text == null ? "NULL" : "'" + this.txtNumBank.Text + "'";

                a.HOTENNLQ = this.txtNamePerRela.Text == "" || this.txtNamePerRela.Text == null ? "NULL" : "N'" + this.txtNamePerRela.Text + "'";
                a.DIACHINLQ = this.txtAddPerRela.Text == "" || this.txtAddPerRela.Text == null ? "NULL" : "N'" + this.txtAddPerRela.Text + "'";
                a.MOIQUANHE = this.txtRelationship.SelectedIndex == -1 ? "NULL" : "N'" + this.txtRelationship.SelectedItem.ToString() + "'";
                a.SDTNLQ = this.txtPhonePer.Text == "" || this.txtPhonePer.Text == null ? "NULL" : "'" + this.txtPhonePer.Text + "'";
                a.GIOITINHNLQ = this.checkSexPerRela.SelectedIndex == -1 || this.checkSexPerRela.SelectedIndex == 2 ? "NULL" : "N'" + this.checkSexPerRela.SelectedItem.ToString() + "'";
                a.NGAYSINHNLQ = this.birthPerRela.Value == DateTime.Now ? new DateTime(1800, 01, 01) : this.birthPerRela.Value;//*****

                a.TRINHDO = this.txtLevel.Text == "" || this.txtLevel == null ? "NULL" : "N'" + this.txtLevel.Text + "'";
                //Đọc thông tin công việc từ forms 
                a.CHUCDANH = this.txtTitle.Text == "" || this.txtTitle.Text == null ? "NULL" : "N'" + this.txtTitle.Text + "'";
                a.NOILAMVIEC = this.txtAddCo.Text == "" || this.txtAddCo.Text == null ? "NULL" : "N'" + this.txtAddCo.Text + "'";
                a.NGUOIPHUTRACH = this.txtSuperviser.Text == "" || this.txtSuperviser.Text == null ? "NULL" : "N'" + this.txtSuperviser.Text + "'";
                a.TRANGTHAILAMVIEC = this.txtStateWorking.Text == "" || this.txtStateWorking.Text == null ? "NULL" : "N'" + this.txtStateWorking.Text + "'";

                a.LUONGCB = this.txtSalary.Text == "" || this.txtSalary.Text == null ? 0 : decimal.Parse(this.txtSalary.Text.Replace(",", ""));
                a.LOAIHDLD = this.txtTitleLabourContract.Text == "" || this.txtTitleLabourContract.Text == null ? "NULL" : "'" + this.txtTitleLabourContract.Text + "'";
                a.SOHDLD = this.txtNumLarbourContract.Text == "" || this.txtNumLarbourContract.Text == null ? "NULL" : "'" + this.txtNumLarbourContract.Text + "'";
                a.THOIHANLD = this.txtDateLimit.Text == "" || this.txtDateLimit.Text == null ? "NULL" : "'" + this.txtDateLimit.Text + "'";

                a.NGAYBATDAU = this.dateStartWorking.Value > new DateTime(1970, 01, 01) ? DateTime.Now : this.dateStartWorking.Value;//*****
                
            return a;
        }
        private void btnAddInfoEmployee_Click(object sender, EventArgs e)
        {
            //Kiem tra tuoi cua nhan vien moi da 18 tuoi chưa
            if (DateTime.Today.Year - this.txtBirth.Value.Year < 18)
                MessageBox.Show("Ngày sinh không hợp lệ !!!!!");
            else
            {
                bool flag;
                flag = (this.txtName.Text == "" || this.txtName.Text == null) ||
                       (this.txtUserID.Text == "" || this.txtUserID.Text == null) ||
                       (this.txtUserName.Text == "" || this.txtUserName == null);                   
                if (flag)
                {
                    MessageBox.Show("Họ tên , UserID, User Name không được bỏ trống !!!!!!");
                }
                else
                {
                    NHANVIEN temp = LoadDataForms();
                    string query = "INSERT INTO NHANSU(UserID, UserName, HoVaTen, NgaySinh, DiaChiThuongTru, DiaChiTamTru, CMND, GioiTinh," +
                    "SoTKNganHang, TrinhDo, MaSoThue, SoHDLD, LoaiHDLD, ThoiHanHDLD, ChucDanh, TrangThaiLamViec, NgayBatDau, EmailCongTy," +
                    "LuongCB, TinhTrangHonNhan, NguoiPhuTrach, SoDT, NoiLamViec, HoTenNguoiLienQuan, SDTNguoiLienQuan, DiaChiNguoiLienQuan, MoiQuanHe," +
                    "NgaySinhNguoiLienQuan, GioiTinhNguoiLienQuan) VALUES (" +
                    temp.USERID + "," + temp.USERNAME + "," + temp.HOVATEN + ",'" +
                    temp.NGAYSINH.ToString("yyyy/MM/dd").Replace("/", "") + "'," + temp.DIACHITHUONGTRU + "," +
                    temp.DIACHITAMTRU + "," + temp.CMND + "," + temp.GIOITINH + "," + temp.SOTK + "," +
                    temp.TRINHDO + "," + temp.MASOTHUE + "," + temp.SOHDLD + "," +
                    temp.LOAIHDLD + "," + temp.THOIHANLD.ToString() + "," +
                    temp.CHUCDANH + "," + temp.TRANGTHAILAMVIEC + ",'" + temp.NGAYBATDAU.ToString("yyyy/MM/dd").Replace("/", "") + "'," + temp.EMAILCONGTY + "," +
                    temp.LUONGCB + "," + temp.TINHTRANGHONNHAN + "," + temp.NGUOIPHUTRACH + "," + temp.SODT + "," +
                    temp.NOILAMVIEC + "," + temp.HOTENNLQ + "," + temp.SDTNLQ + "," + temp.DIACHINLQ + "," +
                    temp.MOIQUANHE + ",'" + temp.NGAYSINHNLQ.ToString("yyyy/MM/dd").Replace("/", "") + "'," + temp.GIOITINHNLQ + ")";
                    CONNECT_DB conn = new CONNECT_DB();
                    MessageBox.Show(query);
                    conn.ExecuteNonQuery(query);
                    Close();
                }
            }
        }
        private void txtSalary_TextChanged(object sender, EventArgs e)
        {
            System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-US");
            decimal value = decimal.Parse(this.txtSalary.Text, System.Globalization.NumberStyles.AllowThousands);
            this.txtSalary.Text = String.Format(culture, "{0:N0}", value);
            this.txtSalary.Select(this.txtSalary.Text.Length, 0);
        }
    }
}
