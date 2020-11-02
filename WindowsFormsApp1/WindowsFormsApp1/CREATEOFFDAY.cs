using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TinhLuongBackEnd;

namespace WindowsFormsApp1
{
    public partial class CREATEOFFDAY : Form
    {
        private DataTable dt;
        private List<NHANSU> listEmployeeTemp;
        public CREATEOFFDAY()
        {
            InitializeComponent();
            CONNECT_DB conn = new CONNECT_DB();
            this.btnTaoNgay.Show();
            this.btnCapNhat.Hide();
            DataSet ds = conn.GetDBToDS("SELECT * FROM LOAINGAYNGHI", "DayOFF");
            conn.CloseDB();
            
        }
        public CREATEOFFDAY(DataSet ds)
        {
            InitializeComponent();
            this.btnCapNhat.Show();
            this.btnTaoNgay.Hide();
            this.txtSearchBar.Enabled = false;
            this.btnSearch.Enabled = false;  
        }
        private void bunifuCustomDataGrid1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            string query = "SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc' AND HoVaTen LIKE N'%" + this.txtSearchBar.Text + "%'";
            
            GetDataToGridViewSearchUser(query);
        }
        public void GetDataToGridViewSearchUser(string query)
        {
            //thực hiện fill data vào dataset từ DB 
            CONNECT_DB conn = new CONNECT_DB();
            DataSet ds = conn.GetDBToDS(query, "Employee");
            conn.CloseDB();
            //thự hiện hiển thị dat vào datagridview từ dataset 
            this.bunifuCustomDataGrid1.Rows.Clear();
            dt = ds.Tables["Employee"];
            listEmployeeTemp = new List<NHANSU>();
            int i = 0;
            
            
            foreach (DataRow row in dt.Rows)
            {
                i++;
                listEmployeeTemp.Add(new NHANSU(row));
                Object[] temp = new object[] { false, i, (string)row["UserName"] ,(string)row["HoVaTen"], ""};
                this.bunifuCustomDataGrid1.Rows.Add(temp);
                this.bunifuCustomDataGrid1.Columns[0].ReadOnly = false;
            }
        }

        private void bunifuCustomDataGrid1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void bunifuCustomDataGrid2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (this.checkBoxOFFAllDay.Checked == true)
            {
                this.dateTimePicker1.CustomFormat = "dd-MM-yyyy";
                this.dateTimePicker2.CustomFormat = "dd-MM-yyyy";
            }
            else
            {
                this.dateTimePicker1.CustomFormat = "dd-MM-yyyy HH:mm";
                this.dateTimePicker2.CustomFormat = "dd-MM-yyyy HH:mm";
            }

        }

        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            if (this.dateTimePicker1.Value > this.dateTimePicker2.Value)
            {
                MessageBox.Show("Khoảng thời gian nghỉ không hợp lệ");
                this.dateTimePicker2.Value = this.dateTimePicker1.Value;
            }
        }

        private void btnCapNhat_Click(object sender, EventArgs e)
        {

        }
    }
}
