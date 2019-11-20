using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using System.Threading;

namespace TestCore
{
    [TestClass]
    public abstract class Core
    {
        public static bool prologue_has_run = false;
        public enum ReaderType
        {
            PCSC,
            NFC
        }
        public static ReaderType reader_type = ReaderType.PCSC;

        protected static ReaderProvider provider;

        protected static ReaderUnit readerUnit;

        protected static Chip chip;

        [TestInitialize]
        public void Prologue()
        {
            string waitTime = Environment.GetEnvironmentVariable("LLAN_TEST_WAIT");
            if (waitTime != null && waitTime.Length > 0)
            {
                int duration = int.Parse(waitTime);
                Thread.Sleep(duration);
            }

            prologue_has_run = true;
        }

        [TestInitialize]
        public abstract void Introduction();

        public static void PCSCTestInit(string card_type = "", string contact_reader = "")
        {
            // Reader configuration object to store reader provider and reader unit selection.
            ReaderConfiguration readerConfig = new ReaderConfiguration();

            // Set PCSC ReaderProvider by calling the Library Manager which will load the function from the corresponding plug-in
            provider = LibraryManager.getInstance().getReaderProvider("PCSC");
            Assert.IsNotNull(provider, "Cannot get PCSC provider.");
            readerConfig.setReaderProvider(provider);

            readerUnit = null;
            var readerUnits = readerConfig.getReaderProvider().getReaderList();
            if (!string.IsNullOrEmpty(contact_reader))
            {
                for (int x = 0; x < readerUnits.Count; ++x)
                {
                    if (readerUnits[x].getName() == contact_reader)
                        readerUnit = readerUnits[x];
                }
            }
            else if (readerUnits.Count > 0)
                readerUnit = readerUnits[0];
            Assert.IsNotNull(readerUnit, "Cannot create reader unit.");

            if (card_type.Length > 0)
                readerUnit.setCardType(card_type);

            Assert.IsTrue(readerUnit.connectToReader(), "Cannot connect to reader.");
            Debug.WriteLine("~ Connected to reader");
            Debug.WriteLine("~ StartWaitInsertation");
            Assert.IsTrue(readerUnit.waitInsertion(15000), "waitInsertion failed.");
            Debug.WriteLine("~ EndWaitInsertation");
            Assert.IsTrue(readerUnit.connect(), "Failed to connect");
            Debug.WriteLine("~ Connected");

            chip = readerUnit.getSingleChip();
            Assert.IsNotNull(chip, "getSingleChip() returned NULL");
            Debug.WriteLine("~ GetSingleChip");
        }

        public static void NFCTestInit()
        {
            // Reader configuration object to store reader provider and reader unit selection.
            ReaderConfiguration readerConfig = new ReaderConfiguration();

            // Set PCSC ReaderProvider by calling the Library Manager which will load the function from the corresponding plug-in
            provider = LibraryManager.getInstance().getReaderProvider("NFC");
            Assert.IsNotNull(provider, "Cannot get NFC provider.");
            readerConfig.setReaderProvider(provider);

            readerUnit = readerConfig.getReaderProvider().createReaderUnit();
            Assert.IsNotNull(readerUnit, "Cannot create reader unit.");

            Assert.IsTrue(readerUnit.connectToReader(), "Cannot connect to reader.");

            Assert.IsTrue(readerUnit.waitInsertion(15000), "waitInsertion failed.");

            Assert.IsTrue(readerUnit.connect(), "Failed to connect");

            chip = readerUnit.getSingleChip();
            Assert.IsNotNull(chip, "getSingleChip() returned NULL");
        }

        public static void LLATestInit(string card_type = "")
        {
            Assert.IsTrue(prologue_has_run, "Call prologue() before initializing the test suite");
            if (reader_type == ReaderType.PCSC)
                PCSCTestInit();
            else if (reader_type == ReaderType.NFC)
                NFCTestInit();
            else
            {
                provider = null;
                readerUnit = null;
                chip = null;
            }
        }

        public static string GetOSName()
        {
            OperatingSystem os = Environment.OSVersion;
            switch (os.Platform)
            {
                case PlatformID.MacOSX:
                    return "Mac OSX";
                case PlatformID.Unix:
                    return "Linux";
                default:
                    return "Win";
            }
        }

        public static string UCharCollectionToHexString(ByteVector uchars)
        {
            string str = String.Empty;
            foreach (byte b in uchars)
            {
                str += b.ToString("X2");
            }
            return str;
        }

        public string PCSCReaderUnitName(ReaderUnit ru)
        {
            PCSCReaderUnit PCSCReader = ru as PCSCReaderUnit;
            Assert.IsNotNull(PCSCReader, "Reader is not PCSC");

            switch (PCSCReader.getPCSCType())
            {
                case PCSCReaderUnitType.PCSC_RUT_OMNIKEY_XX21:
                    return "OKXX21";
                case PCSCReaderUnitType.PCSC_RUT_OMNIKEY_XX22:
                    return "OKXX22";
                case PCSCReaderUnitType.PCSC_RUT_OMNIKEY_XX25:
                    return "OKXX25";
                case PCSCReaderUnitType.PCSC_RUT_OMNIKEY_XX27:
                    return "OKXX27";
                default:
                    Assert.IsTrue(false, "PCSC type not handled");
                    break;
            }
            return "I AM DEAD";
        }

        [TestCleanup]
        public void PCSCTestShutdown()
        {
            readerUnit.disconnect();
            Debug.WriteLine("~ StartWaitRemoval");
            //Assert.IsTrue(readerUnit.waitRemoval(15000), "Failed to waitRemoval");
            readerUnit.waitRemoval(1);
            Debug.WriteLine("~ EndWaitRemoval");
            readerUnit.disconnectFromReader();
        }
    }
}
