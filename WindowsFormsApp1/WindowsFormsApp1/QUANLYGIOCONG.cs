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
            crtWorkingH.Show();
            crtWorkingH.eventAddDataSuccess += addDataComeBack;
        }
        private void addDataComeBack(object sender, EventArgs e)
        {
            LoadData();
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
                int tmpWorkingdays = Weekdays(  new DateTime(this.MonthYear.Value.Year, this.MonthYear.Value.Month,1),
                                                new DateTime(this.MonthYear.Value.Year,this.MonthYear.Value.Month,1).AddMonths(1).AddDays(-1)); 
                
                int tmpPresentWorkingDays =(tmpWorkingdays - CalculateTotalOFFDayInWeekdays(this.lstWorkingDaysForStaffOfMonth[i].ID, 
                                                                                            new DateTime(this.MonthYear.Value.Year, this.MonthYear.Value.Month, 1), 
                                                                                            new DateTime(this.MonthYear.Value.Year, this.MonthYear.Value.Month, 1).AddMonths(1).AddDays(-1)));
                int tmpWFH = this.lstWorkingDaysForStaffOfMonth[i].WFH.HasValue ? (int)this.lstWorkingDaysForStaffOfMonth[i].WFH.Value : 0;
                int tmpLeaves = this.lstWorkingDaysForStaffOfMonth[i].LEAVES.HasValue ? (int)this.lstWorkingDaysForStaffOfMonth[i].LEAVES.Value : 0;
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    this.lstWorkingDaysForStaffOfMonth[i].HoVaTen,
                                                    tmpWorkingdays,
                                                    tmpPresentWorkingDays,
                                                    tmpWFH,
                                                    tmpPresentWorkingDays - tmpWFH,
                                                    tmpLeaves
                                                    ) ;
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
            if (Convert.ToInt32(lstWorkingDaysForStaffOfMonth[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID) != -1)
            {
                EDIT_WORKING_DAY_OF_STAFF edit = new EDIT_WORKING_DAY_OF_STAFF(Convert.ToInt32(lstWorkingDaysForStaffOfMonth[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID), this.MonthYear.Value);
                edit.ShowDialog();
                LoadData();
            }
        }
        private void tableLayoutPanel7_MouseLeave(object sender, EventArgs e)
        {
            this.tableLayoutPanel7.BackColor = Color.FromArgb(23, 143, 7);
        }
        private void tableLayoutPanel7_MouseEnter(object sender, EventArgs e)
        {
            this.tableLayoutPanel7.BackColor = Color.FromArgb(47, 114, 12);
        }
        private int CalculateTotalOFFDayInWeekdays(int ID, DateTime start, DateTime end)
        {
            int result = 0;
            List<fnDisplayOFFDayFollowCondition_Result> tmp = data.fnDisplayOFFDayFollowCondition(start, end, data.NHANSUs.Find(ID).HoVaTen).ToList();
            foreach(var item in tmp)
            {
                if(item.ID_LoaiNgayNghi != 1 && item.ID_LoaiNgayNghi != 2)
                {
                    DateTime startDay = (item.NgayBatDau.Value < start ? start : item.NgayBatDau.Value);
                    DateTime endDay = (item.NgayKetThuc.Value > end ? end : item.NgayKetThuc.Value);
                    result = result + Weekdays(startDay, endDay);
                }
            }
            return result;
        }
        public int Weekdays(DateTime dtmStart, DateTime dtmEnd)
        {
            // This function includes the start and end date in the count if they fall on a weekday
            int dowStart = ((int)dtmStart.DayOfWeek == 0 ? 7 : (int)dtmStart.DayOfWeek);
            int dowEnd = ((int)dtmEnd.DayOfWeek == 0 ? 7 : (int)dtmEnd.DayOfWeek);
            TimeSpan tSpan = dtmEnd - dtmStart;
            if (dowStart <= dowEnd)
            {
                return (((tSpan.Days / 7) * 5) + Math.Max((Math.Min((dowEnd + 1), 6) - dowStart), 0));
            }
            return (((tSpan.Days / 7) * 5) + Math.Min((dowEnd + 6) - Math.Min(dowStart, 6), 5));
        }
    }
}
