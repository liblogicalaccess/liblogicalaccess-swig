using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using LibLogicalAccess.Reader;

namespace LibLogicalAccess.UI
{
    public partial class BasicReaderConfigurationControl : UserControl
    {
        public BasicReaderConfigurationControl()
        {
            InitializeComponent();

            if (!this.DesignMode && LicenseManager.UsageMode != LicenseUsageMode.Designtime)
            {
                RefreshReaderProviderList();
            }
        }

        private void linkRefresh_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            RefreshReaderUnitList();
        }

        private void cbReaderProvider_SelectedIndexChanged(object sender, EventArgs e)
        {
            RefreshReaderUnitList();
        }

        private void RefreshReaderProviderList()
        {
            cbReaderProvider.Items.Clear();
            StringCollection readers = LibraryManager.getInstance().getAvailableReaders();
            foreach (string reader in readers)
            {
                cbReaderProvider.Items.Add(reader);
            }

            if (cbReaderProvider.Items.Contains("PCSC"))
            {
                cbReaderProvider.SelectedItem = "PCSC";
            }
        }

        private void RefreshReaderUnitList()
        {
            cbReaderUnit.Items.Clear();

            if (cbReaderProvider.SelectedIndex > -1)
            {
                ReaderProvider readerProvider = LibraryManager.getInstance().getReaderProvider(cbReaderProvider.SelectedItem.ToString());
                if (readerProvider != null)
                {
                    ReaderUnitCollection readerUnitList = readerProvider.getReaderList();
                    foreach (ReaderUnit readerUnit in readerUnitList)
                    {
                        cbReaderUnit.Items.Add(readerUnit.getName());
                    }
                }
            }
        }

        public void SetReader(ReaderProvider readerProvider, ReaderUnit readerUnit)
        {
            if (readerProvider == null)
            {
                cbReaderProvider.SelectedIndex = -1;
            }
            else
            {
                cbReaderProvider.SelectedItem = readerProvider.getRPName();
                if (readerUnit == null)
                {
                    cbReaderUnit.SelectedIndex = -1;
                }
                else
                {
                    cbReaderUnit.SelectedItem = readerUnit.getName();
                }
            }
        }

        public void GetReader(out ReaderProvider readerProvider, out ReaderUnit readerUnit)
        {
            if (cbReaderProvider.SelectedIndex > -1)
            {
                readerProvider = LibraryManager.getInstance().getReaderProvider(cbReaderProvider.SelectedItem.ToString());
                readerUnit = null;
                if (readerProvider != null && cbReaderUnit.SelectedIndex > -1)
                {
                    ReaderUnitCollection readerUnitList = readerProvider.getReaderList();
                    foreach (ReaderUnit ru in readerUnitList)
                    {
                        if (ru.getName() == cbReaderUnit.SelectedItem.ToString())
                        {
                            readerUnit = ru;
                            break;
                        }
                    }
                }
            }
            else
            {
                readerProvider = null;
                readerUnit = null;
            }
        }
    }
}
