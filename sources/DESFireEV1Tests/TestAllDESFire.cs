#define TESTUNIT_SAM_DESFIRE

using System;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using TestCore;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;

namespace DESFireEV1Tests
{
    [TestClass]
    public class TestAllDESFire
    {
        public static ByteVector StringToByteVector(string hex)
        {
            return new ByteVector(Enumerable.Range(0, hex.Length)
                .Where(x => x % 2 == 0)
                .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                .ToArray());
        }

        [TestMethod]
        public void General()
        {
            StringCollection readerList =
                LibraryManager.getInstance().getAvailableReaders();
            Debug.WriteLine("Available reader plug-ins (" + readerList.Count() + "):");
            for (int x = 0; x < readerList.Count(); ++x)
            {
                Debug.WriteLine("\t" + readerList[x]);
            }

            StringCollection cardList =
                LibraryManager.getInstance().getAvailableCards();
            Debug.WriteLine("Available card plug-ins (" + cardList.Count() + "):");
            for (int x = 0; x < cardList.Count(); ++x)
            {
                Debug.WriteLine("\t" + cardList[x]);
            }

            // Reader configuration object to store reader provider and reader unit selection.
            var readerConfig = new ReaderConfiguration();

            // PC/SC
            string rpstr = "PCSC";
            readerConfig.setReaderProvider(
                LibraryManager.getInstance().getReaderProvider(rpstr));
            Assert.AreNotEqual(readerConfig.getReaderProvider().getReaderList().Count(), 0);
            Debug.WriteLine(readerConfig.getReaderProvider().getReaderList().Count() + " readers on this system.");

            // List available reader units
            int ruindex = 3;
            ReaderUnitVector readers =
                readerConfig.getReaderProvider().getReaderList();
            Debug.WriteLine("Please select index of the reader unit to use:");
            for (int x = 0; x < readers.Count(); ++x)
            {
                Debug.WriteLine("\t" + readers[x].getName());
            }

            if (ruindex < 0 || ruindex >= readers.Count())
            {
                Assert.Fail("Selected reader unit outside range.");
            }

            Debug.WriteLine("Reader selected: " + readers[ruindex]);

            readerConfig.setReaderUnit(readers[ruindex]);
            Debug.WriteLine("Waiting 15 seconds for a card insertion...");

            var readerUnitConfig = readerConfig.getReaderUnit().getConfiguration() as ISO7816ReaderUnitConfiguration;
            readerUnitConfig.setSAMReaderName("OMNIKEY CardMan 5x21 0");
            readerUnitConfig.setSAMType("SAM_AV2");
            var keyUnlock = new DESFireKey(
                "11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11");
            keyUnlock.setKeyType(DESFireKeyType.DF_KEY_AES);
            keyUnlock.setKeyVersion(0x01);
            readerUnitConfig.setSAMUnlockKey(keyUnlock, 0);

            readerConfig.getReaderUnit().connectToReader();

            if (readerConfig.getReaderUnit().waitInsertion(15000))
            {
                if (readerConfig.getReaderUnit().connect())
                {
                    var chip = readerConfig.getReaderUnit().getSingleChip();
                    var cmd = chip.getCommands() as DESFireISO7816Commands;
                    var cmdev1 = chip.getCommands() as DESFireEV1ISO7816Commands;
                    var cmdev2 = chip.getCommands() as DESFireEV2ISO7816Commands;

                    // Create keys
                    var desDefault = new DESFireKey();
                    var aesDefault = new DESFireKey();
                    var desNew = new DESFireKey();
                    var aesNew = new DESFireKey();
                    var desNew2 = new DESFireKey();
                    var aesNew2 = new DESFireKey();
                    cleanupKeys(ref desDefault, ref aesDefault, ref desNew, ref aesNew, ref desNew2, ref aesNew2);

                    cleanupCard(cmd, desDefault);

                    // Test Create App

                    Debug.WriteLine("Card type: " + chip.getCardType());

                    if (chip.getCardType() == "DESFire")
                    {
                        var appIDS = cmd.getApplicationIDs();

                        cmd.createApplication(
                            0x521,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2);
                        cmd.deleteApplication(0x521);

                        // EV1 test
                        cmd.createApplication(
                            0x521,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2);

                        appIDS = cmd.getApplicationIDs();


                        // Classic DES test
                        cmd.selectApplication(0x521);
                        cmd.authenticate(0x00, desDefault);

                        classicTest(cmd, desNew, desNew2);
                    }
                    else if (chip.getCardType() == "DESFireEV1" ||
                             chip.getCardType() == "DESFireEV2")
                    {
                        var appIDS = cmdev1.getApplicationIDs();

                        cmdev1.createApplication(
                            0x521,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2, DESFireKeyType.DF_KEY_AES,
                            FidSupport.FIDS_ISO_FID, 0x125,
                            StringToByteVector("0125"));
                        cmdev1.deleteApplication(0x521);

                        // EV1 test
                        cmdev1.createApplication(
                            0x521,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2, DESFireKeyType.DF_KEY_DES,
                            FidSupport.FIDS_ISO_FID, 0x125,
                            StringToByteVector("0125"));
                        cmdev1.createApplication(
                            0x522,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2, DESFireKeyType.DF_KEY_AES,
                            FidSupport.FIDS_ISO_FID, 0x225,
                            StringToByteVector("0225"));

                        appIDS = cmdev1.getApplicationIDs();

                        var dfNames = cmdev1.getDFNames();

                        // EV1 DES test
                        cmd.selectApplication(0x521);
                        cmdev1.authenticate(0x00, desDefault);
                        ev1Test(cmdev1, cmdev2, desNew, desNew2);

                        // EV1 AES test
                        cmd.selectApplication(0x522);
                        cmdev1.authenticate(0x00, aesDefault);
                        ev1Test(cmdev1, cmdev2, aesNew, aesNew2);

                        cleanupCard(cmdev1, desDefault);
                        cleanupKeys(ref desDefault, ref aesDefault, ref desNew, ref aesNew, ref desNew2,
                            ref aesNew2);
                        cmdev1.createApplication(
                            0x523,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2, DESFireKeyType.DF_KEY_DES,
                            FidSupport.FIDS_ISO_FID, 0x325,
                            StringToByteVector("0325"));
                        cmdev1.createApplication(
                            0x524,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            2, DESFireKeyType.DF_KEY_AES,
                            FidSupport.FIDS_ISO_FID, 0x425,
                            StringToByteVector("0425"));


                        // EV1 authenticateISO DES test
                        cmd.selectApplication(0x523);
                        cmdev1.authenticateISO(0x00);
                        ev1Test(cmdev1, cmdev2, desNew, desNew2);

                        // EV1 authenticateAES test
                        cmd.selectApplication(0x524);
                        cmdev1.authenticateAES(0x00);
                        ev1Test(cmdev1, cmdev2, aesNew, aesNew2);


#if TESTUNIT_SAM_DESFIRE
                        cleanupCard(cmdev1, desDefault);
                        cleanupKeys(ref desDefault, ref aesDefault, ref desNew, ref aesNew, ref desNew2,
                            ref aesNew2);
                        cmdev1.createApplication(
                            0x600,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            3, DESFireKeyType.DF_KEY_DES,
                            FidSupport.FIDS_ISO_FID, 0x006,
                            StringToByteVector("0006"));
                        cmdev1.createApplication(
                            0x601,
                            (DESFireKeySettings) (
                                (int) DESFireKeySettings.KS_DEFAULT |
                                (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                            3, DESFireKeyType.DF_KEY_AES,
                            FidSupport.FIDS_ISO_FID, 0x106,
                            StringToByteVector("0106"));

                        cmd.selectApplication(0x600);
                        testSAMAuthChangeKey(cmdev1, DESFireKeyType.DF_KEY_DES, desNew,
                            desNew2);

                        cmd.selectApplication(0x601);
                        testSAMAuthChangeKey(cmdev1, DESFireKeyType.DF_KEY_AES, aesNew,
                            aesNew2);
#endif

                        if (cmdev2 != null)
                        {
                            // EV2
                            cleanupCard(cmdev1, desDefault);
                            cleanupKeys(ref desDefault, ref aesDefault, ref desNew, ref aesNew, ref desNew2,
                                ref aesNew2);

                            // EV2 application
                            cmdev1.createApplication(
                                0x531,
                                (DESFireKeySettings) (
                                    (int) DESFireKeySettings.KS_DEFAULT |
                                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                                2, DESFireKeyType.DF_KEY_DES,
                                FidSupport.FIDS_ISO_FID, 0x135,
                                StringToByteVector("0135"));
                            cmdev1.createApplication(
                                0x532,
                                (DESFireKeySettings) (
                                    (int) DESFireKeySettings.KS_DEFAULT |
                                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                                2, DESFireKeyType.DF_KEY_AES,
                                FidSupport.FIDS_ISO_FID, 0x235,
                                StringToByteVector("0235"));
                            cmdev1.createApplication(
                                0x533,
                                (DESFireKeySettings) (
                                    (int) DESFireKeySettings.KS_DEFAULT |
                                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                                2, DESFireKeyType.DF_KEY_AES,
                                FidSupport.FIDS_ISO_FID, 0x335,
                                StringToByteVector("0335"));

                            // EV2 DES test
                            cmd.selectApplication(0x531);
                            cmdev1.authenticate(0x00, desDefault);
                            ev1Test(cmdev1, cmdev2, desNew, desNew2);
                            // EV2 AES test
                            cmd.selectApplication(0x532);
                            cmdev1.authenticate(0x00, aesDefault);
                            ev1Test(cmdev1, cmdev2, aesNew, aesNew2);
                            // EV2 AuthFirst test
                            cmd.selectApplication(0x533);
                            cmdev2.authenticateEV2First(0, aesDefault);
                            ev1Test(cmdev1, cmdev2, aesNew, aesNew2);


                            // ev2 features test
                            ev2Test(desDefault, cmdev2, desNew, aesNew);

#if TESTUNIT_SAM_DESFIRE
                            cleanupCard(cmdev1, desDefault);
                            cleanupKeys(ref desDefault, ref aesDefault, ref desNew, ref aesNew, ref desNew2,
                                ref aesNew2);
                            cmdev1.createApplication(
                                0x600,
                                (DESFireKeySettings) (
                                    (int) DESFireKeySettings.KS_DEFAULT |
                                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                                3, DESFireKeyType.DF_KEY_AES,
                                FidSupport.FIDS_ISO_FID, 0x006,
                                StringToByteVector("0006"));

                            cmd.selectApplication(0x600);
                            testSAMEV2AuthChangeKey(cmdev2, aesNew, aesNew2);
#endif
                        }

                        cleanupCard(cmdev1, desDefault);

                        setConfigurationTest(cmdev1, cmdev2, desDefault);

                        testPICCKey(cmdev1, desDefault, aesDefault, desNew, aesNew);
                    }

                    readerConfig.getReaderUnit().disconnect();
                }

                readerConfig.getReaderUnit().waitRemoval(0x1);
                readerConfig.getReaderUnit().disconnectFromReader();
            }
            else
                throw new Exception("no card detected.");
        }


        void classicTest(DESFireISO7816Commands cmd,
            DESFireKey newKey,
            DESFireKey newKey2)
        {
            DESFireAccessRights acr = new DESFireAccessRights();
            acr.changeAccess = TaskAccessRights.AR_KEY0;
            acr.readAccess = TaskAccessRights.AR_KEY1;
            acr.readAndWriteAccess = TaskAccessRights.AR_KEY0;
            acr.writeAccess = TaskAccessRights.AR_KEY0;

            DESFireCommands.DESFireCardVersion dataVersion = cmd.getVersion();

            DESFireKeySettings settings;
            byte maxNbKeys;
            cmd.getKeySettings(out settings, out maxNbKeys);
            cmd.changeKeySettings(settings);

            var fileIDS = cmd.getFileIDs();

            cmd.changeKeySettings(DESFireKeySettings.KS_DEFAULT);

            var dataArray = new byte[]
            {
                0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
                0x07, 0x08, 0x09, 0x0a, 0x0b
            };
            ByteVector read, data = new ByteVector(dataArray);
            ByteVector datalong = data;

            Array.Resize(ref dataArray, 100);
            datalong = new ByteVector(dataArray);

            // createStdDataFile
            cmd.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 200);
            cmd.createStdDataFile(0x01, EncryptionMode.CM_MAC, acr, 200);
            cmd.createStdDataFile(0x02, EncryptionMode.CM_PLAIN, acr, 200);
            // standard
            cmd.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);
            cmd.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);

            cmd.writeData(0x02, 0, datalong, EncryptionMode.CM_PLAIN);
            cmd.writeData(0x01, 0, datalong, EncryptionMode.CM_MAC);
            cmd.writeData(0x00, 0, datalong, EncryptionMode.CM_ENCRYPT);

            cmd.writeData(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x01, 3, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x01, 3, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x02, 3, data, EncryptionMode.CM_PLAIN);
            cmd.writeData(0x02, 3, data, EncryptionMode.CM_PLAIN);

            read = cmd.readData(0x00, 0, 10, EncryptionMode.CM_ENCRYPT);
            read = cmd.readData(0x01, 0, 10, EncryptionMode.CM_MAC);
            read = cmd.readData(0x02, 0, 10, EncryptionMode.CM_PLAIN);

            read = cmd.readData(0x00, 0, 100, EncryptionMode.CM_ENCRYPT);
            read = cmd.readData(0x01, 0, 100, EncryptionMode.CM_MAC);
            read = cmd.readData(0x02, 0, 100, EncryptionMode.CM_PLAIN);

            read = cmd.readData(0x00, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmd.readData(0x01, 0, 0, EncryptionMode.CM_MAC);
            read = cmd.readData(0x02, 0, 0, EncryptionMode.CM_PLAIN);

            read = cmd.readData(0x00, 5, 8, EncryptionMode.CM_ENCRYPT);
            read = cmd.readData(0x01, 5, 8, EncryptionMode.CM_MAC);
            read = cmd.readData(0x02, 5, 8, EncryptionMode.CM_PLAIN);

            // createBackupFile
            cmd.deleteFile(0x00);
            cmd.deleteFile(0x01);
            cmd.deleteFile(0x02);
            cmd.createBackupFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 15);
            cmd.createBackupFile(0x01, EncryptionMode.CM_MAC, acr, 15);
            cmd.createBackupFile(0x02, EncryptionMode.CM_PLAIN, acr, 15);
            // backup
            cmd.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);
            cmd.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);

            cmd.writeData(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeData(0x01, 3, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x01, 3, data, EncryptionMode.CM_MAC);
            cmd.writeData(0x02, 3, data, EncryptionMode.CM_PLAIN);
            cmd.writeData(0x02, 3, data, EncryptionMode.CM_PLAIN);

            cmd.commitTransaction(); // need to commit after write
            read = cmd.readData(0x00, 0, 10, EncryptionMode.CM_ENCRYPT);
            read = cmd.readData(0x01, 0, 10, EncryptionMode.CM_MAC);
            read = cmd.readData(0x02, 0, 10, EncryptionMode.CM_PLAIN);

            read = cmd.readData(0x00, 5, 8, EncryptionMode.CM_ENCRYPT);
            read = cmd.readData(0x01, 5, 8, EncryptionMode.CM_MAC);
            read = cmd.readData(0x02, 5, 8, EncryptionMode.CM_PLAIN);

            // createCyclicRecordFile
            cmd.deleteFile(0x00);
            cmd.deleteFile(0x01);
            cmd.deleteFile(0x02);
            cmd.createCyclicRecordFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 15, 5);
            cmd.createCyclicRecordFile(0x01, EncryptionMode.CM_MAC, acr, 15, 5);
            cmd.createCyclicRecordFile(0x02, EncryptionMode.CM_PLAIN, acr, 15, 5);

            // createLinearRecordFile
            cmd.createLinearRecordFile(0x03, EncryptionMode.CM_ENCRYPT, acr, 15, 5);
            cmd.createLinearRecordFile(0x04, EncryptionMode.CM_MAC, acr, 15, 5);
            cmd.createLinearRecordFile(0x05, EncryptionMode.CM_PLAIN, acr, 15, 5);

            data = new ByteVector(new byte[] {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b});
            cmd.writeRecord(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeRecord(0x01, 0, data, EncryptionMode.CM_MAC);
            cmd.writeRecord(0x02, 0, data, EncryptionMode.CM_PLAIN);

            cmd.writeRecord(0x03, 0, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeRecord(0x04, 0, data, EncryptionMode.CM_MAC);
            cmd.writeRecord(0x05, 0, data, EncryptionMode.CM_PLAIN);

            cmd.commitTransaction();

            // Writer record 1
            data = new ByteVector(new byte[] {0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b});
            cmd.writeRecord(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeRecord(0x01, 3, data, EncryptionMode.CM_MAC);
            cmd.writeRecord(0x02, 3, data, EncryptionMode.CM_PLAIN);

            cmd.writeRecord(0x03, 3, data, EncryptionMode.CM_ENCRYPT);
            cmd.writeRecord(0x04, 3, data, EncryptionMode.CM_MAC);
            cmd.writeRecord(0x05, 3, data, EncryptionMode.CM_PLAIN);

            cmd.commitTransaction();

            // Read record 0
            read = cmd.readRecords(0x00, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmd.readRecords(0x01, 0, 0, EncryptionMode.CM_MAC);
            read = cmd.readRecords(0x02, 0, 0, EncryptionMode.CM_PLAIN);

            read = cmd.readRecords(0x03, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmd.readRecords(0x04, 0, 0, EncryptionMode.CM_MAC);
            read = cmd.readRecords(0x05, 0, 0, EncryptionMode.CM_PLAIN);

            // Read record 1
            read = cmd.readRecords(0x00, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmd.readRecords(0x01, 0, 0, EncryptionMode.CM_MAC);
            read = cmd.readRecords(0x02, 0, 0, EncryptionMode.CM_PLAIN);

            read = cmd.readRecords(0x03, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmd.readRecords(0x04, 0, 0, EncryptionMode.CM_MAC);
            read = cmd.readRecords(0x05, 0, 0, EncryptionMode.CM_PLAIN);


            cmd.clearRecordFile(0x03);
            cmd.clearRecordFile(0x04);
            cmd.clearRecordFile(0x05);

            // createValueFile
            cmd.deleteFile(0x00);
            cmd.deleteFile(0x01);
            cmd.deleteFile(0x02);
            cmd.createValueFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 2, 15, 5, true);
            cmd.createValueFile(0x01, EncryptionMode.CM_MAC, acr, 2, 15, 5, true);
            cmd.createValueFile(0x02, EncryptionMode.CM_PLAIN, acr, 2, 15, 5, true);
            int value;
            value = cmd.getValue(0x00, EncryptionMode.CM_ENCRYPT);
            value = cmd.getValue(0x01, EncryptionMode.CM_MAC);
            value = cmd.getValue(0x02, EncryptionMode.CM_PLAIN);

            cmd.credit(0x00, 5, EncryptionMode.CM_ENCRYPT);
            cmd.credit(0x01, 5, EncryptionMode.CM_MAC);
            cmd.credit(0x02, 5, EncryptionMode.CM_PLAIN);

            value = cmd.getValue(0x00, EncryptionMode.CM_ENCRYPT);
            value = cmd.getValue(0x01, EncryptionMode.CM_MAC);
            value = cmd.getValue(0x02, EncryptionMode.CM_PLAIN);

            cmd.commitTransaction();

            value = cmd.getValue(0x00, EncryptionMode.CM_ENCRYPT);
            value = cmd.getValue(0x01, EncryptionMode.CM_MAC);
            value = cmd.getValue(0x02, EncryptionMode.CM_PLAIN);

            cmd.debit(0x00, 3, EncryptionMode.CM_ENCRYPT);
            cmd.debit(0x01, 3, EncryptionMode.CM_MAC);
            cmd.debit(0x02, 3, EncryptionMode.CM_PLAIN);

            cmd.commitTransaction();

            value = cmd.getValue(0x00, EncryptionMode.CM_ENCRYPT);
            value = cmd.getValue(0x01, EncryptionMode.CM_MAC);
            value = cmd.getValue(0x02, EncryptionMode.CM_PLAIN);

            cmd.debit(0x00, 3, EncryptionMode.CM_ENCRYPT);
            cmd.debit(0x01, 3, EncryptionMode.CM_MAC);
            cmd.debit(0x02, 3, EncryptionMode.CM_PLAIN);

            cmd.commitTransaction();

            cmd.credit(0x00, 3, EncryptionMode.CM_ENCRYPT);
            cmd.credit(0x01, 3, EncryptionMode.CM_MAC);
            cmd.credit(0x02, 3, EncryptionMode.CM_PLAIN);

            cmd.abortTransaction();

            cmd.limitedCredit(0x00, 2, EncryptionMode.CM_ENCRYPT);
            cmd.limitedCredit(0x01, 2, EncryptionMode.CM_MAC);
            cmd.limitedCredit(0x02, 2, EncryptionMode.CM_PLAIN);

            value = cmd.getValue(0x00, EncryptionMode.CM_ENCRYPT);
            value = cmd.getValue(0x01, EncryptionMode.CM_MAC);
            value = cmd.getValue(0x02, EncryptionMode.CM_PLAIN);

            fileIDS = cmd.getFileIDs();

            DESFireCommands.FileSetting fileset;
            fileset = cmd.getFileSettings(0x00);
            cmd.changeFileSettings(0x00, EncryptionMode.CM_ENCRYPT, acr, false);


            // Read/write with free is not really handle
            /*acr.readAccess = TaskAccessRights.AR_FREE;
            acr.writeAccess = TaskAccessRights.AR_FREE;
            cmdev1.changeFileSettings(0x08, EncryptionMode.CM_ENCRYPT, acr, false);*/


            cmd.deleteFile(0x00);
            cmd.deleteFile(0x01);
            cmd.deleteFile(0x02);

            cmd.changeKey(1, newKey);
            var keyversion = cmd.getKeyVersion(1);
            Assert.AreEqual(keyversion, newKey.getKeyVersion());
            cmd.changeKey(1, newKey2);
            keyversion = cmd.getKeyVersion(1);
            Assert.AreEqual(keyversion, newKey2.getKeyVersion());
            cmd.changeKey(0, newKey);
            cmd.authenticate(0, newKey);
            keyversion = cmd.getKeyVersion(0);
            Assert.AreEqual(keyversion, newKey.getKeyVersion());

            newKey2.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmd.changeKey(1, newKey2);
            newKey2.setKeyDiversification(
                new SagemKeyDiversification());
            cmd.changeKey(1, newKey2);
            cmd.authenticate(1, newKey2);
        }

        void ev1Test(DESFireEV1ISO7816Commands cmdev1,
            DESFireEV2ISO7816Commands cmdev2,
            DESFireKey newKey,
            DESFireKey newKey2)
        {
            DESFireAccessRights acr = new DESFireAccessRights();
            acr.changeAccess = TaskAccessRights.AR_KEY0;
            acr.readAccess = TaskAccessRights.AR_KEY1;
            acr.readAndWriteAccess = TaskAccessRights.AR_KEY0;
            acr.writeAccess = TaskAccessRights.AR_KEY0;

            // TODO TEST SETCONFIGURATION EV2

            cmdev1.getFreeMem();
            DESFireCommands.DESFireCardVersion dataVersion = cmdev1.getVersion();
            cmdev1.getCardUID();

            DESFireKeySettings settings;
            byte maxNbKeys;
            DESFireKeyType keyType;
            cmdev1.getKeySettings(out settings, out maxNbKeys, out keyType);
            cmdev1.changeKeySettings(settings);

            var fileIDS = cmdev1.getFileIDs();
            var ISOFileIDs = cmdev1.getISOFileIDs();

            cmdev1.changeKeySettings(DESFireKeySettings.KS_DEFAULT);

            // createStdDataFile
            cmdev1.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 200, 42);
            cmdev1.createStdDataFile(0x01, EncryptionMode.CM_MAC, acr, 200, 43);
            cmdev1.createStdDataFile(0x02, EncryptionMode.CM_PLAIN, acr, 200, 44);
            // createBackupFile
            cmdev1.createBackupFile(0x03, EncryptionMode.CM_ENCRYPT, acr, 15, 45);
            cmdev1.createBackupFile(0x04, EncryptionMode.CM_MAC, acr, 15, 46);
            cmdev1.createBackupFile(0x05, EncryptionMode.CM_PLAIN, acr, 15, 47);
            // createCyclicRecordFile
            cmdev1.createCyclicRecordFile(0x06, EncryptionMode.CM_ENCRYPT, acr, 15, 5, 48);
            cmdev1.createCyclicRecordFile(0x07, EncryptionMode.CM_MAC, acr, 15, 5, 49);
            cmdev1.createCyclicRecordFile(0x08, EncryptionMode.CM_PLAIN, acr, 15, 5, 50);
            // createLinearRecordFile
            cmdev1.createLinearRecordFile(0x09, EncryptionMode.CM_ENCRYPT, acr, 15, 5, 51);
            cmdev1.createLinearRecordFile(0x0a, EncryptionMode.CM_MAC, acr, 15, 5, 52);
            cmdev1.createLinearRecordFile(0x0b, EncryptionMode.CM_PLAIN, acr, 15, 5, 53);
            // createValueFile
            cmdev1.createValueFile(0x0c, EncryptionMode.CM_ENCRYPT, acr, 2, 15, 5, true);
            cmdev1.createValueFile(0x0d, EncryptionMode.CM_MAC, acr, 2, 15, 5, true);
            cmdev1.createValueFile(0x0e, EncryptionMode.CM_PLAIN, acr, 2, 15, 5, true);

            fileIDS = cmdev1.getFileIDs();
            ISOFileIDs = cmdev1.getISOFileIDs();

            DESFireCommands.FileSetting fileset;
            fileset = cmdev1.getFileSettings(0x00);
            cmdev1.changeFileSettings(0x00, EncryptionMode.CM_ENCRYPT, acr, false);
            fileset = cmdev1.getFileSettings(0x03);
            cmdev1.changeFileSettings(0x03, EncryptionMode.CM_ENCRYPT, acr, false);
            fileset = cmdev1.getFileSettings(0x06);
            cmdev1.changeFileSettings(0x06, EncryptionMode.CM_ENCRYPT, acr, false);
            fileset = cmdev1.getFileSettings(0x09);
            cmdev1.changeFileSettings(0x09, EncryptionMode.CM_ENCRYPT, acr, false);
            fileset = cmdev1.getFileSettings(0x0c);
            cmdev1.changeFileSettings(0x0c, EncryptionMode.CM_ENCRYPT, acr, false);


            // Read/write with free is not really handle
            /*acr.readAccess = TaskAccessRights.AR_FREE;
            acr.writeAccess = TaskAccessRights.AR_FREE;
            cmdev1.changeFileSettings(0x08, EncryptionMode.CM_ENCRYPT, acr, false);*/

            var dataArray = new byte[]
            {
                0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
                0x07, 0x08, 0x09, 0x0a, 0x0b
            };
            ByteVector read, data = new ByteVector(dataArray);
            // standard
            cmdev1.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);
            cmdev1.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);

            Array.Resize(ref dataArray, 100);
            data = new ByteVector(dataArray);
            cmdev1.writeData(0x02, 0, data, EncryptionMode.CM_PLAIN);
            cmdev1.writeData(0x01, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x00, 0, data, EncryptionMode.CM_ENCRYPT);

            data = new ByteVector(new byte[] {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b});

            // backup
            cmdev1.writeData(0x03, 0, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x03, 0, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x04, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x04, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x05, 0, data, EncryptionMode.CM_PLAIN);
            cmdev1.writeData(0x05, 0, data, EncryptionMode.CM_PLAIN);

            data = new ByteVector(new byte[] {0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b});
            // standard
            cmdev1.writeData(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x00, 3, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x01, 3, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x01, 3, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x02, 3, data, EncryptionMode.CM_PLAIN);
            cmdev1.writeData(0x02, 3, data, EncryptionMode.CM_PLAIN);
            // backup
            cmdev1.writeData(0x03, 3, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x03, 3, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeData(0x04, 3, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x04, 3, data, EncryptionMode.CM_MAC);
            cmdev1.writeData(0x05, 3, data, EncryptionMode.CM_PLAIN);
            cmdev1.writeData(0x05, 3, data, EncryptionMode.CM_PLAIN);

            // standard
            read = cmdev1.readData(0x00, 0, 10, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readData(0x01, 0, 10, EncryptionMode.CM_MAC);
            read = cmdev1.readData(0x02, 0, 10, EncryptionMode.CM_PLAIN);

            read = cmdev1.readData(0x00, 0, 100, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readData(0x01, 0, 100, EncryptionMode.CM_MAC);
            read = cmdev1.readData(0x02, 0, 100, EncryptionMode.CM_PLAIN);

            read = cmdev1.readData(0x00, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readData(0x01, 0, 0, EncryptionMode.CM_MAC);
            read = cmdev1.readData(0x02, 0, 0, EncryptionMode.CM_PLAIN);

            read = cmdev1.readData(0x00, 5, 8, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readData(0x01, 5, 8, EncryptionMode.CM_MAC);
            read = cmdev1.readData(0x02, 5, 8, EncryptionMode.CM_PLAIN);

            // backup
            cmdev1.commitTransaction(); // need to commit after write
            read = cmdev1.readData(0x03, 0, 10, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readData(0x04, 0, 10, EncryptionMode.CM_MAC);
            read = cmdev1.readData(0x05, 0, 10, EncryptionMode.CM_PLAIN);

            read = cmdev1.readData(0x03, 5, 8, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readData(0x04, 5, 8, EncryptionMode.CM_MAC);
            read = cmdev1.readData(0x05, 5, 8, EncryptionMode.CM_PLAIN);


            // CREDIT / DEBIT
            int value;
            value = cmdev1.getValue(0x0c, EncryptionMode.CM_ENCRYPT);
            value = cmdev1.getValue(0x0d, EncryptionMode.CM_MAC);
            value = cmdev1.getValue(0x0e, EncryptionMode.CM_PLAIN);

            cmdev1.credit(0x0c, 5, EncryptionMode.CM_ENCRYPT);
            cmdev1.credit(0x0d, 5, EncryptionMode.CM_MAC);
            cmdev1.credit(0x0e, 5, EncryptionMode.CM_PLAIN);

            value = cmdev1.getValue(0x0c, EncryptionMode.CM_ENCRYPT);
            value = cmdev1.getValue(0x0d, EncryptionMode.CM_MAC);
            value = cmdev1.getValue(0x0e, EncryptionMode.CM_PLAIN);

            cmdev1.commitTransaction();

            value = cmdev1.getValue(0x0c, EncryptionMode.CM_ENCRYPT);
            value = cmdev1.getValue(0x0d, EncryptionMode.CM_MAC);
            value = cmdev1.getValue(0x0e, EncryptionMode.CM_PLAIN);

            cmdev1.debit(0x0c, 3, EncryptionMode.CM_ENCRYPT);
            cmdev1.debit(0x0d, 3, EncryptionMode.CM_MAC);
            cmdev1.debit(0x0e, 3, EncryptionMode.CM_PLAIN);

            cmdev1.commitTransaction();

            value = cmdev1.getValue(0x0c, EncryptionMode.CM_ENCRYPT);
            value = cmdev1.getValue(0x0d, EncryptionMode.CM_MAC);
            value = cmdev1.getValue(0x0e, EncryptionMode.CM_PLAIN);

            cmdev1.debit(0x0c, 3, EncryptionMode.CM_ENCRYPT);
            cmdev1.debit(0x0d, 3, EncryptionMode.CM_MAC);
            cmdev1.debit(0x0e, 3, EncryptionMode.CM_PLAIN);

            cmdev1.commitTransaction();

            cmdev1.credit(0x0c, 3, EncryptionMode.CM_ENCRYPT);
            cmdev1.credit(0x0d, 3, EncryptionMode.CM_MAC);
            cmdev1.credit(0x0e, 3, EncryptionMode.CM_PLAIN);

            cmdev1.abortTransaction();

            cmdev1.limitedCredit(0x0c, 2, EncryptionMode.CM_ENCRYPT);
            cmdev1.limitedCredit(0x0d, 2, EncryptionMode.CM_MAC);
            cmdev1.limitedCredit(0x0e, 2, EncryptionMode.CM_PLAIN);

            value = cmdev1.getValue(0x0c, EncryptionMode.CM_ENCRYPT);
            value = cmdev1.getValue(0x0d, EncryptionMode.CM_MAC);
            value = cmdev1.getValue(0x0e, EncryptionMode.CM_PLAIN);

            // Writer record 0
            data = new ByteVector(new byte[] {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b});
            cmdev1.writeRecord(0x06, 0, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeRecord(0x07, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeRecord(0x08, 0, data, EncryptionMode.CM_PLAIN);

            cmdev1.writeRecord(0x09, 0, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeRecord(0x0a, 0, data, EncryptionMode.CM_MAC);
            cmdev1.writeRecord(0x0b, 0, data, EncryptionMode.CM_PLAIN);

            cmdev1.commitTransaction();

            // Writer record 1
            data = new ByteVector(new byte[] {0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b});
            cmdev1.writeRecord(0x06, 3, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeRecord(0x07, 3, data, EncryptionMode.CM_MAC);
            cmdev1.writeRecord(0x08, 3, data, EncryptionMode.CM_PLAIN);

            cmdev1.writeRecord(0x09, 3, data, EncryptionMode.CM_ENCRYPT);
            cmdev1.writeRecord(0x0a, 3, data, EncryptionMode.CM_MAC);
            cmdev1.writeRecord(0x0b, 3, data, EncryptionMode.CM_PLAIN);

            cmdev1.commitTransaction();

            // Read record 0
            read = cmdev1.readRecords(0x06, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readRecords(0x07, 0, 0, EncryptionMode.CM_MAC);
            read = cmdev1.readRecords(0x08, 0, 0, EncryptionMode.CM_PLAIN);

            read = cmdev1.readRecords(0x09, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readRecords(0x0a, 0, 0, EncryptionMode.CM_MAC);
            read = cmdev1.readRecords(0x0b, 0, 0, EncryptionMode.CM_PLAIN);

            // Read record 1
            read = cmdev1.readRecords(0x06, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readRecords(0x07, 0, 0, EncryptionMode.CM_MAC);
            read = cmdev1.readRecords(0x08, 0, 0, EncryptionMode.CM_PLAIN);

            read = cmdev1.readRecords(0x09, 0, 0, EncryptionMode.CM_ENCRYPT);
            read = cmdev1.readRecords(0x0a, 0, 0, EncryptionMode.CM_MAC);
            read = cmdev1.readRecords(0x0b, 0, 0, EncryptionMode.CM_PLAIN);


            cmdev1.clearRecordFile(0x06);
            cmdev1.clearRecordFile(0x07);
            cmdev1.clearRecordFile(0x08);

            cmdev1.deleteFile(0x01);
            cmdev1.deleteFile(0x02);
            cmdev1.deleteFile(0x04);
            cmdev1.deleteFile(0x05);

            cmdev1.getISO7816Commands().selectFile(42);
            cmdev1.getISO7816Commands().selectFile(45);
            cmdev1.getISO7816Commands().selectFile(48);

            cmdev1.getISO7816Commands().selectFile(50);

            cmdev1.changeKey(1, newKey);
            var keyversion = cmdev1.getKeyVersion(1);
            Assert.AreEqual(keyversion, newKey.getKeyVersion());
            cmdev1.changeKey(1, newKey2);
            keyversion = cmdev1.getKeyVersion(1);
            Assert.AreEqual(keyversion, newKey2.getKeyVersion());
            cmdev1.changeKey(0, newKey);
            cmdev1.authenticate(0, newKey);
            keyversion = cmdev1.getKeyVersion(0);
            Assert.AreEqual(keyversion, newKey.getKeyVersion());

            newKey2.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmdev1.changeKey(1, newKey2);
            newKey2.setKeyDiversification(
                new SagemKeyDiversification());
            cmdev1.changeKey(1, newKey2);
            cmdev1.authenticate(1, newKey2);

            // BUG : iso_readRecords seems to break CMAC so we do it at the end...
            // cmdev1.iso_appendrecord(data, 00); //Security status not sat....
            if (cmdev2 == null) // EV2 has changed iso...it do not work probably because of free access
                // not handle
                read = cmdev1.getISO7816Commands().readRecords(50, 0, ISORecords.ISO_RECORD_ALLRECORDS);
        }

        void authMasterCard(DESFireISO7816Commands cmd,
            DESFireKey masterPICCKey)
        {
            cmd.selectApplication(0x00);
            cmd.authenticate(0, masterPICCKey);
        }

        void cleanupCard(DESFireISO7816Commands cmd,
            DESFireKey masterPICCKey)
        {
            authMasterCard(cmd, masterPICCKey);
            cmd.erase();
        }

        void ev2Test(DESFireKey masterPICCKey,
            DESFireEV2ISO7816Commands cmdev2,
            DESFireKey desNew,
            DESFireKey aesNew)
        {
            var desDefault = new DESFireKey();
            desDefault.setKeyType(DESFireKeyType.DF_KEY_DES);
            var aesDefault = new DESFireKey();
            aesDefault.setKeyType(DESFireKeyType.DF_KEY_AES);

            // EV2 CreateApplicatio KeySet
            cleanupCard(cmdev2, masterPICCKey);

            // DES Create App with keystore 0 version 1
            cmdev2.createApplication(
                0x777,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_DES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 4, 0, 1, 2, false, false);

            cmdev2.selectApplication(0x777);
            cmdev2.authenticate(0x00, desDefault);
            cmdev2.changeKeyEV2(0x00, 0x01, desNew);
            var keyversion = cmdev2.getKeyVersion(0x00, 0x01);
            Assert.AreEqual(keyversion[0], desNew.getKeyVersion());
            cmdev2.changeKeyEV2(0x00, 0x00, desNew);
            cmdev2.authenticate(0x00, desNew);
            cmdev2.changeKeyEV2(0x00, 0x00, desDefault);
            cmdev2.authenticate(0x00, desDefault);

            // Create KeySet 1 version 2
            cmdev2.initliazeKeySet(0x01, DESFireKeyType.DF_KEY_DES);
            cmdev2.changeKeyEV2(0x01, 0x02, desNew);
            desNew.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmdev2.changeKeyEV2(0x01, 0x00, desNew);
            desNew.setKeyDiversification(null);
            cmdev2.changeKeyEV2(0x01, 0x01, desNew);
            cmdev2.finalizeKeySet(0x01, 0x02);
            keyversion = cmdev2.getKeyVersion(0x01, 0x01);
            Assert.AreEqual(keyversion[0], desNew.getKeyVersion());

            // Create KeySet 2 version 4
            cmdev2.initliazeKeySet(0x02, DESFireKeyType.DF_KEY_AES);
            cmdev2.changeKeyEV2(0x02, 0x00, aesNew);
            cmdev2.finalizeKeySet(0x02, 0x04);
            keyversion = cmdev2.getKeyVersion(0x02, 0x01);
            Assert.AreEqual(keyversion[0], aesNew.getKeyVersion());

            // Create KeySet 3 version 3
            cmdev2.initliazeKeySet(0x03, DESFireKeyType.DF_KEY_AES);
            cmdev2.changeKeyEV2(0x03, 0x02, aesNew);
            cmdev2.changeKeyEV2(0x03, 0x02, aesDefault);
            cmdev2.changeKeyEV2(0x03, 0x00, aesDefault);
            cmdev2.finalizeKeySet(0x03, 0x03);

            keyversion = cmdev2.getKeyVersion(0x00, 0x00);
            Assert.AreEqual(keyversion.Count(), 4);
            Assert.AreEqual(keyversion[0], 0x01);
            Assert.AreEqual(keyversion[1], 0x02);
            Assert.AreEqual(keyversion[2], 0x04);
            Assert.AreEqual(keyversion[3], 0x03);

            // Create roll to keyset 1 version 2 (we are version 1)
            cmdev2.authenticate(0x02, desDefault);
            cmdev2.rollKeySet(0x01);
            desNew.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmdev2.authenticate(0x00, desNew);
            desNew.setKeyDiversification(null);
            keyversion = cmdev2.getKeyVersion(0x00, 0x00);
            Assert.AreEqual(keyversion.Count(), 4);
            Assert.AreEqual(keyversion[0], 0x02);
            Assert.AreEqual(keyversion[1], 0x04);
            Assert.AreEqual(keyversion[2], 0x03);
            Assert.AreEqual(keyversion[3], 0x01);

            // Create roll to keyset 3 version 3 (we are version 2)
            cmdev2.authenticate(0x02, desNew);
            cmdev2.rollKeySet(0x02);
            cmdev2.authenticate(0x00, aesDefault);
            keyversion = cmdev2.getKeyVersion(0x00, 0x00);
            Assert.AreEqual(keyversion.Count(), 4);
            Assert.AreEqual(keyversion[0], 0x03);
            Assert.AreEqual(keyversion[1], 0x01);
            Assert.AreEqual(keyversion[2], 0x02);
            Assert.AreEqual(keyversion[3], 0x04);
            // Create roll to keyset 2 version 4 (we are version 3)
            cmdev2.authenticate(0x02, aesDefault);
            cmdev2.rollKeySet(0x3);
            cmdev2.authenticate(0x00, aesNew);
            keyversion = cmdev2.getKeyVersion(0x00, 0x00);
            Assert.AreEqual(keyversion.Count(), 4);
            Assert.AreEqual(keyversion[0], 0x04);
            Assert.AreEqual(keyversion[1], 0x03);
            Assert.AreEqual(keyversion[2], 0x01);
            Assert.AreEqual(keyversion[3], 0x02);

            cleanupCard(cmdev2, masterPICCKey);

            // AES Create App with keystore 0 version 1
            cmdev2.createApplication(
                0x778,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_AES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 2, false, false);

            cmdev2.selectApplication(0x778);
            cmdev2.authenticate(0x00, aesDefault);
            cmdev2.changeKeyEV2(0x00, 0x00, aesNew);
            cmdev2.authenticate(0x00, aesNew);
            cmdev2.changeKeyEV2(0x00, 0x00, aesDefault);
            cmdev2.authenticate(0x00, aesDefault);
            cmdev2.changeKeyEV2(0x00, 0x01, aesNew);
            cmdev2.changeKeyEV2(0x00, 0x02, aesNew);

            // Create KeySet 1 version 3
            cmdev2.initliazeKeySet(0x01, DESFireKeyType.DF_KEY_AES);
            cmdev2.changeKey(0x01, aesNew);
            cmdev2.changeKeyEV2(0x01, 0x00, aesNew);
            cmdev2.changeKeyEV2(0x01, 0x00, aesDefault);
            cmdev2.changeKeyEV2(0x01, 0x00, aesNew);
            cmdev2.finalizeKeySet(0x01, 0x03);

            // Create KeySet 2 version 2
            cmdev2.initliazeKeySet(0x02, DESFireKeyType.DF_KEY_AES);
            cmdev2.changeKeyEV2(0x02, 0x02, aesNew);
            cmdev2.changeKeyEV2(0x02, 0x02, aesDefault);
            cmdev2.changeKeyEV2(0x02, 0x00, aesNew);
            aesDefault.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmdev2.changeKeyEV2(0x02, 0x01, aesDefault);
            aesDefault.setKeyDiversification(null);
            cmdev2.finalizeKeySet(0x02, 0x02);

            // Create roll to keyset 2 version 2 (we are version 1)
            cmdev2.authenticate(0x02, aesNew); // rolling key
            cmdev2.rollKeySet(0x02);
            aesDefault.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmdev2.authenticate(0x01, aesDefault);
            aesDefault.setKeyDiversification(null);
            cmdev2.authenticate(0x02, aesDefault);
            cmdev2.authenticate(0x00, aesNew);
            cmdev2.changeKey(0x01, aesDefault);
            cmdev2.authenticate(0x02, aesDefault);
            // Create roll to keyset 1 version 3 (we are version 2)
            cmdev2.rollKeySet(0x2);
            cmdev2.authenticate(0x00, aesNew);


            DESFireAccessRights acr = new DESFireAccessRights();
            acr.changeAccess = TaskAccessRights.AR_KEY0;
            acr.readAccess = TaskAccessRights.AR_KEY1;
            acr.readAndWriteAccess = TaskAccessRights.AR_KEY0;
            acr.writeAccess = TaskAccessRights.AR_KEY0;
            cmdev2.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 200, 0, true);
            cmdev2.createBackupFile(0x01, EncryptionMode.CM_ENCRYPT, acr, 200, 0, true);
            cmdev2.createCyclicRecordFile(0x02, EncryptionMode.CM_ENCRYPT, acr, 200, 5, 0, true);
            cmdev2.createLinearRecordFile(0x03, EncryptionMode.CM_ENCRYPT, acr, 200, 5, 0, true);

            // Multi DESFireAccessRights
            DESFireAccessRightsVector accessrightses = new DESFireAccessRightsVector();
            accessrightses.Add(acr);
            acr.changeAccess = TaskAccessRights.AR_NEVER;
            acr.readAccess = TaskAccessRights.AR_KEY4;
            acr.readAndWriteAccess = TaskAccessRights.AR_KEY5;
            acr.writeAccess = TaskAccessRights.AR_KEY6;
            accessrightses.Add(acr);
            acr.changeAccess = TaskAccessRights.AR_NEVER;
            acr.readAccess = TaskAccessRights.AR_KEY7;
            acr.readAndWriteAccess = TaskAccessRights.AR_KEY8;
            acr.writeAccess = TaskAccessRights.AR_KEY9;
            accessrightses.Add(acr);
            cmdev2.changeFileSettings(0x00, EncryptionMode.CM_ENCRYPT, accessrightses, false);
            cmdev2.changeFileSettings(0x01, EncryptionMode.CM_ENCRYPT, accessrightses, false);
            cmdev2.changeFileSettings(0x02, EncryptionMode.CM_ENCRYPT, accessrightses, false);
            cmdev2.changeFileSettings(0x03, EncryptionMode.CM_ENCRYPT, accessrightses, false);

            cmdev2.authenticateEV2First(0x04, aesDefault);
            var read = cmdev2.readData(0x00, 0, 0, EncryptionMode.CM_ENCRYPT);

            cmdev2.authenticateEV2First(0x07, aesDefault);
            read = cmdev2.readData(0x00, 0, 0, EncryptionMode.CM_ENCRYPT);

            cmdev2.authenticateEV2First(0x00, aesNew);

            acr.changeAccess = TaskAccessRights.AR_KEY0;
            acr.readAccess = TaskAccessRights.AR_KEY1;
            acr.readAndWriteAccess = TaskAccessRights.AR_KEY0;
            acr.writeAccess = TaskAccessRights.AR_NEVER;
            cmdev2.createTransactionMACFile(0x04, EncryptionMode.CM_ENCRYPT, acr, aesNew, 0x01);

            // EV2 createDeletagedApplication
            cleanupCard(cmdev2, masterPICCKey);

            var DAMAuthKey = new DESFireKey(
                "88 11 88 99 88 11 88 99 88 11 88 99 88 11 88 00");
            DAMAuthKey.setKeyVersion(0x01);
            DAMAuthKey.setKeyType(DESFireKeyType.DF_KEY_DES);
            var DAMMACKey = new DESFireKey(
                "88 11 88 99 88 11 88 99 88 11 88 99 88 11 88 11");
            DAMMACKey.setKeyType(DESFireKeyType.DF_KEY_DES);
            DAMMACKey.setKeyVersion(0x01);
            var DAMENCKey = new DESFireKey(
                "88 11 88 99 88 11 88 99 88 11 88 99 88 11 88 22");
            DAMENCKey.setKeyType(DESFireKeyType.DF_KEY_DES);
            DAMENCKey.setKeyVersion(0x01);

            var DAMDefaultKey = new DESFireKey(
                "88 11 88 33 88 11 88 99 88 11 88 99 88 11 88 33");
            DAMDefaultKey.setKeyType(DESFireKeyType.DF_KEY_DES);
            DAMDefaultKey.setKeyVersion(0x01);

            // Enable DAM by changing keys
            try
            {
                // Card with new keys
                (cmdev2.getChip() as DESFireChip)
                    .getCrypto()
                    .setKey(0x00, 0, 0x10, DAMAuthKey);
                (cmdev2.getChip() as DESFireChip)
                    .getCrypto()
                    .setKey(0x00, 0, 0x11, DAMMACKey);
                (cmdev2.getChip() as DESFireChip)
                    .getCrypto()
                    .setKey(0x00, 0, 0x12, DAMENCKey);

                cmdev2.changeKey(0x10, DAMAuthKey);
                cmdev2.changeKey(0x11, DAMMACKey);
                cmdev2.changeKey(0x12, DAMENCKey);
            }
            catch (Exception)
            {
                // Card with default keys
                (cmdev2.getChip() as DESFireChip)
                    .getCrypto()
                    .setKey(0x00, 0, 0x10, desDefault);
                (cmdev2.getChip() as DESFireChip)
                    .getCrypto()
                    .setKey(0x00, 0, 0x11, desDefault);
                (cmdev2.getChip() as DESFireChip)
                    .getCrypto()
                    .setKey(0x00, 0, 0x12, desDefault);

                cmdev2.changeKey(0x10, DAMAuthKey);
                cmdev2.changeKey(0x11, DAMMACKey);
                cmdev2.changeKey(0x12, DAMENCKey);
            }

            // Auth with DAMAuthKey
            cmdev2.authenticate(0x10, DAMAuthKey);

            var damInfo = cmdev2.createDAMChallenge(
                DAMMACKey, DAMENCKey, DAMDefaultKey, 0x777, 0, 0, 100,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_DES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 0, false, false);

            cmdev2.createDelegatedApplication(
                damInfo, 0x777, 0, 0, 100,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_DES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 0, false, false);
            (cmdev2.getChip() as DESFireChip)
                .getCrypto()
                .setKeyInAllKeySet(0x777, 3, 14, DAMDefaultKey);

            // Test with just one version more
            damInfo = cmdev2.createDAMChallenge(
                DAMMACKey, DAMENCKey, DAMDefaultKey, 0x777, 0, 1, 100,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_DES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 0, false, false);

            // Override with a new version
            cmdev2.createDelegatedApplication(
                damInfo, 0x777, 0, 1, 100,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_DES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 0, false, false);
            (cmdev2.getChip() as DESFireChip)
                .getCrypto()
                .setKeyInAllKeySet(0x777, 3, 14, DAMDefaultKey);

            // Test auth DAMDefaultKey DES
            authMasterCard(cmdev2, masterPICCKey);
            cmdev2.selectApplication(0x777);
            cmdev2.authenticate(0x00, DAMDefaultKey);
            // Setconfiguration format disabled
            cmdev2.setConfiguration(true, false, false, false);

            cmdev2.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 10, 0, false);
            cmdev2.changeKeyEV2(0x00, 0x00, desNew);
            cmdev2.authenticate(0x00, desNew);

            cmdev2.initliazeKeySet(0x01, DESFireKeyType.DF_KEY_DES);
            cmdev2.changeKeyEV2(0x01, 0x00, desDefault);
            cmdev2.finalizeKeySet(0x01, 0x02);
            cmdev2.rollKeySet(0x01);
            cmdev2.authenticate(0x00, desDefault);

            authMasterCard(cmdev2, masterPICCKey);
            cmdev2.authenticate(0x10, DAMAuthKey);


            // Test create AES with DAM keys DES
            DAMDefaultKey.setKeyType(DESFireKeyType.DF_KEY_AES);
            damInfo = cmdev2.createDAMChallenge(
                DAMMACKey, DAMENCKey, DAMDefaultKey, 0x888, 1, 1, 100,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_AES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 0, false, false);

            cmdev2.createDelegatedApplication(
                damInfo, 0x888, 1, 1, 100,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                14, DESFireKeyType.DF_KEY_AES, FidSupport.FIDS_NO_ISO_FID, 0x00,
                new ByteVector(), 3, 0, 1, 0, false, false);
            (cmdev2.getChip() as DESFireChip)
                .getCrypto()
                .setKeyInAllKeySet(0x888, 3, 14, DAMDefaultKey);

            // Test auth DAMDefaultKey AES
            cmdev2.selectApplication(0x888);
            cmdev2.authenticate(0x00, DAMDefaultKey);

            cmdev2.createStdDataFile(0x00, EncryptionMode.CM_ENCRYPT, acr, 10, 0, false);
            cmdev2.changeKeyEV2(0x00, 0x00, aesNew);
            cmdev2.authenticate(0x00, aesNew);

            cmdev2.initliazeKeySet(0x01, DESFireKeyType.DF_KEY_AES);
            cmdev2.changeKeyEV2(0x01, 0x00, aesDefault);
            cmdev2.finalizeKeySet(0x01, 0x02);
            cmdev2.rollKeySet(0x01);
            cmdev2.authenticate(0x00, aesDefault);

            authMasterCard(cmdev2, masterPICCKey);
        }

        void testSAMAuthChangeKey(DESFireISO7816Commands cmd,
            DESFireKeyType cryptomethod,
            DESFireKey newKeyWithoutSAM,
            DESFireKey newKeyWithoutSAM2)
        {
            var crypto = (cmd.getChip() as DESFireChip)
                .getCrypto();
            // Default: Keyslot DES 21 / AES 20 - version 0
            // New: Keyslot DES 21 / AES 20 - version 1
            // New2: Keyslot DES 21 / AES 20 - version 2
            // WARNING EV2 NEED OFFLINE CRYPTO KEY Keyslot 19 used
            byte keyslot = (cryptomethod == DESFireKeyType.DF_KEY_DES)
                ? (byte) 21
                : // DES
                (byte) 20; // AES
            var samKeyStorage = new SAMKeyStorage();
            samKeyStorage.setKeySlot(keyslot);

            var defaultKey = new DESFireKey();
            defaultKey.setKeyType(cryptomethod);
            defaultKey.setKeyVersion(0);
            defaultKey.setKeyStorage(samKeyStorage);

            var newKey = new DESFireKey();
            newKey.setKeyType(cryptomethod);
            newKey.setKeyVersion(1);
            newKey.setKeyStorage(samKeyStorage);

            var newKey2 = new DESFireKey();
            newKey2.setKeyType(cryptomethod);
            newKey2.setKeyVersion(2);
            newKey2.setKeyStorage(samKeyStorage);

            cmd.authenticate(0x00, defaultKey);

            cmd.changeKey(0x00, newKey);
            cmd.authenticate(0x00, newKeyWithoutSAM); // Test with normal
            cmd.authenticate(0x00, newKey); // Test with normal
            cmd.changeKey(0x00, newKey2);
            cmd.authenticate(0x00, newKeyWithoutSAM2);
            cmd.authenticate(0x00, newKey2); // Test with normal

            // changekey full sam
            crypto.setKey(crypto.d_currentAid, 0, 0x01, defaultKey);
            cmd.changeKey(0x01, newKey);
            cmd.changeKey(0x01, newKey2);
            cmd.authenticate(0x01, newKeyWithoutSAM2); // Test with normal

            // TEST AV2 Diversification with SAM
            cmd.authenticate(0x00, newKey2);
            crypto.setKey(crypto.d_currentAid, 0, 0x01, newKey2); // Set newKey2
            newKey.setKeyDiversification(
                new NXPAV2KeyDiversification());
            newKeyWithoutSAM.setKeyDiversification(
                new NXPAV2KeyDiversification());
            cmd.changeKey(0x01, newKey);
            cmd.authenticate(0x01, newKeyWithoutSAM); // Test with normal
            cmd.authenticate(0x00, newKey2);
            crypto.setKey(crypto.d_currentAid, 0, 0x01, newKey); // Set newKey
            cmd.changeKey(0x01, newKey2);
            newKey.setKeyDiversification(null);
            newKeyWithoutSAM.setKeyDiversification(null);

            // dump key
            samKeyStorage.setDumpKey(true);
            cmd.authenticate(0x00, newKey2);
            // dump key remove the flag
            newKey2.setKeyStorage(samKeyStorage);
            newKey.setKeyStorage(samKeyStorage);
            // get both keys from dump
            crypto.setKey(crypto.d_currentAid, 0, 0x01, newKey2); // Set newKey2
            cmd.changeKey(0x01, newKey);

            cmd.authenticate(0x01, newKeyWithoutSAM); // Test with normal key
            cmd.authenticate(0x00, newKey2);

            // Only one of each is dump
            if (cryptomethod != DESFireKeyType.DF_KEY_DES)
            {
                // SAM DumpSecretKey dump DES Key with version in the first 8 block and 8 last
                // also
                // This is not compatible with what we are doing and make changekey fail
                (newKey2.getKeyStorage() as SAMKeyStorage)
                    .setDumpKey(true);
                (newKey.getKeyStorage() as SAMKeyStorage)
                    .setDumpKey(true);
                crypto.setKey(crypto.d_currentAid, 0, 0x01, newKeyWithoutSAM);
                cmd.changeKey(0x01, newKeyWithoutSAM2);
                crypto.setKey(crypto.d_currentAid, 0, 0x01, newKey2);
                cmd.changeKey(0x01, newKeyWithoutSAM);
                cmd.authenticate(0x01, newKeyWithoutSAM); // Test with normal
            }
            else
            {
                // TEST Sagem Diversification with SAM ONLY DES
                samKeyStorage.setDumpKey(false);
                cmd.authenticate(0x00, newKey2);
                crypto.setKey(crypto.d_currentAid, 0, 0x01, newKey); // Set newKey2
                samKeyStorage.setDumpKey(true);
                newKey2.setKeyDiversification(
                    new SagemKeyDiversification());
                cmd.changeKey(0x01, newKey2);
                newKeyWithoutSAM2.setKeyDiversification(
                    new SagemKeyDiversification());
                cmd.authenticate(0x01, newKeyWithoutSAM2); // Test with normal
                samKeyStorage.setDumpKey(false);

                cmd.authenticate(0x00, newKey2);
                cmd.changeKey(0x01, newKeyWithoutSAM);
                cmd.authenticate(0x01, newKey);
                newKey2.setKeyDiversification(null);
                newKeyWithoutSAM2.setKeyDiversification(null);

                cmd.authenticate(0x00, newKey2);
                crypto.setKey(crypto.d_currentAid, 0, 0x01, newKeyWithoutSAM); // Set newKey2
                cmd.changeKey(0x01, newKeyWithoutSAM2);
                cmd.authenticate(0x01, newKey2);
            }
        }

        void testSAMEV2AuthChangeKey(
            DESFireEV2ISO7816Commands cmd,
            DESFireKey newKeyWithoutSAM,
            DESFireKey newKeyWithoutSAM2)
        {
            var crypto = (cmd.getChip() as DESFireChip).getCrypto();
            // Default: Keyslot DES 21 / AES 20 - version 0
            // New: Keyslot DES 21 / AES 20 - version 1
            // New2: Keyslot DES 21 / AES 20 - version 2
            // WARNING EV2 NEED OFFLINE CRYPTO KEY Keyslot 19 used
            byte keyslot = 19; // AES offline
            var samKeyStorage = new SAMKeyStorage();
            samKeyStorage.setKeySlot(keyslot);

            var defaultKey = new DESFireKey();
            defaultKey.setKeyType(DESFireKeyType.DF_KEY_AES);
            defaultKey.setKeyVersion(0);
            defaultKey.setKeyStorage(samKeyStorage);

            var newKey = new DESFireKey();
            newKey.setKeyType(DESFireKeyType.DF_KEY_AES);
            newKey.setKeyVersion(1);
            newKey.setKeyStorage(samKeyStorage);

            var newKey2 = new DESFireKey();
            newKey2.setKeyType(DESFireKeyType.DF_KEY_AES);
            newKey2.setKeyVersion(2);
            newKey2.setKeyStorage(samKeyStorage);

            cmd.sam_authenticateEV2First(0x00, defaultKey);
            cmd.changeKey(0x01, newKeyWithoutSAM);
            cmd.changeKey(0x02, newKeyWithoutSAM2);
            cmd.sam_authenticateEV2First(0x01, newKey);
            cmd.sam_authenticateEV2First(0x02, newKey2);
        }

        void cleanupKeys(ref DESFireKey desDefault,
            ref DESFireKey aesDefault,
            ref DESFireKey desNew,
            ref DESFireKey aesNew,
            ref DESFireKey desNew2,
            ref DESFireKey aesNew2)
        {
            /*desDefault = new DESFireKey("99 11 88 99 88 11 88 99 88
            11 88 99 88 11 88 99");
            desDefault.setKeyType(DESFireKeyType.DF_KEY_DES);
            desDefault.setKeyVersion(1);
            aesDefault = new DESFireKey("99 11 88 99 88 11 88 99 88
            11 88 99 88 11 88 99");
            aesDefault.setKeyType(DESFireKeyType.DF_KEY_AES);
            aesDefault.setKeyVersion(1);*/

            desDefault = new DESFireKey();
            desDefault.setKeyType(DESFireKeyType.DF_KEY_DES);
            desDefault.setKeyVersion(0);
            aesDefault = new DESFireKey();
            aesDefault.setKeyType(DESFireKeyType.DF_KEY_AES);
            aesDefault.setKeyVersion(0);

            desNew = new DESFireKey(
                "88 11 88 99 88 11 88 99 88 10 88 98 88 10 88 98");
            desNew.setKeyType(DESFireKeyType.DF_KEY_DES);
            desNew.setKeyVersion(1);
            aesNew = new DESFireKey(
                "88 11 88 99 88 11 88 99 88 11 88 99 88 11 88 99");
            aesNew.setKeyType(DESFireKeyType.DF_KEY_AES);
            aesNew.setKeyVersion(1);
            desNew2 = new DESFireKey(
                "98 10 88 98 88 10 88 89 88 10 88 98 88 10 88 98");
            desNew2.setKeyType(DESFireKeyType.DF_KEY_DES);
            desNew2.setKeyVersion(2);
            aesNew2 = new DESFireKey(
                "99 11 88 99 88 11 88 99 88 11 88 99 88 11 88 99");
            aesNew2.setKeyType(DESFireKeyType.DF_KEY_AES);
            aesNew2.setKeyVersion(2);
        }

        void testPICCKey(DESFireEV1ISO7816Commands cmdev1,
            DESFireKey desDefault,
            DESFireKey aesDefault,
            DESFireKey desNew,
            DESFireKey aesNew)
        {
            cmdev1.authenticate(0x00, desDefault);
            cmdev1.changeKey(0x00, desNew);
            cmdev1.authenticate(0x00, desNew);
            var keyversion = cmdev1.getKeyVersion(0x00);
            Assert.AreEqual(desNew.getKeyVersion(), keyversion);
            cmdev1.changeKey(0x00, desDefault);
            cmdev1.authenticate(0x00, desDefault);
            keyversion = cmdev1.getKeyVersion(0x00);
            Assert.AreEqual(desDefault.getKeyVersion(), keyversion);


            cmdev1.changeKey(0x00, aesNew);
            cmdev1.authenticate(0x00, aesNew);
            keyversion = cmdev1.getKeyVersion(0x00);
            Assert.AreEqual(aesNew.getKeyVersion(), keyversion);
            cmdev1.changeKey(0x00, aesDefault);
            cmdev1.authenticate(0x00, aesDefault);
            keyversion = cmdev1.getKeyVersion(0x00);
            Assert.AreEqual(desDefault.getKeyVersion(), keyversion);


            cmdev1.changeKey(0x00, desDefault);
            cmdev1.authenticate(0x00, desDefault);
            keyversion = cmdev1.getKeyVersion(0x00);
            Assert.AreEqual(desDefault.getKeyVersion(), keyversion);
        }

        void setConfigurationTest(
            DESFireEV1ISO7816Commands cmdev1,
            DESFireEV2ISO7816Commands cmdev2,
            DESFireKey desDefault)
        {
            var newDefaultKey = new DESFireKey(
                "99 11 88 99 88 11 88 99 88 11 88 99 88 11 88 99");
            newDefaultKey.setKeyType(DESFireKeyType.DF_KEY_3K3DES);
            newDefaultKey.setKeyVersion(0x01);
            var oldDefaultKey = new DESFireKey();
            oldDefaultKey.setKeyType(DESFireKeyType.DF_KEY_3K3DES);
            oldDefaultKey.setKeyVersion(0x00);

            cmdev1.setConfiguration(true, false);
            cmdev1.setConfiguration(newDefaultKey);

            if (cmdev2 != null)
            {
                // There is no way back for the two last params
                cmdev2.setConfiguration(true, false, false, false);
                cmdev2.setConfiguration(0x04, 0x20);
            }


            // Application
            cmdev1.createApplication(
                0x521,
                (DESFireKeySettings) (
                    (int) DESFireKeySettings.KS_DEFAULT |
                    (int) DESFireKeySettings.KS_FREE_CREATE_DELETE_WITHOUT_MK),
                2, DESFireKeyType.DF_KEY_AES,
                FidSupport.FIDS_ISO_FID, 0x125,
                StringToByteVector("0125"));

            cmdev1.selectApplication(0x521);
            newDefaultKey.setKeyType(DESFireKeyType.DF_KEY_AES);
            cmdev1.authenticate(0x00, newDefaultKey);

            if (cmdev2 != null)
            {
                // TODO fix this and also add dfname change go DAM
                // Wrong authentication...
                // cmdev2.setConfigurationPDCap(0x02, 0x03, 0x04);
                // Currently give an error wrong value...
                // cmdev2.setConfiguration({},
                // StringToByteVector("D2760000850100"));
                cmdev2.setConfiguration(false, true, true);
            }

            // delegate application test

            cmdev1.selectApplication(0x00);
            cmdev1.authenticate(0x00, desDefault);
            cmdev1.setConfiguration(oldDefaultKey);

            if (cmdev2 != null)
            {
                var dfNames = cmdev2.getDFNames();
            }
        }
    }
}