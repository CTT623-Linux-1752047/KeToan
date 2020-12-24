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
    public partial class CREATE_HOURS_OT : UserControl
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        public EventHandler addDataSuccess;
        public CREATE_HOURS_OT()
        {
            InitializeComponent();
        }

        private void CREATE_HOURS_OT_Load(object sender, EventArgs e)
        {

        }
        public void LoadData()
        {
            List<fnDisplayStaffFollowName_Result> lstStaff = data.fnDisplayStaffFollowName("").OrderBy(o => o.UserName).ToList();
            this.cbNameOfStaff.DataSource = lstStaff;
            this.cbNameOfStaff.DisplayMember = "HoVaTen";
            this.cbNameOfStaff.ValueMember = "ID";
            
            
            
            this.cbRangeHoursOT.DataSource = data.TYPE_RANGE_HOURS_OT.SqlQuery("SELECT * FROM TYPE_RANGE_HOURS_OT").ToList();
            this.cbRangeHoursOT.DisplayMember = "RangeHours";
            this.cbRangeHoursOT.ValueMember = "ID";
        }

        private void cbNameOfStaff_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(this.cbNameOfStaff.SelectedIndex > 0)
            {
                this.lbUserName.Text = data.NHANSUs.SqlQuery("SELECT * FROM NHANSU WHERE ID = " + this.cbNameOfStaff.SelectedValue).FirstOrDefault().UserName;
            }
        }
        //btn Add OT 
        private void button1_Click_1(object sender, EventArgs e)
        {
            if(this.txtOTHours.Text == null)
            {
                MessageBox.Show("Cần nhập số giờ OT");
            }
            else
            {
                DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
                if (confirm == DialogResult.Yes)
                {
                    NHANVIEN_OT OTOfStaff = new NHANVIEN_OT();
                    OTOfStaff.ID_NhanVien = Convert.ToInt32(this.cbNameOfStaff.SelectedValue);
                    OTOfStaff.DateDangKy = this.DateCreateOT.Value;
                    OTOfStaff.SoGioOT = Convert.ToDouble(this.txtOTHours.Text);
                    OTOfStaff.ID_Range_Hours_OT = Convert.ToInt32(this.cbRangeHoursOT.SelectedValue);
                    data.NHANVIEN_OT.Add(OTOfStaff);
                    int resultCreate = data.SaveChanges();
                    if (resultCreate < 1)
                    {
                        MessageBox.Show("Thêm thất bại !!!");
                    }
                    else
                    {
                        MessageBox.Show("Thêm thành công");
                        this.lbUserName.Text = "";
                        this.cbRangeHoursOT.SelectedValue = -1;
                        this.cbNameOfStaff.SelectedValue = -1;
                        this.txtOTHours.Text = "";
                        if (addDataSuccess != null) 
                            addDataSuccess(this, null);
                    }
                }
            }
        }
    }
}
