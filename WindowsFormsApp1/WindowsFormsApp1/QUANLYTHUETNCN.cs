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
    public partial class QUANLYTHUETNCN : UserControl
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        public QUANLYTHUETNCN()
        {
            InitializeComponent();
        }
        public void LoadData()
        {
            this.bunifuCustomDataGrid1.Rows.Clear();
            List<fnDisplayStaffFollowName_Result> lstStaff = data.fnDisplayStaffFollowName(this.txtSearchName.Text).ToList();
            for (int i = 0; i < lstStaff.Count; i++)
            {
                Payroll payrollStaff = new Payroll(lstStaff[i].ID, this.txtThangNam.Value);
                double InsuranceDeduction = payrollStaff.HEALTHY_INSURANCE_STAFF + payrollStaff.SOCIAL_INSURANCE_STAFF + payrollStaff.UNEMPLOYTED_INSURANCE_STAFF;
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    lstStaff[i].HoVaTen,
                                                    payrollStaff.TOTAL_AMOUNT_IN_VND.ToString("#,##0"),
                                                    payrollStaff.PAYBACK.ToString("#,##0"),
                                                    InsuranceDeduction.ToString("#,##0"),
                                                    payrollStaff.OT_DEDUCTION.ToString("#,##0"),
                                                    payrollStaff.PERSONAL_DEDUCTION.ToString("#,##0"),
                                                    payrollStaff.AMOUNT_DEPENDENT_PERSONAL_DEDUCTION.ToString("#,##0"),
                                                    payrollStaff.NUM_DEPENDENT_PERSONAL.ToString("#,##0"),
                                                    payrollStaff.TAXABLE_INCOME.ToString("#,##0"),
                                                    payrollStaff.PIT_PAYEMENT.ToString("#,##0")
                                                    );
                if(lstStaff.Count == 0)
                {
                    this.lbNoData.Show();
                }
                else
                {
                    this.lbNoData.Hide();
                }
            }
        }

        private void txtThangNam_ValueChanged(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}
