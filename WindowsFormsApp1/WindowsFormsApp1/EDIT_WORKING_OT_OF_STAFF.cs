﻿using System;
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
    public partial class EDIT_WORKING_OT_OF_STAFF : Form
    {
        TinhTienLuongEntities data = new TinhTienLuongEntities();
        List<NHANVIEN_OT> lstDateOTOfStaffInMonth;
        private int ID;
        private DateTime dateSelected;
        private bool stateTextChanged = false;
        public EDIT_WORKING_OT_OF_STAFF(int ID, DateTime NgayThang)
        {
            InitializeComponent();
            this.ID = ID;
            this.dateSelected = NgayThang;
            this.btnEdit.Enabled = false;
        }
        private void LoadData()
        {
            StringBuilder queryRangeTimeOT = new StringBuilder();
            queryRangeTimeOT.Append("SELECT");
            queryRangeTimeOT.Append("   * ");
            queryRangeTimeOT.Append("FROM");
            queryRangeTimeOT.Append("   TYPE_RANGE_HOURS_OT ");

            this.RangeTimeOT.DataSource = data.TYPE_RANGE_HOURS_OT.SqlQuery(queryRangeTimeOT.ToString()).ToList();
            this.RangeTimeOT.DisplayMember = "RangeHours";
            this.RangeTimeOT.ValueMember = "ID";


            StringBuilder queryStaffOT = new StringBuilder();
            queryStaffOT.Append("SELECT");
            queryStaffOT.Append("  *");
            queryStaffOT.Append("FROM");
            queryStaffOT.Append("  NHANVIEN_OT ");
            queryStaffOT.Append("WHERE");
            queryStaffOT.Append("  ID_NhanVien = " + this.ID);
            queryStaffOT.Append("  AND ");
            queryStaffOT.Append("  MONTH(DateDangKy) = " + this.dateSelected.Month);
            queryStaffOT.Append("  AND ");
            queryStaffOT.Append("  YEAR(DateDangKy) = " + this.dateSelected.Year);
            lstDateOTOfStaffInMonth = data.NHANVIEN_OT.SqlQuery(queryStaffOT.ToString()).ToList();


            this.lbName.Text = data.NHANSUs.Find(this.ID).HoVaTen;
            this.lbUserName.Text = data.NHANSUs.Find(this.ID).UserName;
            this.lbMonth.Text = this.dateSelected.ToString("MM - yyyy");
            this.lbTotalOTInMonth.Text = (data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().Total_hours.HasValue) ?
                                            data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().Total_hours.Value.ToString("#,##0") : "0";
            this.lbAmountOTWithoutTax.Text = (data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().TotalWithoutTax.HasValue) ?
                                            data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().TotalWithoutTax.Value.ToString("#,##0") : "0";
            this.lbTax.Text = (data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().Tax.HasValue) ?
                                            data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().Tax.Value.ToString("#,##0") : "0";
            this.lbAmountOTWithTax.Text = (data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().TotalAmountWithTax.HasValue) ?
                                          data.fnDisplayOT_AmountOTStaffOfMonth(data.NHANSUs.Find(this.ID).HoVaTen, this.dateSelected).FirstOrDefault().TotalAmountWithTax.Value.ToString("#,##0") : "0";


            for (int i = 0; i < lstDateOTOfStaffInMonth.Count; i++)
            {
                this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                    lstDateOTOfStaffInMonth[i].TYPE_RANGE_HOURS_OT.ID,
                                                    lstDateOTOfStaffInMonth[i].SoGioOT,
                                                    lstDateOTOfStaffInMonth[i].DateDangKy.ToString("dd - MM - yyyy"));
            }
            if (lstDateOTOfStaffInMonth.Count == 0)
            {
                this.lbNoData.Show();
            }
            else
            {
                this.lbNoData.Hide();
            }
        }

        private void EDIT_WORKING_OT_OF_STAFF_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private void bunifuCustomDataGrid1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            switch (this.bunifuCustomDataGrid1.Columns[e.ColumnIndex].Name)
            {
                case "DateApproved":
                    _Retangle = this.bunifuCustomDataGrid1.GetCellDisplayRectangle(e.ColumnIndex, e.RowIndex, true);
                    this.date.Size = new Size(this.DateApproved.Width, _Retangle.Height);
                    this.date.Location = new Point(_Retangle.X, _Retangle.Y);
                    this.date.Visible = true;
                    break;
            }
        }
        private void date_TextChange(object sender, EventArgs e)
        {
            this.bunifuCustomDataGrid1.CurrentCell.Value = date.Text.ToString();
            this.date.Visible = false;
        }

        private void bunifuCustomDataGrid1_ColumnWidthChanged(object sender, DataGridViewColumnEventArgs e)
        {
            date.Visible = false;
        }

        private void bunifuCustomDataGrid1_Scroll(object sender, ScrollEventArgs e)
        {
            date.Visible = false;
        }
        //btn Edit 
        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void bunifuCustomDataGrid1_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            this.stateTextChanged = true;
            this.btnEdit.Enabled = true;
            this.btnEdit.BackColor = Color.Orange;
        }

        private void bunifuCustomDataGrid1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == 4)
            {
                DialogResult dialogResult = MessageBox.Show("Bạn có muốn xóa ?", "Some Title", MessageBoxButtons.YesNo);
                if (dialogResult == DialogResult.Yes)
                {
                    data.NHANVIEN_OT.Remove(data.NHANVIEN_OT.Find(Convert.ToInt32(lstDateOTOfStaffInMonth[Convert.ToInt32(this.bunifuCustomDataGrid1.SelectedRows[0].Cells[0].Value) - 1].ID)));
                    data.SaveChanges();
                }
                else
                {

                }
            }
        }
    }
}
