using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;

namespace Mifare1KTests
{
    [TestClass]
    public class TestStorageService : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.Write("This test target Mifare1K cards.");

            Debug.Write("You will have 20 seconds to insert a card. Test log below");
            Debug.Write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.Write("TESTS LIST: ");
        }

        //[TestMethod]
        public void StorageServiceTests(string[] arg)
        {
            LLANTestInit();

            Assert.AreEqual(chip.getCardType(), "Mifare1K", "Chip is not a Mifare1K, but is " + chip.getCardType() + " instead.");

            var storage = chip.getService(CardServiceType.CST_STORAGE) as StorageCardService;

            Location location;
            AccessInfo aiToUse;
            AccessInfo aiToWrite;

            // We want to write data on sector 7.
            MifareLocation mLocation = new MifareLocation();
            mLocation.sector = 7;
            mLocation.block = 0;
            location = mLocation;

            // Key to use for sector authentication
            MifareAccessInfo maiToUse = new MifareAccessInfo();
            maiToUse.keyA.fromString("ff ff ff ff ff ff");
            maiToUse.keyB.fromString("ff ff ff ff ff ff");
            aiToUse = maiToUse;

            // Change the sector key with the following key
            MifareAccessInfo maiToWrite = new MifareAccessInfo();
            maiToWrite.keyA.fromString("ff ff ff ff ff ff");
            maiToWrite.keyB.fromString("ff ff ff ff ff ff");
            aiToWrite = maiToWrite;

            // Data to write
            UByteVector writeData = new UByteVector(16);
            for (int i = 0; i < 16; i++)
            {
                writeData[i] = (byte)'e';
            }

            // Data read
            UByteVector readData = new UByteVector();

            // Write data on the specified location with the specified key
            storage.writeData(location, aiToUse, aiToWrite, writeData, CardBehavior.CB_DEFAULT);

            const int mifare_block_size = 16;
            // We read the data on the same location. Remember, the key is now changed.
            readData = storage.readData(location, aiToWrite, mifare_block_size, CardBehavior.CB_DEFAULT);

            Assert.AreEqual(readData.Count, writeData.Count, "read and write data are different!");
            for (int i = 0; i < readData.Count; i++)
                Assert.AreEqual(readData[i], writeData[i], "read and write data are different!");
        }
    }
}
