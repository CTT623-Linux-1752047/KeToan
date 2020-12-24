using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Runtime.InteropServices;


namespace WindowsFormsApp1
{
    public partial class QUANLYNHANSU : UserControl
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private List<fnDisplayStaffFollowName_Result> lstStaff;
        public QUANLYNHANSU()
        {
            InitializeComponent();
        }
        public void LoadData()
        {
            if(this.searchBar.Text == "" || this.searchBar.Text == null)
            {
                lstStaff = data.fnDisplayStaffFollowName("").ToList();
            }
            else
            {
                lstStaff = data.fnDisplayStaffFollowName(this.searchBar.Text).ToList();
            }
            this.bunifuCustomDataGrid1.Rows.Clear();
            
            for(int i = 0 ; i < this.lstStaff.Count ; i++)
            {
                string[] Fullname = this.lstStaff[i].HoVaTen.Split(' ');
                string Firstname = "";
                for (int j = 0; j < Fullname.Length - 1 ; j++)
                {
                    Firstname += Fullname[j] + " ";
                }
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    this.lstStaff[i].UserName,
                                                    Firstname,
                                                    Fullname[Fullname.Length-1],
                                                    ((DateTime)this.lstStaff[i].NgaySinh).ToString("dd/MM/yyyy")
                                                    );     
            }
        }
        //button add user 
        private void button3_Click(object sender, EventArgs e)
        {
            THONGTINNHANVIEN InformationEmployee = new THONGTINNHANVIEN();
            InformationEmployee.ShowDialog();
            LoadData();
        }
        //multi selected được lưu theo nguyên tắc LIFO - button delete user
        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
                {
                    int index = this.lstStaff[(int)this.bunifuCustomDataGrid1.SelectedRows[i].Cells[0].Value - 1].ID;
                    NHANSU temp = data.NHANSUs.SingleOrDefault(id => id.ID == index);
                    int j = 1;
                    if (temp != null)
                    {
                        temp.TrangThaiLamViec = 1;
                        data.SaveChanges();
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            LoadData();
        }
        //nút tìm kiếm 
        private void button1_Click(object sender, EventArgs e)
        {
            LoadData();                           
        }
        //double click để mở form Thông tin chi tiết nhân viên 
        private void bunifuCustomDataGrid1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            THONGTINNHANVIEN updateUser1 = new THONGTINNHANVIEN(this.lstStaff[(int)this.bunifuCustomDataGrid1.CurrentRow.Cells[0].Value-1].ID);
            updateUser1.ShowDialog();

            LoadData();
        }
        private void pnlReportExel_MouseEnter(object sender, EventArgs e)
        {
            this.pnlReportExel.BackColor = Color.FromArgb(56, 142, 60);
        }
        private void pnlReportExel_MouseLeave(object sender, EventArgs e)
        {
            this.pnlReportExel.BackColor = Color.FromArgb(23, 143, 7);
        }

        private void pnlQuitEmployee_MouseEnter(object sender, EventArgs e)
        {
            this.pnlQuitEmployee.BackColor = Color.FromArgb(198, 40, 40);
        }

        private void pnlQuitEmployee_MouseLeave(object sender, EventArgs e)
        {
            this.pnlQuitEmployee.BackColor = Color.FromArgb(229, 57, 53);
        }

        private void pnlCreateUser_MouseEnter(object sender, EventArgs e)
        {
            this.pnlCreateUser.BackColor = Color.FromArgb(2, 136, 209);
        }

        private void pnlCreateUser_MouseLeave(object sender, EventArgs e)
        {
            this.pnlCreateUser.BackColor = Color.FromArgb(3, 155, 229);
        }

        private void pnlDepartement_MouseEnter(object sender, EventArgs e)
        {
            this.pnlDepartement.BackColor = Color.FromArgb(255, 143, 0);
        }

        private void pnlDepartement_MouseLeave(object sender, EventArgs e)
        {
            this.pnlDepartement.BackColor = Color.FromArgb(255, 167, 38);
        }

        private void pnlCreateUser_Click(object sender, EventArgs e)
        {
            THONGTINNHANVIEN InfoStaff = new THONGTINNHANVIEN();
            InfoStaff.ShowDialog();
            LoadData();
        }
    }
}
                                                                                                                                                                  