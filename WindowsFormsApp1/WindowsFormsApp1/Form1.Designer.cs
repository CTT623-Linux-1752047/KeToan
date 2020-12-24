using System.Drawing;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    partial class Form1
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.process1 = new System.Diagnostics.Process();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.panel1 = new System.Windows.Forms.Panel();
            this.tbnSetting = new System.Windows.Forms.Button();
            this.btnOT = new System.Windows.Forms.Button();
            this.btnWorkingHours = new System.Windows.Forms.Button();
            this.panelDropDown = new System.Windows.Forms.Panel();
            this.btnPIT = new System.Windows.Forms.Button();
            this.btnInsurance = new System.Windows.Forms.Button();
            this.btnPayroll = new System.Windows.Forms.Button();
            this.btnDayOFF = new System.Windows.Forms.Button();
            this.btnDashBoard = new System.Windows.Forms.Button();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.button7 = new System.Windows.Forms.Button();
            this.quanlynhansu1 = new WindowsFormsApp1.QUANLYNHANSU();
            this.quanlyngaynghi1 = new WindowsFormsApp1.QUANLYNGAYNGHI();
            this.quanlyluong1 = new WindowsFormsApp1.QUANLYLUONG();
            this.quanlybaohiem1 = new WindowsFormsApp1.QUANLYBAOHIEM();
            this.quanlythuetncn1 = new WindowsFormsApp1.QUANLYTHUETNCN();
            this.quanlygiocong1 = new WindowsFormsApp1.QUANLYGIOCONG();
            this.quanlyot1 = new WindowsFormsApp1.QUANLYOT();
            this.quanlythietlap1 = new WindowsFormsApp1.QUANLYTHIETLAP();
            this.tableLayoutPanel2.SuspendLayout();
            this.panel2.SuspendLayout();
            this.panel1.SuspendLayout();
            this.panelDropDown.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 1;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel2.Controls.Add(this.panel2, 0, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(246, 0);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 1;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 811F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(1238, 811);
            this.tableLayoutPanel2.TabIndex = 7;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.quanlythietlap1);
            this.panel2.Controls.Add(this.quanlyot1);
            this.panel2.Controls.Add(this.quanlygiocong1);
            this.panel2.Controls.Add(this.quanlythuetncn1);
            this.panel2.Controls.Add(this.quanlybaohiem1);
            this.panel2.Controls.Add(this.quanlyluong1);
            this.panel2.Controls.Add(this.quanlyngaynghi1);
            this.panel2.Controls.Add(this.quanlynhansu1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(3, 3);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(1232, 805);
            this.panel2.TabIndex = 0;
            // 
            // process1
            // 
            this.process1.StartInfo.Domain = "";
            this.process1.StartInfo.LoadUserProfile = false;
            this.process1.StartInfo.Password = null;
            this.process1.StartInfo.StandardErrorEncoding = null;
            this.process1.StartInfo.StandardOutputEncoding = null;
            this.process1.StartInfo.UserName = "";
            this.process1.SynchronizingObject = this;
            // 
            // timer1
            // 
            this.timer1.Interval = 5;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.panel1.Controls.Add(this.tbnSetting);
            this.panel1.Controls.Add(this.btnOT);
            this.panel1.Controls.Add(this.btnWorkingHours);
            this.panel1.Controls.Add(this.panelDropDown);
            this.panel1.Controls.Add(this.btnDayOFF);
            this.panel1.Controls.Add(this.btnDashBoard);
            this.panel1.Controls.Add(this.pictureBox1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(246, 811);
            this.panel1.TabIndex = 0;
            // 
            // tbnSetting
            // 
            this.tbnSetting.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.tbnSetting.Dock = System.Windows.Forms.DockStyle.Top;
            this.tbnSetting.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.tbnSetting.FlatAppearance.BorderSize = 0;
            this.tbnSetting.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.tbnSetting.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tbnSetting.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.tbnSetting.Image = ((System.Drawing.Image)(resources.GetObject("tbnSetting.Image")));
            this.tbnSetting.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.tbnSetting.Location = new System.Drawing.Point(0, 555);
            this.tbnSetting.Margin = new System.Windows.Forms.Padding(0);
            this.tbnSetting.Name = "tbnSetting";
            this.tbnSetting.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.tbnSetting.Size = new System.Drawing.Size(246, 81);
            this.tbnSetting.TabIndex = 17;
            this.tbnSetting.Text = "THIẾT LẬP ";
            this.tbnSetting.UseVisualStyleBackColor = false;
            this.tbnSetting.Click += new System.EventHandler(this.tbnSetting_Click);
            // 
            // btnOT
            // 
            this.btnOT.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.btnOT.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnOT.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(4)))), ((int)(((byte)(36)))), ((int)(((byte)(52)))));
            this.btnOT.FlatAppearance.BorderSize = 0;
            this.btnOT.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnOT.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnOT.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnOT.Image = ((System.Drawing.Image)(resources.GetObject("btnOT.Image")));
            this.btnOT.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnOT.Location = new System.Drawing.Point(0, 474);
            this.btnOT.Margin = new System.Windows.Forms.Padding(0);
            this.btnOT.Name = "btnOT";
            this.btnOT.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.btnOT.Size = new System.Drawing.Size(246, 81);
            this.btnOT.TabIndex = 16;
            this.btnOT.Text = "OVER TIME";
            this.btnOT.UseVisualStyleBackColor = false;
            this.btnOT.Click += new System.EventHandler(this.btnOT_Click);
            // 
            // btnWorkingHours
            // 
            this.btnWorkingHours.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.btnWorkingHours.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnWorkingHours.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.btnWorkingHours.FlatAppearance.BorderSize = 0;
            this.btnWorkingHours.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnWorkingHours.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnWorkingHours.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnWorkingHours.Image = ((System.Drawing.Image)(resources.GetObject("btnWorkingHours.Image")));
            this.btnWorkingHours.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnWorkingHours.Location = new System.Drawing.Point(0, 393);
            this.btnWorkingHours.Margin = new System.Windows.Forms.Padding(0);
            this.btnWorkingHours.Name = "btnWorkingHours";
            this.btnWorkingHours.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.btnWorkingHours.Size = new System.Drawing.Size(246, 81);
            this.btnWorkingHours.TabIndex = 15;
            this.btnWorkingHours.Text = "GIỜ CÔNG ";
            this.btnWorkingHours.UseVisualStyleBackColor = false;
            this.btnWorkingHours.Click += new System.EventHandler(this.btnWorkingHours_Click);
            // 
            // panelDropDown
            // 
            this.panelDropDown.Controls.Add(this.btnPIT);
            this.panelDropDown.Controls.Add(this.btnInsurance);
            this.panelDropDown.Controls.Add(this.btnPayroll);
            this.panelDropDown.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelDropDown.Location = new System.Drawing.Point(0, 312);
            this.panelDropDown.MaximumSize = new System.Drawing.Size(246, 246);
            this.panelDropDown.MinimumSize = new System.Drawing.Size(246, 81);
            this.panelDropDown.Name = "panelDropDown";
            this.panelDropDown.Size = new System.Drawing.Size(246, 81);
            this.panelDropDown.TabIndex = 14;
            // 
            // btnPIT
            // 
            this.btnPIT.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(44)))), ((int)(((byte)(44)))), ((int)(((byte)(44)))));
            this.btnPIT.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnPIT.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.btnPIT.FlatAppearance.BorderSize = 0;
            this.btnPIT.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPIT.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPIT.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnPIT.Image = ((System.Drawing.Image)(resources.GetObject("btnPIT.Image")));
            this.btnPIT.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnPIT.Location = new System.Drawing.Point(0, 152);
            this.btnPIT.Margin = new System.Windows.Forms.Padding(0);
            this.btnPIT.Name = "btnPIT";
            this.btnPIT.Padding = new System.Windows.Forms.Padding(30, 0, 0, 0);
            this.btnPIT.Size = new System.Drawing.Size(246, 71);
            this.btnPIT.TabIndex = 5;
            this.btnPIT.Text = "              THUẾ THU NHẬP CÁ NHÂN (PIT)";
            this.btnPIT.UseVisualStyleBackColor = false;
            this.btnPIT.Click += new System.EventHandler(this.btnPIT_Click);
            // 
            // btnInsurance
            // 
            this.btnInsurance.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(55)))), ((int)(((byte)(55)))), ((int)(((byte)(55)))));
            this.btnInsurance.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnInsurance.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.btnInsurance.FlatAppearance.BorderSize = 0;
            this.btnInsurance.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnInsurance.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnInsurance.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnInsurance.Image = ((System.Drawing.Image)(resources.GetObject("btnInsurance.Image")));
            this.btnInsurance.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnInsurance.Location = new System.Drawing.Point(0, 81);
            this.btnInsurance.Margin = new System.Windows.Forms.Padding(0);
            this.btnInsurance.Name = "btnInsurance";
            this.btnInsurance.Padding = new System.Windows.Forms.Padding(30, 0, 0, 0);
            this.btnInsurance.Size = new System.Drawing.Size(246, 71);
            this.btnInsurance.TabIndex = 4;
            this.btnInsurance.Text = "BẢO HIỂM ";
            this.btnInsurance.UseVisualStyleBackColor = false;
            this.btnInsurance.Click += new System.EventHandler(this.btnInsurance_Click);
            // 
            // btnPayroll
            // 
            this.btnPayroll.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.btnPayroll.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnPayroll.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.btnPayroll.FlatAppearance.BorderSize = 0;
            this.btnPayroll.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPayroll.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPayroll.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnPayroll.Image = ((System.Drawing.Image)(resources.GetObject("btnPayroll.Image")));
            this.btnPayroll.ImageAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnPayroll.Location = new System.Drawing.Point(0, 0);
            this.btnPayroll.Margin = new System.Windows.Forms.Padding(0);
            this.btnPayroll.Name = "btnPayroll";
            this.btnPayroll.Padding = new System.Windows.Forms.Padding(8, 0, 10, 0);
            this.btnPayroll.Size = new System.Drawing.Size(246, 81);
            this.btnPayroll.TabIndex = 3;
            this.btnPayroll.Text = "      BẢNG LƯƠNG ";
            this.btnPayroll.UseVisualStyleBackColor = false;
            this.btnPayroll.Click += new System.EventHandler(this.btnPayroll_Click);
            // 
            // btnDayOFF
            // 
            this.btnDayOFF.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.btnDayOFF.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnDayOFF.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.btnDayOFF.FlatAppearance.BorderSize = 0;
            this.btnDayOFF.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDayOFF.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDayOFF.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnDayOFF.Image = ((System.Drawing.Image)(resources.GetObject("btnDayOFF.Image")));
            this.btnDayOFF.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnDayOFF.Location = new System.Drawing.Point(0, 231);
            this.btnDayOFF.Margin = new System.Windows.Forms.Padding(0);
            this.btnDayOFF.Name = "btnDayOFF";
            this.btnDayOFF.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.btnDayOFF.Size = new System.Drawing.Size(246, 81);
            this.btnDayOFF.TabIndex = 3;
            this.btnDayOFF.Text = " NGÀY NGHỈ";
            this.btnDayOFF.UseVisualStyleBackColor = false;
            this.btnDayOFF.Click += new System.EventHandler(this.btnDayOFF_Click);
            // 
            // btnDashBoard
            // 
            this.btnDashBoard.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.btnDashBoard.Dock = System.Windows.Forms.DockStyle.Top;
            this.btnDashBoard.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.btnDashBoard.FlatAppearance.BorderSize = 0;
            this.btnDashBoard.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDashBoard.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDashBoard.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.btnDashBoard.Image = ((System.Drawing.Image)(resources.GetObject("btnDashBoard.Image")));
            this.btnDashBoard.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnDashBoard.Location = new System.Drawing.Point(0, 150);
            this.btnDashBoard.Margin = new System.Windows.Forms.Padding(0);
            this.btnDashBoard.Name = "btnDashBoard";
            this.btnDashBoard.Padding = new System.Windows.Forms.Padding(10, 0, 0, 0);
            this.btnDashBoard.Size = new System.Drawing.Size(246, 81);
            this.btnDashBoard.TabIndex = 2;
            this.btnDashBoard.Text = "QUẢN LÝ NHÂN SỰ ";
            this.btnDashBoard.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnDashBoard.UseVisualStyleBackColor = false;
            this.btnDashBoard.Click += new System.EventHandler(this.btnDashBoard_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.pictureBox1.Dock = System.Windows.Forms.DockStyle.Top;
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Margin = new System.Windows.Forms.Padding(0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(246, 150);
            this.pictureBox1.TabIndex = 1;
            this.pictureBox1.TabStop = false;
            // 
            // button7
            // 
            this.button7.BackColor = System.Drawing.SystemColors.Control;
            this.button7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button7.FlatAppearance.BorderSize = 0;
            this.button7.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button7.Image = ((System.Drawing.Image)(resources.GetObject("button7.Image")));
            this.button7.Location = new System.Drawing.Point(1174, 0);
            this.button7.Margin = new System.Windows.Forms.Padding(0);
            this.button7.Name = "button7";
            this.button7.Size = new System.Drawing.Size(32, 32);
            this.button7.TabIndex = 4;
            this.button7.UseVisualStyleBackColor = false;
            // 
            // quanlynhansu1
            // 
            this.quanlynhansu1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlynhansu1.Location = new System.Drawing.Point(0, 0);
            this.quanlynhansu1.Name = "quanlynhansu1";
            this.quanlynhansu1.Size = new System.Drawing.Size(1232, 805);
            this.quanlynhansu1.TabIndex = 0;
            // 
            // quanlyngaynghi1
            // 
            this.quanlyngaynghi1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlyngaynghi1.Location = new System.Drawing.Point(0, 0);
            this.quanlyngaynghi1.Name = "quanlyngaynghi1";
            this.quanlyngaynghi1.Size = new System.Drawing.Size(1232, 805);
            this.quanlyngaynghi1.TabIndex = 1;
            // 
            // quanlyluong1
            // 
            this.quanlyluong1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlyluong1.Location = new System.Drawing.Point(0, 0);
            this.quanlyluong1.Margin = new System.Windows.Forms.Padding(0);
            this.quanlyluong1.Name = "quanlyluong1";
            this.quanlyluong1.Size = new System.Drawing.Size(1232, 805);
            this.quanlyluong1.TabIndex = 2;
            // 
            // quanlybaohiem1
            // 
            this.quanlybaohiem1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlybaohiem1.Location = new System.Drawing.Point(0, 0);
            this.quanlybaohiem1.Name = "quanlybaohiem1";
            this.quanlybaohiem1.Size = new System.Drawing.Size(1232, 805);
            this.quanlybaohiem1.TabIndex = 3;
            // 
            // quanlythuetncn1
            // 
            this.quanlythuetncn1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlythuetncn1.Location = new System.Drawing.Point(0, 0);
            this.quanlythuetncn1.Name = "quanlythuetncn1";
            this.quanlythuetncn1.Size = new System.Drawing.Size(1232, 805);
            this.quanlythuetncn1.TabIndex = 4;
            // 
            // quanlygiocong1
            // 
            this.quanlygiocong1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlygiocong1.Location = new System.Drawing.Point(0, 0);
            this.quanlygiocong1.Name = "quanlygiocong1";
            this.quanlygiocong1.Size = new System.Drawing.Size(1232, 805);
            this.quanlygiocong1.TabIndex = 5;
            // 
            // quanlyot1
            // 
            this.quanlyot1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlyot1.Location = new System.Drawing.Point(0, 0);
            this.quanlyot1.Name = "quanlyot1";
            this.quanlyot1.Size = new System.Drawing.Size(1232, 805);
            this.quanlyot1.TabIndex = 6;
            // 
            // quanlythietlap1
            // 
            this.quanlythietlap1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlythietlap1.Location = new System.Drawing.Point(0, 0);
            this.quanlythietlap1.Name = "quanlythietlap1";
            this.quanlythietlap1.Size = new System.Drawing.Size(1232, 805);
            this.quanlythietlap1.TabIndex = 7;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1484, 811);
            this.Controls.Add(this.tableLayoutPanel2);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panelDropDown.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private TableLayoutPanel tableLayoutPanel2;
        private Panel panel2;
        private Button button7;
        private System.Diagnostics.Process process1;
        private Timer timer1;
        private Panel panel1;
        private Button tbnSetting;
        private Button btnOT;
        private Button btnWorkingHours;
        private Panel panelDropDown;
        private Button btnPIT;
        private Button btnInsurance;
        private Button btnPayroll;
        private Button btnDayOFF;
        private Button btnDashBoard;
        private PictureBox pictureBox1;
        private QUANLYTHIETLAP quanlythietlap1;
        private QUANLYOT quanlyot1;
        private QUANLYGIOCONG quanlygiocong1;
        private QUANLYTHUETNCN quanlythuetncn1;
        private QUANLYBAOHIEM quanlybaohiem1;
        private QUANLYLUONG quanlyluong1;
        private QUANLYNGAYNGHI quanlyngaynghi1;
        private QUANLYNHANSU quanlynhansu1;
    }
}

