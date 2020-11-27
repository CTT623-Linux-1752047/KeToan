﻿using System.Drawing;
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.panel2 = new System.Windows.Forms.Panel();
            this.bangluongnhanvien1 = new WindowsFormsApp1.BANGLUONGNHANVIEN();
            this.quanlynhansu1 = new WindowsFormsApp1.QUANLYNHANSU();
            this.ngaynghi1 = new WindowsFormsApp1.NGAYNGHI();
            this.header = new System.Windows.Forms.TableLayoutPanel();
            this.MaximumSize = new System.Windows.Forms.Button();
            this.MinimumWindow = new System.Windows.Forms.Button();
            this.CloseWindow = new System.Windows.Forms.Button();
            this.quanlygiocong1 = new WindowsFormsApp1.QUANLYGIOCONG();
            this.process1 = new System.Diagnostics.Process();
            this.button7 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            this.panel2.SuspendLayout();
            this.header.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.panel1.Controls.Add(this.tableLayoutPanel1);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Left;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(246, 811);
            this.panel1.TabIndex = 0;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(21)))), ((int)(((byte)(23)))), ((int)(((byte)(22)))));
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.button6, 0, 5);
            this.tableLayoutPanel1.Controls.Add(this.button5, 0, 6);
            this.tableLayoutPanel1.Controls.Add(this.button1, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.button2, 0, 2);
            this.tableLayoutPanel1.Controls.Add(this.button3, 0, 3);
            this.tableLayoutPanel1.Controls.Add(this.button4, 0, 4);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 8;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(246, 811);
            this.tableLayoutPanel1.TabIndex = 0;
            // 
            // button1
            // 
            this.button1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button1.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.button1.FlatAppearance.BorderSize = 0;
            this.button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button1.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.button1.Image = global::WindowsFormsApp1.Properties.Resources.icons8_business_conference_female_speaker_48;
            this.button1.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button1.Location = new System.Drawing.Point(0, 162);
            this.button1.Margin = new System.Windows.Forms.Padding(0);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(246, 81);
            this.button1.TabIndex = 0;
            this.button1.Text = "QUẢN LÝ NHÂN SỰ ";
            this.button1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click_1);
            // 
            // button2
            // 
            this.button2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button2.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.button2.FlatAppearance.BorderSize = 0;
            this.button2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button2.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button2.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.button2.Image = global::WindowsFormsApp1.Properties.Resources.icons8_day_off_48;
            this.button2.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button2.Location = new System.Drawing.Point(0, 243);
            this.button2.Margin = new System.Windows.Forms.Padding(0);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(246, 81);
            this.button2.TabIndex = 1;
            this.button2.Text = " NGÀY NGHỈ";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click_1);
            // 
            // button3
            // 
            this.button3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button3.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.button3.FlatAppearance.BorderSize = 0;
            this.button3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button3.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button3.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.button3.Image = global::WindowsFormsApp1.Properties.Resources.icons8_estimate_48;
            this.button3.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button3.Location = new System.Drawing.Point(0, 324);
            this.button3.Margin = new System.Windows.Forms.Padding(0);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(246, 81);
            this.button3.TabIndex = 2;
            this.button3.Text = "      BẢNG LƯƠNG ";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click_1);
            // 
            // button4
            // 
            this.button4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button4.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.button4.FlatAppearance.BorderSize = 0;
            this.button4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button4.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button4.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.button4.Image = global::WindowsFormsApp1.Properties.Resources.icons8_schedule_48;
            this.button4.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button4.Location = new System.Drawing.Point(0, 405);
            this.button4.Margin = new System.Windows.Forms.Padding(0);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(246, 81);
            this.button4.TabIndex = 3;
            this.button4.Text = "GIỜ CÔNG ";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click_1);
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 1;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel2.Controls.Add(this.panel2, 0, 1);
            this.tableLayoutPanel2.Controls.Add(this.header, 0, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(246, 0);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 2;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 4F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 96F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(1238, 811);
            this.tableLayoutPanel2.TabIndex = 7;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.quanlygiocong1);
            this.panel2.Controls.Add(this.bangluongnhanvien1);
            this.panel2.Controls.Add(this.quanlynhansu1);
            this.panel2.Controls.Add(this.ngaynghi1);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(3, 35);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(1232, 773);
            this.panel2.TabIndex = 0;
            // 
            // bangluongnhanvien1
            // 
            this.bangluongnhanvien1.BackColor = System.Drawing.Color.Maroon;
            this.bangluongnhanvien1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bangluongnhanvien1.Location = new System.Drawing.Point(0, 0);
            this.bangluongnhanvien1.Margin = new System.Windows.Forms.Padding(0);
            this.bangluongnhanvien1.Name = "bangluongnhanvien1";
            this.bangluongnhanvien1.Size = new System.Drawing.Size(1232, 773);
            this.bangluongnhanvien1.TabIndex = 6;
            // 
            // quanlynhansu1
            // 
            this.quanlynhansu1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlynhansu1.Location = new System.Drawing.Point(0, 0);
            this.quanlynhansu1.Name = "quanlynhansu1";
            this.quanlynhansu1.Size = new System.Drawing.Size(1232, 773);
            this.quanlynhansu1.TabIndex = 5;
            // 
            // ngaynghi1
            // 
            this.ngaynghi1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ngaynghi1.Location = new System.Drawing.Point(0, 0);
            this.ngaynghi1.Name = "ngaynghi1";
            this.ngaynghi1.Size = new System.Drawing.Size(1232, 773);
            this.ngaynghi1.TabIndex = 7;
            // 
            // header
            // 
            this.header.ColumnCount = 4;
            this.header.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.header.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 32F));
            this.header.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 32F));
            this.header.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 32F));
            this.header.Controls.Add(this.MaximumSize, 2, 0);
            this.header.Controls.Add(this.MinimumWindow, 1, 0);
            this.header.Controls.Add(this.CloseWindow, 3, 0);
            this.header.Dock = System.Windows.Forms.DockStyle.Fill;
            this.header.Location = new System.Drawing.Point(0, 0);
            this.header.Margin = new System.Windows.Forms.Padding(0);
            this.header.Name = "header";
            this.header.RowCount = 1;
            this.header.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.header.Size = new System.Drawing.Size(1238, 32);
            this.header.TabIndex = 1;
            this.header.MouseDown += new System.Windows.Forms.MouseEventHandler(this.header_MouseDown);
            this.header.MouseMove += new System.Windows.Forms.MouseEventHandler(this.header_MouseMove);
            this.header.MouseUp += new System.Windows.Forms.MouseEventHandler(this.header_MouseUp);
            // 
            // MaximumSize
            // 
            this.MaximumSize.BackColor = System.Drawing.SystemColors.Control;
            this.MaximumSize.Dock = System.Windows.Forms.DockStyle.Fill;
            this.MaximumSize.FlatAppearance.BorderSize = 0;
            this.MaximumSize.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.MaximumSize.ForeColor = System.Drawing.SystemColors.Control;
            this.MaximumSize.Image = global::WindowsFormsApp1.Properties.Resources.icons8_restore_window_24;
            this.MaximumSize.ImageAlign = System.Drawing.ContentAlignment.TopRight;
            this.MaximumSize.Location = new System.Drawing.Point(1174, 0);
            this.MaximumSize.Margin = new System.Windows.Forms.Padding(0);
            this.MaximumSize.Name = "MaximumSize";
            this.MaximumSize.Size = new System.Drawing.Size(32, 32);
            this.MaximumSize.TabIndex = 11;
            this.MaximumSize.UseVisualStyleBackColor = false;
            this.MaximumSize.Click += new System.EventHandler(this.MaximumSize_Click);
            // 
            // MinimumWindow
            // 
            this.MinimumWindow.BackColor = System.Drawing.SystemColors.Control;
            this.MinimumWindow.Dock = System.Windows.Forms.DockStyle.Fill;
            this.MinimumWindow.FlatAppearance.BorderSize = 0;
            this.MinimumWindow.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.MinimumWindow.ForeColor = System.Drawing.SystemColors.Control;
            this.MinimumWindow.Image = global::WindowsFormsApp1.Properties.Resources.icons8_minimize_window_24;
            this.MinimumWindow.ImageAlign = System.Drawing.ContentAlignment.TopRight;
            this.MinimumWindow.Location = new System.Drawing.Point(1142, 0);
            this.MinimumWindow.Margin = new System.Windows.Forms.Padding(0);
            this.MinimumWindow.Name = "MinimumWindow";
            this.MinimumWindow.Size = new System.Drawing.Size(32, 32);
            this.MinimumWindow.TabIndex = 9;
            this.MinimumWindow.UseVisualStyleBackColor = false;
            this.MinimumWindow.Click += new System.EventHandler(this.MinimumWindow_Click);
            // 
            // CloseWindow
            // 
            this.CloseWindow.BackColor = System.Drawing.SystemColors.Control;
            this.CloseWindow.Dock = System.Windows.Forms.DockStyle.Fill;
            this.CloseWindow.FlatAppearance.BorderSize = 0;
            this.CloseWindow.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.CloseWindow.ForeColor = System.Drawing.SystemColors.Control;
            this.CloseWindow.Image = global::WindowsFormsApp1.Properties.Resources.icons8_close_window_24__2_;
            this.CloseWindow.ImageAlign = System.Drawing.ContentAlignment.TopRight;
            this.CloseWindow.Location = new System.Drawing.Point(1206, 0);
            this.CloseWindow.Margin = new System.Windows.Forms.Padding(0);
            this.CloseWindow.Name = "CloseWindow";
            this.CloseWindow.Size = new System.Drawing.Size(32, 32);
            this.CloseWindow.TabIndex = 7;
            this.CloseWindow.UseVisualStyleBackColor = false;
            this.CloseWindow.Click += new System.EventHandler(this.CloseWindow_Click);            
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
            // button7
            // 
            this.button7.BackColor = System.Drawing.SystemColors.Control;
            this.button7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button7.FlatAppearance.BorderSize = 0;
            this.button7.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button7.Image = global::WindowsFormsApp1.Properties.Resources.icons8_minimize_window_24;
            this.button7.Location = new System.Drawing.Point(1174, 0);
            this.button7.Margin = new System.Windows.Forms.Padding(0);
            this.button7.Name = "button7";
            this.button7.Size = new System.Drawing.Size(32, 32);
            this.button7.TabIndex = 4;
            this.button7.UseVisualStyleBackColor = false;
            // 
            // quanlygiocong2
            // 
            this.quanlygiocong1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quanlygiocong1.Location = new System.Drawing.Point(0, 0);
            this.quanlygiocong1.Name = "quanlygiocong2";
            this.quanlygiocong1.Size = new System.Drawing.Size(1232, 773);
            this.quanlygiocong1.TabIndex = 8;
            // 
            // button5
            // 
            this.button5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button5.FlatAppearance.BorderColor = System.Drawing.Color.MediumSeaGreen;
            this.button5.FlatAppearance.BorderSize = 0;
            this.button5.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button5.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button5.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.button5.Image = global::WindowsFormsApp1.Properties.Resources.icons8_gear_48;
            this.button5.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button5.Location = new System.Drawing.Point(0, 567);
            this.button5.Margin = new System.Windows.Forms.Padding(0);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(246, 81);
            this.button5.TabIndex = 6;
            this.button5.Text = "THIẾT LẬP ";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // button6
            // 
            this.button6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.button6.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(4)))), ((int)(((byte)(36)))), ((int)(((byte)(52)))));
            this.button6.FlatAppearance.BorderSize = 0;
            this.button6.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.button6.Font = new System.Drawing.Font("Segoe UI Semibold", 12.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button6.ForeColor = System.Drawing.SystemColors.ControlLightLight;
            this.button6.Image = global::WindowsFormsApp1.Properties.Resources.icons8_time_to_pay_48;
            this.button6.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.button6.Location = new System.Drawing.Point(0, 486);
            this.button6.Margin = new System.Windows.Forms.Padding(0);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(246, 81);
            this.button6.TabIndex = 7;
            this.button6.Text = "OVER TIME";
            this.button6.UseVisualStyleBackColor = true;
            this.button6.Click += new System.EventHandler(this.button6_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1484, 811);
            this.Controls.Add(this.tableLayoutPanel2);
            this.Controls.Add(this.panel1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panel1.ResumeLayout(false);
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.header.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
        private Panel panel1;
        private TableLayoutPanel tableLayoutPanel1;
        private Button button1;
        private Button button2;
        private NGAYNGHI ngaynghi1;
        private QUANLYNHANSU quanlynhansu1;
        private Button button3;
        private Button button4;
        private TableLayoutPanel tableLayoutPanel2;
        private Panel panel2;
        private TableLayoutPanel header;
        private Button button7;
        private Button MaximumSize;
        private Button MinimumWindow;
        private Button CloseWindow;
        private System.Diagnostics.Process process1;
        private BANGLUONGNHANVIEN bangluongnhanvien1;
        private QUANLYGIOCONG quanlygiocong1;
        private Button button6;
        private Button button5;
    }
}

