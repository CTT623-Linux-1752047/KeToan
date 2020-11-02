using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class SETTING : UserControl
    {
        public SETTING()
        {
            InitializeComponent();
        }
        private void btnSettingDayOff_Click(object sender, EventArgs e)
        {
            this.btnSettingDayOff.BackColor = Color.DarkCyan;
            this.btnSettingPhuCap.BackColor = Color.MediumAquamarine;
            this.btnSettingBaoHiem.BackColor = Color.MediumAquamarine;
        }
        private void btnSettingPhuCap_Click(object sender, EventArgs e)
        {
            this.btnSettingDayOff.BackColor = Color.MediumAquamarine;
            this.btnSettingPhuCap.BackColor = Color.DarkCyan;
            this.btnSettingBaoHiem.BackColor = Color.MediumAquamarine;
        }
        private void btnSettingBaoHiem_Click(object sender, EventArgs e)
        {
            this.btnSettingDayOff.BackColor = Color.MediumAquamarine;
            this.btnSettingPhuCap.BackColor = Color.MediumAquamarine;
            this.btnSettingBaoHiem.BackColor = Color.DarkCyan;
        }

        private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void SETTING_Load(object sender, EventArgs e)
        {

        }
    }
}
