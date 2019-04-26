using LibLogicalAccess;
using LibLogicalAccess.Card;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace TestCore
{
    [TestClass]
    public class TestAccessInfo
    {
        [TestMethod]
        public void TestIksConfig()
        {
            DESFireAccessInfo ai = new DESFireAccessInfo();
            ai.unSerialize(@"<DESFireAccessInfo>
    <ReadKey>
        <DESFireKey keyStorageType=""3"">
            <IsCiphered>true</IsCiphered>
            <Data>oWeKz6/zgvddDB79LGzpCVyFnjU2maVZwISQg075HHv8LcNDf408nIi+x7hwNLvU</Data>
            <IKSStorage>
                <KeyIdentity>556b4973-e367-4ac6-90bf-b978b09cd475</KeyIdentity>
                <IKS>
                    <ip>iksf</ip>
                    <port>6565</port>
                    <client_cert>C:\my-client-1.crt</client_cert>
                    <client_key>C:\my-client-1.key</client_key>
                    <root_ca>C:\iks-server-intermediate-ca.crt</root_ca>
                    <saveIKSConfig>true</saveIKSConfig>
                </IKS>
            </IKSStorage>
            <KeyType>128</KeyType>
            <KeyVersion>0</KeyVersion>
        </DESFireKey>
    </ReadKey>
    <ReadKeyno>1</ReadKeyno>
    <WriteKey>
        <DESFireKey keyStorageType=""0"">
            <IsCiphered>false</IsCiphered>
            <Data/>
            <ComputerMemoryKeyStorage>
                <KeyStorage>
                    <metadata>
                        <IsHidden>False</IsHidden>
                        <IsKeyCeremony>False</IsKeyCeremony>
                    </metadata>
                </KeyStorage>
            </ComputerMemoryKeyStorage>
            <KeyType>128</KeyType>
            <KeyVersion>0</KeyVersion>
        </DESFireKey>
    </WriteKey>
    <WriteKeyno>0</WriteKeyno>
    <MasterApplicationKey>
        <DESFireKey keyStorageType=""0"">
            <IsCiphered>false</IsCiphered>
            <Data/>
            <ComputerMemoryKeyStorage>
                <KeyStorage>
                    <metadata>
                        <IsHidden>False</IsHidden>
                        <IsKeyCeremony>False</IsKeyCeremony>
                    </metadata>
                </KeyStorage>
            </ComputerMemoryKeyStorage>
            <KeyType>128</KeyType>
            <KeyVersion>0</KeyVersion>
        </DESFireKey>
    </MasterApplicationKey>
    <MasterCardKey>
        <DESFireKey keyStorageType=""0"">
            <IsCiphered>false</IsCiphered>
            <Data/>
            <ComputerMemoryKeyStorage>
                <KeyStorage>
                    <metadata>
                        <IsHidden>False</IsHidden>
                        <IsKeyCeremony>False</IsKeyCeremony>
                    </metadata>
                </KeyStorage>
            </ComputerMemoryKeyStorage>
            <KeyType>0</KeyType>
            <KeyVersion>0</KeyVersion>
        </DESFireKey>
    </MasterCardKey>
</DESFireAccessInfo>", string.Empty);
            IKSStorage iksStorage = ai.readKey.getKeyStorage() as IKSStorage;
            Assert.IsNotNull(iksStorage);
            Assert.AreEqual("556b4973-e367-4ac6-90bf-b978b09cd475", iksStorage.getKeyIdentity());
        }

        [TestMethod]
        public void TestUnserializeReaderFormatCompositeIks()
        {
            string config = @"<ReaderFormatComposite>
    <ReaderConfiguration>
        <ReaderProvider>PCSC</ReaderProvider>
        <ReaderUnit type=""PCSC"">
            <PCSCReaderUnitConfiguration>
                <SAMType>SAM_NONE</SAMType>
                <SAMReaderName/>
                <SAMKey>
                    <KeyNo>0</KeyNo>
                </SAMKey>
                <CheckSAMReaderIsAvailable>true</CheckSAMReaderIsAvailable>
                <AutoConnectToSAMReader>true</AutoConnectToSAMReader>
                <TransmissionProtocol>3</TransmissionProtocol>
                <ShareMode>2</ShareMode>
            </PCSCReaderUnitConfiguration>
            <TransportType/>
            <Name/>
        </ReaderUnit>
    </ReaderConfiguration>
    <CardsFormat>
        <Card>
            <type>DESFireEV1</type>
            <SelectedFormat>16</SelectedFormat>
            <WriteInfo/>
            <FormatConfiguration>
                <CustomFormat type=""16"">
                    <Name>Custom</Name>
                    <Fields>
                        <NumberDataField>
                            <Name>id</Name>
                            <Position>0</Position>
                            <IsFixedField>false</IsFixedField>
                            <IsIdentifier>true</IsIdentifier>
                            <DataRepresentation>4</DataRepresentation>
                            <DataType>3</DataType>
                            <Length>8</Length>
                            <Value>0</Value>
                        </NumberDataField>
                        <StringDataField>
                            <Name>Login</Name>
                            <Position>8</Position>
                            <IsFixedField>false</IsFixedField>
                            <IsIdentifier>false</IsIdentifier>
                            <DataRepresentation>4</DataRepresentation>
                            <DataType>3</DataType>
                            <Length>64</Length>
                            <Padding>0</Padding>
                            <Charset>ascii</Charset>
                            <Value/>
                        </StringDataField>
                    </Fields>
                </CustomFormat>
                <DESFireEV1Location>
                    <DESFireLocation>
                        <AID>2</AID>
                        <File>0</File>
                        <Byte>0</Byte>
                        <SecurityLevel>3</SecurityLevel>
                    </DESFireLocation>
                    <UseEV1>true</UseEV1>
                    <CryptoMethod>128</CryptoMethod>
                    <UseISO7816>false</UseISO7816>
                    <ApplicationFID>0</ApplicationFID>
                    <FileFID>0</FileFID>
                </DESFireEV1Location>
                <DESFireAccessInfo>
                    <ReadKey>
                        <DESFireKey keyStorageType=""3"">
                            <IsCiphered>true</IsCiphered>
                            <Data>oWeKz6/zgvddDB79LGzpCVyFnjU2maVZwISQg075HHv8LcNDf408nIi+x7hwNLvU</Data>
                            <IKSStorage>
                                <KeyIdentity>556b4973-e367-4ac6-90bf-b978b09cd475</KeyIdentity>
                                <IKS>
                                    <ip>iksf</ip>
                                    <port>6565</port>
                                    <client_cert>C:\my-client-1.crt</client_cert>
                                    <client_key>C:\my-client-1.key</client_key>
                                    <root_ca>C:\iks-server-intermediate-ca.crt</root_ca>
                                    <saveIKSConfig>true</saveIKSConfig>
                                </IKS>
                            </IKSStorage>
                            <KeyType>128</KeyType>
                            <KeyVersion>0</KeyVersion>
                        </DESFireKey>
                    </ReadKey>
                    <ReadKeyno>1</ReadKeyno>
                    <WriteKey>
                        <DESFireKey keyStorageType=""0"">
                            <IsCiphered>false</IsCiphered>
                            <Data/>
                            <ComputerMemoryKeyStorage>
                                <KeyStorage>
                                    <metadata>
                                        <IsHidden>False</IsHidden>
                                        <IsKeyCeremony>False</IsKeyCeremony>
                                    </metadata>
                                </KeyStorage>
                            </ComputerMemoryKeyStorage>
                            <KeyType>128</KeyType>
                            <KeyVersion>0</KeyVersion>
                        </DESFireKey>
                    </WriteKey>
                    <WriteKeyno>0</WriteKeyno>
                    <MasterApplicationKey>
                        <DESFireKey keyStorageType=""0"">
                            <IsCiphered>false</IsCiphered>
                            <Data/>
                            <ComputerMemoryKeyStorage>
                                <KeyStorage>
                                    <metadata>
                                        <IsHidden>False</IsHidden>
                                        <IsKeyCeremony>False</IsKeyCeremony>
                                    </metadata>
                                </KeyStorage>
                            </ComputerMemoryKeyStorage>
                            <KeyType>128</KeyType>
                            <KeyVersion>0</KeyVersion>
                        </DESFireKey>
                    </MasterApplicationKey>
                    <MasterCardKey>
                        <DESFireKey keyStorageType=""0"">
                            <IsCiphered>false</IsCiphered>
                            <Data/>
                            <ComputerMemoryKeyStorage>
                                <KeyStorage>
                                    <metadata>
                                        <IsHidden>False</IsHidden>
                                        <IsKeyCeremony>False</IsKeyCeremony>
                                    </metadata>
                                </KeyStorage>
                            </ComputerMemoryKeyStorage>
                            <KeyType>0</KeyType>
                            <KeyVersion>0</KeyVersion>
                        </DESFireKey>
                    </MasterCardKey>
                </DESFireAccessInfo>
            </FormatConfiguration>
        </Card>
    </CardsFormat>
</ReaderFormatComposite>";
            ReaderFormatComposite rfc = new ReaderFormatComposite();
            rfc.unSerialize(config, string.Empty);
        }
    }
}
