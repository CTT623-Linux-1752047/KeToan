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
    public partial class EDIT_WORKING_DAY_OF_STAFF : Form
    {
        private int ID;
        private DateTime ThangNam;
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private List<fnDisplayInfoStaffWorkingDayInMonth_Result> lstWorkingDayOfAEmployee ;
        public EDIT_WORKING_DAY_OF_STAFF(int ID, DateTime ThangNam)
        {
            this.ID = ID;
            this.ThangNam = ThangNam;
            InitializeComponent();
        }
        private void LoadData()
        {
            this.bunifuCustomDataGrid1.Rows.Clear();
            this.lbName.Text = data.NHANSUs.Find(this.ID).HoVaTen;
            this.lbUserName.Text = data.NHANSUs.Find(this.ID).UserName;
            this.lbMonth.Text = this.ThangNam.ToString("MM - yyyy");
            fnDisplayWorkingDaysStaffOfMonth_Result temp = data.fnDisplayWorkingDaysStaffOfMonth(this.lbName.Text, this.ThangNam).FirstOrDefault();
            if(temp != null)
            {
                this.lbWFH.Text = (temp.WFH == null ? "0" : temp.LEAVES.ToString());
                this.lbLeaveHours.Text = (temp.LEAVES == null ? "0" : temp.LEAVES.ToString());
            }
            this.lbOFFDayTakeLeave.Text = (CalcultDayOFFTakeLeave().ToString() == null ? "0" : CalcultDayOFFTakeLeave().ToString());
            this.lbDayOFFNoTakeLeave.Text = (CalculDayOFFNoTakeLeave().ToString() == null ? "0" : CalculDayOFFNoTakeLeave().ToString());
            this.lbTotalWorkingHours.Text = (((Weekdays(new DateTime(ThangNam.Year,ThangNam.Month,1),new DateTime(ThangNam.Year,ThangNam.Month,1).AddMonths(1).AddDays(-1))) * 8) - Convert.ToInt32(this.lbLeaveHours.Text)).ToString();
            try
            {
                this.TitleWorkingDay.DataSource = data.LOAI_GIO_CONG.SqlQuery("SELECT * FROM LOAI_GIO_CONG").ToList();
                this.TitleWorkingDay.DisplayMember = "LoaiGioCong";
                this.TitleWorkingDay.ValueMember = "ID";
                this.lstWorkingDayOfAEmployee = data.fnDisplayInfoStaffWorkingDayInMonth(this.ID, this.ThangNam).ToList();
                int TotalWFH = 0; 
                for(int i =0; i < this.lstWorkingDayOfAEmployee.Count; i++)
                {
                    this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                        this.lstWorkingDayOfAEmployee[i].ID_GioCong,
                                                        this.lstWorkingDayOfAEmployee[i].NgayGioBatDau.Value.ToString("dd/MM/yyyy [ HH:mm ]"),
                                                        this.lstWorkingDayOfAEmployee[i].NgayGioKetThuc.Value.ToString("dd/MM/yyyy [ HH:mm ]")
                                                        );
                }
                if(lstWorkingDayOfAEmployee.Count == 0)
                {
                    this.lbNoData.Show();
                }
                else
                {
                    this.lbNoData.Hide();
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void EDIT_WORKING_DAY_OF_STAFF_Load(object sender, EventArgs e)
        {
            LoadData();
        }
        private void bunifuCustomDataGrid1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void bunifuCustomDataGrid1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == 4)
            {
                DialogResult dialogResult = MessageBox.Show("Bạn có muốn xóa ?", "Some Title", MessageBoxButtons.YesNo);
                if (dialogResult == DialogResult.Yes)
                {
                    data.NHANVIEN_GIOCONG.Remove(data.NHANVIEN_GIOCONG.Find(Convert.ToInt32(lstWorkingDayOfAEmployee[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID)));
                    data.SaveChanges();
                }
                else if (dialogResult == DialogResult.No)
                {
                    //do something else
                }
                LoadData();
            }
        }
        private int CalculDayOFFNoTakeLeave()
        {
            int resultOFFDayNoTakeLeave = 0;
            List<fnDisplayOFFDayFollowCondition_Result> tmpLstOFFDayOf = data.fnDisplayOFFDayFollowCondition(
                                                                            new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1),
                                                                            new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1).AddMonths(1).AddDays(-1),
                                                                            data.NHANSUs.Find(this.ID).HoVaTen).ToList();
            //Tinh toan hien thi so ngay nghi co phep trong thang 
            foreach (var tmp in tmpLstOFFDayOf)
            {
                if (tmp.ID_LoaiNgayNghi != 1 && tmp.ID_LoaiNgayNghi != 2)
                {
                    DateTime tmpStart = (tmp.NgayBatDau.Value < new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1) ? new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1) : tmp.NgayBatDau.Value);
                    DateTime tmpEnd = (tmp.NgayKetThuc.Value > new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1).AddMonths(1).AddDays(-1) ? new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1).AddMonths(1).AddDays(-1) : tmp.NgayKetThuc.Value);
                    resultOFFDayNoTakeLeave = resultOFFDayNoTakeLeave + Weekdays(tmpStart, tmpEnd);
                }
            }
            return resultOFFDayNoTakeLeave;
        }
        public int CalcultDayOFFTakeLeave()
        {
            int resultOFFDayTakeLeave = 0;
            List<fnDisplayOFFDayFollowCondition_Result> tmpLstOFFDayOf = data.fnDisplayOFFDayFollowCondition(
                                                                            new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1),
                                                                            new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1).AddMonths(1).AddDays(-1),
                                                                            data.NHANSUs.Find(this.ID).HoVaTen).ToList();
            //Tinh toan hien thi so ngay nghi co phep trong thang 
            foreach (var tmp in tmpLstOFFDayOf)
            {
                if (tmp.ID_LoaiNgayNghi == 1 || tmp.ID_LoaiNgayNghi == 2)
                {
                    DateTime tmpStart = (tmp.NgayBatDau.Value < new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1) ? new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1) : tmp.NgayBatDau.Value);
                    DateTime tmpEnd = (tmp.NgayKetThuc.Value > new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1).AddMonths(1).AddDays(-1) ? new DateTime(this.ThangNam.Year, this.ThangNam.Month, 1).AddMonths(1).AddDays(-1) : tmp.NgayKetThuc.Value);
                    resultOFFDayTakeLeave = resultOFFDayTakeLeave + Weekdays(tmpStart, tmpEnd);
                }
            }
            return resultOFFDayTakeLeave;
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
