using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApp1.Properties;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        private bool isCollapsed;
        bool drag = false;
        Point start_point = new Point(0, 0);
        public Form1()
        {
            InitializeComponent();
            //data.spUpdateDayOfTakeLeaveForStaff();
        }
        protected override void WndProc(ref Message m)
        {
            switch (m.Msg)
            {
                case 0x84:
                    base.WndProc(ref m);
                    if ((int)m.Result == 0x1)
                        m.Result = (IntPtr)0x2;
                    return;
            }

            base.WndProc(ref m);
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            this.quanlynhansu1.Show();
            this.quanlynhansu1.LoadData();
            this.quanlyngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyluong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

        }
        private void header_MouseDown(object sender, MouseEventArgs e)
        {
            drag = true;
            start_point = new Point(e.X, e.Y);
        }
        private void header_MouseMove(object sender, MouseEventArgs e)
        {
            if(drag)
            {
                Point p = PointToScreen(e.Location);
                this.Location = new Point(p.X - start_point.X, p.Y - start_point.Y);
            }
        }

        private void header_MouseUp(object sender, MouseEventArgs e)
        {
            drag = false;
        }
        private void timer1_Tick(object sender, EventArgs e)
        {
            if (isCollapsed)
            {
                btnPayroll.Image = Resources.icons8_chevron_down_24;
                panelDropDown.Height += 10;
                if(panelDropDown.Size == panelDropDown.MaximumSize)
                {
                    timer1.Stop();
                    isCollapsed = false;
                }
            }
            else
            {
                btnPayroll.Image = Resources.icons8_chevron_up_24;
                panelDropDown.Height -= 10;
                if (panelDropDown.Size == panelDropDown.MinimumSize)
                {
                    timer1.Stop();
                    isCollapsed = true;
                }
            }
                

        }
        private void btnDashBoard_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Show();
            this.quanlyngaynghi1.Hide();
            this.quanlyluong1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

            this.btnDashBoard.BackColor = Color.FromArgb(69, 69, 69);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(21, 23, 22);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
        }

        private void btnDayOFF_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Show();
            this.quanlyngaynghi1.LoadData();
            this.quanlyluong1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

            this.btnDayOFF.BackColor = Color.FromArgb(69, 69, 69);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(21, 23, 22);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
        }

        private void btnPayroll_Click(object sender, EventArgs e)
        {
            this.timer1.Start();
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Hide();
            this.quanlyluong1.Show();
            this.quanlyluong1.LoadData();
            this.quanlygiocong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

            this.btnPayroll.BackColor = Color.FromArgb(69, 69, 69);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
        }

        private void btnWorkingHours_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Hide();
            this.quanlygiocong1.Show();
            this.quanlygiocong1.LoadData();
            this.quanlyluong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

            this.btnWorkingHours.BackColor = Color.FromArgb(69, 69, 69);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
        }

        private void btnOT_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyluong1.Hide();
            this.quanlyot1.Show();
            this.quanlyot1.LoadData();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

            this.btnOT.BackColor = Color.FromArgb(69, 69, 69);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(21, 23, 22);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
        }

        private void tbnSetting_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyluong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Show();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Hide();

            this.tbnSetting.BackColor = Color.FromArgb(69, 69, 69);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(21, 23, 22);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
        }

        private void btnInsurance_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyluong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Show();
            this.quanlybaohiem1.LoadData();
            this.quanlythuetncn1.Hide();

            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(88, 88, 88);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnInsurance.BackColor = Color.FromArgb(69, 69, 69);
            this.btnPIT.BackColor = Color.FromArgb(44, 44, 44);
        }

        private void btnPIT_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.quanlyngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyluong1.Hide();
            this.quanlyot1.Hide();
            this.quanlythietlap1.Hide();
            this.quanlybaohiem1.Hide();
            this.quanlythuetncn1.Show();
            this.quanlythuetncn1.LoadData();

            this.tbnSetting.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDayOFF.BackColor = Color.FromArgb(21, 23, 22);
            this.btnPayroll.BackColor = Color.FromArgb(88, 88, 88);
            this.btnWorkingHours.BackColor = Color.FromArgb(21, 23, 22);
            this.btnDashBoard.BackColor = Color.FromArgb(21, 23, 22);
            this.btnOT.BackColor = Color.FromArgb(21, 23, 22);
            this.btnInsurance.BackColor = Color.FromArgb(55, 55, 55);
            this.btnPIT.BackColor = Color.FromArgb(69, 69, 69);
        }
    }
}
