using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;
using System.Collections.Generic;
using System.Linq;

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

            var cmdev1 = chip.getCommands() as DESFireEV1ISO7816Commands;
            var cmd = cmdev1;
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
            Assert.IsTrue(data.SequenceEqual(tmp), "read and write data are different!");
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


            DESFireEV1Location dlocation = new DESFireEV1Location();

            // The Application ID to use
            dlocation.aid = 0x000534;
            // File 0 into this application
            dlocation.file = 0;
            // File communication requires encryption
            dlocation.securityLevel = EncryptionMode.CM_ENCRYPT;
            dlocation.useEV1 = true;
            dlocation.cryptoMethod = DESFireKeyType.DF_KEY_AES;


            DESFireAccessInfo daiToUse = new DESFireAccessInfo();
            daiToUse.masterCardKey.fromString("00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00");
            daiToUse.writeKeyno = 1;
            daiToUse.readKeyno = 1;


            cmdev1.selectApplication(0x00);
            cmdev1.authenticate(0);
            cmdev1.erase();

            cmdev1.createApplication(0x534, DESFireKeySettings.KS_DEFAULT, 3,
                DESFireKeyType.DF_KEY_AES,
                FidSupport.FIDS_NO_ISO_FID, 0, new UByteVector());
            cmd.selectApplication(0x534);

            key = new DESFireKey();
            key.setKeyType(DESFireKeyType.DF_KEY_AES);
            cmd.authenticate(0, key);

            // We can do everything with key1
            ar.readAccess = TaskAccessRights.AR_KEY1;
            ar.writeAccess = TaskAccessRights.AR_KEY1;
            ar.readAndWriteAccess = TaskAccessRights.AR_KEY1;
            ar.changeAccess = TaskAccessRights.AR_KEY1;

            // Create the file we will use.
            uint file_size = 16;
            cmdev1.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, ar, file_size, 0);

            byte[] writeData = new byte[16];
            for (byte i = 0; i < 16; i++)
            {
                writeData[i] = i;
            }

            var storage = cmdev1.getChip().getService(CardServiceType.CST_STORAGE) as StorageCardService;
            storage.writeData(location, daiToUse, daiToUse, new UByteVector(writeData), CardBehavior.CB_DEFAULT);
            Debug.WriteLine("WriteService: OK");

            UByteVector readData = storage.readData(location, daiToUse, 16, CardBehavior.CB_DEFAULT);
            Debug.WriteLine("ReadService: OK");

            Assert.AreEqual(writeData.Length, readData.Count, "Data read is not what we wrote.");
            for (int i = 0; i < writeData.Length && i < readData.Count; i++)
            {
                Assert.AreEqual(writeData[i], readData[i], "Data read is not what we wrote.");
            }
            Debug.WriteLine("CorrectWriteRead");

            Debug.WriteLine("Has Real UID: " + desfirechip.hasRealUID());
            Debug.WriteLine("Chip UID" + chip.getChipIdentifier());
        }
    }
}
