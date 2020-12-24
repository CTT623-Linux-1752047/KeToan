using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1
{
    class Payroll
    {
        private int ID_NhanVien;
        private DateTime ThangNam;
        private TinhTienLuongEntities data;
        //Man hinh Payroll (15 col)
        private double Wfh;
        private double AtWork;
        private double Km;
        private double LeaveHours;
        private double Responsi_Japanese;
        private double SalaryDeduction;
        private double OTSalary;
        private double BenefitWFH;
        private double Bonus;
        private double Payback;
        private double Parking;
        private double Gasoline;
        private double TotalAmount;
        private double TotalAmountInVND;
        private double SalaryBasic;
        //Man hinh Insurance (8 col)
        private double SalaryForInsurance;
        private double SalaryForUnemployted;
        private double HealthyInsuranceStaff;
        private double SocialInsuranceStaff;
        private double UnemploytedInsuranceStaff;
        private double HealthyInsuranceEnterprise;
        private double SocialInsuranceEnterprise;
        private double UnemploytedInsuranceEnterprise;
        //Man hinh PIT (6 col)
        private double OTDeduction;
        private double PersonalDeduction;
        private double AmountDependentPersonalDeduction;
        private double TaxableIncome;
        private double PITPayment;
        private double NumDependentPersonal;

        public Payroll(int IDNhanVien, DateTime ThangNam)
        {
            this.data = new TinhTienLuongEntities();
            this.ID_NhanVien = IDNhanVien;
            this.ThangNam = ThangNam;
            NHANSU staff = data.NHANSUs.Find(this.ID_NhanVien);

            if (staff != null)
            {
                DateTime start = new DateTime(ThangNam.Year, ThangNam.Month, 1);
                DateTime end = new DateTime(ThangNam.Year, ThangNam.Month, 1).AddMonths(1).AddDays(-1);
                fnDisplayWorkingDaysStaffOfMonth_Result WorkingHoursStaff = data.fnDisplayWorkingDaysStaffOfMonth(staff.HoVaTen, ThangNam).FirstOrDefault();
                fnDisplayOT_AmountOTStaffOfMonth_Result OTStaff = data.fnDisplayOT_AmountOTStaffOfMonth(staff.HoVaTen, ThangNam).FirstOrDefault();
                Dictionary<string, double> dictAllBenefitOfStaff = new Dictionary<string, double>();
                foreach(var TypeBenefit in data.PHUCAPs.ToList())
                {
                    fnGetAmountBenefit_Result BenefitStaff = data.fnGetAmountBenefit(staff.HoVaTen, start, TypeBenefit.ID, end).FirstOrDefault();
                    double ValueBenefit = Decimal.ToDouble(BenefitStaff.PC_CoDinh.HasValue ? BenefitStaff.PC_CoDinh.Value : 0);
                    dictAllBenefitOfStaff.Add(TypeBenefit.TenPhuCap.Replace(" ",""),ValueBenefit);
                }
                Dictionary<string, double> dictInsurancePercentage = new Dictionary<string, double>();
                foreach (var item in data.BAOHIEM_THUE.ToList())
                {
                    dictInsurancePercentage.Add(item.LoaiBaoHiem.Replace(" ", ""), (double)item.PhanTramBaoHiem);
                }

                double BenefitWFH = dictAllBenefitOfStaff["Benefit_WFH"];
                double BenefitParking = dictAllBenefitOfStaff["Benefit_WFH"];
                double BenefitGasoline = dictAllBenefitOfStaff["Benefit_WFH"];
                double BenefitJapaneseN1 = dictAllBenefitOfStaff["Benefit_Japanese_N1"];
                double BenefitJapaneseN2 = dictAllBenefitOfStaff["Benefit_Japanese_N2"];
                double BenefitJapaneseN3 = dictAllBenefitOfStaff["Benefit_Japanese_N3"];
                double BenefitJapaneseN4 = dictAllBenefitOfStaff["Benefit_Japanese_N4"];
                double BenefitJapaneseOther = dictAllBenefitOfStaff["Benefit_Japanese_Other"];
                double BenefitJapanese = BenefitJapaneseN1 + BenefitJapaneseN2 + BenefitJapaneseN3 + BenefitJapaneseN4 + BenefitJapaneseOther;

                double PercentHealthyInsuranceStaff = dictInsurancePercentage["Healthy_Insurance_Staff"];
                double PercentSocialInsuranceStaff = dictInsurancePercentage["Social_Insurance_Staff"];
                double PercentUnemploytedStaff = dictInsurancePercentage["Unemployted_Insurance_Staff"];
                double PercentHealthyInsuranceEnterprise = dictInsurancePercentage["Healthy_Insurance_Enterprise"];
                double PercentSocialInsuranceEnterprise = dictInsurancePercentage["Social_Insurance_Enterprise"];
                double PercentUnemploytedEnterprise = dictInsurancePercentage["Unemployted_Insurance_Enterprise"];
                double LevelHealthySocial = (dictInsurancePercentage["Times"] * dictInsurancePercentage["Min_Salary"]);
                double LevelUnemployted = (dictInsurancePercentage["Times"] * dictInsurancePercentage["Min_Salary_Of_Region"]);
                double TaxPersonalDeduction = dictInsurancePercentage["Personal_Deduction"];
                double TaxDependentPersonDeduction = dictInsurancePercentage["Dependent_Person_Deduction"];
                double IncomeTaxSalaryLevel1 = dictInsurancePercentage["Percent_PIT_Level_1"];
                double IncomeTaxSalaryLevel2 = dictInsurancePercentage["Percent_PIT_Level_2"];
                double IncomeTaxSalaryLevel3 = dictInsurancePercentage["Percent_PIT_Level_3"];
                double IncomeTaxSalaryLevel4 = dictInsurancePercentage["Percent_PIT_Level_4"];
                double IncomeTaxSalaryLevel5 = dictInsurancePercentage["Percent_PIT_Level_5"];
                double IncomeTaxSalaryLevel6 = dictInsurancePercentage["Percent_PIT_Level_6"];
                double IncomeTaxSalaryLevel7 = dictInsurancePercentage["Percent_PIT_Level_7"];
                double TaxableIncomeLevel1 = dictInsurancePercentage["Amount_PIT_Level_1"];
                double TaxableIncomeLevel2 = dictInsurancePercentage["Amount_PIT_Level_2"];
                double TaxableIncomeLevel3 = dictInsurancePercentage["Amount_PIT_Level_3"];
                double TaxableIncomeLevel4 = dictInsurancePercentage["Amount_PIT_Level_4"];
                double TaxableIncomeLevel5 = dictInsurancePercentage["Amount_PIT_Level_5"];
                double TaxableIncomeLevel6 = dictInsurancePercentage["Amount_PIT_Level_6"];
                double TaxableIncomeLevel7 = dictInsurancePercentage["Amount_PIT_Level_7"];
                double LandmarkLevel1_OfRangeSalary = dictInsurancePercentage["Range_Salary_PIT_Mark_1"];
                double LandmarkLevel2_OfRangeSalary = dictInsurancePercentage["Range_Salary_PIT_Mark_2"];
                double LandmarkLevel3_OfRangeSalary = dictInsurancePercentage["Range_Salary_PIT_Mark_3"];
                double LandmarkLevel4_OfRangeSalary = dictInsurancePercentage["Range_Salary_PIT_Mark_4"];
                double LandmarkLevel5_OfRangeSalary = dictInsurancePercentage["Range_Salary_PIT_Mark_5"];
                double LandmarkLevel6_OfRangeSalary = dictInsurancePercentage["Range_Salary_PIT_Mark_6"];


                double TaxOT = OTStaff.Tax.HasValue ? OTStaff.Tax.Value : 0;
                double NumDependentPersonal = staff.SoNguoiPhuThuoc.HasValue ? staff.SoNguoiPhuThuoc.Value : 0;
                this.Wfh = WorkingHoursStaff.WFH.HasValue ? WorkingHoursStaff.WFH.Value : 0;
                this.AtWork = Weekdays(start, end) - CalculateTotalOFFDayInWeekdays(this.ID_NhanVien, start, end) - this.WFH;
                this.LeaveHours = WorkingHoursStaff.LEAVES.HasValue ? WorkingHoursStaff.LEAVES.Value : 0;
                this.Km = staff.Km.Value;
                this.SalaryBasic = Decimal.ToDouble(staff.LuongCB.Value);
                this.OTSalary = OTStaff.TotalWithoutTax.HasValue ? OTStaff.TotalWithoutTax.Value : 0;
                this.Responsi_Japanese = BenefitJapanese;
                this.Parking = BenefitParking * this.AtWork;
                this.Gasoline = BenefitGasoline * 2 * this.AtWork;
                this.BenefitWFH = BenefitWFH * this.Wfh;
                this.SalaryDeduction = ((this.SalaryBasic + Responsi_Japanese) / 176) * LeaveHours;
                this.TotalAmount = ((this.SalaryBasic + this.Responsi_Japanese) * Weekdays(start, end)) / 22 - this.SalaryDeduction + this.OTSalary + this.Payback + this.Parking + this.Gasoline;
                this.TotalAmountInVND = this.TotalAmount + this.BenefitWFH + this.Bonus;
                if (this.TotalAmountInVND < LevelHealthySocial)
                {
                    this.SalaryForInsurance = this.TotalAmountInVND;
                }
                else
                {
                    this.SalaryForInsurance = LevelHealthySocial;
                }
                if (this.TotalAmountInVND < LevelUnemployted)
                {
                    this.SalaryForUnemployted = this.TotalAmountInVND;
                }
                else
                {
                    this.SalaryForUnemployted = LevelUnemployted;
                }
                this.HealthyInsuranceStaff = SalaryForInsurance * PercentHealthyInsuranceStaff;
                this.SocialInsuranceStaff = SalaryForInsurance * PercentSocialInsuranceStaff;
                this.UnemploytedInsuranceStaff = SalaryForInsurance * PercentUnemploytedStaff;
                this.UnemploytedInsuranceEnterprise = SalaryForInsurance * PercentUnemploytedEnterprise;
                this.HealthyInsuranceEnterprise = SalaryForInsurance * PercentHealthyInsuranceEnterprise;
                this.SocialInsuranceEnterprise = SalaryForInsurance * PercentSocialInsuranceEnterprise;
                this.OTDeduction = this.OTSalary - TaxOT; 
                this.PersonalDeduction = dictInsurancePercentage["Personal_Deduction"];
                this.AmountDependentPersonalDeduction = NumDependentPersonal * TaxDependentPersonDeduction;
                double TaxIncome = this.SalaryBasic - (this.HealthyInsuranceStaff + this.SocialInsuranceStaff + UnemploytedInsuranceStaff) - this.OTDeduction - this.Payback - this.PersonalDeduction;
                if (TaxIncome > 0)
                {
                    this.TaxableIncome = TaxIncome;
                }
                else
                {
                    this.TaxableIncome = 0;
                }
                if (this.TaxableIncome > LandmarkLevel6_OfRangeSalary)
                {
                    this.PITPayment = this.TaxableIncome * IncomeTaxSalaryLevel7 - TaxableIncomeLevel7;
                }
                else if (TaxableIncome > LandmarkLevel5_OfRangeSalary)
                {
                    this.PITPayment = this.TaxableIncome * IncomeTaxSalaryLevel6 - TaxableIncomeLevel6;
                }
                else if (TaxableIncome > LandmarkLevel4_OfRangeSalary)
                {
                    this.PITPayment = this.TaxableIncome * IncomeTaxSalaryLevel5 - TaxableIncomeLevel5;
                }
                else if (TaxableIncome > LandmarkLevel3_OfRangeSalary)
                {
                    this.PITPayment = this.TaxableIncome * IncomeTaxSalaryLevel4 - TaxableIncomeLevel4;
                }
                else if (TaxableIncome > LandmarkLevel2_OfRangeSalary)
                {
                    this.PITPayment = this.TaxableIncome * IncomeTaxSalaryLevel3 - TaxableIncomeLevel3;
                }
                else if (TaxableIncome > LandmarkLevel1_OfRangeSalary)
                {
                    this.PITPayment = this.TaxableIncome * IncomeTaxSalaryLevel2 - TaxableIncomeLevel2;
                }
                else
                {
                    this.PITPayment = TaxableIncome * IncomeTaxSalaryLevel1 - TaxableIncomeLevel1;
                }
            }
        }
        private int Weekdays(DateTime dtmStart, DateTime dtmEnd)
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
        public double WFH
        {
            get { return this.Wfh; }
        }
        public double ATWORK
        {
            get { return this.AtWork; }
        }
        public double KM
        {
            get { return this.Km; }
        }
        public double LEVEAS_HOURS
        {
            get { return this.LeaveHours; }
        }
        public double RESPONSI_JAPANESE
        {
            get { return this.Responsi_Japanese; }
        }
        public double OT_SALARY
        {
            get { return this.OTSalary; }
        }
        public double BENEFIT
        {
            get { return this.BenefitWFH; }
        }
        public double BONUS
        {
            get { return this.Bonus; }
        }
        public double PAYBACK
        {
            get { return this.Payback; }
        }
        public double PARKING
        {
            get { return this.Parking; }
        }
        public double GASOLINE
        {
            get { return this.Gasoline; }
        }
        public double TOTAL_AMOUNT
        {
            get { return this.TotalAmount; }
        }
        public double TOTAL_AMOUNT_IN_VND
        {
            get { return this.TotalAmountInVND; }
        }
        public double SALARY_BASIC
        {
            get { return this.SalaryBasic; }
        }
        public double SALARY_FOR_INSURANCE
        {
            get { return this.SalaryForInsurance; }
        }
        public double SALARY_FOR_UNEMPLOYTED
        {
            get { return this.SalaryForUnemployted; }
        }
        public double HEALTHY_INSURANCE_STAFF
        {
            get { return this.HealthyInsuranceStaff; }
        }
        public double SOCIAL_INSURANCE_STAFF
        {
            get { return this.SocialInsuranceStaff; }
        }
        public double UNEMPLOYTED_INSURANCE_STAFF
        {
            get { return this.UnemploytedInsuranceStaff; }
        }
        public double HEALTHY_INSURANCE_ENTERPRISE
        {
            get { return this.HealthyInsuranceEnterprise; }
        }
        public double SOCIAL_INSURANCE_ENTERPRISE
        {
            get { return this.SocialInsuranceEnterprise; }
        }
        public double UNEMPLOYTED_INSURANCE_ENTERPRISE
        {
            get { return this.UnemploytedInsuranceEnterprise; }
        }
        public double OT_DEDUCTION
        {
            get { return this.OTDeduction; }
        }
        public double PERSONAL_DEDUCTION
        {
            get { return this.PersonalDeduction; }
        }
        public double AMOUNT_DEPENDENT_PERSONAL_DEDUCTION
        {
            get { return this.AmountDependentPersonalDeduction; }
        }
        public double TAXABLE_INCOME
        {
            get { return this.TaxableIncome; }
        }
        public double PIT_PAYEMENT
        {
            get { return this.PITPayment; }
        }
        public double NUM_DEPENDENT_PERSONAL
        {
            get { return this.NumDependentPersonal; }
        }
        public double SALARY_DEDUCTION
        {
            get { return this.SalaryDeduction; }
        }
    }
}
