using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class CREATE_WORKING_HOURS : Form
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private List<fnDisplayStaffFollowName_Result> listEmployeeTemp;
        public CREATE_WORKING_HOURS()
        {
            InitializeComponent();
        }

        private void CREATE_WORKING_HOURS_Load(object sender, EventArgs e)
        {
            this.cBoxTitleWorking.DataSource = data.LOAI_GIO_CONG.SqlQuery("SELECT * FROM LOAI_GIO_CONG").ToList();
            this.cBoxTitleWorking.DisplayMember = "LoaiGioCong";
            this.cBoxTitleWorking.ValueMember = "ID";
            ShowInfoEmployee();
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            this.dateStart.Enabled = true;
            if(this.chkAllDay.Checked == true)
            {
                this.dateStart.Value = new DateTime(dateStart.Value.Year, dateStart.Value.Month, dateStart.Value.Day, 0, 0, 0);
                this.dateEnd.Value = new DateTime(dateEnd.Value.Year, dateEnd.Value.Month, dateEnd.Value.Day, 0, 0, 0);
                this.dateStart.CustomFormat = "dd/MM/yyyy";
                this.dateEnd.CustomFormat = "dd/MM/yyyy";
            }
            else
            {
                this.dateStart.Value = new DateTime(dateStart.Value.Year, dateStart.Value.Month, dateStart.Value.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                this.dateEnd.Value = new DateTime(dateEnd.Value.Year, dateEnd.Value.Month, dateEnd.Value.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second);
                this.dateStart.CustomFormat = "dd/MM/yyyy [ HH:mm ]";
                this.dateEnd.CustomFormat = "dd/MM/yyyy [ HH:mm ]";
            }
        }
        public void ShowInfoEmployee()
        {
            this.bunifuCustomDataGrid1.Rows.Clear();
            this.listEmployeeTemp = data.fnDisplayStaffFollowName(this.txtSearchBar.Text).ToList();
            for (int i = 0; i < this.listEmployeeTemp.Count; i++)
            {
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    this.listEmployeeTemp[i].HoVaTen
                                                    );
                this.bunifuCustomDataGrid1.DefaultCellStyle.ForeColor = Color.FromArgb(64, 64, 64);
            }

        }
        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (this.lbUserName.Text == "" || this.lbUserName.Text == null || this.lbName.Text == "" || this.lbName.Text == null)
            {
                MessageBox.Show("Bạn cần chọn nhân viên !!!");
            }
            else
            {
                DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
                if (confirm == DialogResult.Yes)
                {
                    NHANVIEN_GIOCONG temp = new NHANVIEN_GIOCONG();
                    temp.ID_GioCong = Convert.ToInt32(this.cBoxTitleWorking.SelectedValue);
                    temp.ID_NhanVien = this.listEmployeeTemp[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID;
                    temp.NgayGioBatDau = this.dateStart.Value;
                    temp.NgayGioKetThuc = this.dateEnd.Value;
                   
                        data.NHANVIEN_GIOCONG.Add(temp);
                        data.SaveChanges();
                    
                }
            }
        }

        private void bunifuCustomDataGrid1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            this.lbName.Text = this.listEmployeeTemp[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].HoVaTen;
            this.lbUserName.Text = this.listEmployeeTemp[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].UserName;
        }
    }
}
