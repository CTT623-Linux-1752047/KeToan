using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace WindowsFormsApp1
{
    public partial class CREATEOFFDAY : Form
    {
        private TinhTienLuongEntities data;
        private List<fnDisplayStaffFollowName_Result> listEmployeeTemp;
        private List<fnDisplayTitleOFFDay_Result> listTitleOFFDay;
        private List<int> lstIDNhanVienNgayNghi;
        private List<int> lstIDNhanVien = new List<int>();
        public CREATEOFFDAY()
        {
            InitializeComponent();
            this.btnTaoNgay.Show();
            this.btnCapNhat.Hide();
            data = new TinhTienLuongEntities();
            this.listTitleOFFDay = data.fnDisplayTitleOFFDay().ToList();
            this.TitleOFFDay.DataSource = data.LOAINGAYNGHIs.ToList();
            this.TitleOFFDay.DisplayMember = "TenNgayNghi";
            this.TitleOFFDay.ValueMember = "ID";
           
            ShowInfoEmployee();
        }
        public CREATEOFFDAY(List<int> lstIDNhanVienNgayNghi)
        {
            this.lstIDNhanVienNgayNghi = lstIDNhanVienNgayNghi;
            data = new TinhTienLuongEntities();
            InitializeComponent();
            this.btnCapNhat.Show();
            this.btnTaoNgay.Hide();
            this.txtSearchBar.Enabled = false;
            this.btnSearch.Enabled = false;

            this.listTitleOFFDay = data.fnDisplayTitleOFFDay().ToList();
            this.TitleOFFDay.DataSource = this.listTitleOFFDay;
            this.TitleOFFDay.DisplayMember = "TenNgayNghi";
            this.TitleOFFDay.ValueMember = "ID";

            //Show info staff on datagridview 
            int i = 1;
            foreach(int id in lstIDNhanVienNgayNghi)
            {
                this.bunifuCustomDataGrid1.Rows.Add(true,
                                                    i,
                                                    data.NHANSUs.Find(data.NHANVIEN_LOAINGAYNGHI.Find(id).ID_NhanVien).UserName,
                                                    data.NHANSUs.Find(data.NHANVIEN_LOAINGAYNGHI.Find(id).ID_NhanVien).HoVaTen,
                                                    data.NHANSUs.Find(data.NHANVIEN_LOAINGAYNGHI.Find(id).ID_NhanVien).SoNgayNghiPhep
                                                    );
                this.bunifuCustomDataGrid1.DefaultCellStyle.ForeColor = Color.FromArgb(64, 64, 64);
                this.lstIDNhanVien.Add((int)data.NHANVIEN_LOAINGAYNGHI.Find(id).ID_NhanVien);
                i++;
            }
            //Khi fill data vao form phải fill TitleOFFDay trước vì TitleOFFDay có sự kiện text change 
            //khi tiltleOFFDay được lựa chọn nó sẽ làm thay đổi các thông tin đã nhập trước đó 
            this.TitleOFFDay.SelectedValue = data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).ID_LoaiNgayNghi;

            this.txtNgayKetThuc.Value = data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).NgayKetThuc.GetValueOrDefault();
            this.txtNgayBatDau.Value = data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).NgayBatDau.GetValueOrDefault();

            if(data.LOAINGAYNGHIs.Find(data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).ID_LoaiNgayNghi.GetValueOrDefault()).LoaiNgayNghi1.Replace(" ","") == "CoPhep")
                this.TypeOFFDay.SetSelected(0, true);
            else
                this.TypeOFFDay.SetSelected(1, true);

            this.txtNameOfOFFDay.Text = data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).LyDo;

            if ((data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).NgayBatDau.GetValueOrDefault().Minute != 00 &&
               data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).NgayBatDau.GetValueOrDefault().Hour != 00) ||
               (data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).NgayKetThuc.GetValueOrDefault().Minute != 00 &&
               data.NHANVIEN_LOAINGAYNGHI.Find(lstIDNhanVienNgayNghi[0]).NgayKetThuc.GetValueOrDefault().Hour != 00))
                this.checkBoxOFFAllDay.Checked = false;
            else
                this.checkBoxOFFAllDay.Checked = true;
        }
        public void ShowInfoEmployee()
        {
            this.bunifuCustomDataGrid1.Rows.Clear();
            this.listEmployeeTemp = data.fnDisplayStaffFollowName(this.txtSearchBar.Text).ToList();
            for(int i = 0; i < this.listEmployeeTemp.Count; i++)
            {
                this.bunifuCustomDataGrid1.Rows.Add(false,
                                                    i + 1,
                                                    this.listEmployeeTemp[i].UserName,
                                                    this.listEmployeeTemp[i].HoVaTen,
                                                    this.listEmployeeTemp[i].SoNgayNghiPhep
                                                    );
                this.bunifuCustomDataGrid1.DefaultCellStyle.ForeColor = Color.FromArgb(64, 64, 64);
            }

        }
        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (this.checkBoxOFFAllDay.Checked == true)
            {
                this.txtNgayBatDau.CustomFormat = "dd-MM-yyyy";
                this.txtNgayKetThuc.CustomFormat = "dd-MM-yyyy";
                DateTime tempStartDay = this.txtNgayBatDau.Value;
                this.txtNgayBatDau.Value = new DateTime(tempStartDay.Year, tempStartDay.Month, tempStartDay.Day, 00, 00, 00);
                DateTime tempEndDay = this.txtNgayKetThuc.Value;
                this.txtNgayKetThuc.Value = new DateTime(tempEndDay.Year, tempEndDay.Month, tempEndDay.Day, 00, 00, 00);
            }
            else
            {
                this.txtNgayBatDau.CustomFormat = "dd-MM-yyyy HH:mm";
                this.txtNgayKetThuc.CustomFormat = "dd-MM-yyyy HH:mm";
            }
        }
        private void btnSearch_Click(object sender, EventArgs e)
        {
            ShowInfoEmployee();
        }
        //thực hiện click checkbox từng dòng 
        private void bunifuCustomDataGrid1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.ColumnIndex == 0)
            {
                DataGridViewCheckBoxCell temp = (DataGridViewCheckBoxCell)this.bunifuCustomDataGrid1.Rows[e.RowIndex].Cells[e.ColumnIndex];
                temp.Value = !Convert.ToBoolean(temp.Value);
            }
        }
        private void typeOffDay_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.TitleOFFDay.SelectedIndex > -1)
            {
                this.txtNameOfOFFDay.Text = this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].TenNgayNghi;
                if (this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].LoaiNgayNghi.Replace(" ","") == "CoPhep")
                {
                    this.TypeOFFDay.SetSelected(0, true);
                }
                else
                {
                    this.TypeOFFDay.SetSelected(1, true);
                }
                if( this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].ThoiGian != null)
                {
                    checkBoxOFFAllDay.Checked = true;
                    this.txtNgayKetThuc.Value = this.txtNgayBatDau.Value.AddDays((double)this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].ThoiGian);
                }
                else
                {
                    checkBoxOFFAllDay.Checked = false;
                }
            }
        }
        private void btnTaoNgay_Click(object sender, EventArgs e)
        {
            if (this.txtNgayKetThuc.Value >= this.txtNgayBatDau.Value)
            {
                DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
                if (confirm == DialogResult.Yes)
                {
                    using (var transaction = data.Database.BeginTransaction())
                    {
                        try
                        {
                            string NgayBatDau = this.txtNgayBatDau.Value.ToString("yyyy/MM/dd").Replace(" ", "").Replace("/", "");
                            string NgayKetThuc = this.txtNgayKetThuc.Value.ToString("yyyy/MM/dd").Replace(" ", "").Replace("/", "");
                            int j;
                            int result = 0 ;
                            for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
                            {
                                
                                 result = data.spCreateOFFDayForStaff( this.listEmployeeTemp[this.bunifuCustomDataGrid1.SelectedRows[i].Index].ID,
                                                                        this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].ID,
                                                                        this.txtNgayBatDau.Value,
                                                                        this.txtNgayKetThuc.Value,
                                                                        this.txtNameOfOFFDay.Text
                                                                        );
                            }
                            if(result != -1)
                                transaction.Commit();
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            MessageBox.Show("Thêm thất bại !!! ");
                        }
                    }
                    Close();
                }
            }
            else
            {
                MessageBox.Show("Ngày nghỉ không hợp lệ !!!! xin nhập lại ");
                this.txtNgayBatDau.Value = DateTime.Now; 
                this.txtNgayKetThuc.Value = this.txtNgayBatDau.Value;
            }
        }
        private void btnCapNhat_Click(object sender, EventArgs e)
        {
            if (this.txtNgayKetThuc.Value >= this.txtNgayBatDau.Value)
            {
                DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
                if (confirm == DialogResult.Yes)
                {
                    using (var transaction = data.Database.BeginTransaction())
                    {
                        try
                        {
                            string NgayBatDau = this.txtNgayBatDau.Value.ToString("yyyy/MM/dd").Replace(" ", "").Replace("/", "");
                            string NgayKetThuc = this.txtNgayKetThuc.Value.ToString("yyyy/MM/dd").Replace(" ", "").Replace("/", "");
                            int result = 0;
                            for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
                            {
                                result = data.spUpdateOFFDayForStaff(this.lstIDNhanVienNgayNghi[bunifuCustomDataGrid1.SelectedRows[i].Index],
                                                                     this.lstIDNhanVien[i],
                                                                     (int) this.TitleOFFDay.SelectedValue,
                                                                     this.txtNgayBatDau.Value, 
                                                                     this.txtNgayKetThuc.Value,
                                                                     this.txtNameOfOFFDay.Text);
                                
                            }
                            transaction.Commit();
                            MessageBox.Show("Thêm thành công ");
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            MessageBox.Show("Thêm thất bại !!! ");
                        }
                    }
                    Close();
                }
            }
            else
            {
                MessageBox.Show("Ngày nghỉ không hợp lệ !!!! xin nhập lại ");
                this.txtNgayBatDau.Value = DateTime.Now;
                this.txtNgayKetThuc.Value = this.txtNgayBatDau.Value;
            }
        }

        private void bunifuCustomDataGrid1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
                return;
            if(e.ColumnIndex == 0)
                this.bunifuCustomDataGrid1.Rows[e.RowIndex].Cells["Checkbox"].Value = !(bool)(this.bunifuCustomDataGrid1.Rows[e.RowIndex].Cells["Checkbox"].Value);
            if (e.ColumnIndex == 0 && e.RowIndex == 0)
                this.bunifuCustomDataGrid1.Columns[0].Selected = !(bool)this.bunifuCustomDataGrid1.Columns[0].Selected;
            
        }
    }
}
