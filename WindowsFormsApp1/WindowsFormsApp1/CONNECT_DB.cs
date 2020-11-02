using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Globalization;
using System.Windows.Forms;
using System.Data;

namespace WindowsFormsApp1
{
    class CONNECT_DB
    {
        private SqlConnection connectionDB;
        private string dataSource = "Data Source=HUUVV-PC;Initial Catalog=TinhTienLuong;Integrated Security=True";
        
        public CONNECT_DB()
        {            
            try
            {
                this.connectionDB = new SqlConnection(this.dataSource);
                this.connectionDB.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Can't connect DB");
            }
        }
        public void CloseDB()
        {
            this.connectionDB.Close();
        }
        public DataSet GetDBToDS(string query, string nameTableDataSet)
        {
            var dataAdapter = new SqlDataAdapter(query, this.connectionDB);
            var dataSet = new DataSet();
            dataAdapter.Fill(dataSet, nameTableDataSet);
            return dataSet;
        }
        public int ExecuteNonQuery(string query)
        {
            int a = 0;
            try
            {
                using(SqlCommand sqlComm = this.connectionDB.CreateCommand())
                {
                    sqlComm.CommandText = query;
                    a = sqlComm.ExecuteNonQuery();
                }
                if (a > 0)
                {
                    MessageBox.Show("Tác vụ thành công ");
                }
                else
                    MessageBox.Show("Tác vụ thất bại !!!! ");
            }
            catch(Exception ex)
            {
                MessageBox.Show("Lỗi update user : " + ex);
            }
            //new
            return a;
        }
    }
}
