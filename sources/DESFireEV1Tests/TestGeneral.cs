using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;
using System.Collections.Generic;

namespace DESFireEV1Tests
{
    [TestClass]
    public class TestGeneral : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.WriteLine("This test target DESFireEV1 cards. It tests that we are able to change a key using Islog Key Server.");
            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.WriteLine("TESTS LIST: ");
            Debug.WriteLine("Authenticate");
            Debug.WriteLine("ChangeKey");
            Debug.WriteLine("WriteRead");
            Debug.WriteLine("ReadFormat");
        }

        [TestMethod]
        public void General()
        {
            LLANTestInit();

            Debug.WriteLine("Chip identifier: " + UCharCollectionToHexString(chip.getChipIdentifier()));
            Assert.AreEqual(chip.getCardType(), "DESFireEV1", "Chip is not an DESFireEV1, but is " + chip.getCardType() + " instead.");

            DESFireEV1Chip desfirechip = chip as DESFireEV1Chip;
            Assert.IsNotNull(desfirechip);
            Debug.WriteLine("Has Real UID: " + desfirechip.hasRealUID());

            var location_root_node = chip.getRootLocationNode();

            var cmdev1 = chip.getCommands() as DESFireEV1ISO7816Commands;
            var cmd = cmdev1.getBridgeDF();
            Assert.IsNotNull(cmd, "Cannot get correct command object from chip.");
            Assert.IsNotNull(cmdev1, "Cannot get correct command object from chip.");

            cmd.selectApplication(0x00);
            cmd.authenticate(0);
               
            cmd.erase();
            cmdev1.createApplication(0x521, DESFireKeySettings.KS_DEFAULT, 3,
                                      DESFireKeyType.DF_KEY_AES,
                                      FidSupport.FIDS_NO_ISO_FID, 0, new UByteVector());

            cmd.selectApplication(0x521);
            DESFireKey key = new DESFireKey();
            key.setKeyType(DESFireKeyType.DF_KEY_AES);
            cmdev1.authenticate(0, key);
            Debug.WriteLine("Authenticate: OK");

            DESFireAccessRights ar = new DESFireAccessRights();
            ar.readAccess = TaskAccessRights.AR_KEY2;
            ar.writeAccess = TaskAccessRights.AR_KEY1;
            ar.readAndWriteAccess = TaskAccessRights.AR_KEY1;
            ar.changeAccess = TaskAccessRights.AR_KEY1;
            cmdev1.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, ar, 4, 0);


            cmdev1.authenticate(1, key);
            UByteVector data = new UByteVector(new byte[] { 0x01, 0x02, 0x03, 0x04});
            cmdev1.writeData(0, 0, data, EncryptionMode.CM_ENCRYPT);

            cmdev1.authenticate(2, key);
            UByteVector tmp = cmdev1.readData(0, 0, 4, EncryptionMode.CM_ENCRYPT);
            Assert.AreEqual(data, tmp, "read and write data are different!");
            Debug.WriteLine("WriteRead: OK");

            cmdev1.authenticate(0x00, key);
            cmdev1.deleteFile(0x00);

            cmdev1.authenticate(0x00, key);
            DESFireKey newkey = new DESFireKey("00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03");
            cmdev1.changeKey(0x00, newkey);
            Debug.WriteLine("ChangeKey: OK");

            cmdev1.selectApplication(0x00);
            cmdev1.authenticate(0);
            cmdev1.deleteApplication(0x521);

            var service = chip.getService(CardServiceType.CST_ACCESS_CONTROL) as AccessControlCardService;
            Assert.IsNotNull(service, "Cannot retrieve access control service from chip.");

            var location = new DESFireLocation();
            location.aid = 0x522;
            location.file = 0;
            var ai = new DESFireAccessInfo();
            var format = new Wiegand26Format();
            format.setUid(1000);
            format.setFacilityCode(67);

            service.writeFormat(format, location, ai, ai);
            var formattmp = new Wiegand26Format();
            var rformat = service.readFormat(formattmp, location, ai) as Wiegand26Format;

            if (rformat == null || rformat.getUid() != 1000 || rformat.getFacilityCode() != 67)
                throw new Exception("Bad format");
            Debug.WriteLine("ReadFormat; OK");

            Debug.WriteLine("Has Real UID: " + desfirechip.hasRealUID());
            Debug.WriteLine("Chip UID" + chip.getChipIdentifier());
        }
    }
}
