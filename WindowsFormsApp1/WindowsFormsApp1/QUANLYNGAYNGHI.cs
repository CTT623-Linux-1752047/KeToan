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
    public partial class QUANLYNGAYNGHI : UserControl
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private DataTable dt;
        private List<fnDisplayOFFDayFollowCondition_Result> listOFFStaff;
        public QUANLYNGAYNGHI()
        {
            InitializeComponent();
            this.txtSearchName.GotFocus += TxtSearchName_GotFocus;
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
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                   this.listOFFStaff[i].UserName,
                                                   this.listOFFStaff[i].HoVaTen,
                                                   this.listOFFStaff[i].NgayBatDau.Value.Minute == 00 && this.listOFFStaff[i].NgayBatDau.Value.Hour == 00 ?
                                                   this.listOFFStaff[i].NgayBatDau.Value.ToString("dd/MM/yyyy") : this.listOFFStaff[i].NgayBatDau.Value.ToString("dd/MM/yyyy - [HH:mm]"),
                                                   this.listOFFStaff[i].NgayKetThuc.Value.Minute == 00 && this.listOFFStaff[i].NgayKetThuc.Value.Hour == 00 ?
                                                   this.listOFFStaff[i].NgayKetThuc.Value.ToString("dd/MM/yyyy ") : this.listOFFStaff[i].NgayKetThuc.Value.ToString("dd/MM/yyyy - [HH:mm]"),
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
            /*
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
            }*/
            CREATE_OFF_DAY frmOffDay = new CREATE_OFF_DAY();
            frmOffDay.Show();
            LoadData();
        }
        //nút cập nhật cho 1 (hoặc 1 số ) nhân viên 
        private void button1_Click(object sender, EventArgs e)
        {
            //Form formBackground = new Form();
            List<int> temp = new List<int> ();
            //Kiểm tra các dòng selected có cùng nhau hay không 
            bool checkDuplicate = false;
            for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count - 1; i++)
            {
                if (this.listOFFStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i].Cells[0].Value - 1].ID_LoaiNgayNghi !=
                    this.listOFFStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i + 1].Cells[0].Value - 1].ID_LoaiNgayNghi)
                    checkDuplicate = true;
            }
            for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count - 1; i++)
            {
                if (this.listOFFStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i].Cells[0].Value - 1].NgayBatDau !=
                    this.listOFFStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i + 1].Cells[0].Value - 1].NgayBatDau)
                    checkDuplicate = true;
            }
            for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count - 1; i++)
            {
                if (this.listOFFStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i].Cells[0].Value - 1].NgayKetThuc !=
                    this.listOFFStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i + 1].Cells[0].Value - 1].NgayKetThuc)
                    checkDuplicate = true;
            }
            if (checkDuplicate == false)
            {
                for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
                {
                    temp.Add(this.listOFFStaff[this.bunifuCustomDataGrid1.SelectedRows[i].Index].ID);
                }
                try
                {
                    using (CREATE_OFF_DAY frmOffDay = new CREATE_OFF_DAY(temp))
                    {
                        /*
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
                        */
                        frmOffDay.Show();
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Các ngày lựa chọn không hợp lệ !!! Xin nhập lại ");
            }
            LoadData();
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
        //Khi click mouse vào textbox thì text Họ và tên biến mất vì textbox ko có placeholder
        private void txtSearchName_Enter(object sender, EventArgs e)
        {
            this.txtSearchName.Text = "";
        }
        //nút tìm kiếm họ và tên 
        private void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData();
        }
        //nút xóa ngày nghỉ 
        private void btnDelete_Click(object sender, EventArgs e)
        {
            for (int i =0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
            {
                data.NHANVIEN_LOAINGAYNGHI.Remove(data.NHANVIEN_LOAINGAYNGHI.Find(this.listOFFStaff[(int)this.bunifuCustomDataGrid1.CurrentRow.Cells[0].Value - 1].ID));
                data.SaveChanges();
            }
            LoadData();
        }
        //Click double để mở màn hình chỉnh sửa thông tin 
        private void bunifuCustomDataGrid1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            Form formBackground = new Form();
            List<int> temp = new List<int>();
            for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
            {
                temp.Add(this.listOFFStaff[(int)this.bunifuCustomDataGrid1.CurrentRow.Cells[0].Value - 1].ID);
            }
            try
            {
                using (CREATE_OFF_DAY frmOffDay = new CREATE_OFF_DAY(temp))
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
            LoadData();
        }
        private void txtNgayBatDau_ValueChanged(object sender, EventArgs e)
        {
            if (this.txtNgayKetThuc.Value < this.txtNgayBatDau.Value)
            {
                MessageBox.Show("Ngày không đúng định dạng ");
                this.txtNgayBatDau.Value = this.txtNgayKetThuc.Value;
            }
            else
            {
                LoadData();
            }
        }
    }
}
