using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;



namespace WindowsFormsApp1
{
    public partial class NGAYNGHI : UserControl
    {
        private FormWindowState WindowState;

        public NGAYNGHI()
        {
           InitializeComponent();
           
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
        private void button9_Click(object sender, EventArgs e)
        {
            Form formBackground = new Form();
            try
            {
                using (CREATEOFFDAY frmOffDay = new CREATEOFFDAY())
                {
                    formBackground.StartPosition = FormStartPosition.CenterScreen;
                    formBackground.FormBorderStyle = FormBorderStyle.None;
                    formBackground.Size = new Size(1484, 811);
                    formBackground.Opacity = .80d;
                    formBackground.BackColor = Color.Black;
                    formBackground.WindowState = FormWindowState.Normal;
                    formBackground.TopMost = true;
                    formBackground.Location = this.Location;
                    formBackground.ShowInTaskbar = false;
                    formBackground.Show();

                    frmOffDay.Owner = formBackground;

                    frmOffDay.ShowDialog();
                    formBackground.Dispose();
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            
        }

       
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form formBackground = new Form();
            DataSet ds = new DataSet();
            try
            {
                using (CREATEOFFDAY frmOffDay = new CREATEOFFDAY(ds))
                {
                    
                    formBackground.StartPosition = FormStartPosition.CenterScreen;
                    formBackground.FormBorderStyle = FormBorderStyle.None;
                    formBackground.Size = new Size(1484, 811);
                    formBackground.Opacity = .80d;
                    formBackground.BackColor = Color.Black;
                    formBackground.WindowState = FormWindowState.Normal;
                    formBackground.TopMost = true;
                    formBackground.Location = this.Location;
                    formBackground.ShowInTaskbar = false;
                    formBackground.Show();

                    frmOffDay.Owner = formBackground;

                    frmOffDay.ShowDialog();
                    formBackground.Dispose();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }

        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            if (this.dateTimePicker2.Value < this.dateTimePicker1.Value)
            {
                MessageBox.Show("Ngày không đúng định dạng ");
                this.dateTimePicker2.Value = this.dateTimePicker1.Value;
            }
        }
    }
}
