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
        public Form1()
        {
            InitializeComponent();
            
        }
        private void button1_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Show();
            this.ngaynghi1.Hide();
            this.bangluong1.Hide();
            this.tamungluong1.Hide();

            this.button1.BackColor = Color.PaleGreen;
            this.button1.FlatAppearance.BorderColor = Color.PaleGreen;
            this.button2.BackColor = Color.MediumSeaGreen;
            this.button2.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button3.BackColor = Color.MediumSeaGreen;
            this.button3.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button4.BackColor = Color.MediumSeaGreen;
            this.button4.FlatAppearance.BorderColor = Color.MediumSeaGreen;
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Show();
            this.bangluong1.Hide();
            this.tamungluong1.Hide();

            this.button2.BackColor = Color.PaleGreen;
            this.button2.FlatAppearance.BorderColor = Color.PaleGreen;
            this.button1.BackColor = Color.MediumSeaGreen;
            this.button1.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button3.BackColor = Color.MediumSeaGreen;
            this.button3.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button4.BackColor = Color.MediumSeaGreen;
            this.button4.FlatAppearance.BorderColor = Color.MediumSeaGreen;
        }

        private void button3_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Hide();
            this.bangluong1.Show();
            this.tamungluong1.Hide();

            this.button3.BackColor = Color.PaleGreen;
            this.button3.FlatAppearance.BorderColor = Color.PaleGreen;
            this.button2.BackColor = Color.MediumSeaGreen;
            this.button2.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button1.BackColor = Color.MediumSeaGreen;
            this.button1.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button4.BackColor = Color.MediumSeaGreen;
            this.button4.FlatAppearance.BorderColor = Color.MediumSeaGreen;
        }

        private void button4_Click_1(object sender, EventArgs e)
        {
            this.quanlynhansu1.Hide();
            this.ngaynghi1.Hide();
            this.bangluong1.Hide();
            this.tamungluong1.Show();

            this.button4.BackColor = Color.PaleGreen;
            this.button4.FlatAppearance.BorderColor = Color.PaleGreen;
            this.button2.BackColor = Color.MediumSeaGreen;
            this.button2.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button3.BackColor = Color.MediumSeaGreen;
            this.button3.FlatAppearance.BorderColor = Color.MediumSeaGreen;
            this.button1.BackColor = Color.MediumSeaGreen;
            this.button1.FlatAppearance.BorderColor = Color.MediumSeaGreen;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.quanlynhansu1.Show();
            this.ngaynghi1.Hide();
            this.bangluong1.Hide();
            this.tamungluong1.Hide();
        }

        private void quanlynhansu1_Load(object sender, EventArgs e)
        {

        }
    }
}
