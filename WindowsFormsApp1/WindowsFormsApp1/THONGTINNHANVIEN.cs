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
using System.Diagnostics;
using System.Data.Entity.Migrations;

namespace WindowsFormsApp1
{
    public partial class THONGTINNHANVIEN : Form
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private bool drag = false;
        private Point start_point = new Point(0, 0);
        private int id;
        private List<fnDisplayOptionStateWorking_Result> lstStatWorking;
        private List<fnDisplayOptionTitle_Result> lstTitle;

        public THONGTINNHANVIEN()
        {
            InitializeComponent();
            this.btnAddInfoEmployee.Show();
            this.btnRepairInfoEmployee.Hide();
            this.ManPicture.Visible = false;
            this.pictureBox2.Visible = false;

            this.lstStatWorking = data.fnDisplayOptionStateWorking().ToList();
            ShowOption();
        }
        public THONGTINNHANVIEN(int id)
        {
            this.id = id;
            InitializeComponent();
            this.ManPicture.Visible = false;
            this.pictureBox2.Visible = false;
            this.btnAddInfoEmployee.Hide();
            this.btnRepairInfoEmployee.Show();

            ShowOption();

            //fnDisplayStaffFollowID_Result temp = data.NHANSUs.Find(id).;
            NHANSU temp = data.NHANSUs.Find(id);
            DisplayData(temp);
            
        }
        public void ShowOption()
        {
            this.lstStatWorking = data.fnDisplayOptionStateWorking().ToList();
            this.lstBoxStateWorking.DataSource = this.lstStatWorking;
            this.lstBoxStateWorking.DisplayMember = "TenTrangThai";
            this.lstBoxStateWorking.ValueMember = "ID";

            this.lstTitle = data.fnDisplayOptionTitle().ToList();
            this.lstBoxTitle.DataSource = this.lstTitle;
            this.lstBoxTitle.DisplayMember = "TenChucDanh";
            this.lstBoxTitle.ValueMember = "ID";

            var bindingSource1 = new BindingSource();
            
            this.lstBoxSupervisor.DataSource = data.NHANSUs.SqlQuery("SELECT * FROM NHANSU WHERE NHANSU.ChucDanh != 7").ToList<NHANSU>();
            this.lstBoxSupervisor.DisplayMember = "HoVaTen";
            this.lstBoxSupervisor.ValueMember = "ID";
            
        }

        //btn close windows 
        private void button1_Click_1(object sender, EventArgs e)
        {
            Close();
        }
        public void DisplayData(NHANSU a)
        {
            //điền các trường vào form
            //thông tin nhân viên
           
            this.txtName.Text = a.HoVaTen; //**
            this.txtIdentify.Text = a.CMND;
            this.txtAddressTemp.Text = a.DiaChiTamTru;
            this.txtAddressPermanent.Text = a.DiaChiThuongTru;
            this.txtLevel.Text = a.TrinhDo;
            this.txtNumBank.Text = a.SoTKNganHang;
            this.txtBirth.Value = (DateTime)a.NgaySinh;
            this.txtPhonePer.Text = a.SoDT;
            
            if (a.TinhTrangHonNhan == "Đã kết hôn")
            {
                this.ComboBoxStateMarie.SelectedIndex = 1;
            }
            else
            {
                this.ComboBoxStateMarie.SelectedIndex = 0;
            }

            //thông tin người liên quan
            this.txtNamePerRela.Text = a.HoTenNguoiLienQuan;
            this.txtAddPerRela.Text = a.DiaChiNguoiLienQuan;
            this.txtPhonePerRela.Text = a.SDTNguoiLienQuan;
            this.birthPerRela.Value = (DateTime.Compare(new DateTime(1800, 01, 01), (DateTime)a.NgaySinhNguoiLienQuan) < 0) ? (DateTime)a.NgaySinhNguoiLienQuan : new DateTime(9998, 12, 31);

            if (a.GioiTinhNguoiLienQuan == "Nam")
                this.checkSexPerRela.SelectedIndex = 0;
            else if (String.Compare(a.GioiTinhNguoiLienQuan, "Nữ", true) == 0)
                this.checkSexPerRela.SelectedIndex = 1;
            else
                this.checkSexPerRela.SelectedIndex = 2;
            if(a.GioiTinh == null)
            {
                this.txtSex.SelectedIndex = 2;
            }
            else
            {
                if(a.GioiTinh.Replace(" ","") == "Nam")
                {
                    this.txtSex.SelectedIndex = 0;
                    this.ManPicture.Show();
                    this.pictureBox2.Hide();
                }
                else
                {
                    this.txtSex.SelectedIndex = 1;
                    this.ManPicture.Hide();
                    this.pictureBox2.Show();
                }
            }

            this.txtRelationship.Text = a.MoiQuanHe;

            //thông tin công việc 
            this.txtUserID.Text = a.UserID;
            this.txtUserID.Enabled = false;
            this.txtUserName.Text = a.UserName;
            this.lstBoxSupervisor.SelectedValue = a.NguoiPhuTrach == null ? -1 : a.NguoiPhuTrach;
            this.lstBoxTitle.SelectedValue = a.ChucDanh == null ? -1 : Convert.ToInt32(a.ChucDanh);
            this.lstBoxStateWorking.SelectedValue = a.TrangThaiLamViec == null ? -1 : a.TrangThaiLamViec;
            this.txtEmailCo.Text = a.EmailCongTy;
            this.txtAddCo.Text = a.NoiLamViec;
            this.txtSalary.Text =  ((decimal) a.LuongCB).ToString("#,##0.###");
            this.txtNumLarbourContract.Text = a.SoHDLD;
            this.txtTitleLabourContract.Text = a.LoaiHDLD;
            this.txtDateLimit.Text = a.ThoiHanHDLD + "  Tháng";
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
                    DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
                    if (confirm == DialogResult.Yes)
                    {
                        NHANSU temp = data.NHANSUs.SingleOrDefault(id => id.ID == this.id);

                        if (temp != null)
                        {
                            temp.HoVaTen = LoadDataForms().HoVaTen;
                            temp.UserID = LoadDataForms().UserID;
                            temp.UserName = LoadDataForms().UserName;
                            temp.EmailCongTy = LoadDataForms().EmailCongTy;

                            temp.DiaChiThuongTru = LoadDataForms().DiaChiThuongTru;
                            temp.DiaChiTamTru = LoadDataForms().DiaChiTamTru;
                            temp.CMND = LoadDataForms().CMND;
                            temp.SoDT = LoadDataForms().SoDT;

                            temp.TinhTrangHonNhan = LoadDataForms().TinhTrangHonNhan;
                            temp.NgaySinh = LoadDataForms().NgaySinh;
                            temp.GioiTinh = LoadDataForms().GioiTinh;
                            temp.MaSoThue = LoadDataForms().MaSoThue;
                            temp.SoTKNganHang = LoadDataForms().SoTKNganHang;

                            temp.HoTenNguoiLienQuan = LoadDataForms().HoTenNguoiLienQuan;
                            temp.DiaChiNguoiLienQuan = LoadDataForms().DiaChiNguoiLienQuan;
                            temp.MoiQuanHe = LoadDataForms().MoiQuanHe;
                            temp.SDTNguoiLienQuan = LoadDataForms().SDTNguoiLienQuan;
                            temp.GioiTinhNguoiLienQuan = LoadDataForms().GioiTinhNguoiLienQuan;
                            temp.NgaySinhNguoiLienQuan = LoadDataForms().NgaySinhNguoiLienQuan;

                            temp.TrinhDo = LoadDataForms().TrinhDo;
                            //Đọc thông tin công việc từ forms 
                            temp.ChucDanh = LoadDataForms().ChucDanh;
                            temp.NoiLamViec = LoadDataForms().NoiLamViec;
                            temp.NguoiPhuTrach = LoadDataForms().NguoiPhuTrach;
                            temp.TrangThaiLamViec = LoadDataForms().TrangThaiLamViec;

                            temp.LuongCB = LoadDataForms().LuongCB;
                            temp.LoaiHDLD = LoadDataForms().LoaiHDLD;
                            temp.SoHDLD = LoadDataForms().SoHDLD;
                            temp.ThoiHanHDLD = LoadDataForms().ThoiHanHDLD;

                            temp.NgayBatDau = LoadDataForms().NgayBatDau;
                            data.SaveChanges();
                        }

                        Close();
                        MessageBox.Show("Cập nhật thành công ");
                    }
                }
            }
        }
        private NHANSU LoadDataForms()
        {
            NHANSU a = new NHANSU();
            //Đọc thông tin nhân viên từ forms 
                a.HoVaTen = this.txtName.Text;
                a.UserID = this.txtUserID.Text;
                a.UserName = this.txtUserName.Text;
                a.EmailCongTy = this.txtEmailCo.Text == "" || this.txtEmailCo.Text == null ? null : this.txtEmailCo.Text;

                a.DiaChiThuongTru = (this.txtAddressPermanent.Text == "" || this.txtAddressPermanent == null) ? null : this.txtAddressPermanent.Text ;
                a.DiaChiTamTru = this.txtAddressTemp.Text == "" || this.txtAddressTemp == null ? null : this.txtAddressTemp.Text;
                a.CMND = this.txtIdentify.Text == "" || this.txtIdentify.Text == null ? null : this.txtIdentify.Text;
                a.SoDT = this.txtPhonePer.Text == "" || this.txtPhonePer.Text == null ? null : this.txtPhonePer.Text;

                a.TinhTrangHonNhan = this.ComboBoxStateMarie.SelectedIndex == -1 ? null : this.ComboBoxStateMarie.SelectedItem.ToString();
                a.NgaySinh = this.txtBirth.Value; //*****
                a.GioiTinh = this.txtSex.SelectedIndex == -1 || this.txtSex.SelectedIndex == 2 ? null : this.txtSex.SelectedItem.ToString() ;
                a.MaSoThue = this.textTaxCode.Text == "" || this.textTaxCode.Text == null ? null : this.textTaxCode.Text;
                a.SoTKNganHang = this.txtNumBank.Text == "" || this.txtNumBank.Text == null ? null : this.txtNumBank.Text;

                a.HoTenNguoiLienQuan = this.txtNamePerRela.Text == "" || this.txtNamePerRela.Text == null ? null : this.txtNamePerRela.Text;
                a.DiaChiNguoiLienQuan = this.txtAddPerRela.Text == "" || this.txtAddPerRela.Text == null ? null : this.txtAddPerRela.Text;
                a.MoiQuanHe = this.txtRelationship.SelectedIndex == -1 ? null : this.txtRelationship.SelectedItem.ToString();
                a.SDTNguoiLienQuan = this.txtPhonePer.Text == "" || this.txtPhonePer.Text == null ? null : this.txtPhonePer.Text;
                a.GioiTinhNguoiLienQuan = this.checkSexPerRela.SelectedIndex == -1 || this.checkSexPerRela.SelectedIndex == 2 ? null : this.checkSexPerRela.SelectedItem.ToString();
                a.NgaySinhNguoiLienQuan = this.birthPerRela.Value == DateTime.Now ? new DateTime(1800, 01, 01) : this.birthPerRela.Value;//*****

                a.TrinhDo = this.txtLevel.Text == "" || this.txtLevel == null ? null : this.txtLevel.Text;
                //Đọc thông tin công việc từ forms 
                a.ChucDanh = Convert.ToInt32(this.lstBoxTitle.SelectedValue) == 0 ? 6 : Convert.ToInt32(this.lstBoxTitle.SelectedValue);
                a.NoiLamViec = this.txtAddCo.Text == "" || this.txtAddCo.Text == null ? null : this.txtAddCo.Text;
                a.NguoiPhuTrach = Convert.ToInt32(this.lstBoxSupervisor.SelectedValue) == 0 ? -1 : Convert.ToInt32(this.lstBoxSupervisor.SelectedValue);
                a.TrangThaiLamViec = Convert.ToInt32(this.lstBoxStateWorking.SelectedValue);

                a.LuongCB = this.txtSalary.Text == "" || this.txtSalary.Text == null ? 0 : decimal.Parse(this.txtSalary.Text.Replace(",", ""));
                a.LoaiHDLD = this.txtTitleLabourContract.Text == "" || this.txtTitleLabourContract.Text == null ? null : this.txtTitleLabourContract.Text;
                a.SoHDLD = this.txtNumLarbourContract.Text == "" || this.txtNumLarbourContract.Text == null ? null : this.txtNumLarbourContract.Text;
                a.ThoiHanHDLD = this.txtDateLimit.Text == "" || this.txtDateLimit.Text == null ? 0 : Convert.ToInt32(this.txtDateLimit.Text.Replace(" Tháng", ""));

                a.NgayBatDau = this.dateStartWorking.Value > new DateTime(1970, 01, 01) ? DateTime.Now : this.dateStartWorking.Value;//*****
                
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
                    DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
                    if (confirm == DialogResult.Yes)
                    {
                        NHANSU temp = LoadDataForms();
                        data.NHANSUs.Add(temp);
                        data.SaveChanges();
                        Close();
                        MessageBox.Show("Thêm thành công ");
                    }
                }
            }
        }
        //thay đổi con số lương có dấy phẩy ngay khi người dùng nhập số 
        private void txtSalary_TextChanged(object sender, EventArgs e)
        {
            System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-US");
            decimal value = decimal.Parse(this.txtSalary.Text, System.Globalization.NumberStyles.AllowThousands);
            this.txtSalary.Text = String.Format(culture, "{0:N0}", value);
            this.txtSalary.Select(this.txtSalary.Text.Length, 0);
        }

    }
}
