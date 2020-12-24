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
    public partial class QUANLYTHIETLAP : UserControl
    {
        public QUANLYTHIETLAP()
        {
            InitializeComponent();
            this.thieT_LAP_GIO_CONG1.Hide();
            this.thieT_LAP_PHU_CAP1.Hide();
            
        }
        private void pnlWorkingHours_MouseEnter(object sender, EventArgs e)
        {

        }

        private void pnlWorkingHours_MouseLeave(object sender, EventArgs e)
        {
            this.pnlWorkingHours.BackColor = Color.FromArgb(0, 151, 167);
        }

        private void pnlPayroll_MouseEnter(object sender, EventArgs e)
        {

        }

        private void pnlPayroll_MouseLeave(object sender, EventArgs e)
        {
            this.pnlPayroll.BackColor = Color.FromArgb(250, 160, 0);
        }

        private void pnlBenefit_MouseEnter(object sender, EventArgs e)
        {

        }

        private void pnlBenefit_MouseLeave(object sender, EventArgs e)
        {
            this.pnlBenefit.BackColor = Color.FromArgb(56, 142, 60);
        }

        private void pnlWorkingHours_Click(object sender, EventArgs e)
        {
            this.thieT_LAP_GIO_CONG1.Show();
            this.thieT_LAP_GIO_CONG1.LoadData();
            this.thieT_LAP_PHU_CAP1.Hide();
        }

        private void pnlPayroll_Click(object sender, EventArgs e)
        {
            
            
        }

        private void pnlBenefit_Click(object sender, EventArgs e)
        {
            this.thieT_LAP_GIO_CONG1.Hide();
            this.thieT_LAP_PHU_CAP1.Show();
            this.thieT_LAP_PHU_CAP1.LoadData();
        }
    }
}
