using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1
{
    class ListColumnName
    {
        private Dictionary<string, List<double>> lstColumnName;
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private List<fnDisplayWorkingDaysStaffOfMonth_Result> lstWorkingDaysForStaffOfMonth;
        public ListColumnName(DateTime ThangNam,int ID_NhanVien)
        {
            DateTime start = new DateTime(ThangNam.Year, ThangNam.Month, 1);
            DateTime end = new DateTime(start.Year, start.Month, 1).AddMonths(1).AddDays(-1);
            lstColumnName = new Dictionary<string, List<double>>();
            string HoVaTen = data.NHANSUs.Find(ID_NhanVien).HoVaTen;
            //item At Work - WFH 
            List<double> tmpAtWork = new List<double>();
            List<double> tmpWFH = new List<double>();
            lstWorkingDaysForStaffOfMonth = data.fnDisplayWorkingDaysStaffOfMonth(HoVaTen, ThangNam).ToList();
            for(int i = 0; i < lstWorkingDaysForStaffOfMonth.Count; i++)
            {
                tmpAtWork.Add((double)(Weekdays(start, end)
                    - CalculateTotalOFFDayInWeekdays(lstWorkingDaysForStaffOfMonth[i].ID, start, end)
                    - (lstWorkingDaysForStaffOfMonth[i].WFH.HasValue ? lstWorkingDaysForStaffOfMonth[i].WFH.Value : 0)));
                tmpWFH.Add((double)((lstWorkingDaysForStaffOfMonth[i].WFH.HasValue ? lstWorkingDaysForStaffOfMonth[i].WFH.Value : 0)));
            }
            lstColumnName.Add("At_Work",tmpAtWork);
            lstColumnName.Add("WFH", tmpWFH);

            //them toan bo PC vao list 
            foreach(var item in data.PHUCAPs.ToList())
            {
                List<fnGetAmountBenefit_Result> tmpBenefit = data.fnGetAmountBenefit(HoVaTen, start, item.ID, end).ToList();
                List<double> tmpAmountBenefit = new List<double>();
                foreach(var item1 in tmpBenefit)
                {
                    tmpAmountBenefit.Add(Decimal.ToDouble((decimal)(item1.PC_CoDinh.HasValue ? item1.PC_CoDinh.Value : 0)));
                }
                lstColumnName.Add(item.TenPhuCap.Replace(" ",""),tmpAmountBenefit);
            }
        }
        public Dictionary<string, List<double>> getListColumnName
        {
            get { return this.lstColumnName; }
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
        private int CalculateTotalOFFDayInWeekdays(int ID, DateTime start, DateTime end)
        {
            int result = 0;
            List<fnDisplayOFFDayFollowCondition_Result> tmp = data.fnDisplayOFFDayFollowCondition(start, end, data.NHANSUs.Find(ID).HoVaTen).ToList();
            foreach (var item in tmp)
            {
                if (item.ID_LoaiNgayNghi != 1 && item.ID_LoaiNgayNghi != 2)
                {
                    DateTime startDay = (item.NgayBatDau.Value < start ? start : item.NgayBatDau.Value);
                    DateTime endDay = (item.NgayKetThuc.Value > end ? end : item.NgayKetThuc.Value);
                    result = result + Weekdays(startDay, endDay);
                }
            }
            return result;
        }


    }
}
