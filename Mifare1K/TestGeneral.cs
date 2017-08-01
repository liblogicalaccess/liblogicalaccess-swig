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
    public class TestGeneral : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.WriteLine("This test target Mifare1K cards.\n");

            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.WriteLine("TESTS LIST: ");
            Debug.WriteLine("LoadKey");
            Debug.WriteLine("Authenticate");
            Debug.WriteLine("WriteReadBinary");
            Debug.WriteLine("WriteReadSector");
            Debug.WriteLine("WriteReadSectors");
            Debug.WriteLine("ChangeKey");
            Debug.WriteLine("WriteReadFormat");
        }

        [TestMethod]
        public void GeneralTests()
        {
            LLANTestInit();

            Debug.WriteLine("Chip identifier: " + UCharCollectionToHexString(chip.getChipIdentifier()));
            Assert.AreEqual(chip.getChipIdentifier().ToString(), "Mifare1K", "Chip is not an Mifare1K, but is " + chip.getCardType() + " instead.");

            var cmd = chip.getCommands() as MifareCommands;
            var key = new MifareKey("ff ff ff ff ff ff");
            cmd.loadKey(0, MifareKeyType.KT_KEY_A, key);
            Debug.WriteLine("LoadKey: OK");

            cmd.authenticate(8, 0, MifareKeyType.KT_KEY_A);
            Debug.WriteLine("Authenticate: OK");

            UByteVector data = new UByteVector(16);
            UByteVector tmp = new UByteVector();

            cmd.updateBinary(8, data);
            tmp = cmd.readBinary(8, 16);

            Assert.AreEqual(data.Count, tmp.Count, "read and write data are different!");
            for (int i = 0; i < data.Count; i++)
                Assert.AreEqual(data[i], tmp[i], "read and write data are different!");
            Debug.WriteLine("WriteReadBinary: OK");

            data.Clear();
            data.Capacity = 48;
            data[0] = 0x11;
            data[47] = 0xff;
            MifareAccessInfo.SectorAccessBits sab = new MifareAccessInfo.SectorAccessBits();

            cmd.writeSector(2, 0, data, new MifareKey(), new MifareKey(), sab, 0, out sab);

            tmp = cmd.readSector(2, 0, new MifareKey(), new MifareKey(), sab);

            Assert.AreEqual(data.Count, tmp.Count, "read and write data are different!");
            for (int i = 0; i < data.Count; i++)
                Assert.AreEqual(data[i], tmp[i], "read and write data are different!");
            Debug.WriteLine("WriteReadSector: OK");

            data.Clear();
            data.Capacity = 96;
            data[0] = 0x11;
            data[95] = 0xff;

            cmd.writeSectors(2, 3, 0, data, new MifareKey(), new MifareKey(), sab);

            tmp = cmd.readSectors(2, 3, 0, new MifareKey(), new MifareKey(), sab);

            Assert.AreEqual(data.Count, tmp.Count, "read and write data are different!");
            for (int i = 0; i < data.Count; i++)
                Assert.AreEqual(data[i], tmp[i], "read and write data are different!");
            Debug.WriteLine("WriteReadSectors: OK");


            var newkey = new MifareKey("ff ff ff ff ff fa");
            cmd.changeKeys(MifareKeyType.KT_KEY_A, new MifareKey(), newkey, new MifareKey(), 2, out sab);
            cmd.changeKeys(MifareKeyType.KT_KEY_A, newkey, new MifareKey(), new MifareKey(), 2, out sab);
            Debug.WriteLine("ChangeKey: OK");

            var service = chip.getService(CardServiceType.CST_ACCESS_CONTROL) as AccessControlCardService;
            Assert.IsNotNull(service, "Cannot retrieve service");

            var location = new MifareLocation();
            location.sector = 2;
            var format = new Wiegand26Format();
            format.setUid(1000);
            format.setFacilityCode(67);
            service.writeFormat(format, location, null, null);

            var formattmp = new Wiegand26Format();
            var rformat = service.readFormat(formattmp, location, null) as Wiegand26Format;

            if (rformat == null || rformat.getUid() != 1000 || rformat.getFacilityCode() != 67)
                throw new FormatException("Bad format");
            Debug.WriteLine("WriteReadFormat: OK");
        }
    }
}
