using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace TestCore
{
    [TestClass]
    public class TestGetType
    {
        [TestMethod]
        public void TestGetAllAccessInfo()
        {
            var formatInfos = new FormatInfos();
            AccessInfo tmpAccessInfo = new DESFireAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is DESFireAccessInfo);

            tmpAccessInfo = new EPassAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is EPassAccessInfo);

            tmpAccessInfo = new HIDiClassAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is HIDiClassAccessInfo);

            tmpAccessInfo = new MifareAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is MifareAccessInfo);

            tmpAccessInfo = new MifarePlusSL1AccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is MifarePlusSL1AccessInfo);

            tmpAccessInfo = new MifareUltralightAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is MifareUltralightAccessInfo);

            tmpAccessInfo = new MifareUltralightCAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is MifareUltralightCAccessInfo);

            tmpAccessInfo = new SeosAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is SeosAccessInfo);

            tmpAccessInfo = new SeosValueAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is SeosValueAccessInfo);

            tmpAccessInfo = new TopazAccessInfo();
            formatInfos.setAiToWrite(tmpAccessInfo);
            Assert.IsTrue(formatInfos.getAiToWrite() is TopazAccessInfo);
        }


        [TestMethod]
        public void TestGetAllFormat()
        {
            Debug.WriteLine("Start format... ");
            foreach (FormatType type in Enum.GetValues(typeof(FormatType)))
            {
                Format format = Format.getByFormatType(type);

                switch (type)
                {
                    case FormatType.FT_ASCII:
                        if (!(format is ASCIIFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_BARIUM_FERRITE_PCSC:
                        if (!(format is BariumFerritePCSCFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND35:
                        if (!(format is Wiegand35Format))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_CUSTOM:
                        if (!(format is CustomFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_DATACLOCK:
                        if (!(format is DataClockFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_FASCN200BIT:
                        if (!(format is FASCN200BitFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_GETRONIK40BIT:
                        if (!(format is Getronik40BitFormat))
                            throw new Exception("Wrong format");
                        break;

                    case FormatType.FT_HIDHONEYWELL:
                        if (!(format is HIDHoneywell40BitFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_RAW:
                        if (!(format is RawFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND26:
                        if (!(format is Wiegand26Format))
                            throw new Exception("Wrong format");
                        break;

                    case FormatType.FT_WIEGAND34:
                        if (!(format is Wiegand34Format))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND34FACILITY:
                        if (!(format is Wiegand34WithFacilityFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND37:
                        if (!(format is Wiegand37Format))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGAND37FACILITY:
                        if (!(format is Wiegand37WithFacilityFormat))
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_UNKNOWN:
                        if (format != null)
                            throw new Exception("Wrong format");
                        break;
                    case FormatType.FT_WIEGANDFLEXIBLE:
                        break; //No used
                    default:
                        throw new Exception("Unknown format");
                }
            }

            Debug.WriteLine("End format test");
        }

        [TestMethod]
        public void TestGetAllReaderService()
        {
            OmnikeyXX21ReaderUnit pcscReader = new OmnikeyXX21ReaderUnit("my-reader-name");
            var readerService = pcscReader.getService(ReaderServiceType.RST_LICENSE_CHECKER);
            (readerService as LicenseCheckerService).GetType();
            readerService = LibraryManager.getInstance()
                .getReaderService(pcscReader, ReaderServiceType.RST_LICENSE_CHECKER);
            (readerService as LicenseCheckerService).GetType();
        }

        [TestMethod]
        public void TestGetAllCardService()
        {
            DESFireEV1Chip desFireEv2Chip = new DESFireEV1Chip();
            (desFireEv2Chip.getService(CardServiceType.CST_NFC_TAG) as DESFireEV1NFCTag4CardService).GetType();
        }

        [TestMethod]
        public void TestGetDataTransport()
        {
            var readerUnit = PCSCReaderProvider.createInstance().createReaderUnit();

            DataTransport dt = new RplethDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is RplethDataTransport);
            dt = new SerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is SerialPortDataTransport);
            dt = new TCPDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is TCPDataTransport);
            dt = new UDPDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is UDPDataTransport);
#if ENABLE_WINDOWS_SPECIFIC_TESTS
            if (!Environment.Is64BitProcess)
            {
                dt = new IDPDataTransport();
                readerUnit.setDataTransport(dt);
                Assert.IsTrue(readerUnit.getDataTransport() is IDPDataTransport);
            }
#endif
            dt = new NFCDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is NFCDataTransport);
            dt = new PCSCDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is PCSCDataTransport);
            dt = new AdmittoSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is AdmittoSerialPortDataTransport);
            dt = new AxessTMC13SerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is AxessTMC13SerialPortDataTransport);
            dt = new AxessTMCLegicSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is AxessTMCLegicSerialPortDataTransport);
            dt = new DeisterSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is DeisterSerialPortDataTransport);
            dt = new ElatecSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is ElatecSerialPortDataTransport);
            dt = new GigaTMSSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is GigaTMSSerialPortDataTransport);
            dt = new GunneboSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is GunneboSerialPortDataTransport);
            dt = new OSDPSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is OSDPSerialPortDataTransport);
            dt = new STidPRGSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is STidPRGSerialPortDataTransport);
            dt = new STidSTRSerialPortDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is STidSTRSerialPortDataTransport);
            /*  dt = new PCSCHIDiClassDataTransport(); //Need an Argument
              readerUnit.setDataTransport(dt);
              Assert.IsTrue(readerUnit.getDataTransport() is PCSCHIDiClassDataTransport);*/
            dt = new PCSCControlDataTransport();
            readerUnit.setDataTransport(dt);
            Assert.IsTrue(readerUnit.getDataTransport() is PCSCControlDataTransport);
        }

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
#if ENABLE_WINDOWS_SPECIFIC_TESTS
            if (!Environment.Is64BitProcess)
            {
                readerProvider = libManager.getReaderProvider("IDP"); //Need external dll
                Assert.IsTrue(readerProvider is IDPReaderProvider);
            }

            readerProvider = libManager.getReaderProvider("ISO7816"); //Return null by c++
            Assert.IsTrue(readerProvider == null); // is ISO7816ReaderProvider);
            readerProvider = libManager.getReaderProvider("Keyboard");
            Assert.IsTrue(readerProvider is KeyboardReaderProvider);
#endif
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
#if ENABLE_WINDOWS_SPECIFIC_TESTS
            Assert.IsTrue(readerProvider is RFIDeasReaderProvider);
            readerProvider = libManager.getReaderProvider("Rpleth");
#endif
            Assert.IsTrue(readerProvider is RplethReaderProvider);
            readerProvider = libManager.getReaderProvider("SCIEL");
            Assert.IsTrue(readerProvider is SCIELReaderProvider);
            readerProvider = libManager.getReaderProvider("SmartID");
            Assert.IsTrue(readerProvider is SmartIDReaderProvider);
            readerProvider = libManager.getReaderProvider("STidPRG");
            Assert.IsTrue(readerProvider is STidPRGReaderProvider);
            readerProvider = libManager.getReaderProvider("STidSTR");
            Assert.IsTrue(readerProvider is STidSTRReaderProvider);


            var readerConfiguration = new ReaderConfiguration();
            readerConfiguration.setReaderProvider(PCSCReaderProvider.createInstance());
            (readerConfiguration.getReaderProvider() as PCSCReaderProvider).GetType();
        }
    }
}