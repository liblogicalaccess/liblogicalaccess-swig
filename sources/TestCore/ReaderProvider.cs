using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibLogicalAccess;
using LibLogicalAccess.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace TestCore
{
    [TestClass]
    public class TestReaderProvider
    {
        [TestMethod]
        public void TestGetReaderProvider()
        {
            var libManager = LibraryManager.getInstance();
            var readerProvider = libManager.getReaderProvider("A3MLGM5600");
            Assert.IsTrue(readerProvider is A3MLGM5600ReaderProvider);
            readerProvider = libManager.getReaderProvider("Admitto");
            Assert.IsTrue(readerProvider is AdmittoReaderProvider);
            readerProvider = libManager.getReaderProvider("AxessTMC13");
            Assert.IsTrue(readerProvider is AxessTMC13ReaderProvider);
            readerProvider = libManager.getReaderProvider("AxessTMCLegic");
            Assert.IsTrue(readerProvider is AxessTMCLegicReaderProvider);
            readerProvider = libManager.getReaderProvider("Deister");
            Assert.IsTrue(readerProvider is DeisterReaderProvider);
            readerProvider = libManager.getReaderProvider("Elatec");
            Assert.IsTrue(readerProvider is ElatecReaderProvider);
            readerProvider = libManager.getReaderProvider("GigaTMS");
            Assert.IsTrue(readerProvider is GigaTMSReaderProvider);
            readerProvider = libManager.getReaderProvider("Gunnebo");
            Assert.IsTrue(readerProvider is GunneboReaderProvider);
            readerProvider = libManager.getReaderProvider("IdOnDemand");
            Assert.IsTrue(readerProvider is IdOnDemandReaderProvider);
            //readerProvider = libManager.getReaderProvider("IDP"); //Need external dll
            //Assert.IsTrue(readerProvider is IDPReaderProvider);
            //readerProvider = libManager.getReaderProvider("ISO7816"); //Return null by c++
            //Assert.IsTrue(readerProvider is ISO7816ReaderProvider);
            readerProvider = libManager.getReaderProvider("Keyboard");
            Assert.IsTrue(readerProvider is KeyboardReaderProvider);
            readerProvider = libManager.getReaderProvider("NFC");
            Assert.IsTrue(readerProvider is NFCReaderProvider);
            readerProvider = libManager.getReaderProvider("OK5553");
            Assert.IsTrue(readerProvider is OK5553ReaderProvider);
            readerProvider = libManager.getReaderProvider("OSDP");
            Assert.IsTrue(readerProvider is OSDPReaderProvider);
            readerProvider = libManager.getReaderProvider("PCSC");
            Assert.IsTrue(readerProvider is PCSCReaderProvider);
            readerProvider = libManager.getReaderProvider("Promag");
            Assert.IsTrue(readerProvider is PromagReaderProvider);
            readerProvider = libManager.getReaderProvider("RFIDeas");
            Assert.IsTrue(readerProvider is RFIDeasReaderProvider);
            readerProvider = libManager.getReaderProvider("Rpleth");
            Assert.IsTrue(readerProvider is RplethReaderProvider);
            readerProvider = libManager.getReaderProvider("SCIEL");
            Assert.IsTrue(readerProvider is SCIELReaderProvider);
            readerProvider = libManager.getReaderProvider("SmartID");
            Assert.IsTrue(readerProvider is SmartIDReaderProvider);
            readerProvider = libManager.getReaderProvider("STidPRG");
            Assert.IsTrue(readerProvider is STidPRGReaderProvider);
            readerProvider = libManager.getReaderProvider("STidSTR");
            Assert.IsTrue(readerProvider is STidSTRReaderProvider);
        }
    }
}
