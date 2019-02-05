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
        [TestMethod]
        public void General()
        {
            string seReaderName = "HID Global OMNIKEY 5422 Smartcard Reader 0";
            string osReaderName = "HID OMNIKEY 5127 CK 0";

            // Reader configuration object to store reader provider and reader unit selection.
            ReaderConfiguration readerConfig = new ReaderConfiguration();

            // Set PCSC ReaderProvider by calling the Library Manager which will load the function from the corresponding plug-in
            var provider = LibraryManager.getInstance().getReaderProvider("PCSC");
            Assert.IsNotNull(provider, "Cannot get PCSC provider.");
            readerConfig.setReaderProvider(provider);

            ReaderUnit seReaderUnit = null;
            ReaderUnit osReaderUnit = null;
            var readerUnits = readerConfig.getReaderProvider().getReaderList();
            for (int x = 0; x < readerUnits.Count; ++x)
            {
                if (readerUnits[x].getName() == seReaderName)
                    seReaderUnit = readerUnits[x];
                else if(readerUnits[x].getName() == osReaderName)
                    osReaderUnit = readerUnits[x];
            }

            Assert.IsNotNull(seReaderUnit);
            Assert.IsNotNull(osReaderUnit);

            Assert.IsTrue(seReaderUnit.connectToReader(), "Cannot connect to se reader.");
            Debug.WriteLine($"~ Connected to reader{Environment.NewLine}~ StartWaitInsertation");
            Assert.IsTrue(seReaderUnit.waitInsertion(15000), "waitInsertion se failed.");
            Debug.WriteLine("~ EndWaitInsertation");
            Assert.IsTrue(seReaderUnit.connect(), "Failed to se connect");
            Debug.WriteLine("~ Connected");
            var sechip = seReaderUnit.getSingleChip();
            Assert.IsNotNull(sechip, "getSingleChip() se returned NULL");

            Assert.IsTrue(osReaderUnit.connectToReader(), "Cannot connect to os reader.");
            Debug.WriteLine($"~ Connected to reader{Environment.NewLine}~ StartWaitInsertation");
            Assert.IsTrue(osReaderUnit.waitInsertion(15000), "waitInsertion os failed.");
            Debug.WriteLine("~ EndWaitInsertation");
            Assert.IsTrue(osReaderUnit.connect(), "Failed to se connect");
            Debug.WriteLine("~ Connected");
            var oschip = osReaderUnit.getSingleChip();
            Assert.IsNotNull(oschip, "getSingleChip() se returned NULL");

            Debug.WriteLine("Chip identifier: " + Core.UCharCollectionToHexString(sechip.getChipIdentifier()));
            Assert.AreEqual(sechip.getCardType(), "SEProcessor", "Chip is not an SEProcessor, but is " + sechip.getCardType() + " instead.");
            Debug.WriteLine("Chip identifier: " + Core.UCharCollectionToHexString(oschip.getChipIdentifier()));
            Assert.AreEqual(oschip.getCardType(), "Seos", "Chip is not an Seos, but is " + oschip.getCardType() + " instead.");

            SeosChip seosChip = oschip as SeosChip;
            Assert.IsNotNull(seosChip);

            SEProcessorChip sEProcessorChip = sechip as SEProcessorChip;
            Assert.IsNotNull(sEProcessorChip);

            var cmdos = oschip.getCommands() as SeosISO7816Commands;
            Assert.IsNotNull(cmdos, "Cannot get correct command object from chip.");

            var cmdse = sechip.getCommands() as SEProcessorISO7816Commands;
            Assert.IsNotNull(cmdse, "Cannot get correct command object from chip.");

            cmdse.setHFReaderCardAdapter(oschip.getCommands().getReaderCardAdapter());

            var seosSEAccessControlCardService = sEProcessorChip.getService(LibLogicalAccess.CardServiceType.CST_ACCESS_CONTROL) as SeosSEAccessControlCardService;
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
