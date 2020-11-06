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
using System.Runtime.InteropServices;


namespace WindowsFormsApp1
{
    public partial class QUANLYNHANSU : UserControl
    {
        private DataTable dt;
        private List<NHANVIEN> ListEmployee;
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
            dt = ds.Tables["Employee"];
            this.ListEmployee = new List<NHANVIEN>();
            foreach (DataRow row in dt.Rows)
            {
                this.ListEmployee.Add(new NHANVIEN(row));
                string[] temp = new string[] { (string)row["UserName"], (string)row["HoVaTen"], ((DateTime)row["NgaySinh"]).ToString("dd/MM/yyyy"), (string)row["GioiTinh"], (string)row["SoHDLD"], (string)row["LoaiHDLD"], ((DateTime)row["NgayBatDau"]).ToString("dd/MM/yyyy"), Convert.ToString(row["ThoiHanHDLD"]) };
                this.bunifuCustomDataGrid1.Rows.Add(temp);
            }
        }
        //button add user 
        private void button3_Click(object sender, EventArgs e)
        {
            THONGTINNHANVIEN InformationEmployee = new THONGTINNHANVIEN();
            InformationEmployee.ShowDialog();
            GetDataToGridView("SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'");
        }
        //multi selected được lưu theo nguyên tắc LIFO - button delete user
        private void button2_Click(object sender, EventArgs e)
        {
            CONNECT_DB conn = new CONNECT_DB();
            for(int i =0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
            {
                //update lai trang thai cua cac row selected = Nghĩ việc -> thực hiện chức năng xóa delete User 
                
                string query = "UPDATE NHANSU SET TrangThaiLamViec = N'Nghĩ việc' WHERE ID = " + this.ListEmployee[this.bunifuCustomDataGrid1.SelectedRows[i].Index].ID;
                conn.ExecuteNonQuery(query);
                this.ListEmployee.RemoveAt(this.bunifuCustomDataGrid1.SelectedRows[i].Index);
            }
            conn.CloseDB();
            GetDataToGridView("SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'");
        }
        //nút tìm kiếm 
        private void button1_Click(object sender, EventArgs e)
        {
            string query = "SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc' AND HoVaTen LIKE N'%" + this.searchBar.Text + "%'";
            GetDataToGridView(query);
        }
        //double click để mở form Thông tin chi tiết nhân viên 
        private void bunifuCustomDataGrid1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            THONGTINNHANVIEN updateUser1 = new THONGTINNHANVIEN(this.ListEmployee[e.RowIndex].ID);
            updateUser1.ShowDialog();
            GetDataToGridView("SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghĩ việc'");
        }
    }
}
