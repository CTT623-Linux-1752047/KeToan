using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.EntityFrameworkCore.Scaffolding.Metadata;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;



namespace WindowsFormsApp1
{
    public partial class NGAYNGHI : UserControl
    {
        private TinhTienLuongEntities data;
        private FormWindowState WindowState;
        private DataTable dt;
        private List<fnDisplayOFFDayFollowCondition_Result> listOFFStaff;
        public NGAYNGHI()
        {
            data = new TinhTienLuongEntities();
            InitializeComponent();
            this.txtSearchName.GotFocus += TxtSearchName_GotFocus;
            LoadData();
        }
        public void LoadData()
        {
            if (this.txtSearchName.Text == "họ và tên ....")
            {
                this.listOFFStaff = data.fnDisplayOFFDayFollowCondition(this.txtNgayBatDau.Value, this.txtNgayKetThuc.Value, "").ToList();
            }
            else
            {
                this.listOFFStaff = data.fnDisplayOFFDayFollowCondition(this.txtNgayBatDau.Value, this.txtNgayKetThuc.Value, this.txtSearchName.Text).ToList();
            }
            this.bunifuCustomDataGrid1.Rows.Clear();
            for (int i = 0; i < this.listOFFStaff.Count; i++)
            {
                this.bunifuCustomDataGrid1.Rows.Add(this.listOFFStaff[i].UserID,
                                                   this.listOFFStaff[i].UserName,
                                                   this.listOFFStaff[i].HoVaTen,
                                                   this.listOFFStaff[i].NgayBatDau.Value.ToString("dd/MM/yyyy - [HH:mm]"),
                                                   this.listOFFStaff[i].NgayKetThuc.Value.ToString("dd/MM/yyyy - [HH:mm]"),
                                                   this.listOFFStaff[i].LyDo);
            }
            
        }
        private void TxtSearchName_GotFocus(object sender, EventArgs e)
        {
            this.txtSearchName.Text = "";
            this.txtSearchName.ForeColor = Color.Maroon;
        }
        //nút tạo thêm ngày nghỉ cho nhân viên
        private void button9_Click(object sender, EventArgs e)
        {
            Form formBackground = new Form();
            try
            {
                using (CREATEOFFDAY frmOffDay = new CREATEOFFDAY())
                {
                    formBackground.StartPosition = FormStartPosition.CenterScreen;
                    formBackground.FormBorderStyle = FormBorderStyle.None;
                    formBackground.Size = new Size(1484, 811);
                    formBackground.Opacity = .80d;
                    formBackground.BackColor = Color.Black;
                    formBackground.WindowState = FormWindowState.Normal;
                    formBackground.TopMost = true;
                    formBackground.Location = this.Location;
                    formBackground.ShowInTaskbar = false;
                    formBackground.Show();

                    frmOffDay.Owner = formBackground;

                    frmOffDay.ShowDialog();
                    formBackground.Dispose();
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            LoadData();
        }
        //nút cập nhật cho 1 (hoặc 1 số ) nhân viên 
        private void button1_Click(object sender, EventArgs e)
        {
            Form formBackground = new Form();
            DataSet ds = new DataSet();
            try
            {
                using (CREATEOFFDAY frmOffDay = new CREATEOFFDAY(ds))
                {
                    formBackground.StartPosition = FormStartPosition.CenterScreen;
                    formBackground.FormBorderStyle = FormBorderStyle.None;
                    formBackground.Size = new Size(1484, 811);
                    formBackground.Opacity = .80d;
                    formBackground.BackColor = Color.Black;
                    formBackground.WindowState = FormWindowState.Normal;
                    formBackground.TopMost = true;
                    formBackground.Location = this.Location;
                    formBackground.ShowInTaskbar = false;
                    formBackground.Show();

                    frmOffDay.Owner = formBackground;

                    frmOffDay.ShowDialog();
                    formBackground.Dispose();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
        }
        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            if (this.txtNgayKetThuc.Value < this.txtNgayBatDau.Value)
            {
                MessageBox.Show("Ngày không đúng định dạng ");
                this.txtNgayKetThuc.Value = this.txtNgayBatDau.Value;
            }
            else
            {
                LoadData();
            }
        }
        private void txtSearchName_Enter(object sender, EventArgs e)
        {
            this.txtSearchName.Text = "";
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData();
        }
        private void btnDelete_Click(object sender, EventArgs e)
        {
            for (int i =0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
            {
                data.NHANVIEN_LOAINGAYNGHI.Remove(data.NHANVIEN_LOAINGAYNGHI.Find(this.listOFFStaff[this.bunifuCustomDataGrid1.SelectedRows[i].Index].ID));
                data.SaveChanges();
            }
            LoadData();
        }
    }
}
