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
    public partial class TAMUNGLUONG : UserControl
    {
        public TAMUNGLUONG()
        {
            InitializeComponent();
            this.textBox1.Text = this.monthCalendar1.SelectionStart.Date.ToString("dd/MM/yyyy");
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button1_MouseHover(object sender, EventArgs e)
        {
           
        }

        private void button1_MouseLeave(object sender, EventArgs e)
        {
            
        }

        private void tableLayoutPanel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void buttonCalendar1_Click(object sender, EventArgs e)
        {
            if (this.groupBox1.Visible == false)
            {
                groupBox1.Show();
            }
            else
            {
                groupBox1.Hide();
            }
        }

        private void buttonCalendar2_Click(object sender, EventArgs e)
        {
            if (this.groupBox2.Visible == false)
            {
                groupBox2.Show();
            }
            else
            {
                groupBox2.Hide();
            }
        }

        private void monthCalendar1_DateChanged(object sender, DateRangeEventArgs e)
        {
            this.textBox1.Text = this.monthCalendar1.SelectionStart.Date.ToString("dd/MM/yyyy");
            this.groupBox1.Visible = false;
        }
        private void monthCalendar2_DateChanged(object sender, DateRangeEventArgs e)
        {
            DateTime t1 = this.monthCalendar1.SelectionStart.Date;// lay ngay nhap o textbox 1
            DateTime t2 = this.monthCalendar2.SelectionStart.Date;// lay ngay nhap o textbox 2
            if (DateTime.Compare(t1, t2) > 0)
            {
                MessageBox.Show("ngày nhập vào phải sau ngày " + this.textBox1.Text);
            }
            else
            {
                this.textBox2.Text = this.monthCalendar2.SelectionStart.Date.ToString("dd/MM/yyyy");
            }
            this.groupBox2.Visible = false;
        }
    }
}
