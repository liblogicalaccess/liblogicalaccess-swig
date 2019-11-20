using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;

namespace ISO15693Tests
{
    [TestClass]
    public class TestGeneral : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.WriteLine("This test target ISO15693 cards.");
            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.WriteLine("TESTS LIST:");
            Debug.WriteLine("SystemInformation");
            Debug.WriteLine("WriteBlock");
            Debug.WriteLine("ReadBlock");
        }

        public void WriteReadTest(ReaderUnit readerUnit, ISO15693Commands cmd)
        {
            byte val = 0x00;

            for (uint i = 1; i < 7; ++i)
            {
                cmd.writeBlock(i, new ByteVector(new byte[]{ ++val, ++val, ++val, ++val }));
            }
            Debug.WriteLine("WriteBlock: OK");

            val = 0x00;

            for (uint i = 1; i < 7; ++i)
            {
                var ret = cmd.readBlock(i);
                Debug.WriteLine("Read back (" + i + ") : " + ret);
                var tmp = new ByteVector(new byte[] { ++val, ++val, ++val, ++val });
                Assert.AreEqual(tmp, ret, "We didn't read back what we wrote");
            }
            Debug.WriteLine("ReadBlock: OK");
        }

        [TestMethod]
        public void GeneralTest()
        {
            LLATestInit();

            Debug.WriteLine("Chip identifier: " + UCharCollectionToHexString(chip.getChipIdentifier()));
            Assert.AreEqual("ISO15693", chip.getCardType(), "Chip is not an ISO15693, but is " + chip.getCardType() + " instead.");

            var cmd = chip.getCommands() as ISO15693Commands;
            Assert.IsNotNull(cmd, "Cannot retrieve correct command object");

            var sysinfo = cmd.getSystemInformation();

            if (PCSCReaderUnitName(readerUnit) == "OKXX21" && GetOSName() == "Win")
            {
                Assert.IsTrue(sysinfo.hasVICCMemorySize, "Doesn't have VICCMemorySize information");
                Assert.AreEqual(4, sysinfo.blockSize, "Unexpected block size");
                Assert.AreEqual(40, sysinfo.nbBlocks, "Unexpected block number");
                Debug.WriteLine("SystemInformation: OK");
            }

            if ((GetOSName() == "Win" && PCSCReaderUnitName(readerUnit) == "OKXX21") ||
                PCSCReaderUnitName(readerUnit) == "OKXX27")
            {
                WriteReadTest(readerUnit, cmd);
            }
        }
    }
}
