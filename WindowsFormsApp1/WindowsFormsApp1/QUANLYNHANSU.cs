using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using TinhLuongBackEnd;
using System.Runtime.InteropServices;

namespace WindowsFormsApp1
{
    public partial class QUANLYNHANSU : UserControl
    {
        private DataTable dt;
        private List<NHANSU> listEmployeeTemp;
        public QUANLYNHANSU()
        {
            InitializeComponent();
            
            string query = "SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'";
            GetDataToGridView(query);
        }
        public void GetDataToGridView(string query)
        {
            CONNECT_DB conn = new CONNECT_DB();
            DataSet ds = conn.GetDBToDS(query, "Employee");
            conn.CloseDB();

            this.bunifuCustomDataGrid1.Rows.Clear();
            //this.bunifuCustomDataGrid1.AutoGenerateColumns = false; 
            //this.bunifuCustomDataGrid1.DataSource = ds.Tables["Employee"];
            
            dt = ds.Tables["Employee"];
            listEmployeeTemp = new List<NHANSU>();
            foreach (DataRow row in dt.Rows)
            {
                listEmployeeTemp.Add(new NHANSU(row));
                string[] temp = new string[] { (string)row["UserName"], (string)row["HoVaTen"], ((DateTime)row["NgaySinh"]).ToString("dd/MM/yyyy"), (string)row["GioiTinh"], (string)row["SoHDLD"], (string)row["LoaiHDLD"], ((DateTime)row["NgayBatDau"]).ToString("dd/MM/yyyy"), Convert.ToString(row["ThoiHanHDLD"]) };
                this.bunifuCustomDataGrid1.Rows.Add(temp);
            }
        }
        private void searchTextBox_TextChanged(object sender, EventArgs e)
        {
            string query = "SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc' AND HoVaTen LIKE N'%"+ this.searchBar.Text + "%'";
            GetDataToGridView(query);
        }
        private void bunifuCustomDataGrid1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            RegisterUser updateUser = new RegisterUser(listEmployeeTemp[e.RowIndex].ID);
            updateUser.ShowDialog();

            GetDataToGridView("SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'");
        }
        //button add user 
        private void button3_Click(object sender, EventArgs e)
        {
            RegisterUser registerUser = new RegisterUser();
            registerUser.ShowDialog();
            GetDataToGridView("SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'");
        }
        //multi selected được lưu theo nguyên tắc LIFO button delete user
        private void button2_Click(object sender, EventArgs e)
        {
            CONNECT_DB conn = new CONNECT_DB();
            for(int i =0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
            {
                //update lai trang thai cua cac row selected = Nghĩ việc -> thực hiện chức năng xóa delete User 
                string query = "UPDATE NHANSU SET TrangThaiLamViec = N'Nghĩ việc' WHERE UserID = " + listEmployeeTemp[this.bunifuCustomDataGrid1.SelectedRows[i].Index].USERID;
                conn.ExecuteNonQuery(query);
                listEmployeeTemp.RemoveAt(this.bunifuCustomDataGrid1.SelectedRows[i].Index);
            }
            conn.CloseDB();
            GetDataToGridView("SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'");
        }       
    }
}
