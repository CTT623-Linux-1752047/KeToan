using System;

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
        private double Parking_Gasoline;
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
            
            if (staff != null && staff.ID <= 10)
            {
                Calculate val = new Calculate();

                this.Wfh = val.CALCULATE(("OTH_33").Split(' '), ID_NhanVien, ThangNam);
                this.AtWork = val.CALCULATE(("OTH_32").Split(' '), ID_NhanVien, ThangNam);
                this.LeaveHours = val.CALCULATE(("OTH_32").Split(' '), ID_NhanVien, ThangNam);
                this.Km = val.CALCULATE(("OTH_37").Split(' '), ID_NhanVien, ThangNam);
                this.SalaryBasic = val.CALCULATE(("OTH_34").Split(' '), ID_NhanVien, ThangNam);
                this.OTSalary = val.CALCULATE(("OTH_13").Split(' '), ID_NhanVien, ThangNam);
                this.Responsi_Japanese = val.CALCULATE(("OTH_3").Split(' '), ID_NhanVien, ThangNam);
                this.Parking_Gasoline = val.CALCULATE(("OTH_2").Split(' '), ID_NhanVien, ThangNam);
                this.BenefitWFH = val.CALCULATE(("OTH_1").Split(' '), ID_NhanVien, ThangNam);
                this.SalaryDeduction = val.CALCULATE(("OTH_5").Split(' '), ID_NhanVien, ThangNam);
                this.TotalAmount = val.CALCULATE(("OTH_6").Split(' '), ID_NhanVien, ThangNam);
                this.TotalAmountInVND = val.CALCULATE(("OTH_7").Split(' '), ID_NhanVien, ThangNam);
                this.SalaryForInsurance = val.CALCULATE(("OTH_17").Split(' '), ID_NhanVien, ThangNam);
                this.SalaryForUnemployted = val.CALCULATE(("OTH_18").Split(' '), ID_NhanVien, ThangNam);

                this.HealthyInsuranceStaff = val.CALCULATE(("OTH_19").Split(' '), ID_NhanVien, ThangNam);
                this.SocialInsuranceStaff = val.CALCULATE(("OTH_20").Split(' '), ID_NhanVien, ThangNam);
                this.UnemploytedInsuranceStaff = val.CALCULATE(("OTH_21").Split(' '), ID_NhanVien, ThangNam);
                this.UnemploytedInsuranceEnterprise = val.CALCULATE(("OTH_22").Split(' '), ID_NhanVien, ThangNam);
                this.HealthyInsuranceEnterprise = val.CALCULATE(("OTH_23").Split(' '), ID_NhanVien, ThangNam);
                this.SocialInsuranceEnterprise = val.CALCULATE(("OTH_24").Split(' '), ID_NhanVien, ThangNam);
                this.OTDeduction = val.CALCULATE(("OTH_16").Split(' '), ID_NhanVien, ThangNam);
                this.PersonalDeduction = val.CALCULATE(("OTH_27").Split(' '), ID_NhanVien, ThangNam);
                this.AmountDependentPersonalDeduction = val.CALCULATE(("OTH_28").Split(' '), ID_NhanVien, ThangNam);
                this.TaxableIncome = val.CALCULATE(("OTH_29").Split(' '), ID_NhanVien, ThangNam);
                this.PITPayment = val.CALCULATE(("OTH_30").Split(' '), ID_NhanVien, ThangNam);
            }
        }
        public double KM
        {
            get { return this.Km; }
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
        public double PARKING_GASOLINE
        {
            get { return this.Parking_Gasoline; }
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
