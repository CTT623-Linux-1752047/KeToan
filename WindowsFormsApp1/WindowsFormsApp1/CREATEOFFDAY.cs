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
    public partial class CREATEOFFDAY : Form
    {
        private TinhTienLuongEntities data;
        private DataTable dt;
        private List<NHANVIEN> listEmployeeTemp;
        private List<fnDisplayTitleOFFDay_Result> listTitleOFFDay;
        public CREATEOFFDAY()
        {
            InitializeComponent();
           
            this.btnTaoNgay.Show();
            this.btnCapNhat.Hide();
            data = new TinhTienLuongEntities();
            this.listTitleOFFDay = data.fnDisplayTitleOFFDay().ToList();
            this.TitleOFFDay.DataSource = this.listTitleOFFDay;
            this.TitleOFFDay.DisplayMember = "TenNgayNghi";
            this.TitleOFFDay.ValueMember = "ID";
            GetDataToGridViewSearchUser("SELECT * FROM NHANSU WHERE NHANSU.TrangThaiLamViec NOT LIKE N'%Nghĩ việc%'");
        }
        public CREATEOFFDAY(DataSet ds)
        {
            InitializeComponent();
            this.btnCapNhat.Show();
            this.btnTaoNgay.Hide();
            this.txtSearchBar.Enabled = false;
            this.btnSearch.Enabled = false;  
        }
        private void 
        public void GetDataToGridViewSearchUser(string query)
        {
            //thực hiện fill data vào dataset từ DB 
            CONNECT_DB conn = new CONNECT_DB();
            DataSet ds = conn.GetDBToDS(query, "Employee");
            conn.CloseDB();
            //thực hiện hiển thị data vào datagridview từ dataset 
            this.bunifuCustomDataGrid1.Rows.Clear();
            dt = ds.Tables["Employee"];
            listEmployeeTemp = new List<NHANVIEN>();
            int i = 0;            
            foreach (DataRow row in dt.Rows)
            {
                i++;
                listEmployeeTemp.Add(new NHANVIEN(row));
                Object[] temp = new object[] {false,i, (string)row["UserName"] ,(string)row["HoVaTen"], ""};
                this.bunifuCustomDataGrid1.Rows.Add(temp);
            }
        }
        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (this.checkBoxOFFAllDay.Checked == true)
            {
                this.txtNgayBatDau.CustomFormat = "dd-MM-yyyy";
                this.txtNgayKetThuc.CustomFormat = "dd-MM-yyyy";
            }
            else
            {
                this.txtNgayBatDau.CustomFormat = "dd-MM-yyyy HH:mm";
                this.txtNgayKetThuc.CustomFormat = "dd-MM-yyyy HH:mm";
            }
        }
        private void btnCapNhat_Click(object sender, EventArgs e)
        {

        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            string query = "SELECT * FROM NHANSU WHERE TrangThaiLamViec != N'Nghỉ việc' AND HoVaTen LIKE N'%" + this.txtSearchBar.Text + "%'";
            GetDataToGridViewSearchUser(query);
        }
        //thực hiện click checkbox từng dòng 
        private void bunifuCustomDataGrid1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.ColumnIndex == 0)
            {
                DataGridViewCheckBoxCell temp = (DataGridViewCheckBoxCell)this.bunifuCustomDataGrid1.Rows[e.RowIndex].Cells[e.ColumnIndex];
                temp.Value = !Convert.ToBoolean(temp.Value);
            }
        }
        private void typeOffDay_SelectedIndexChanged(object sender, EventArgs e)
        {
            MessageBox.Show(this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].LoaiNgayNghi );
            if (this.TitleOFFDay.SelectedIndex > -1)
            {
                this.txtNameOfOFFDay.Text = this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].TenNgayNghi;
                if (this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].LoaiNgayNghi.Replace(" ","") == "CoPhep")
                {
                    this.TypeOFFDay.SetSelected(0, true);
                    MessageBox.Show("Yes");
                }
                else
                {
                    this.TypeOFFDay.SetSelected(1, true);
                    MessageBox.Show("No");
                }
                if( this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].ThoiGian != null)
                {
                    checkBoxOFFAllDay.Checked = true;
                    this.txtNgayKetThuc.Value = this.txtNgayBatDau.Value.AddDays((double)this.listTitleOFFDay[this.TitleOFFDay.SelectedIndex].ThoiGian);
                }
                else
                {
                    checkBoxOFFAllDay.Checked = false;
                }
            }
        }

        private void btnTaoNgay_Click(object sender, EventArgs e)
        {
            DialogResult confirm = MessageBox.Show("Do you want to save changes?", "Confirmation", MessageBoxButtons.YesNoCancel);
            if (confirm == DialogResult.Yes)
            {
                string NgayBatDau = this.txtNgayBatDau.Value.ToString("yyyy/MM/dd").Replace(" ", "").Replace("/", "");
                string NgayKetThuc = this.txtNgayKetThuc.Value.ToString("yyyy/MM/dd").Replace(" ", "").Replace("/", "");
                CONNECT_DB conn = new CONNECT_DB();
                for (int i = 0; i < this.bunifuCustomDataGrid1.SelectedRows.Count; i++)
                {
                    string query = "INSERT INTO NHANVIEN_LOAINGAYNGHI(NgayBatDau,ID_NhanVien,ID_LoaiNgayNghi,NgayKetThuc,LyDo) VALUES " +
                                "(  '" + NgayBatDau +
                                    "'," + this.listEmployeeTemp[this.bunifuCustomDataGrid1.SelectedRows[i].Index].ID +
                                    "," + (int)((DataRowView)this.TitleOFFDay.SelectedItem)["ID"] +
                                    ",'" + NgayKetThuc +
                                    "',N'" + this.txtNameOfOFFDay.Text + "')";
                    int temp = conn.ExecuteNonQuery(query);
                    MessageBox.Show(temp + "");
                }
                conn.CloseDB();
                Close();
            }
        }

        private void btnCapNhat_Click_1(object sender, EventArgs e)
        {

        }

        private void txtNgayBatDau_ValueChanged(object sender, EventArgs e)
        {
            if (this.txtNgayBatDau.Value > this.txtNgayKetThuc.Value)
            {
                MessageBox.Show("Khoảng thời gian nghỉ không hợp lệ");
                this.txtNgayBatDau.Value = this.txtNgayKetThuc.Value;
            }
        }
        //Check nếu ngày kết thức bé hơn ngày bắt đầu 
        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            if (this.txtNgayBatDau.Value > this.txtNgayKetThuc.Value)
            {
                MessageBox.Show("Khoảng thời gian nghỉ không hợp lệ");
                this.txtNgayKetThuc.Value = this.txtNgayBatDau.Value;
            }
        }
    }
}
