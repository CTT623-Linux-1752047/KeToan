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
    public partial class QUANLYBAOHIEM : UserControl
    {
        TinhTienLuongEntities data = new TinhTienLuongEntities();
        List<fnDisplayStaffFollowName_Result> lstStaff;
        public QUANLYBAOHIEM()
        {
            InitializeComponent();            
        }
        public void LoadData()
        {
            /*
            if(this.searchBar.Text == "" || this.searchBar.Text == null)
            {
                this.lstStaff = data.fnDisplayStaffFollowName("").ToList();
            }
            else
            {
                this.lstStaff = data.fnDisplayStaffFollowName(this.searchBar.Text).ToList();
            }
            */
            this.lstStaff = data.fnDisplayStaffFollowName(this.searchBar.Text).ToList();
            this.bunifuCustomDataGrid1.Rows.Clear();
            for (int i = 0; i < this.lstStaff.Count; i++)
            {
                Payroll payrollStaff = new Payroll(lstStaff[i].ID, this.txtMonthYear.Value);
                double totalInsuranceOfStaff = payrollStaff.HEALTHY_INSURANCE_STAFF + payrollStaff.SOCIAL_INSURANCE_STAFF + payrollStaff.UNEMPLOYTED_INSURANCE_STAFF;
                double totalInsuranceOfEnterprise = payrollStaff.HEALTHY_INSURANCE_ENTERPRISE + payrollStaff.SOCIAL_INSURANCE_ENTERPRISE + payrollStaff.UNEMPLOYTED_INSURANCE_ENTERPRISE;
                double totalInsurance = totalInsuranceOfEnterprise + totalInsuranceOfStaff;
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    lstStaff[i].HoVaTen,
                                                    payrollStaff.TOTAL_AMOUNT_IN_VND.ToString("#,##0"),
                                                    payrollStaff.SALARY_FOR_INSURANCE.ToString("#,##0"),
                                                    payrollStaff.SALARY_FOR_UNEMPLOYTED.ToString("#,##0"),
                                                    payrollStaff.HEALTHY_INSURANCE_STAFF.ToString("#,##0"),
                                                    payrollStaff.SOCIAL_INSURANCE_STAFF.ToString("#,##0"),
                                                    payrollStaff.UNEMPLOYTED_INSURANCE_STAFF.ToString("#,##0"),
                                                    totalInsuranceOfStaff.ToString("#,##0"),
                                                    payrollStaff.HEALTHY_INSURANCE_ENTERPRISE.ToString("#,##0"),
                                                    payrollStaff.SOCIAL_INSURANCE_ENTERPRISE.ToString("#,##0"),
                                                    payrollStaff.UNEMPLOYTED_INSURANCE_ENTERPRISE.ToString("#,##0"),
                                                    totalInsuranceOfEnterprise.ToString("#,##0"), 
                                                    totalInsurance.ToString("#,##0")
                                                    );
            }
            if(lstStaff.Count == 0)
            {
                this.lbNoData.Show();
            }
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
    }
}
