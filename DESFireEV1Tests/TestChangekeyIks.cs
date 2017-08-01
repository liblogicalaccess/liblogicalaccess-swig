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
    public class TestChangekeyIks : Core
    {
        [TestInitialize]
        public override void Introduction()
        {
            Debug.WriteLine("This test target DESFireEV1 cards. It tests that we are able to change a key using Islog Key Server.");
            Debug.WriteLine("You will have 20 seconds to insert a card. Test log below");
            Debug.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

            Debug.WriteLine("TESTS LIST: ");
            Debug.WriteLine("WriteService");
            Debug.WriteLine("ReadService");
            Debug.WriteLine("CorrectWriteRead");
        }

        public void ReadWrite(DESFireEV1ISO7816Commands cmdev1)
        {
            var key = new DESFireKey();
            key.setKeyType(DESFireKeyType.DF_KEY_AES);
            key.setKeyStorage(new IKSStorage("imported-one-aes"));
            var div = new NXPAV2KeyDiversification();
            div.setSystemIdentifier(new UByteVector(System.Text.Encoding.ASCII.GetBytes("BOAP")));
            key.setKeyDiversification(div);
    
            cmdev1.selectApplication(0x535);
            cmdev1.authenticate(0, key);
    
            // The excepted memory tree
            DESFireEV1Location dlocation = new DESFireEV1Location();
    
            var storage = cmdev1.getChip().getService(CardServiceType.CST_STORAGE) as StorageCardService;
    
            // The Application ID to use
            dlocation.aid = 0x535;
            // File 0 into this application
            dlocation.file = 0;
            // File communication requires encryption
            dlocation.securityLevel = EncryptionMode.CM_ENCRYPT;
            dlocation.useEV1 = true;
            dlocation.cryptoMethod = DESFireKeyType.DF_KEY_AES;
    
            DESFireAccessInfo daiToUse = new DESFireAccessInfo();
            daiToUse.masterApplicationKey = key;
            daiToUse.writeKeyno = 0;
            daiToUse.writeKey = key;
            daiToUse.readKeyno = 0;
            daiToUse.readKey = key;
    
            // Data to write
            List<byte> writeData = new List<byte>(16);
            for (int i = 0; i < 16; i++)
            {
                writeData[i] = (byte)'d';
            }
            UByteVector readData = new UByteVector();
            // Write data on the specified location with the specified key
            storage.writeData(dlocation, daiToUse, daiToUse, new UByteVector(writeData), CardBehavior.CB_DEFAULT);
            Debug.WriteLine("WriteService: OK");
    
            // We read the data on the same location. Remember, the key is now changed.
            readData = storage.readData(dlocation, daiToUse, 16, CardBehavior.CB_DEFAULT);
            Debug.WriteLine("ReadService: OK");

            Assert.AreEqual(writeData.Count, readData.Count, "Data read is not what we wrote.");
            for (int i = 0; i < writeData.Count && i < readData.Count; i++)
            {
                Assert.AreEqual(writeData[i], readData[i], "Data read is not what we wrote.");
            }
            Debug.WriteLine("CorrectWriteRead");
        }
    
        public void CreateAppAndFile(DESFireISO7816Commands cmd, DESFireEV1ISO7816Commands cmdev1)
        {
            // create the application we wish to write into
            cmdev1.createApplication(0x535, DESFireKeySettings.KS_DEFAULT, 3, DESFireKeyType.DF_KEY_AES,
                                     FidSupport.FIDS_NO_ISO_FID, 0, new UByteVector());
            cmd.selectApplication(0x535);
    
            DESFireKey key = new DESFireKey();
            key.setKeyType(DESFireKeyType.DF_KEY_AES);
            key.fromString("00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00");
            UByteVector bla = new UByteVector(key.getData().ToCharArray());
    
            //key.setKeyStorage(new IKSStorage("imported-zero-aes"));
            cmdev1.authenticate(0, key);
            DESFireKey new_key = new DESFireKey();
            new_key.setKeyType(DESFireKeyType.DF_KEY_AES);
            var div = new NXPAV2KeyDiversification();
            byte[] tmp = System.Text.Encoding.ASCII.GetBytes("BOAP");
            div.setSystemIdentifier(new UByteVector(tmp));
            new_key.setKeyDiversification(div);
            //new_key.setKeyStorage(new IKSStorage("imported-zero-aes"));
    
            // We can do everything with key1
            DESFireAccessRights ar = new DESFireAccessRights();
            ar.readAccess = TaskAccessRights.AR_KEY0;
            ar.writeAccess = TaskAccessRights.AR_KEY0;
            ar.readAndWriteAccess = TaskAccessRights.AR_KEY0;
            ar.changeAccess = TaskAccessRights.AR_KEY0;
    
            // Create the file we will use.
            uint file_size = 16;
            cmdev1.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, ar, file_size, 0);
            cmdev1.authenticate(0, key);
            DESFireChip dchip = cmd.getChip() as DESFireChip;
            dchip.getCrypto().setKey(0x535, 0, key);
    
            cmd.changeKey(0, new_key);
        }

        [TestMethod]
        public void ChangekeyIks()
        {
            LLANTestInit();
            
            Debug.WriteLine("Chip identifier: " + UCharCollectionToHexString(chip.getChipIdentifier()));
            Assert.AreEqual(chip.getCardType(), "DESFireEV1", "Chip is not an DESFireEV1, but is " + chip.getCardType() + " instead.");
    
            var storage = chip.getService(CardServiceType.CST_STORAGE) as StorageCardService;
            var test = chip.getCardType();
            var cmd = (chip.getCommands() as DESFireEV1ISO7816Commands).getBridgeDF();
            DESFireEV1ISO7816Commands cmdev1 = chip.getCommands() as DESFireEV1ISO7816Commands;
            DESFireKey key = new DESFireKey();
            key.setKeyType(DESFireKeyType.DF_KEY_DES);
            //key.setKeyStorage(new IKSStorage("imported-zero-des"));
            cmd.selectApplication(0x00);
            cmd.authenticate(0, key);
            cmd.erase();

            CreateAppAndFile(cmd, cmdev1);
            ReadWrite(cmdev1);
            cmd.selectApplication(0x00);
            cmd.authenticate(0, key);
            cmd.deleteApplication(0x535);
            cmd.erase();
        }
    }
}
