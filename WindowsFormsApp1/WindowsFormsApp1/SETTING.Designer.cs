namespace WindowsFormsApp1
{
    partial class SETTING
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.btnSettingDayOff = new System.Windows.Forms.Button();
            this.btnSettingPhuCap = new System.Windows.Forms.Button();
            this.btnSettingBaoHiem = new System.Windows.Forms.Button();
            this.tableLayoutPanel1.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel2, 0, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Margin = new System.Windows.Forms.Padding(0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 13F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 87F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(1038, 861);
            this.tableLayoutPanel1.TabIndex = 0;
            this.tableLayoutPanel1.Paint += new System.Windows.Forms.PaintEventHandler(this.tableLayoutPanel1_Paint);
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(80)))), ((int)(((byte)(97)))));
            this.tableLayoutPanel2.ColumnCount = 4;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 17F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 17F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 17F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 49F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel2.Controls.Add(this.btnSettingDayOff, 0, 0);
            this.tableLayoutPanel2.Controls.Add(this.btnSettingPhuCap, 1, 0);
            this.tableLayoutPanel2.Controls.Add(this.btnSettingBaoHiem, 2, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel2.Margin = new System.Windows.Forms.Padding(0);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 1;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(1038, 111);
            this.tableLayoutPanel2.TabIndex = 0;
            // 
            // btnSettingDayOff
            // 
            this.btnSettingDayOff.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnSettingDayOff.FlatAppearance.BorderSize = 0;
            this.btnSettingDayOff.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSettingDayOff.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSettingDayOff.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnSettingDayOff.Image = global::WindowsFormsApp1.Properties.Resources.icons8_event_48;
            this.btnSettingDayOff.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSettingDayOff.Location = new System.Drawing.Point(0, 0);
            this.btnSettingDayOff.Margin = new System.Windows.Forms.Padding(0);
            this.btnSettingDayOff.Name = "btnSettingDayOff";
            this.btnSettingDayOff.Size = new System.Drawing.Size(176, 111);
            this.btnSettingDayOff.TabIndex = 0;
            this.btnSettingDayOff.Text = "THIẾT LẬP NGÀY NGHỈ";
            this.btnSettingDayOff.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnSettingDayOff.UseVisualStyleBackColor = true;
            this.btnSettingDayOff.Click += new System.EventHandler(this.btnSettingDayOff_Click);
            // 
            // btnSettingPhuCap
            // 
            this.btnSettingPhuCap.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnSettingPhuCap.FlatAppearance.BorderSize = 0;
            this.btnSettingPhuCap.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSettingPhuCap.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSettingPhuCap.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnSettingPhuCap.Image = global::WindowsFormsApp1.Properties.Resources.icons8_get_cash_48;
            this.btnSettingPhuCap.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSettingPhuCap.Location = new System.Drawing.Point(176, 0);
            this.btnSettingPhuCap.Margin = new System.Windows.Forms.Padding(0);
            this.btnSettingPhuCap.Name = "btnSettingPhuCap";
            this.btnSettingPhuCap.Size = new System.Drawing.Size(176, 111);
            this.btnSettingPhuCap.TabIndex = 1;
            this.btnSettingPhuCap.Text = "THIẾT LẬP PHỤ     CẤP ";
            this.btnSettingPhuCap.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnSettingPhuCap.UseVisualStyleBackColor = true;
            this.btnSettingPhuCap.Click += new System.EventHandler(this.btnSettingPhuCap_Click);
            // 
            // btnSettingBaoHiem
            // 
            this.btnSettingBaoHiem.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnSettingBaoHiem.FlatAppearance.BorderSize = 0;
            this.btnSettingBaoHiem.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSettingBaoHiem.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSettingBaoHiem.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnSettingBaoHiem.Image = global::WindowsFormsApp1.Properties.Resources.icons8_terms_and_conditions_48;
            this.btnSettingBaoHiem.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSettingBaoHiem.Location = new System.Drawing.Point(352, 0);
            this.btnSettingBaoHiem.Margin = new System.Windows.Forms.Padding(0);
            this.btnSettingBaoHiem.Name = "btnSettingBaoHiem";
            this.btnSettingBaoHiem.Size = new System.Drawing.Size(176, 111);
            this.btnSettingBaoHiem.TabIndex = 2;
            this.btnSettingBaoHiem.Text = "THIẾT LẬP BẢO HIỂM";
            this.btnSettingBaoHiem.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnSettingBaoHiem.UseVisualStyleBackColor = true;
            this.btnSettingBaoHiem.Click += new System.EventHandler(this.btnSettingBaoHiem_Click);
            // 
            // SETTING
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "SETTING";
            this.Size = new System.Drawing.Size(1038, 861);
            this.Load += new System.EventHandler(this.SETTING_Load);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.Button btnSettingDayOff;
        private System.Windows.Forms.Button btnSettingPhuCap;
        private System.Windows.Forms.Button btnSettingBaoHiem;
    }
}
