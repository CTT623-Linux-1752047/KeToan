
using System.Drawing;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    partial class EDIT_WORKING_OT_OF_STAFF
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
            this.lbWFH = new System.Windows.Forms.Label();
            this.lbAmountOTWithTax = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.lbTax = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.lbAmountOTWithoutTax = new System.Windows.Forms.Label();
            this.label16 = new System.Windows.Forms.Label();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.lbTotalOTInMonth = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.lbMonth = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.lbUserName = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lbName = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.bunifuCustomDataGrid1 = new Bunifu.Framework.UI.BunifuCustomDataGrid();
            this.STT = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.RangeTimeOT = new System.Windows.Forms.DataGridViewComboBoxColumn();
            this.HoursOT = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.DateApproved = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Column4 = new System.Windows.Forms.DataGridViewImageColumn();
            this.date = new System.Windows.Forms.DateTimePicker();
            this.tableLayoutPanel5 = new System.Windows.Forms.TableLayoutPanel();
            this.lbNoData = new System.Windows.Forms.Label();
            this.btnEdit = new System.Windows.Forms.Button();
            this.tableLayoutPanel1.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.bunifuCustomDataGrid1)).BeginInit();
            this.bunifuCustomDataGrid1.SuspendLayout();
            this.tableLayoutPanel5.SuspendLayout();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.SystemColors.Control;
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel2, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.panel1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel5, 0, 2);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 30F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 60F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(984, 561);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 3;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 48F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 4F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 48F));
            this.tableLayoutPanel2.Controls.Add(this.tableLayoutPanel4, 2, 0);
            this.tableLayoutPanel2.Controls.Add(this.tableLayoutPanel3, 0, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(30, 30);
            this.tableLayoutPanel2.Margin = new System.Windows.Forms.Padding(30);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 1;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 108F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(924, 108);
            this.tableLayoutPanel2.TabIndex = 0;
            // 
            // tableLayoutPanel4
            // 
            this.tableLayoutPanel4.BackColor = System.Drawing.Color.GhostWhite;
            this.tableLayoutPanel4.ColumnCount = 2;
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 40F));
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 60F));
            this.tableLayoutPanel4.Controls.Add(this.lbWFH, 1, 3);
            this.tableLayoutPanel4.Controls.Add(this.lbAmountOTWithTax, 1, 2);
            this.tableLayoutPanel4.Controls.Add(this.label12, 0, 2);
            this.tableLayoutPanel4.Controls.Add(this.lbTax, 1, 1);
            this.tableLayoutPanel4.Controls.Add(this.label14, 0, 1);
            this.tableLayoutPanel4.Controls.Add(this.lbAmountOTWithoutTax, 1, 0);
            this.tableLayoutPanel4.Controls.Add(this.label16, 0, 0);
            this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel4.Location = new System.Drawing.Point(479, 0);
            this.tableLayoutPanel4.Margin = new System.Windows.Forms.Padding(0);
            this.tableLayoutPanel4.Name = "tableLayoutPanel4";
            this.tableLayoutPanel4.RowCount = 4;
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel4.Size = new System.Drawing.Size(445, 108);
            this.tableLayoutPanel4.TabIndex = 2;
            // 
            // lbWFH
            // 
            this.lbWFH.AutoSize = true;
            this.lbWFH.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbWFH.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbWFH.Location = new System.Drawing.Point(178, 81);
            this.lbWFH.Margin = new System.Windows.Forms.Padding(0);
            this.lbWFH.Name = "lbWFH";
            this.lbWFH.Size = new System.Drawing.Size(267, 27);
            this.lbWFH.TabIndex = 7;
            this.lbWFH.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbAmountOTWithTax
            // 
            this.lbAmountOTWithTax.AutoSize = true;
            this.lbAmountOTWithTax.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbAmountOTWithTax.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbAmountOTWithTax.Location = new System.Drawing.Point(178, 54);
            this.lbAmountOTWithTax.Margin = new System.Windows.Forms.Padding(0);
            this.lbAmountOTWithTax.Name = "lbAmountOTWithTax";
            this.lbAmountOTWithTax.Size = new System.Drawing.Size(267, 27);
            this.lbAmountOTWithTax.TabIndex = 5;
            this.lbAmountOTWithTax.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label12.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label12.Location = new System.Drawing.Point(10, 54);
            this.label12.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(168, 27);
            this.label12.TabIndex = 4;
            this.label12.Text = "Tiền OT sau thuế :";
            this.label12.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbTax
            // 
            this.lbTax.AutoSize = true;
            this.lbTax.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbTax.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTax.Location = new System.Drawing.Point(178, 27);
            this.lbTax.Margin = new System.Windows.Forms.Padding(0);
            this.lbTax.Name = "lbTax";
            this.lbTax.Size = new System.Drawing.Size(267, 27);
            this.lbTax.TabIndex = 3;
            this.lbTax.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label14.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label14.Location = new System.Drawing.Point(10, 27);
            this.label14.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(168, 27);
            this.label14.TabIndex = 2;
            this.label14.Text = "Thuế OT :";
            this.label14.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbAmountOTWithoutTax
            // 
            this.lbAmountOTWithoutTax.AutoSize = true;
            this.lbAmountOTWithoutTax.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbAmountOTWithoutTax.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbAmountOTWithoutTax.Location = new System.Drawing.Point(178, 0);
            this.lbAmountOTWithoutTax.Margin = new System.Windows.Forms.Padding(0);
            this.lbAmountOTWithoutTax.Name = "lbAmountOTWithoutTax";
            this.lbAmountOTWithoutTax.Size = new System.Drawing.Size(267, 27);
            this.lbAmountOTWithoutTax.TabIndex = 1;
            this.lbAmountOTWithoutTax.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label16.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label16.Location = new System.Drawing.Point(10, 0);
            this.label16.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(168, 27);
            this.label16.TabIndex = 0;
            this.label16.Text = "Tiền OT trước thuế :";
            this.label16.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.BackColor = System.Drawing.Color.GhostWhite;
            this.tableLayoutPanel3.ColumnCount = 2;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 40F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 60F));
            this.tableLayoutPanel3.Controls.Add(this.lbTotalOTInMonth, 1, 3);
            this.tableLayoutPanel3.Controls.Add(this.label7, 0, 3);
            this.tableLayoutPanel3.Controls.Add(this.lbMonth, 1, 2);
            this.tableLayoutPanel3.Controls.Add(this.label5, 0, 2);
            this.tableLayoutPanel3.Controls.Add(this.lbUserName, 1, 1);
            this.tableLayoutPanel3.Controls.Add(this.label3, 0, 1);
            this.tableLayoutPanel3.Controls.Add(this.lbName, 1, 0);
            this.tableLayoutPanel3.Controls.Add(this.label1, 0, 0);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel3.Margin = new System.Windows.Forms.Padding(0);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 4;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel3.Size = new System.Drawing.Size(443, 108);
            this.tableLayoutPanel3.TabIndex = 0;
            // 
            // lbTotalOTInMonth
            // 
            this.lbTotalOTInMonth.AutoSize = true;
            this.lbTotalOTInMonth.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbTotalOTInMonth.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbTotalOTInMonth.Location = new System.Drawing.Point(177, 81);
            this.lbTotalOTInMonth.Margin = new System.Windows.Forms.Padding(0);
            this.lbTotalOTInMonth.Name = "lbTotalOTInMonth";
            this.lbTotalOTInMonth.Size = new System.Drawing.Size(266, 27);
            this.lbTotalOTInMonth.TabIndex = 7;
            this.lbTotalOTInMonth.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label7.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(10, 81);
            this.label7.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(167, 27);
            this.label7.TabIndex = 6;
            this.label7.Text = "Tổng số giờ OT : ";
            this.label7.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbMonth
            // 
            this.lbMonth.AutoSize = true;
            this.lbMonth.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbMonth.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbMonth.Location = new System.Drawing.Point(177, 54);
            this.lbMonth.Margin = new System.Windows.Forms.Padding(0);
            this.lbMonth.Name = "lbMonth";
            this.lbMonth.Size = new System.Drawing.Size(266, 27);
            this.lbMonth.TabIndex = 5;
            this.lbMonth.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label5.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(10, 54);
            this.label5.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(167, 27);
            this.label5.TabIndex = 4;
            this.label5.Text = "Tháng : ";
            this.label5.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbUserName
            // 
            this.lbUserName.AutoSize = true;
            this.lbUserName.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbUserName.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbUserName.Location = new System.Drawing.Point(177, 27);
            this.lbUserName.Margin = new System.Windows.Forms.Padding(0);
            this.lbUserName.Name = "lbUserName";
            this.lbUserName.Size = new System.Drawing.Size(266, 27);
            this.lbUserName.TabIndex = 3;
            this.lbUserName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label3.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(10, 27);
            this.label3.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(167, 27);
            this.label3.TabIndex = 2;
            this.label3.Text = "User name : ";
            this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbName
            // 
            this.lbName.AutoSize = true;
            this.lbName.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbName.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbName.Location = new System.Drawing.Point(177, 0);
            this.lbName.Margin = new System.Windows.Forms.Padding(0);
            this.lbName.Name = "lbName";
            this.lbName.Size = new System.Drawing.Size(266, 27);
            this.lbName.TabIndex = 1;
            this.lbName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label1.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(10, 0);
            this.label1.Margin = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(167, 27);
            this.label1.TabIndex = 0;
            this.label1.Text = "Họ và tên : ";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.bunifuCustomDataGrid1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(30, 171);
            this.panel1.Margin = new System.Windows.Forms.Padding(30, 3, 30, 30);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(924, 303);
            this.panel1.TabIndex = 1;
            // 
            // bunifuCustomDataGrid1
            // 
            this.bunifuCustomDataGrid1.AllowUserToAddRows = false;
            this.bunifuCustomDataGrid1.AllowUserToOrderColumns = true;
            this.bunifuCustomDataGrid1.AllowUserToResizeColumns = false;
            this.bunifuCustomDataGrid1.AllowUserToResizeRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.White;
            this.bunifuCustomDataGrid1.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.bunifuCustomDataGrid1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.bunifuCustomDataGrid1.BackgroundColor = System.Drawing.Color.GhostWhite;
            this.bunifuCustomDataGrid1.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.bunifuCustomDataGrid1.CellBorderStyle = System.Windows.Forms.DataGridViewCellBorderStyle.None;
            this.bunifuCustomDataGrid1.ColumnHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.MediumSlateBlue;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.Color.White;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.bunifuCustomDataGrid1.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.bunifuCustomDataGrid1.ColumnHeadersHeight = 60;
            this.bunifuCustomDataGrid1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.STT,
            this.RangeTimeOT,
            this.HoursOT,
            this.DateApproved,
            this.Column4});
            this.bunifuCustomDataGrid1.Controls.Add(this.date);
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(229)))), ((int)(((byte)(226)))), ((int)(((byte)(244)))));
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.bunifuCustomDataGrid1.DefaultCellStyle = dataGridViewCellStyle3;
            this.bunifuCustomDataGrid1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bunifuCustomDataGrid1.DoubleBuffered = true;
            this.bunifuCustomDataGrid1.EditMode = System.Windows.Forms.DataGridViewEditMode.EditOnKeystroke;
            this.bunifuCustomDataGrid1.EnableHeadersVisualStyles = false;
            this.bunifuCustomDataGrid1.GridColor = System.Drawing.SystemColors.ControlLightLight;
            this.bunifuCustomDataGrid1.HeaderBgColor = System.Drawing.Color.MediumSlateBlue;
            this.bunifuCustomDataGrid1.HeaderForeColor = System.Drawing.Color.White;
            this.bunifuCustomDataGrid1.Location = new System.Drawing.Point(0, 0);
            this.bunifuCustomDataGrid1.Margin = new System.Windows.Forms.Padding(30, 3, 3, 20);
            this.bunifuCustomDataGrid1.MultiSelect = false;
            this.bunifuCustomDataGrid1.Name = "bunifuCustomDataGrid1";
            this.bunifuCustomDataGrid1.RowHeadersBorderStyle = System.Windows.Forms.DataGridViewHeaderBorderStyle.None;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Segoe UI", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.bunifuCustomDataGrid1.RowHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.bunifuCustomDataGrid1.RowHeadersVisible = false;
            this.bunifuCustomDataGrid1.RowTemplate.DividerHeight = 1;
            this.bunifuCustomDataGrid1.RowTemplate.Height = 40;
            this.bunifuCustomDataGrid1.RowTemplate.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.bunifuCustomDataGrid1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.bunifuCustomDataGrid1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.bunifuCustomDataGrid1.Size = new System.Drawing.Size(924, 303);
            this.bunifuCustomDataGrid1.TabIndex = 5;
            this.bunifuCustomDataGrid1.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.bunifuCustomDataGrid1_CellClick);
            this.bunifuCustomDataGrid1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.bunifuCustomDataGrid1_CellContentClick);
            this.bunifuCustomDataGrid1.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.bunifuCustomDataGrid1_CellValueChanged);
            this.bunifuCustomDataGrid1.ColumnWidthChanged += new System.Windows.Forms.DataGridViewColumnEventHandler(this.bunifuCustomDataGrid1_ColumnWidthChanged);
            this.bunifuCustomDataGrid1.Scroll += new System.Windows.Forms.ScrollEventHandler(this.bunifuCustomDataGrid1_Scroll);
            // 
            // STT
            // 
            this.STT.FillWeight = 20F;
            this.STT.HeaderText = "STT";
            this.STT.Name = "STT";
            this.STT.ReadOnly = true;
            // 
            // RangeTimeOT
            // 
            this.RangeTimeOT.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.RangeTimeOT.DisplayStyle = System.Windows.Forms.DataGridViewComboBoxDisplayStyle.ComboBox;
            this.RangeTimeOT.DisplayStyleForCurrentCellOnly = true;
            this.RangeTimeOT.FillWeight = 150F;
            this.RangeTimeOT.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.RangeTimeOT.HeaderText = "Range Time OT";
            this.RangeTimeOT.Items.AddRange(new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7"});
            this.RangeTimeOT.Name = "RangeTimeOT";
            this.RangeTimeOT.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            this.RangeTimeOT.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic;
            // 
            // HoursOT
            // 
            this.HoursOT.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.HoursOT.FillWeight = 70F;
            this.HoursOT.HeaderText = "Hours OT";
            this.HoursOT.Name = "HoursOT";
            // 
            // DateApproved
            // 
            this.DateApproved.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.DateApproved.HeaderText = "Date Approved";
            this.DateApproved.Name = "DateApproved";
            this.DateApproved.ReadOnly = true;
            // 
            // Column4
            // 
            this.Column4.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Column4.FillWeight = 20F;
            this.Column4.HeaderText = "";
            this.Column4.Image = global::WindowsFormsApp1.Properties.Resources.icons8_delete_bin_241;
            this.Column4.Name = "Column4";
            this.Column4.ReadOnly = true;
            this.Column4.Resizable = System.Windows.Forms.DataGridViewTriState.True;
            // 
            // date
            // 
            this.date.CustomFormat = "dd - MM - yyyy";
            this.date.Font = new System.Drawing.Font("Consolas", 18.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.date.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.date.Location = new System.Drawing.Point(0, 0);
            this.date.Margin = new System.Windows.Forms.Padding(0);
            this.date.Name = "date";
            this.date.Size = new System.Drawing.Size(200, 37);
            this.date.TabIndex = 2;
            this.date.Visible = false;
            this.date.TextChanged += new System.EventHandler(this.date_TextChange);
            // 
            // tableLayoutPanel5
            // 
            this.tableLayoutPanel5.ColumnCount = 4;
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 53.33333F));
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 13.33333F));
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 43F));
            this.tableLayoutPanel5.Controls.Add(this.lbNoData, 0, 0);
            this.tableLayoutPanel5.Controls.Add(this.btnEdit, 2, 0);
            this.tableLayoutPanel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel5.Location = new System.Drawing.Point(0, 504);
            this.tableLayoutPanel5.Margin = new System.Windows.Forms.Padding(0);
            this.tableLayoutPanel5.Name = "tableLayoutPanel5";
            this.tableLayoutPanel5.RowCount = 2;
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 38F));
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel5.Size = new System.Drawing.Size(984, 57);
            this.tableLayoutPanel5.TabIndex = 2;
            // 
            // lbNoData
            // 
            this.lbNoData.AutoSize = true;
            this.lbNoData.BackColor = System.Drawing.Color.Firebrick;
            this.lbNoData.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbNoData.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbNoData.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.lbNoData.Image = global::WindowsFormsApp1.Properties.Resources.icons8_no_data_availible_24;
            this.lbNoData.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.lbNoData.Location = new System.Drawing.Point(3, 0);
            this.lbNoData.Name = "lbNoData";
            this.lbNoData.Padding = new System.Windows.Forms.Padding(8, 0, 0, 0);
            this.lbNoData.Size = new System.Drawing.Size(307, 38);
            this.lbNoData.TabIndex = 5;
            this.lbNoData.Text = "KHÔNG CÓ NỘI DUNG ĐỂ HIỂN THỊ ";
            this.lbNoData.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // btnEdit
            // 
            this.btnEdit.BackColor = System.Drawing.Color.SaddleBrown;
            this.btnEdit.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnEdit.FlatAppearance.BorderSize = 0;
            this.btnEdit.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnEdit.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnEdit.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnEdit.Image = global::WindowsFormsApp1.Properties.Resources.icons8_edit_property_24;
            this.btnEdit.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnEdit.Location = new System.Drawing.Point(814, 0);
            this.btnEdit.Margin = new System.Windows.Forms.Padding(0);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(125, 38);
            this.btnEdit.TabIndex = 2;
            this.btnEdit.Text = "EDIT";
            this.btnEdit.UseVisualStyleBackColor = false;
            this.btnEdit.Click += new System.EventHandler(this.button1_Click);
            // 
            // EDIT_WORKING_OT_OF_STAFF
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(984, 561);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "EDIT_WORKING_OT_OF_STAFF";
            this.Text = "EDIT_WORKING_OT_OF_STAFF";
            this.Load += new System.EventHandler(this.EDIT_WORKING_OT_OF_STAFF_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel4.ResumeLayout(false);
            this.tableLayoutPanel4.PerformLayout();
            this.tableLayoutPanel3.ResumeLayout(false);
            this.tableLayoutPanel3.PerformLayout();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.bunifuCustomDataGrid1)).EndInit();
            this.bunifuCustomDataGrid1.ResumeLayout(false);
            this.tableLayoutPanel5.ResumeLayout(false);
            this.tableLayoutPanel5.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel4;
        private System.Windows.Forms.Label lbWFH;
        private System.Windows.Forms.Label lbAmountOTWithTax;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label lbTax;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.Label lbAmountOTWithoutTax;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.Label lbTotalOTInMonth;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label lbMonth;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label lbUserName;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lbName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel panel1;
        private Bunifu.Framework.UI.BunifuCustomDataGrid bunifuCustomDataGrid1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel5;
        private System.Windows.Forms.Label lbNoData;
        private System.Windows.Forms.Button btnEdit;
        private System.Windows.Forms.DataGridViewTextBoxColumn STT;
        private System.Windows.Forms.DataGridViewComboBoxColumn RangeTimeOT;
        private System.Windows.Forms.DataGridViewTextBoxColumn HoursOT;
        private System.Windows.Forms.DataGridViewTextBoxColumn DateApproved;
        private System.Windows.Forms.DataGridViewImageColumn Column4;
        private DateTimePicker date;
        public Rectangle _Retangle;
    }
}