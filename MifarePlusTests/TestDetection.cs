using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;

namespace MifarePlusTests
{
    [TestClass]
    public class TestDetection : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.WriteLine("This test target ISO15693 cards.");
            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.WriteLine("TESTS LIST: ");
            Debug.WriteLine("SystemInformation");
            Debug.WriteLine("WriteBlock");
            Debug.WriteLine("ReadBlock");
        }

        [TestMethod]
        public void DetectionTest()
        {
            PCSCTestInit();

            Debug.WriteLine("Chip identifier: " + UCharCollectionToHexString(chip.getChipIdentifier()));
            Debug.WriteLine("Chip type = " + chip.getCardType());
            Debug.WriteLine("Generic type = " + chip.getGenericCardType());
            Assert.IsNotNull(chip.getCommands(), "No command object.");

            var mfp = chip as MifarePlusChip;
            Assert.IsNotNull(mfp, "Invalid chip object");
            Debug.WriteLine("Security Level: " + mfp.getSecurityLevel());
        }
    }
}
