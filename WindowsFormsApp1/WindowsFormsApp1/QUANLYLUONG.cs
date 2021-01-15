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
    public partial class QUANLYLUONG : UserControl
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        List<fnDisplayStaffFollowName_Result> lstStaff;
        public QUANLYLUONG()
        {
            InitializeComponent();
        }
        public void LoadData()
        {
            this.bunifuCustomDataGrid1.Rows.Clear();
            this.lstStaff = data.fnDisplayStaffFollowName(this.txtSearchName.Text).ToList();
            if(this.lstStaff.Count == 0 )
            {
                this.lbNoData.Show();
            }
            else
            {
                for (int i = 0; i < lstStaff.Count; i++)
                {
                    this.lbNoData.Hide();
                    Payroll payrollStaff = new Payroll(lstStaff[i].ID, this.txtThangNam.Value);
                    this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                         lstStaff[i].HoVaTen,
                                                         payrollStaff.SALARY_BASIC.ToString("#,##0"),
                                                         payrollStaff.KM.ToString("#,##0"),
                                                         payrollStaff.RESPONSI_JAPANESE.ToString("#,##0"),
                                                         payrollStaff.SALARY_DEDUCTION.ToString("#,##0"),
                                                         payrollStaff.OT_SALARY.ToString("#,##0"),
                                                         payrollStaff.BENEFIT.ToString("#,##0"),
                                                         payrollStaff.BONUS.ToString("#,##0"),
                                                         payrollStaff.PAYBACK.ToString("#,##0"),
                                                         (payrollStaff.PARKING_GASOLINE).ToString("#,##0"),
                                                         payrollStaff.TOTAL_AMOUNT.ToString("#,##0"),
                                                         payrollStaff.TOTAL_AMOUNT_IN_VND.ToString("#,##0"),
                                                         (payrollStaff.HEALTHY_INSURANCE_STAFF
                                                         + payrollStaff.SOCIAL_INSURANCE_STAFF
                                                         + payrollStaff.UNEMPLOYTED_INSURANCE_STAFF).ToString("#,##0"),
                                                         payrollStaff.PIT_PAYEMENT.ToString("#,##0"),
                                                         (payrollStaff.TOTAL_AMOUNT
                                                         - payrollStaff.HEALTHY_INSURANCE_STAFF
                                                         - payrollStaff.SOCIAL_INSURANCE_STAFF
                                                         - payrollStaff.UNEMPLOYTED_INSURANCE_STAFF
                                                         - payrollStaff.PIT_PAYEMENT).ToString("#,##0"));
                }
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void txtThangNam_ValueChanged(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}
                                                                                                                                                                                                                                                                                                                                                 