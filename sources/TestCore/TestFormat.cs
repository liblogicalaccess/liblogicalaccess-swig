using Microsoft.VisualStudio.TestTools.UnitTesting;
using LibLogicalAccess;
using System.Collections.Generic;
using System.Linq;

namespace TestCore
{
    [TestClass]
    public class TestFormat
    {
        [TestMethod]
        public void Wiegand26()
        {
            var formatWiegand26 = new Wiegand26Format();
            formatWiegand26.setUid(1000);
            formatWiegand26.setFacilityCode(67);
            UByteVector formatBuf = formatWiegand26.getLinearData();
            var result = new UByteVector(new byte[] {0xa1, 0x81, 0xf4, 0x40});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand26 = new Wiegand26Format();
            formatWiegand26.setLinearData(result);
            Assert.AreEqual(formatWiegand26.getUid(), (ulong) 1000);
            Assert.AreEqual(formatWiegand26.getFacilityCode(), (byte) 67);
        }

        [TestMethod]
        public void Wiegand37()
        {
            var formatWiegand37 = new Wiegand37Format();
            formatWiegand37.setUid(98765);
            var formatBuf = formatWiegand37.getLinearData();
            var result = new UByteVector(new byte[] {0x00, 0x00, 0x18, 0x1c, 0xd8});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand37 = new Wiegand37Format();
            formatWiegand37.setLinearData(result);
            Assert.AreEqual(formatWiegand37.getUid(), (ulong) 98765);
        }

        [TestMethod]
        public void Wiegand34()
        {
            var formatWiegand34 = new Wiegand34Format();
            formatWiegand34.setUid(9865);
            var formatBuf = formatWiegand34.getLinearData();
            var result = new UByteVector(new byte[] {0x00, 0x00, 0x13, 0x44, 0xc0});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand34 = new Wiegand34Format();
            formatWiegand34.setLinearData(result);
            Assert.AreEqual(formatWiegand34.getUid(), (ulong) 9865);
        }

        [TestMethod]
        public void Wiegand34WithFacility()
        {
            var formatWiegand34F = new Wiegand34WithFacilityFormat();
            formatWiegand34F.setUid(9765);
            formatWiegand34F.setFacilityCode(89);
            var formatBuf = formatWiegand34F.getLinearData();
            var result = new UByteVector(new byte[] {0x00, 0x2c, 0x93, 0x12, 0xc0});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand34F = new Wiegand34WithFacilityFormat();
            formatWiegand34F.setLinearData(result);
            Assert.AreEqual(formatWiegand34F.getUid(), (ulong) 9765);
            Assert.AreEqual(formatWiegand34F.getFacilityCode(), (ushort) 89);
        }

        [TestMethod]
        public void Wiegand37WithFacility()
        {
            var formatWiegand37F = new Wiegand37WithFacilityFormat();
            formatWiegand37F.setUid(95265);
            formatWiegand37F.setFacilityCode(15);
            var formatBuf = formatWiegand37F.getLinearData();
            var result = new UByteVector(new byte[] {0x00, 0x07, 0x97, 0x42, 0x10});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand37F = new Wiegand37WithFacilityFormat();
            formatWiegand37F.setLinearData(result);
            Assert.AreEqual(formatWiegand37F.getUid(), (ulong) 95265);
            Assert.AreEqual(formatWiegand37F.getFacilityCode(), (ushort) 15);
        }

        [TestMethod]
        public void Wiegand37WithFacilityRightParity2()
        {
            var formatWiegand37F2F = new Wiegand37WithFacilityRightParity2Format();
            formatWiegand37F2F.setUid(75265);
            formatWiegand37F2F.setFacilityCode(85);
            var formatBuf = formatWiegand37F2F.getLinearData();
            var result = new UByteVector(new byte[] {0x80, 0x2a, 0xa4, 0xc0, 0x30});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand37F2F = new Wiegand37WithFacilityRightParity2Format();
            formatWiegand37F2F.setLinearData(result);
            Assert.AreEqual(formatWiegand37F2F.getUid(), (ulong) 75265);
            Assert.AreEqual(formatWiegand37F2F.getFacilityCode(), (ushort) 85);
        }

        [TestMethod]
        public void ASCII()
        {
            var formatASCII = new ASCIIFormat();
            string message = "I am locking at you from a RFID distance !";
            formatASCII.setASCIIValue(message);
            formatASCII.setASCIILength((uint) message.Length + 10);
            var formatBuf = formatASCII.getLinearData();

            var result = message.Clone() as string;

            for (int x = 0; x < 10; ++x)
                result += ' ';

            var resultBytes = new UByteVector(System.Text.Encoding.ASCII.GetBytes(result));

            Assert.IsTrue(formatBuf.SequenceEqual(resultBytes), "Data not equal");

            formatASCII = new ASCIIFormat();
            formatASCII.setASCIILength((uint) message.Length + 10);
            formatASCII.setLinearData(resultBytes);
            Assert.AreEqual(formatASCII.getASCIIValue(), message);
        }

        [TestMethod]
        public void Wiegand35()
        {
            var formatWiegand35 = new Wiegand35Format();
            formatWiegand35.setUid(39248);
            formatWiegand35.setCompanyCode(235);
            var formatBuf = formatWiegand35.getLinearData();
            var result = new UByteVector(new byte[] {0xc3, 0xac, 0x26, 0x54, 0x20});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatWiegand35 = new Wiegand35Format();
            formatWiegand35.setLinearData(result);
            Assert.AreEqual(formatWiegand35.getUid(), (ulong) 39248);
            Assert.AreEqual(formatWiegand35.getCompanyCode(), (ushort) 235);
        }

        [TestMethod]
        public void DataClock()
        {
            var formatDataClock = new DataClockFormat();
            formatDataClock.setUid(974641);
            var formatBuf = formatDataClock.getLinearData();
            var result = new UByteVector(new byte[] {0x00, 0x97, 0x46, 0x41, 0xd0});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatDataClock = new DataClockFormat();
            formatDataClock.setLinearData(result);
            Assert.AreEqual(formatDataClock.getUid(), (ulong) 974641);
        }

        [TestMethod]
        public void Raw()
        {
            var formatRaw = new RawFormat();
            var rawData = new UByteVector(new byte[]
            {
                0x89, 0x59, 0x48, 0x48, 0x56, 0x48, 0x35, 0x48, 0x78, 0x99,
                0x15, 0x54, 0x36, 0x75, 0x12
            });
            formatRaw.setRawData(rawData);
            var formatBuf = formatRaw.getLinearData();
            Assert.IsTrue(formatBuf.SequenceEqual(rawData), "Data not equal");
            formatRaw = new RawFormat();
            var result = rawData;
            formatRaw.setLinearData(result);
            var resultRawData = formatRaw.getRawData();
            Assert.IsTrue(resultRawData.SequenceEqual(rawData), "Data not equal");
        }

        [TestMethod]
        public void BariumFerritePCSC()
        {
            var formatBariumFerritePCSC = new BariumFerritePCSCFormat();
            formatBariumFerritePCSC.setUid(46417);
            formatBariumFerritePCSC.setFacilityCode(156);
            var formatBuf = formatBariumFerritePCSC.getLinearData();
            var result = new UByteVector(new byte[] {0xf0, 0x9c, 0xb5, 0x51, 0x88});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatBariumFerritePCSC = new BariumFerritePCSCFormat();
            formatBariumFerritePCSC.setLinearData(result);
            Assert.AreEqual(formatBariumFerritePCSC.getUid(), (ulong) 46417);
            Assert.AreEqual(formatBariumFerritePCSC.getFacilityCode(), (ushort) 156);
        }

        [TestMethod]
        public void Getronik40Bit()
        {
            var formatGetronik40 = new Getronik40BitFormat();
            formatGetronik40.setUid(5671);
            formatGetronik40.setField(5671);
            var formatBuf = formatGetronik40.getLinearData();
            var result = new UByteVector(new byte[] {0x2e, 0x16, 0x27, 0x58, 0x9f});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatGetronik40 = new Getronik40BitFormat();
            formatGetronik40.setLinearData(result);
            Assert.AreEqual(formatGetronik40.getUid(), (ulong) 5671);
            Assert.AreEqual(formatGetronik40.getField(), (ushort) 5671);
        }

        [TestMethod]
        public void HIDHoneywell40Bit()
        {
            var formatHIDHoneywell40Bit = new HIDHoneywell40BitFormat();
            formatHIDHoneywell40Bit.setUid(17866);
            formatHIDHoneywell40Bit.setFacilityCode(895);
            var formatBuf = formatHIDHoneywell40Bit.getLinearData();
            var result = new UByteVector(new byte[] {0xf3, 0x7f, 0x45, 0xca, 0x03});
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatHIDHoneywell40Bit = new HIDHoneywell40BitFormat();
            formatHIDHoneywell40Bit.setLinearData(result);
            Assert.AreEqual(formatHIDHoneywell40Bit.getUid(), (ulong) 17866);
            Assert.AreEqual(formatHIDHoneywell40Bit.getFacilityCode(), (ushort) 895);
        }

        [TestMethod]
        public void FASCN200Bit()
        {
            // Currently not working because we use BCDNibbleDataType (4bits)
            // with parity offset 4 when FASCN200 use parity at bit 5 (outside the BCDN)
            var formatFASCN200 = new FASCN200BitFormat();
            formatFASCN200.setAgencyCode(32);
            formatFASCN200.setSystemCode(1);
            formatFASCN200.setUid(92446);
            formatFASCN200.setSerieCode(0);
            formatFASCN200.setCredentialCode(1);
            formatFASCN200.setPersonIdentifier(1112223333);
            formatFASCN200.setOrganizationalCategory(FASCNOrganizationalCategory.OC_FEDERAL_GOVERNMENT_AGENCY);
            formatFASCN200.setOrganizationalIdentifier(1223);
            formatFASCN200.setPOACategory(FASCNPOAssociationCategory.POA_CIVIL);
            var formatBuf = formatFASCN200.getLinearData();
            var result = new UByteVector(new byte[]
            {
                0xD0, 0x43, 0x94, 0x58, 0x21, 0x0C, 0x2C, 0x19, 0xA0, 0x84, 0x6D, 0x83, 0x68,
                0x5A, 0x10, 0x82, 0x10, 0x8C, 0xE7, 0x39, 0x84, 0x10, 0x8C, 0xA3, 0xF5
            });
            /*
             * We currently calcul the wrong LRC.... have to found how to do it
             * if (!std::equal(formatBuf.begin(), formatBuf.end(), result.begin()))
                 THROW_EXCEPTION_WITH_LOG(std::runtime_error, "Bad format");*/
            formatFASCN200 = new FASCN200BitFormat();
            formatFASCN200.setLinearData(result);
            Assert.AreEqual(formatFASCN200.getAgencyCode(), (ushort) 32);
            Assert.AreEqual(formatFASCN200.getSystemCode(), (ushort) 1);
            Assert.AreEqual(formatFASCN200.getUid(), (ulong) 92446);
            Assert.AreEqual(formatFASCN200.getSerieCode(), (byte) 0);
            Assert.AreEqual(formatFASCN200.getCredentialCode(), (byte) 1);
            Assert.AreEqual(formatFASCN200.getPersonIdentifier(), (ulong) 1112223333);
            Assert.AreEqual(formatFASCN200.getOrganizationalCategory(),
                FASCNOrganizationalCategory.OC_FEDERAL_GOVERNMENT_AGENCY);
            Assert.AreEqual(formatFASCN200.getOrganizationalIdentifier(), (ushort) 1223);
            Assert.AreEqual(formatFASCN200.getPOACategory(), FASCNPOAssociationCategory.POA_CIVIL);
        }

        [TestMethod]
        public void Custom()
        {
            var formatCustom = new CustomFormat();
            DataFieldVector fieldList = new DataFieldVector();

            var numberDataField = new NumberDataField();
            numberDataField.setPosition(0);
            numberDataField.setDataLength(64);
            numberDataField.setValue(984654321);
            fieldList.Add(numberDataField);

            var binaryDataField = new BinaryDataField();
            binaryDataField.setPosition(64);
            binaryDataField.setDataLength(160);
            binaryDataField.setPaddingChar(0xFF);
            binaryDataField.setValue(new UByteVector(new byte[]
            {
                0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef, 0x12, 0x34,
                0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef
            }));
            fieldList.Add(binaryDataField);

            var stringDataField = new StringDataField();
            stringDataField.setPosition(224);
            stringDataField.setPaddingChar((byte) 'H');
            stringDataField.setDataLength(200);
            stringDataField.setValue("Le lamasticot sur kappou !");
            fieldList.Add(stringDataField);

            var parityDataField = new ParityDataField();
            parityDataField.setPosition(424);
            parityDataField.setBitsUsePositions(new UIntCollection(new List<uint> {0x01, 0x08, 0x0a, 0x0c, 0x12}));
            parityDataField.setParityType(ParityType.PT_ODD);
            fieldList.Add(parityDataField);

            var littleEdian =
                new LittleEndianDataRepresentation();

            var numberLittleDataField = new NumberDataField();
            numberLittleDataField.setDataRepresentation(littleEdian);
            numberLittleDataField.setPosition(425);
            numberLittleDataField.setDataLength(64);
            numberLittleDataField.setValue(984654321);
            fieldList.Add(numberLittleDataField);

            var binaryLittleDataField = new BinaryDataField();
            binaryLittleDataField.setDataRepresentation(littleEdian);
            binaryLittleDataField.setPosition(489);
            binaryLittleDataField.setDataLength(160);
            binaryLittleDataField.setPaddingChar(0xFF);
            binaryLittleDataField.setValue(new UByteVector(new byte[]
            {
                0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef, 0x12,
                0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef
            }));
            fieldList.Add(binaryLittleDataField);

            var stringLittleDataField = new StringDataField();
            stringLittleDataField.setDataRepresentation(littleEdian);
            stringLittleDataField.setPosition(649);
            stringLittleDataField.setPaddingChar((byte) 'H');
            stringLittleDataField.setDataLength(200);
            stringLittleDataField.setValue("Le lamasticot sur kappou !");
            fieldList.Add(stringLittleDataField);

            var parityLittleDataField = new ParityDataField();
            parityLittleDataField.setPosition(850);
            parityLittleDataField.setBitsUsePositions(new UIntCollection(new List<uint> {501, 356, 286, 1, 623}));
            parityLittleDataField.setParityType(ParityType.PT_ODD);
            fieldList.Add(parityLittleDataField);

            var nodatarepre =
                new NoDataRepresentation();

            var numberNoDataField = new NumberDataField();
            numberNoDataField.setDataRepresentation(nodatarepre);
            numberNoDataField.setPosition(851);
            numberNoDataField.setDataLength(64);
            numberNoDataField.setValue(984654321);
            fieldList.Add(numberNoDataField);

            var binaryNoDataField = new BinaryDataField();
            binaryNoDataField.setDataRepresentation(nodatarepre);
            binaryNoDataField.setPosition(915);
            binaryNoDataField.setDataLength(160);
            binaryNoDataField.setPaddingChar(0xFF);
            binaryNoDataField.setValue(new UByteVector(new byte[]
            {
                0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef, 0x12,
                0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef
            }));
            fieldList.Add(binaryNoDataField);

            var stringNoDataField = new StringDataField();
            stringNoDataField.setDataRepresentation(nodatarepre);
            stringNoDataField.setPosition(1075);
            stringNoDataField.setPaddingChar((byte) 'H');
            stringNoDataField.setDataLength(200);
            stringNoDataField.setValue("Le lamasticot sur kappou !");
            fieldList.Add(stringNoDataField);

            var parityNoDataField = new ParityDataField();
            parityNoDataField.setPosition(1275);
            parityNoDataField.setBitsUsePositions(new UIntCollection(new List<uint> {598, 123, 452, 21, 900}));
            parityNoDataField.setParityType(ParityType.PT_ODD);
            fieldList.Add(parityNoDataField);

            formatCustom.setFieldList(fieldList);
            var formatBuf = formatCustom.getLinearData();
            var result = new UByteVector(new byte[]
            {
                0x00, 0x00, 0x00, 0x00, 0x3a, 0xb0, 0xa1, 0xf1, 0x12, 0x34, 0x56, 0x78, 0x9a,
                0xbc, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef, 0xff, 0xff,
                0xff, 0xff, 0x4c, 0x65, 0x20, 0x6c, 0x61, 0x6d, 0x61, 0x73, 0x74, 0x69, 0x63,
                0x6f, 0x74, 0x20, 0x73, 0x75, 0x72, 0x20, 0x6b, 0x61, 0x70, 0x70, 0x6f, 0x75,
                0x20, 0xf8, 0xd0, 0xd8, 0x1d, 0x00, 0x00, 0x00, 0x00, 0x7f, 0xff, 0xff, 0xff,
                0xf7, 0xe6, 0xde, 0x4d, 0x3c, 0x2b, 0x1a, 0x09, 0x77, 0xe6, 0xde, 0x4d, 0x3c,
                0x2b, 0x1a, 0x09, 0x10, 0x3a, 0xb7, 0xb8, 0x38, 0x30, 0xb5, 0x90, 0x39, 0x3a,
                0xb9, 0x90, 0x3a, 0x37, 0xb1, 0xb4, 0xba, 0x39, 0xb0, 0xb6, 0xb0, 0xb6, 0x10,
                0x32, 0xa6, 0x3e, 0x34, 0x36, 0x07, 0x40, 0x00, 0x00, 0x00, 0x02, 0x46, 0x8a,
                0xcf, 0x13, 0x57, 0x99, 0xbd, 0xe2, 0x46, 0x8a, 0xcf, 0x13, 0x57, 0x99, 0xbd,
                0xff, 0xff, 0xff, 0xff, 0xe9, 0x8c, 0xa4, 0x0d, 0x8c, 0x2d, 0xac, 0x2e, 0x6e,
                0x8d, 0x2c, 0x6d, 0xee, 0x84, 0x0e, 0x6e, 0xae, 0x44, 0x0d, 0x6c, 0x2e, 0x0e,
                0x0d, 0xee, 0xa4, 0x10
            });
            Assert.IsTrue(formatBuf.SequenceEqual(result), "Data not equal");
            formatCustom = new CustomFormat();
            formatCustom.setFieldList(fieldList);
            formatCustom.setLinearData(result);

            var numberFieldCheck = formatCustom.getFieldForPosition(0) as NumberDataField;
            Assert.AreEqual(numberFieldCheck.getValue(), 984654321);

            var stringFieldCheck =
                formatCustom.getFieldForPosition(224) as StringDataField;
            Assert.AreEqual(stringFieldCheck.getValue(), "Le lamasticot sur kappou ");

            var binaryFieldCheck =
                formatCustom.getFieldForPosition(489) as BinaryDataField;
            var value = binaryFieldCheck.getValue();
            var rvalue = new UByteVector(new byte[]
            {
                0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef, 0x12, 0x34,
                0x56, 0x78, 0x9a, 0xbc, 0xcd, 0xef, 0xff, 0xff, 0xff, 0xff
            });
            Assert.IsTrue(value.SequenceEqual(rvalue), "Data not equal");

            int x = 0;
            foreach (var fieldTmp in formatCustom.getFieldList())
            {
                switch (x)
                {
                    case 0:
                        Assert.IsTrue(fieldTmp is NumberDataField);
                        break;
                    case 1:
                        Assert.IsTrue(fieldTmp is BinaryDataField);
                        break;
                    case 2:
                        Assert.IsTrue(fieldTmp is StringDataField);
                        break;
                    case 3:
                        Assert.IsTrue(fieldTmp is NumberDataField);
                        break;
                    case 4:
                        Assert.IsTrue(fieldTmp is BinaryDataField);
                        break;
                    case 5:
                        Assert.IsTrue(fieldTmp is StringDataField);
                        break;
                    case 6:
                        Assert.IsTrue(fieldTmp is NumberDataField);
                        break;
                    case 7:
                        Assert.IsTrue(fieldTmp is BinaryDataField);
                        break;
                    case 8:
                        Assert.IsTrue(fieldTmp is StringDataField);
                        break;
                    case 9:
                        Assert.IsTrue(fieldTmp is ParityDataField);
                        break;
                    case 10:
                        Assert.IsTrue(fieldTmp is ParityDataField);
                        break;
                    case 11:
                        Assert.IsTrue(fieldTmp is ParityDataField);
                        break;
                }

                ++x;
            }

            var fieldListTmp = formatCustom.getFieldList();
            Assert.AreEqual(fieldList.Count, 12);
            var fieldListTmpArray = fieldListTmp.ToArray();
            Assert.IsTrue(fieldListTmpArray[0] is NumberDataField);
            Assert.IsTrue(fieldListTmpArray[1] is BinaryDataField);
            Assert.IsTrue(fieldListTmpArray[2] is StringDataField);
            Assert.IsTrue(fieldListTmpArray[3] is NumberDataField);
            Assert.IsTrue(fieldListTmpArray[4] is BinaryDataField);
            Assert.IsTrue(fieldListTmpArray[5] is StringDataField);
            Assert.IsTrue(fieldListTmpArray[6] is NumberDataField);
            Assert.IsTrue(fieldListTmpArray[7] is BinaryDataField);
            Assert.IsTrue(fieldListTmpArray[8] is StringDataField);
            Assert.IsTrue(fieldListTmpArray[9] is ParityDataField);
            Assert.IsTrue(fieldListTmpArray[10] is ParityDataField);
            Assert.IsTrue(fieldListTmpArray[11] is ParityDataField);
        }

        [TestMethod]
        public void CardsFormatComposite()
        {
            CardsFormatComposite composite = new CardsFormatComposite();
            string FormatXml =
                "<CustomFormat type=\"16\"><Name>Diversification</Name><Fields><BinaryDataField><Name>DivInput</Name><Position>0</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>56</Length><Value/><Padding>0</Padding></BinaryDataField></Fields></CustomFormat>";
            var format = composite.createFormatFromXml(FormatXml, string.Empty);
            Assert.IsTrue(format is CustomFormat);
            FormatXml =
                "<CustomFormat type=\"16\"><Name>Identification Porteur</Name><Fields><BinaryDataField><Name>MajorVersion</Name><Position>0</Position><IsFixedField>true</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>8</Length><Value>01</Value><Padding>0</Padding></BinaryDataField><BinaryDataField><Name>MinorVersion</Name><Position>8</Position><IsFixedField>true</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>8</Length><Value>00</Value><Padding>0</Padding></BinaryDataField><StringDataField><Name>Nom</Name><Position>16</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>2</DataType><Length>800</Length><Padding>0</Padding><Charset>utf-16</Charset><Value/></StringDataField><StringDataField><Name>Prenom</Name><Position>816</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>800</Length><Padding>0</Padding><Charset>utf-16</Charset><Value/></StringDataField><StringDataField><Name>Nom facial</Name><Position>1616</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>640</Length><Padding>0</Padding><Charset>utf-16</Charset><Value/></StringDataField><StringDataField><Name>Entreprise facial</Name><Position>2256</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>640</Length><Padding>0</Padding><Charset>utf-16</Charset><Value/></StringDataField><StringDataField><Name>NumeroBadge</Name><Position>2896</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>120</Length><Padding>0</Padding><Charset>ascii</Charset><Value/></StringDataField><StringDataField><Name>AutoriteDelivrance</Name><Position>3016</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>640</Length><Padding>0</Padding><Charset>utf-16</Charset><Value/></StringDataField><StringDataField><Name>SecteursSurete</Name><Position>3656</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>32</Length><Padding>0</Padding><Charset>ascii</Charset><Value/></StringDataField><StringDataField><Name>SecteursFonctionnels</Name><Position>3688</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>152</Length><Padding>0</Padding><Charset>ascii</Charset><Value/></StringDataField><StringDataField><Name>OutilsMetiers</Name><Position>3840</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>152</Length><Padding>0</Padding><Charset>ascii</Charset><Value/></StringDataField><StringDataField><Name>CodeSite</Name><Position>3992</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>320</Length><Padding>0</Padding><Charset>utf-16</Charset><Value/></StringDataField><NumberDataField><Name>DateFinValidite</Name><Position>4312</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>64</Length><Value>0</Value></NumberDataField></Fields></CustomFormat>";
            format = composite.createFormatFromXml(FormatXml, string.Empty);
            Assert.IsTrue(format is CustomFormat);
            FormatXml =
                "<CustomFormat type=\"16\"><Name>Metadonnees</Name><Fields><BinaryDataField><Name>AuthenticationMode</Name><Position>0</Position><IsFixedField>true</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>16</Length><Value>4a 02</Value><Padding>0</Padding></BinaryDataField><BinaryDataField><Name>Communication</Name><Position>16</Position><IsFixedField>true</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>8</Length><Value>02</Value><Padding>0</Padding></BinaryDataField><BinaryDataField><Name>AlgoSign</Name><Position>24</Position><IsFixedField>true</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>2</DataType><Length>8</Length><Value>00</Value><Padding>0</Padding></BinaryDataField><NumberDataField><Name>SignKeyVersion</Name><Position>32</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>2</DataType><Length>8</Length><Value>0</Value></NumberDataField></Fields></CustomFormat>";
            format = composite.createFormatFromXml(FormatXml, string.Empty);
            Assert.IsTrue(format is CustomFormat);
            FormatXml =
                "<CustomFormat type=\"16\"><Name>Identification Porteur Signature</Name><Fields><BinaryDataField><Name>IDPorteurSignature</Name><Position>0</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>4096</Length><Value/><Padding>0</Padding></BinaryDataField></Fields></CustomFormat>";
            format = composite.createFormatFromXml(FormatXml, string.Empty);
            Assert.IsTrue(format is CustomFormat);
            FormatXml =
                "<CustomFormat type=\"16\"><Name>Signature Metadonnees</Name><Fields><BinaryDataField><Name>MetaSignature</Name><Position>0</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>4096</Length><Value/><Padding>0</Padding></BinaryDataField></Fields></CustomFormat>";
            format = composite.createFormatFromXml(FormatXml, string.Empty);
            Assert.IsTrue(format is CustomFormat);
        }

        [TestMethod]
        public void TestFormatFields()
        {
            var w26 = new Wiegand26Format();
            Assert.AreEqual(2, w26.getFieldList().Count);

            CardsFormatComposite composite = new CardsFormatComposite();
            string FormatXml =
                "<CustomFormat type=\"16\"><Name>Diversification</Name><Fields><BinaryDataField><Name>DivInput</Name><Position>0</Position><IsFixedField>false</IsFixedField><IsIdentifier>false</IsIdentifier><DataRepresentation>4</DataRepresentation><DataType>3</DataType><Length>56</Length><Value/><Padding>0</Padding></BinaryDataField></Fields></CustomFormat>";
            var format = composite.createFormatFromXml(FormatXml, string.Empty);
            Assert.AreEqual(1, format.getFieldList().Count);
        }
    }
}