using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Diagnostics;
using TestCore;

namespace SEOSTests
{
    [TestClass]
    public class TestSEOS
    {
        [TestInitialize]
        public void Introduction()
        {
            Debug.WriteLine("This test target Seos cards.");
            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.WriteLine("TESTS LIST: ");
            Debug.WriteLine("WriteFormat");
        }

        [TestMethod]
        public void General()
        {
            string seReaderName = "HID Global OMNIKEY 5422 Smartcard Reader 0";
            string osReaderName = "OMNIKEY CardMan 5x21-CL 0";

            var provider = LibraryManager.getInstance().getReaderProvider("PCSC");
            Assert.IsNotNull(provider, "Cannot get PCSC provider.");
            ReaderConfiguration readerConfig = new ReaderConfiguration();
            readerConfig.setReaderProvider(provider);

            ReaderUnit readerUnit = null;
            var readerUnits = readerConfig.getReaderProvider().getReaderList();
            for (int x = 0; x < readerUnits.Count; ++x)
            {
                if (readerUnits[x].getName() == osReaderName)
                {
                    readerUnit = readerUnits[x];
                    break;
                }
            }
            Assert.IsNotNull(readerUnit);

            var readerUnitConfiguration = new Omnikey5427ReaderUnitConfiguration();
            readerUnitConfiguration.setSAMReaderName(seReaderName);
            readerUnitConfiguration.setSAMType("SEProcessor");
            readerUnit.setConfiguration(readerUnitConfiguration);

            Assert.IsTrue(readerUnit.connectToReader(), "Cannot connect to reader.");
            Debug.WriteLine("~ Connected to reader");
            Debug.WriteLine("~ StartWaitInsertation");
            Assert.IsTrue(readerUnit.waitInsertion(15000), "waitInsertion failed.");
            Debug.WriteLine("~ EndWaitInsertation");
            Assert.IsTrue(readerUnit.connect(), "Failed to connect");
            Debug.WriteLine("~ Connected");

            var chip = readerUnit.getSingleChip();
            Assert.IsNotNull(chip, "getSingleChip() returned NULL");
            Debug.WriteLine("~ GetSingleChip");

            Debug.WriteLine("Chip identifier: " + Core.UCharCollectionToHexString(chip.getChipIdentifier()));
            Assert.AreEqual(chip.getCardType(), "Seos", "Chip is not an Seos, but is " + chip.getCardType() + " instead.");

            var cmdse = chip.getCommands() as SeosISO7816Commands;
            Assert.IsNotNull(cmdse, "Cannot get correct command object from chip.");

            var seosSEAccessControlCardService = chip.getService(LibLogicalAccess.CardServiceType.CST_ACCESS_CONTROL) as AccessControlCardService;
            Assert.IsNotNull(seosSEAccessControlCardService);

            var format = new Wiegand26Format();
            format.setUid(1024);
            format.setFacilityCode(42);
            var location = new SeosLocation();
            var aitouse = new SeosAccessInfo();
            var aitowrite = new SeosAccessInfoValue();
            aitouse.auth_key_oid = new UByteVector(new byte[] { 0x03, 0x42, 0x01 });
            aitouse.priv_enc_key_oid = new UByteVector(new byte[] { 0x03, 0x42, 0x01 });
            aitouse.priv_mac_key_oid = new UByteVector(new byte[] { 0x03, 0x42, 0x01 });
            aitouse.ref_data_qualifier = 2;
            seosSEAccessControlCardService.writeFormat(format, null, aitouse, null);
        }
    }
}
