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
    public partial class Form1 : Form
    {
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        bool drag = false;
        Point start_point = new Point(0, 0);
        public Form1()
        {
            InitializeComponent();
            data.spUpdateDayOfTakeLeaveForStaff();
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
        private void button1_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Show();
            this.ngaynghi1.Hide();
            this.bangluongnhanvien1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyot1.Hide();

            this.button1.BackColor = Color.FromArgb(69, 69, 69);            
            this.button2.BackColor = Color.FromArgb(21, 23, 22);           
            this.button3.BackColor = Color.FromArgb(21, 23, 22);            
            this.button4.BackColor = Color.FromArgb(21, 23, 22);            
            this.button5.BackColor = Color.FromArgb(21, 23, 22);           
            this.button6.BackColor = Color.FromArgb(21, 23, 22);
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Show();
            this.ngaynghi1.LoadData();
            this.bangluongnhanvien1.Hide();
            this.quanlygiocong1.Hide();
            this.quanlyot1.Hide();

            this.button2.BackColor = Color.FromArgb(69, 69, 69);
            this.button1.BackColor = Color.FromArgb(21, 23, 22);
            this.button3.BackColor = Color.FromArgb(21, 23, 22);
            this.button4.BackColor = Color.FromArgb(21, 23, 22);
            this.button5.BackColor = Color.FromArgb(21, 23, 22);
            this.button6.BackColor = Color.FromArgb(21, 23, 22);
        }

        private void button3_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Hide();
            this.bangluongnhanvien1.Show();
            this.quanlygiocong1.Hide();
            this.quanlyot1.Hide();

            this.button3.BackColor = Color.FromArgb(69, 69, 69);
            this.button2.BackColor = Color.FromArgb(21, 23, 22);
            this.button1.BackColor = Color.FromArgb(21, 23, 22);
            this.button4.BackColor = Color.FromArgb(21, 23, 22);
            this.button5.BackColor = Color.FromArgb(21, 23, 22);
            this.button6.BackColor = Color.FromArgb(21, 23, 22);
        }

        private void button4_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Hide();
            this.quanlygiocong1.Show();
            this.quanlygiocong1.LoadData();
            this.bangluongnhanvien1.Hide();
            this.quanlyot1.Hide();

            this.button4.BackColor = Color.FromArgb(69, 69, 69);
            this.button2.BackColor = Color.FromArgb(21, 23, 22);
            this.button3.BackColor = Color.FromArgb(21, 23, 22);
            this.button1.BackColor = Color.FromArgb(21, 23, 22);
            this.button5.BackColor = Color.FromArgb(21, 23, 22);
            this.button6.BackColor = Color.FromArgb(21, 23, 22);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.quanlynhansu1.Show();
            this.quanlynhansu1.LoadData();
            this.ngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.bangluongnhanvien1.Hide();
            this.quanlyot1.Hide();
        }
        private void button6_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.bangluongnhanvien1.Hide();
            this.quanlyot1.Show();
            this.quanlyot1.LoadData();

            this.button6.BackColor = Color.FromArgb(69, 69, 69);
            this.button2.BackColor = Color.FromArgb(21, 23, 22);
            this.button3.BackColor = Color.FromArgb(21, 23, 22);
            this.button4.BackColor = Color.FromArgb(21, 23, 22);
            this.button5.BackColor = Color.FromArgb(21, 23, 22);
            this.button1.BackColor = Color.FromArgb(21, 23, 22);
        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Hide();
            this.quanlygiocong1.Hide();
            this.bangluongnhanvien1.Hide();
            this.quanlyot1.Hide();

            this.button5.BackColor = Color.FromArgb(69, 69, 69);
            this.button2.BackColor = Color.FromArgb(21, 23, 22);
            this.button3.BackColor = Color.FromArgb(21, 23, 22);
            this.button4.BackColor = Color.FromArgb(21, 23, 22);
            this.button1.BackColor = Color.FromArgb(21, 23, 22);
            this.button6.BackColor = Color.FromArgb(21, 23, 22);
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

        private void MinimumWindow_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void CloseWindow_Click(object sender, EventArgs e)
        {
            Close();
        }
        private void MaximumSize_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
        }
    }
}
