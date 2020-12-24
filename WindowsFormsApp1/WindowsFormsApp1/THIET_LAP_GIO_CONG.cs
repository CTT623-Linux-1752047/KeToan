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
    public partial class THIET_LAP_GIO_CONG : UserControl
    {
        public THIET_LAP_GIO_CONG()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }
        public void LoadData()
        {
            TinhTienLuongEntities data = new TinhTienLuongEntities();
            lsttTitleWorkingHours.DataSource = data.LOAI_GIO_CONG.ToList();
            lsttTitleWorkingHours.DisplayMember = "LoaiGioCong";
            lsttTitleWorkingHours.ValueMember = "ID";

            lstbTitleOFFDAYS.DataSource = data.LOAINGAYNGHIs.ToList();
            lstbTitleOFFDAYS.DisplayMember = "TenNgayNghi";
            lstbTitleOFFDAYS.ValueMember = "ID";

            List<TYPE_RANGE_HOURS_OT> lstOT = data.TYPE_RANGE_HOURS_OT.ToList();
            if(lstOT.Count != 0)
            {
                for(int i = 0; i < lstOT.Count; i++)
                {
                    this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                        lstOT[i].RangeHours,
                                                        lstOT[i].PercentAmountOT.HasValue ? lstOT[i].PercentAmountOT.Value : 0);
                }
            }
        }

        private void chkbTakeLeave_Click(object sender, EventArgs e)
        {
            if(this.chkbNoTakeLeave.Checked == this.chkbTakeLeave.Checked)
            {
                this.chkbNoTakeLeave.Checked = !this.chkbNoTakeLeave.Checked;
            }
        }

        private void chkbNoTakeLeave_Click(object sender, EventArgs e)
        {
            if (this.chkbNoTakeLeave.Checked == this.chkbTakeLeave.Checked)
            {
                this.chkbTakeLeave.Checked = !this.chkbTakeLeave.Checked;
            }
        }

        private void lsttTitleWorkingHours_DoubleClick(object sender, EventArgs e)
        {

        }

    }
}
