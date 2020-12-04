
namespace WindowsFormsApp1
{
    partial class CREATE_HOURS_OT
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
            this.components = new System.ComponentModel.Container();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.button1 = new System.Windows.Forms.Button();
            this.txtOTHours = new Bunifu.Framework.UI.BunifuMaterialTextbox();
            this.materialLabel4 = new MaterialSkin.Controls.MaterialLabel();
            this.materialLabel6 = new MaterialSkin.Controls.MaterialLabel();
            this.lbUserName = new System.Windows.Forms.Label();
            this.materialLabel2 = new MaterialSkin.Controls.MaterialLabel();
            this.cbRangeHoursOT = new System.Windows.Forms.ComboBox();
            this.materialLabel3 = new MaterialSkin.Controls.MaterialLabel();
            this.cbNameOfStaff = new System.Windows.Forms.ComboBox();
            this.materialLabel1 = new MaterialSkin.Controls.MaterialLabel();
            this.DateCreateOT = new System.Windows.Forms.DateTimePicker();
            this.bunifuElipse1 = new Bunifu.Framework.UI.BunifuElipse(this.components);
            this.tableLayoutPanel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 4;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 16F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 49F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 15F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel2.Controls.Add(this.button1, 3, 2);
            this.tableLayoutPanel2.Controls.Add(this.txtOTHours, 1, 2);
            this.tableLayoutPanel2.Controls.Add(this.materialLabel4, 0, 2);
            this.tableLayoutPanel2.Controls.Add(this.materialLabel6, 2, 1);
            this.tableLayoutPanel2.Controls.Add(this.lbUserName, 3, 0);
            this.tableLayoutPanel2.Controls.Add(this.materialLabel2, 2, 0);
            this.tableLayoutPanel2.Controls.Add(this.cbRangeHoursOT, 1, 1);
            this.tableLayoutPanel2.Controls.Add(this.materialLabel3, 0, 1);
            this.tableLayoutPanel2.Controls.Add(this.cbNameOfStaff, 1, 0);
            this.tableLayoutPanel2.Controls.Add(this.materialLabel1, 0, 0);
            this.tableLayoutPanel2.Controls.Add(this.DateCreateOT, 3, 1);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 3;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(674, 138);
            this.tableLayoutPanel2.TabIndex = 1;
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(230)))), ((int)(((byte)(126)))), ((int)(((byte)(34)))));
            this.button1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button1.FlatAppearance.BorderSize = 0;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.Image = global::WindowsFormsApp1.Properties.Resources.icons8_create_241;
            this.button1.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.button1.Location = new System.Drawing.Point(553, 95);
            this.button1.Margin = new System.Windows.Forms.Padding(15, 3, 15, 3);
            this.button1.Name = "button1";
            this.button1.Padding = new System.Windows.Forms.Padding(5, 0, 5, 0);
            this.button1.Size = new System.Drawing.Size(106, 40);
            this.button1.TabIndex = 53;
            this.button1.Text = "Tạo";
            this.button1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // txtOTHours
            // 
            this.txtOTHours.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.txtOTHours.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txtOTHours.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F);
            this.txtOTHours.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.txtOTHours.HintForeColor = System.Drawing.Color.Empty;
            this.txtOTHours.HintText = "";
            this.txtOTHours.isPassword = false;
            this.txtOTHours.LineFocusedColor = System.Drawing.Color.Blue;
            this.txtOTHours.LineIdleColor = System.Drawing.Color.Gray;
            this.txtOTHours.LineMouseHoverColor = System.Drawing.Color.Blue;
            this.txtOTHours.LineThickness = 3;
            this.txtOTHours.Location = new System.Drawing.Point(111, 96);
            this.txtOTHours.Margin = new System.Windows.Forms.Padding(4);
            this.txtOTHours.Name = "txtOTHours";
            this.txtOTHours.Size = new System.Drawing.Size(322, 38);
            this.txtOTHours.TabIndex = 51;
            this.txtOTHours.TextAlign = System.Windows.Forms.HorizontalAlignment.Left;
            // 
            // materialLabel4
            // 
            this.materialLabel4.AutoSize = true;
            this.materialLabel4.Depth = 0;
            this.materialLabel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.materialLabel4.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel4.Location = new System.Drawing.Point(0, 92);
            this.materialLabel4.Margin = new System.Windows.Forms.Padding(0);
            this.materialLabel4.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel4.Name = "materialLabel4";
            this.materialLabel4.Size = new System.Drawing.Size(107, 46);
            this.materialLabel4.TabIndex = 50;
            this.materialLabel4.Text = "Số giờ OT";
            this.materialLabel4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // materialLabel6
            // 
            this.materialLabel6.AutoSize = true;
            this.materialLabel6.Depth = 0;
            this.materialLabel6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.materialLabel6.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel6.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel6.Location = new System.Drawing.Point(440, 46);
            this.materialLabel6.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel6.Name = "materialLabel6";
            this.materialLabel6.Size = new System.Drawing.Size(95, 46);
            this.materialLabel6.TabIndex = 48;
            this.materialLabel6.Text = "Ngày tháng đăng ký ";
            this.materialLabel6.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // lbUserName
            // 
            this.lbUserName.AutoSize = true;
            this.lbUserName.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lbUserName.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbUserName.Location = new System.Drawing.Point(538, 0);
            this.lbUserName.Margin = new System.Windows.Forms.Padding(0);
            this.lbUserName.Name = "lbUserName";
            this.lbUserName.Size = new System.Drawing.Size(136, 46);
            this.lbUserName.TabIndex = 34;
            this.lbUserName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // materialLabel2
            // 
            this.materialLabel2.AutoSize = true;
            this.materialLabel2.Depth = 0;
            this.materialLabel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.materialLabel2.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel2.Location = new System.Drawing.Point(437, 0);
            this.materialLabel2.Margin = new System.Windows.Forms.Padding(0);
            this.materialLabel2.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel2.Name = "materialLabel2";
            this.materialLabel2.Size = new System.Drawing.Size(101, 46);
            this.materialLabel2.TabIndex = 32;
            this.materialLabel2.Text = "User name";
            this.materialLabel2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // cbRangeHoursOT
            // 
            this.cbRangeHoursOT.Dock = System.Windows.Forms.DockStyle.Fill;
            this.cbRangeHoursOT.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cbRangeHoursOT.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbRangeHoursOT.FormattingEnabled = true;
            this.cbRangeHoursOT.Location = new System.Drawing.Point(110, 49);
            this.cbRangeHoursOT.Name = "cbRangeHoursOT";
            this.cbRangeHoursOT.Size = new System.Drawing.Size(324, 29);
            this.cbRangeHoursOT.TabIndex = 30;
            // 
            // materialLabel3
            // 
            this.materialLabel3.AutoSize = true;
            this.materialLabel3.Depth = 0;
            this.materialLabel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.materialLabel3.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel3.Location = new System.Drawing.Point(0, 46);
            this.materialLabel3.Margin = new System.Windows.Forms.Padding(0);
            this.materialLabel3.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel3.Name = "materialLabel3";
            this.materialLabel3.Size = new System.Drawing.Size(107, 46);
            this.materialLabel3.TabIndex = 25;
            this.materialLabel3.Text = "Khung giờ";
            this.materialLabel3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // cbNameOfStaff
            // 
            this.cbNameOfStaff.Dock = System.Windows.Forms.DockStyle.Fill;
            this.cbNameOfStaff.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.cbNameOfStaff.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbNameOfStaff.FormattingEnabled = true;
            this.cbNameOfStaff.Location = new System.Drawing.Point(110, 3);
            this.cbNameOfStaff.Name = "cbNameOfStaff";
            this.cbNameOfStaff.Size = new System.Drawing.Size(324, 29);
            this.cbNameOfStaff.TabIndex = 8;
            this.cbNameOfStaff.SelectedValueChanged += new System.EventHandler(this.cbNameOfStaff_SelectedIndexChanged);
            // 
            // materialLabel1
            // 
            this.materialLabel1.AutoSize = true;
            this.materialLabel1.Depth = 0;
            this.materialLabel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.materialLabel1.Font = new System.Drawing.Font("Roboto", 11F);
            this.materialLabel1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(222)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.materialLabel1.Location = new System.Drawing.Point(0, 0);
            this.materialLabel1.Margin = new System.Windows.Forms.Padding(0);
            this.materialLabel1.MouseState = MaterialSkin.MouseState.HOVER;
            this.materialLabel1.Name = "materialLabel1";
            this.materialLabel1.Size = new System.Drawing.Size(107, 46);
            this.materialLabel1.TabIndex = 12;
            this.materialLabel1.Text = "Họ và tên ";
            this.materialLabel1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // DateCreateOT
            // 
            this.DateCreateOT.CustomFormat = "dd/MM/yyyy";
            this.DateCreateOT.Dock = System.Windows.Forms.DockStyle.Fill;
            this.DateCreateOT.Font = new System.Drawing.Font("Consolas", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.DateCreateOT.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.DateCreateOT.Location = new System.Drawing.Point(541, 49);
            this.DateCreateOT.Name = "DateCreateOT";
            this.DateCreateOT.Size = new System.Drawing.Size(130, 26);
            this.DateCreateOT.TabIndex = 47;
            // 
            // bunifuElipse1
            // 
            this.bunifuElipse1.ElipseRadius = 5;
            this.bunifuElipse1.TargetControl = this;
            // 
            // CREATE_HOURS_OT
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tableLayoutPanel2);
            this.Name = "CREATE_HOURS_OT";
            this.Size = new System.Drawing.Size(674, 138);
            this.Load += new System.EventHandler(this.CREATE_HOURS_OT_Load);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.ComboBox cbNameOfStaff;
        private MaterialSkin.Controls.MaterialLabel materialLabel1;
        private System.Windows.Forms.Label lbUserName;
        private MaterialSkin.Controls.MaterialLabel materialLabel2;
        private System.Windows.Forms.ComboBox cbRangeHoursOT;
        private MaterialSkin.Controls.MaterialLabel materialLabel3;
        private Bunifu.Framework.UI.BunifuElipse bunifuElipse1;
        private MaterialSkin.Controls.MaterialLabel materialLabel6;
        private System.Windows.Forms.DateTimePicker DateCreateOT;
        private Bunifu.Framework.UI.BunifuMaterialTextbox txtOTHours;
        private MaterialSkin.Controls.MaterialLabel materialLabel4;
        private System.Windows.Forms.Button button1;
    }
}
