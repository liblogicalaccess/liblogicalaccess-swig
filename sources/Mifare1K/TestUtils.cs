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
    public class TestUtils : Core
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
        public void ValidationTests()
        {
            MifareAccessInfo.SectorAccessBits sab = new MifareAccessInfo.SectorAccessBits();
            ByteVector array = new ByteVector(3);
            array[0] = 1;
            Assert.IsFalse(sab.fromArray(array), "Passed validation but shouldn't have.");

            byte[] tmp = { 0xff, 0x07, 0x80 };
            ByteVector array2 = new ByteVector(tmp);
            Assert.IsTrue(sab.fromArray(array2), "Failed validation");
        }
    }
}
