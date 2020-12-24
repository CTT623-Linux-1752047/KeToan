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
    public partial class THIET_LAP_PHU_CAP : UserControl
    {
        private bool newRowAdd;
        private List<PHUCAP> lstBenefit;
        private List<BAOHIEM_THUE> lstInsurance;
        private TinhTienLuongEntities data = new TinhTienLuongEntities();
        public THIET_LAP_PHU_CAP()
        {
            InitializeComponent();
        }
        public void LoadData()
        {
            lstBenefit = data.PHUCAPs.ToList();
            this.bunifuCustomDataGrid1.Rows.Clear();
            this.bunifuCustomDataGrid4.Rows.Clear();
            if (lstBenefit != null)
            {
                for (int i = 0; i < lstBenefit.Count; i++)
                {
                    decimal UnitPrice = lstBenefit[i].PC_CoDinh.HasValue ? lstBenefit[i].PC_CoDinh.Value : 0;
                    this.bunifuCustomDataGrid4.Rows.Add(i + 1,
                                                        lstBenefit[i].MoTa,
                                                        UnitPrice.ToString("#,##0"),
                                                        lstBenefit[i].CongThuc
                                                        );
                }
            }
            lstInsurance = data.BAOHIEM_THUE.ToList();
            if (lstInsurance != null)
            {
                for (int i = 0; i < lstInsurance.Count; i++)
                {
                    double TaxRate = lstInsurance[i].PhanTramBaoHiem.HasValue ? lstInsurance[i].PhanTramBaoHiem.Value : 0;
                    string strTaxRate;
                    if (TaxRate > 1)
                    {
                        strTaxRate = TaxRate.ToString("#,##0");
                    }
                    else
                    {
                        strTaxRate = TaxRate.ToString();
                    }
                    this.bunifuCustomDataGrid1.Rows.Add(i + 1,
                                                        lstInsurance[i].MoTa,
                                                        strTaxRate
                                                        );
                }
            }
        }

        private void bunifuCustomDataGrid4_NewRowNeeded(object sender, DataGridViewRowEventArgs e)
        {
            this.newRowAdd = true;
        }

        private void bunifuCustomDataGrid4_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
        {
            if (this.newRowAdd)
            {
                this.newRowAdd = false;
                MessageBox.Show("Add");
            }
        }
        private void btnAdd_Click(object sender, EventArgs e)
        {
            PHUCAP benefit = new PHUCAP();
            benefit.MoTa = lbNameBenefit.Text;
            benefit.PC_CoDinh = decimal.Parse(txtUnitPrice.Text.Replace(",", "").Replace(" ", ""));

        }

        private void txtUnitPrice_TextChanged(object sender, EventArgs e)
        {
            try
            {
                System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-US");
                decimal value = decimal.Parse(this.txtUnitPrice.Text, System.Globalization.NumberStyles.AllowThousands);
                this.txtUnitPrice.Text = String.Format(culture, "{0:N0}", value);
                this.txtUnitPrice.Select(this.txtUnitPrice.Text.Length, 0);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Số tiền không hợp lệ");
                this.txtUnitPrice.Text.Remove(0) ;
            }
        }
        private void bunifuCustomDataGrid4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            txtUnitPrice.Text = Decimal.ToDouble(lstBenefit[(int)this.bunifuCustomDataGrid4.CurrentRow.Cells[0].Value - 1].PC_CoDinh.Value).ToString("#,##0");
            lbNameBenefit.Text = lstBenefit[(int)this.bunifuCustomDataGrid4.CurrentRow.Cells[0].Value - 1].MoTa;
            lbFormula.Text = lstBenefit[(int)this.bunifuCustomDataGrid4.CurrentRow.Cells[0].Value - 1].CongThuc;
        }
        //btn modify Insurance
        private void button7_Click(object sender, EventArgs e)
        {
            try
            {
                double TaxRate = Convert.ToDouble(this.txtbTaxRate.Text);
                if(TaxRate > 100)
                {
                    this.txtbTaxRate.Text = TaxRate.ToString("#,##0");
                }
                else if(TaxRate > 1)
                {
                    this.txtbTaxRate.Text = (TaxRate / 100).ToString();
                }
                int index = lstInsurance[(int)this.bunifuCustomDataGrid1.CurrentRow.Cells[0].Value - 1].ID;

                var itemModifyInsurance = data.BAOHIEM_THUE.Find(index);
                itemModifyInsurance.PhanTramBaoHiem = Convert.ToDouble(this.txtbTaxRate.Text);
                int res = data.SaveChanges();
                if(res != 0)
                {
                    MessageBox.Show("Cập nhật thành công");
                    this.lbNameInsurance.Text = "";
                    this.txtbTaxRate.Text = "";
                    LoadData();
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("Thuế suất không hợp lệ !!");
                this.txtbTaxRate.Text ="";
            }
        }
        private void bunifuCustomDataGrid1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == 4)
            {
                DialogResult dialogResult = MessageBox.Show("Bạn có muốn xóa ?", "Some Title", MessageBoxButtons.YesNo);
                if (dialogResult == DialogResult.Yes)
                {

                }
                else if (dialogResult == DialogResult.No)
                {
                    //do something else
                }
                LoadData();
            }
        }
        //click on row
        private void bunifuCustomDataGrid1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            lbNameInsurance.Text = lstInsurance[(int)this.bunifuCustomDataGrid1.CurrentRow.Cells[0].Value - 1].MoTa;
            txtbTaxRate.Text = lstInsurance[(int)this.bunifuCustomDataGrid1.CurrentRow.Cells[0].Value - 1].PhanTramBaoHiem.ToString();
        }

        private void bunifuCustomDataGrid4_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if(e.ColumnIndex == 4)
            {
                DialogResult dialogResult = MessageBox.Show("Bạn có muốn xóa ?","Danger !!!", MessageBoxButtons.YesNo);
                if (dialogResult == DialogResult.Yes)
                {
                    /*
                    int index = (int)this.bunifuCustomDataGrid4.CurrentRow.Cells[0].Value - 1;
                    PHUCAP itemDelete = data.PHUCAPs.Find(index);
                    data.PHUCAPs.Remove(itemDelete);
                    data.SaveChanges();
                    */
                }
                else if (dialogResult == DialogResult.No)
                {
                    //do something else
                }
                LoadData();
            }
        }
    }
}
