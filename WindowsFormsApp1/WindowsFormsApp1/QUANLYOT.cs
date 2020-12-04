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
    public partial class QUANLYOT : UserControl
    {
        TinhTienLuongEntities data = new TinhTienLuongEntities();
        List<fnDisplayOT_AmountOTStaffOfMonth_Result> lstStaffOT;
        public QUANLYOT()
        {
            InitializeComponent();
        }

        private void pictureBox2_Click(object sender, EventArgs e)
        {
            this.create_HOURS_OT1.Visible = !(this.create_HOURS_OT1.Visible);
            this.create_HOURS_OT1.LoadData();
        }
        public void LoadData()
        {
            if(this.searchBar.Text == "" || this.searchBar.Text == null)
            {
                lstStaffOT = data.fnDisplayOT_AmountOTStaffOfMonth("", this.MonthYear.Value).ToList();
            }
            else
            {
                lstStaffOT = data.fnDisplayOT_AmountOTStaffOfMonth(this.searchBar.Text, this.MonthYear.Value).ToList();
            }
            this.bunifuCustomDataGrid1.Rows.Clear();
            for(int i = 0; i < this.lstStaffOT.Count; i++)
            {
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    this.lstStaffOT[i].HoVaTen,
                                                    (this.lstStaffOT[i].C17h___21h.HasValue) ? this.lstStaffOT[i].C17h___21h.Value.ToString() : "0",
                                                    (this.lstStaffOT[i].C21h___5h.HasValue) ? this.lstStaffOT[i].C21h___5h.Value.ToString() : "0",
                                                    (this.lstStaffOT[i].Saturday___Sunday.HasValue) ? this.lstStaffOT[i].Saturday___Sunday.Value.ToString() : "0",
                                                    (this.lstStaffOT[i].Total_hours.HasValue) ? this.lstStaffOT[i].Total_hours.Value.ToString() : "0",
                                                    (this.lstStaffOT[i].Amount_17h___21h.HasValue) ? this.lstStaffOT[i].Amount_17h___21h.Value.ToString("#,##0") : "0",
                                                    (this.lstStaffOT[i].Amount_21h___5h.HasValue) ? this.lstStaffOT[i].Amount_21h___5h.Value.ToString("#,##0") : "0",
                                                    (this.lstStaffOT[i].Amount_Saturday___Sunday.HasValue) ? this.lstStaffOT[i].Amount_Saturday___Sunday.Value.ToString("#,##0") : "0",
                                                    (this.lstStaffOT[i].TotalWithoutTax.HasValue) ? this.lstStaffOT[i].TotalWithoutTax.Value.ToString("#,##0") : "0",
                                                    (this.lstStaffOT[i].Tax.HasValue) ? this.lstStaffOT[i].Tax.Value.ToString("#,##0") : "0",
                                                    (this.lstStaffOT[i].TotalAmountWithTax.HasValue) ? this.lstStaffOT[i].TotalAmountWithTax.Value.ToString("#,##0") : "0");
            }
            if (lstStaffOT.Count == 0)
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

        private void bunifuCustomDataGrid1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (lstStaffOT[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value)-1].ID != -1)
            {
                EDIT_WORKING_OT_OF_STAFF edit = new EDIT_WORKING_OT_OF_STAFF(lstStaffOT[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID, this.MonthYear.Value);
                edit.ShowDialog();
                LoadData();
            }
        }
    }
}
