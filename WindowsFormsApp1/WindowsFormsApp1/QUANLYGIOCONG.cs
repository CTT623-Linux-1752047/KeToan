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
    public partial class QUANLYGIOCONG : UserControl
    {
        private List<fnDisplayWorkingDaysStaffOfMonth_Result> lstWorkingDaysForStaffOfMonth;
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        public QUANLYGIOCONG()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {

        }
        private void tableLayoutPanel9_MouseEnter(object sender, EventArgs e)
        {
            this.tableLayoutPanel9.BackColor = System.Drawing.Color.FromArgb(0, 155, 214);
        }

        private void tableLayoutPanel9_MouseLeave(object sender, EventArgs e)
        {
            this.tableLayoutPanel9.BackColor = System.Drawing.Color.FromArgb(42, 157, 244);
        }

        private void tableLayoutPanel9_Click(object sender, EventArgs e)
        {
            CREATE_WORKING_HOURS crtWorkingH = new CREATE_WORKING_HOURS();
            crtWorkingH.ShowDialog();
        }
        public void LoadData()
        {

            if (this.searchBar.Text == "" || this.searchBar.Text == null)
            {
                lstWorkingDaysForStaffOfMonth = data.fnDisplayWorkingDaysStaffOfMonth("", MonthYear.Value).ToList();
            }
            else
            {
                lstWorkingDaysForStaffOfMonth = data.fnDisplayWorkingDaysStaffOfMonth(this.searchBar.Text, MonthYear.Value).ToList();
            }
            this.bunifuCustomDataGrid1.Rows.Clear();
            Image img = Properties.Resources.icons8_edit_calendar_24;
            for (int i = 0; i < this.lstWorkingDaysForStaffOfMonth.Count; i++)
            {
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    this.lstWorkingDaysForStaffOfMonth[i].HoVaTen,
                                                    (DateTime.DaysInMonth(this.MonthYear.Value.Year, this.MonthYear.Value.Month) == 31 ? 23 : 22),
                                                    (DateTime.DaysInMonth(this.MonthYear.Value.Year, this.MonthYear.Value.Month) == 31 ? 23 : 22) 
                                                    - (this.lstWorkingDaysForStaffOfMonth[i].TotalOFFDays == null ? 0 : this.lstWorkingDaysForStaffOfMonth[i].TotalOFFDays),
                                                    this.lstWorkingDaysForStaffOfMonth[i].WFH,
                                                    22-this.lstWorkingDaysForStaffOfMonth[i].WFH,
                                                    this.lstWorkingDaysForStaffOfMonth[i].LEAVES
                                                    );
            }
            if (lstWorkingDaysForStaffOfMonth.Count == 0)
                this.lbNoData.Show();
            else
            {
                this.lbNoData.Hide();
            }
            
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void MonthYear_ValueChanged(object sender, EventArgs e)
        {
            LoadData();
        }
        private void bunifuCustomDataGrid1_CellContentDoubleClick_1(object sender, DataGridViewCellEventArgs e)
        {
            if (Convert.ToInt32(lstWorkingDaysForStaffOfMonth[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID_NhanVien) != -1)
            {
                EDIT_WORKING_DAY_OF_STAFF edit = new EDIT_WORKING_DAY_OF_STAFF(Convert.ToInt32(lstWorkingDaysForStaffOfMonth[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID_NhanVien), this.MonthYear.Value);
                edit.ShowDialog();
                LoadData();
            }
           
        }
    }
}
