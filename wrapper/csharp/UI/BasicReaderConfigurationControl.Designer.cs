namespace LibLogicalAccess.UI
{
    partial class BasicReaderConfigurationControl
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
            this.lblReaderProvider = new System.Windows.Forms.Label();
            this.cbReaderProvider = new System.Windows.Forms.ComboBox();
            this.cbReaderUnit = new System.Windows.Forms.ComboBox();
            this.lblReaderUnit = new System.Windows.Forms.Label();
            this.linkRefresh = new System.Windows.Forms.LinkLabel();
            this.SuspendLayout();
            // 
            // lblReaderProvider
            // 
            this.lblReaderProvider.AutoSize = true;
            this.lblReaderProvider.Location = new System.Drawing.Point(3, 6);
            this.lblReaderProvider.Name = "lblReaderProvider";
            this.lblReaderProvider.Size = new System.Drawing.Size(87, 13);
            this.lblReaderProvider.TabIndex = 0;
            this.lblReaderProvider.Text = "Reader Provider:";
            // 
            // cbReaderProvider
            // 
            this.cbReaderProvider.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbReaderProvider.FormattingEnabled = true;
            this.cbReaderProvider.Location = new System.Drawing.Point(96, 3);
            this.cbReaderProvider.Name = "cbReaderProvider";
            this.cbReaderProvider.Size = new System.Drawing.Size(186, 21);
            this.cbReaderProvider.TabIndex = 1;
            this.cbReaderProvider.SelectedIndexChanged += new System.EventHandler(this.cbReaderProvider_SelectedIndexChanged);
            // 
            // cbReaderUnit
            // 
            this.cbReaderUnit.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbReaderUnit.FormattingEnabled = true;
            this.cbReaderUnit.Location = new System.Drawing.Point(96, 30);
            this.cbReaderUnit.Name = "cbReaderUnit";
            this.cbReaderUnit.Size = new System.Drawing.Size(137, 21);
            this.cbReaderUnit.TabIndex = 3;
            // 
            // lblReaderUnit
            // 
            this.lblReaderUnit.AutoSize = true;
            this.lblReaderUnit.Location = new System.Drawing.Point(23, 33);
            this.lblReaderUnit.Name = "lblReaderUnit";
            this.lblReaderUnit.Size = new System.Drawing.Size(67, 13);
            this.lblReaderUnit.TabIndex = 2;
            this.lblReaderUnit.Text = "Reader Unit:";
            // 
            // linkRefresh
            // 
            this.linkRefresh.AutoSize = true;
            this.linkRefresh.Cursor = System.Windows.Forms.Cursors.Hand;
            this.linkRefresh.Location = new System.Drawing.Point(239, 33);
            this.linkRefresh.Name = "linkRefresh";
            this.linkRefresh.Size = new System.Drawing.Size(44, 13);
            this.linkRefresh.TabIndex = 4;
            this.linkRefresh.TabStop = true;
            this.linkRefresh.Text = "Refresh";
            this.linkRefresh.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkRefresh_LinkClicked);
            // 
            // BasicReaderConfigurationControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.linkRefresh);
            this.Controls.Add(this.cbReaderUnit);
            this.Controls.Add(this.lblReaderUnit);
            this.Controls.Add(this.cbReaderProvider);
            this.Controls.Add(this.lblReaderProvider);
            this.Name = "BasicReaderConfigurationControl";
            this.Size = new System.Drawing.Size(288, 56);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblReaderProvider;
        private System.Windows.Forms.ComboBox cbReaderProvider;
        private System.Windows.Forms.ComboBox cbReaderUnit;
        private System.Windows.Forms.Label lblReaderUnit;
        private System.Windows.Forms.LinkLabel linkRefresh;
    }
}
