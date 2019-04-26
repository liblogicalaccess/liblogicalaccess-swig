/* File : liblogicalaccess.i */

%include <windows.i>

%typemap(csimports) SWIGTYPE
%{ 
	using System;
	using System.Runtime.InteropServices;
%}


/* Define_section */

#define LLA_READERS_STIDSTR_API
#define LLA_READERS_STIDPRG_API
#define LLA_READERS_SMARTID_API
#define LLA_READERS_SCIEL_API
#define LLA_READERS_RPLETH_API
#define LLA_READERS_PROMAG_API
#define LLA_READERS_PRIVATE_PCSC_API
#define LLA_READERS_PRIVATE_ISO7816_API
#define LLA_READERS_PCSC_API
#define LLA_READERS_OSDP_API
#define LLA_READERS_OK5553_API
#define LLA_READERS_NFC_NFC_API
#define LLA_READERS_ISO7816_API
#define LLA_READERS_IDONDEMAND_API
#define LLA_READERS_GUNNEBO_API
#define LLA_READERS_GIGATMS_API
#define LLA_READERS_ELATEC_API
#define LLA_READERS_DEISTER_API
#define LLA_READERS_AXESSTMCLEGIC_API
#define LLA_READERS_AXESSTMC13_API
#define LLA_READERS_ADMITTO_API
#define LLA_READERS_A3MLGM5600_API
#define LLA_IKS_API
#define LLA_CRYPTO_API
#define LLA_CORE_API
#define LLA_COMMON_API
#define LLA_CARDS_TWIC_API
#define LLA_CARDS_TOPAZ_API
#define LLA_CARDS_TAGIT_API
#define LLA_CARDS_STMLRI_API
#define LLA_CARDS_SMARTFRAME_API
#define LLA_CARDS_SEOS_API
#define LLA_CARDS_SAMAV2_API
#define LLA_CARDS_PROX_API
#define LLA_CARDS_PROXLITE_API
#define LLA_CARDS_PRIVATE_SEPROCESSOR_API
#define LLA_CARDS_PRIVATE_ICLASS_API
#define LLA_CARDS_PRIVATE_DESFIRE2_API
#define LLA_CARDS_MIFARE_API
#define LLA_CARDS_MIFAREULTRALIGHT_API
#define LLA_CARDS_MIFAREPLUS_API
#define LLA_CARDS_LEGICPRIME_API
#define LLA_CARDS_ISO7816_API
#define LLA_CARDS_ISO15693_API
#define LLA_CARDS_INFINEONMYD_API
#define LLA_CARDS_INDALA_API
#define LLA_CARDS_ICODE2_API
#define LLA_CARDS_ICODE1_API
#define LLA_CARDS_GENERICTAG_API
#define LLA_CARDS_FELICA_API
#define LLA_CARDS_EPASS_API
#define LLA_CARDS_EM4135_API
#define LLA_CARDS_EM4102_API
#define LLA_CARDS_DESFIRE_API
#define LLA_CARDS_CPS3_API

/* END_Define_section */

/*****SWIG INCLUSIONS*****/

%include <typemaps.i>
%include <stl.i>
%include <std_string.i>
%include <std_shared_ptr.i>
%include <std_array.i>
%include <std_list.i>
%include <wchar.i>
%include <exception.i>
%include <carrays.i>
%include <arrays_csharp.i>
%include <stdint.i>
%include <swiginterface.i>
%include <cpointer.i>
%include <std_pair.i>
%include <std_vector.i>


/*****OVERRIDE STRING NULL EXCEPTION*****/

%{
#include <string>
%}

%typemap(in) std::string 
%{
	if (!$input) {
		$1.clear();
	} else {
		$1.assign($input);
	}
%}

%typemap(in) const std::string&
%{
	$*1_ltype $1_str;
	if ($input) {
		$1_str = $*1_ltype($input);
	}
	$1 = &$1_str;
%}

%typemap(directorout, canthrow=1) std::string
%{ 
	if (!$input) {
		$result.clear();
	} else {
		$result.assign($input);
	}
%}

/*****WARNING SECTION*****/

#pragma SWIG nowarn=314,401,833

//Ignored Warning:
// - 314: 'lock' is a C# keyword, renaming to 'lock_'
// - 516: Overloaded method ignored 
// - 401: Nothing known about class 'name'. Ignored. 
// - 833: Warning for classname: Base baseclass ignored. Multiple inheritance is not supported in C#. (C#). 

/*****IGNORE SECTION*****/

%ignore newDynLibrary;
%ignore hasEnding;

%rename(IsEqual) operator==;
%rename(IsDifferent) operator!=;
%rename(CompareTo) operator<;
%ignore operator<<;
%ignore operator=;
%ignore operator bool;
%ignore operator int;
%ignore std::ostream;

/*****SHARED PTR SECTION*****/

%shared_ptr(logicalaccess::A3MLGM5600LCDDisplay);
%shared_ptr(logicalaccess::A3MLGM5600LEDBuzzerDisplay);
%shared_ptr(logicalaccess::A3MLGM5600ReaderCardAdapter);
%shared_ptr(logicalaccess::A3MLGM5600ReaderProvider);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnit);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnitConfiguration);
%shared_ptr(logicalaccess::ACSACR1222LLCDDisplay);
%shared_ptr(logicalaccess::ACSACR1222LLEDBuzzerDisplay);
%shared_ptr(logicalaccess::ACSACR1222LReaderUnit);
%shared_ptr(logicalaccess::ACSACR1222LReaderUnitConfiguration);
%shared_ptr(logicalaccess::ACSACRReaderUnit);
%shared_ptr(logicalaccess::ACSACRResultChecker);
%shared_ptr(logicalaccess::AES128Key);
%shared_ptr(logicalaccess::AESCryptoService);
%shared_ptr(logicalaccess::AESHelper);
%shared_ptr(logicalaccess::ASCIIFormat);
%shared_ptr(logicalaccess::ASN1);
%shared_ptr(logicalaccess::ATRParser);
%shared_ptr(logicalaccess::ATRParser::ATRInfo);
%shared_ptr(logicalaccess::AccessControlCardService);
%shared_ptr(logicalaccess::AccessInfo);
%shared_ptr(logicalaccess::AdmittoBufferParser);
%shared_ptr(logicalaccess::AdmittoReaderCardAdapter);
%shared_ptr(logicalaccess::AdmittoReaderProvider);
%shared_ptr(logicalaccess::AdmittoReaderUnit);
%shared_ptr(logicalaccess::AdmittoReaderUnitConfiguration);
%shared_ptr(logicalaccess::AdmittoSerialPortDataTransport);
%shared_ptr(logicalaccess::AxessTMC13BufferParser);
%shared_ptr(logicalaccess::AxessTMC13ReaderCardAdapter);
%shared_ptr(logicalaccess::AxessTMC13ReaderProvider);
%shared_ptr(logicalaccess::AxessTMC13ReaderUnit);
%shared_ptr(logicalaccess::AxessTMC13ReaderUnitConfiguration);
%shared_ptr(logicalaccess::AxessTMC13SerialPortDataTransport);
%shared_ptr(logicalaccess::AxessTMCLegicBufferParser);
%shared_ptr(logicalaccess::AxessTMCLegicReaderCardAdapter);
%shared_ptr(logicalaccess::AxessTMCLegicReaderProvider);
%shared_ptr(logicalaccess::AxessTMCLegicReaderUnit);
%shared_ptr(logicalaccess::AxessTMCLegicReaderUnitConfiguration);
%shared_ptr(logicalaccess::AxessTMCLegicSerialPortDataTransport);
%shared_ptr(logicalaccess::BCDByteDataType);
%shared_ptr(logicalaccess::BCDNibbleDataType);
%shared_ptr(logicalaccess::BariumFerritePCSCFormat);
%shared_ptr(logicalaccess::BigEndianDataRepresentation);
%shared_ptr(logicalaccess::BinaryDataField);
%shared_ptr(logicalaccess::BinaryDataType);
%shared_ptr(logicalaccess::BinaryFieldValue);
%shared_ptr(logicalaccess::BitHelper);
%shared_ptr(logicalaccess::BitsetStream);
%shared_ptr(logicalaccess::BufferHelper);
%shared_ptr(logicalaccess::CL1356PlusUtils);
%shared_ptr(logicalaccess::CL1356PlusUtils::CardCount);
%shared_ptr(logicalaccess::CL1356PlusUtils::Info);
%shared_ptr(logicalaccess::CPS3Chip);
%shared_ptr(logicalaccess::CPS3Commands);
%shared_ptr(logicalaccess::CPS3Location);
%shared_ptr(logicalaccess::CPS3StorageCardService);
%shared_ptr(logicalaccess::CardException);
%shared_ptr(logicalaccess::CardProbe);
%shared_ptr(logicalaccess::CardService);
%shared_ptr(logicalaccess::CardsFormatComposite);
%shared_ptr(logicalaccess::ChecksumDataField);
%shared_ptr(logicalaccess::CherryReaderUnit);
%shared_ptr(logicalaccess::Chip);
%shared_ptr(logicalaccess::CircularBufferParser);
%shared_ptr(logicalaccess::Commands);
%shared_ptr(logicalaccess::ComputerMemoryKeyStorage);
%shared_ptr(logicalaccess::CustomFormat);
%shared_ptr(logicalaccess::DESFireAccessInfo);
%shared_ptr(logicalaccess::DESFireAccessRights);
%shared_ptr(logicalaccess::DESFireChip);
%shared_ptr(logicalaccess::DESFireCommands);
%shared_ptr(logicalaccess::DESFireCommands::DESFireCardVersion);
%shared_ptr(logicalaccess::DESFireCommands::DataFileSetting);
%shared_ptr(logicalaccess::DESFireCommands::FileSetting);
%shared_ptr(logicalaccess::DESFireCommands::RecordFileSetting);
%shared_ptr(logicalaccess::DESFireCommands::ValueFileSetting);
%shared_ptr(logicalaccess::DESFireCrypto);
%shared_ptr(logicalaccess::DESFireEV1Chip);
%shared_ptr(logicalaccess::DESFireEV1Commands);
%shared_ptr(logicalaccess::DESFireEV1ISO7816Commands);
%shared_ptr(logicalaccess::DESFireEV1Location);
%shared_ptr(logicalaccess::DESFireEV1NFCTag4CardService);
%shared_ptr(logicalaccess::DESFireEV1STidSTRCommands);
%shared_ptr(logicalaccess::DESFireEV2Chip);
%shared_ptr(logicalaccess::DESFireEV2Commands);
%shared_ptr(logicalaccess::DESFireEV2Crypto);
%shared_ptr(logicalaccess::DESFireEV2ISO7816Commands);
%shared_ptr(logicalaccess::DESFireISO7816Commands);
%shared_ptr(logicalaccess::DESFireISO7816ResultChecker);
%shared_ptr(logicalaccess::DESFireKey);
%shared_ptr(logicalaccess::DESFireLocation);
%shared_ptr(logicalaccess::DESFireStorageCardService);
%shared_ptr(logicalaccess::DESHelper);
%shared_ptr(logicalaccess::DFName);
%shared_ptr(logicalaccess::DataClockFormat);
%shared_ptr(logicalaccess::DataField);
%shared_ptr(logicalaccess::DataRepresentation);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::DataType);
%shared_ptr(logicalaccess::DeisterBufferParser);
%shared_ptr(logicalaccess::DeisterReaderCardAdapter);
%shared_ptr(logicalaccess::DeisterReaderProvider);
%shared_ptr(logicalaccess::DeisterReaderUnit);
%shared_ptr(logicalaccess::DeisterReaderUnitConfiguration);
%shared_ptr(logicalaccess::DeisterSerialPortDataTransport);
%shared_ptr(logicalaccess::DummyCommands);
%shared_ptr(logicalaccess::EM4102Chip);
%shared_ptr(logicalaccess::EM4135Chip);
%shared_ptr(logicalaccess::EPassAccessInfo);
%shared_ptr(logicalaccess::EPassChip);
%shared_ptr(logicalaccess::EPassCommands);
%shared_ptr(logicalaccess::EPassCrypto);
%shared_ptr(logicalaccess::EPassDG1);
%shared_ptr(logicalaccess::EPassDG2);
%shared_ptr(logicalaccess::EPassDG2::BioInfo);
%shared_ptr(logicalaccess::EPassEFCOM);
%shared_ptr(logicalaccess::EPassISO7816Commands);
%shared_ptr(logicalaccess::EPassIdentityCardService);
%shared_ptr(logicalaccess::EPassUtils);
%shared_ptr(logicalaccess::ElapsedTimeCounter);
%shared_ptr(logicalaccess::ElatecBufferParser);
%shared_ptr(logicalaccess::ElatecReaderCardAdapter);
%shared_ptr(logicalaccess::ElatecReaderProvider);
%shared_ptr(logicalaccess::ElatecReaderUnit);
%shared_ptr(logicalaccess::ElatecReaderUnitConfiguration);
%shared_ptr(logicalaccess::ElatecSerialPortDataTransport);
%shared_ptr(logicalaccess::EncapsulateGuard);
%shared_ptr(logicalaccess::EncapsulateGuard::Adapter);
%shared_ptr(logicalaccess::Encoding);
%shared_ptr(logicalaccess::FASCN200BitFormat);
%shared_ptr(logicalaccess::FeliCaChip);
%shared_ptr(logicalaccess::FeliCaCommands);
%shared_ptr(logicalaccess::FeliCaLocation);
%shared_ptr(logicalaccess::FeliCaSCMCommands);
%shared_ptr(logicalaccess::FeliCaSpringCardCommands);
%shared_ptr(logicalaccess::FeliCaStorageCardService);
%shared_ptr(logicalaccess::Format);
%shared_ptr(logicalaccess::FormatInfos);
%shared_ptr(logicalaccess::GenericTagAccessControlCardService);
%shared_ptr(logicalaccess::GenericTagCardProvider);
%shared_ptr(logicalaccess::GenericTagChip);
%shared_ptr(logicalaccess::GenericTagIdOnDemandAccessControlCardService);
%shared_ptr(logicalaccess::GenericTagIdOnDemandChip);
%shared_ptr(logicalaccess::GenericTagIdOnDemandCommands);
%shared_ptr(logicalaccess::Getronik40BitFormat);
%shared_ptr(logicalaccess::GigaTMSBufferParser);
%shared_ptr(logicalaccess::GigaTMSReaderCardAdapter);
%shared_ptr(logicalaccess::GigaTMSReaderProvider);
%shared_ptr(logicalaccess::GigaTMSReaderUnit);
%shared_ptr(logicalaccess::GigaTMSReaderUnitConfiguration);
%shared_ptr(logicalaccess::GigaTMSSerialPortDataTransport);
%shared_ptr(logicalaccess::GunneboBufferParser);
%shared_ptr(logicalaccess::GunneboReaderCardAdapter);
%shared_ptr(logicalaccess::GunneboReaderProvider);
%shared_ptr(logicalaccess::GunneboReaderUnit);
%shared_ptr(logicalaccess::GunneboReaderUnitConfiguration);
%shared_ptr(logicalaccess::GunneboSerialPortDataTransport);
%shared_ptr(logicalaccess::HIDConstant);
%shared_ptr(logicalaccess::HIDConstant::KeyNumber);
%shared_ptr(logicalaccess::HIDHoneywell40BitFormat);
%shared_ptr(logicalaccess::HIDiClass16KSChip);
%shared_ptr(logicalaccess::HIDiClass2KSChip);
%shared_ptr(logicalaccess::HIDiClass32KS_16_16Chip);
%shared_ptr(logicalaccess::HIDiClass32KS_16_8x2Chip);
%shared_ptr(logicalaccess::HIDiClass32KS_8x2_16Chip);
%shared_ptr(logicalaccess::HIDiClass32KS_8x2_8x2Chip);
%shared_ptr(logicalaccess::HIDiClass8x2KSChip);
%shared_ptr(logicalaccess::HIDiClassAccessControlCardService);
%shared_ptr(logicalaccess::HIDiClassAccessInfo);
%shared_ptr(logicalaccess::HIDiClassCardProvider);
%shared_ptr(logicalaccess::HIDiClassChip);
%shared_ptr(logicalaccess::HIDiClassKey);
%shared_ptr(logicalaccess::HIDiClassLocation);
%shared_ptr(logicalaccess::HIDiClassOmnikeyXX27Commands);
%shared_ptr(logicalaccess::HIDiClassPCSCCommands);
%shared_ptr(logicalaccess::HIDiClassPCSCCommands::SecureModeGuard);
%shared_ptr(logicalaccess::HIDiClassStorageCardService);
%shared_ptr(logicalaccess::HMAC1Key);
%shared_ptr(logicalaccess::IAESCryptoService);
%shared_ptr(logicalaccess::IChip);
%shared_ptr(logicalaccess::ICode1Chip);
%shared_ptr(logicalaccess::ICode2Chip);
%shared_ptr(logicalaccess::ICommands);
%shared_ptr(logicalaccess::ID3ReaderUnit);
%shared_ptr(logicalaccess::ID3ReaderUnit::APDUWrapperGuard);
%shared_ptr(logicalaccess::ID3ReaderUnit::APDUWrapperGuard::Adapter);
%shared_ptr(logicalaccess::ID3ResultChecker);
%shared_ptr(logicalaccess::IKSCryptoWrapper);
%shared_ptr(logicalaccess::IKSException);
%shared_ptr(logicalaccess::IKSStorage);
%shared_ptr(logicalaccess::ISO14443AReaderCommunication);
%shared_ptr(logicalaccess::ISO14443BReaderCommunication);
%shared_ptr(logicalaccess::ISO14443ReaderCommunication);
%shared_ptr(logicalaccess::ISO15693Chip);
%shared_ptr(logicalaccess::ISO15693Commands);
%shared_ptr(logicalaccess::ISO15693Commands::SystemInformation);
%shared_ptr(logicalaccess::ISO15693Location);
%shared_ptr(logicalaccess::ISO15693PCSCCommands);
%shared_ptr(logicalaccess::ISO15693ReaderCommunication);
%shared_ptr(logicalaccess::ISO15693StorageCardService);
%shared_ptr(logicalaccess::ISO24727Crypto);
%shared_ptr(logicalaccess::ISO7816Chip);
%shared_ptr(logicalaccess::ISO7816Commands);
%shared_ptr(logicalaccess::ISO7816FuzzingReaderCardAdapter);
%shared_ptr(logicalaccess::ISO7816ISO7816Commands);
%shared_ptr(logicalaccess::ISO7816Location);
%shared_ptr(logicalaccess::ISO7816NFCTag4CardService);
%shared_ptr(logicalaccess::ISO7816OK5553ReaderCardAdapter);
%shared_ptr(logicalaccess::ISO7816ReaderCardAdapter);
%shared_ptr(logicalaccess::ISO7816ReaderProvider);
%shared_ptr(logicalaccess::ISO7816ReaderUnit);
%shared_ptr(logicalaccess::ISO7816ReaderUnitConfiguration);
%shared_ptr(logicalaccess::ISO7816Response);
%shared_ptr(logicalaccess::ISO7816ResultChecker);
%shared_ptr(logicalaccess::ISO7816StorageCardService);
%shared_ptr(logicalaccess::IdOnDemandReaderCardAdapter);
%shared_ptr(logicalaccess::IdOnDemandReaderProvider);
%shared_ptr(logicalaccess::IdOnDemandReaderUnit);
%shared_ptr(logicalaccess::IdOnDemandReaderUnitConfiguration);
%shared_ptr(logicalaccess::IdentityCardService);
%shared_ptr(logicalaccess::IndalaChip);
%shared_ptr(logicalaccess::InfineonMYDChip);
%shared_ptr(logicalaccess::InitializationVector);
%shared_ptr(logicalaccess::InvalidTLVException);
%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::KeyDiversification);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::LCDDisplay);
%shared_ptr(logicalaccess::LEDBuzzerDisplay);
%shared_ptr(logicalaccess::LegicPrimeChip);
%shared_ptr(logicalaccess::LibLogicalAccessException);
%shared_ptr(logicalaccess::LicenseCheckerService);
%shared_ptr(logicalaccess::Linearizable);
%shared_ptr(logicalaccess::LittleEndianDataRepresentation);
%shared_ptr(logicalaccess::Location);
%shared_ptr(logicalaccess::LocationNode);
%shared_ptr(logicalaccess::LogContext);
%shared_ptr(logicalaccess::LogDisabler);
%shared_ptr(logicalaccess::Logs);
%shared_ptr(logicalaccess::ManchesterEncoder);
%shared_ptr(logicalaccess::Mifare1KChip);
%shared_ptr(logicalaccess::Mifare4KChip);
%shared_ptr(logicalaccess::MifareACR1222LCommands);
%shared_ptr(logicalaccess::MifareAccessInfo);
%shared_ptr(logicalaccess::MifareAccessInfo::SectorAccessBits);
%shared_ptr(logicalaccess::MifareCL1356Commands);
%shared_ptr(logicalaccess::MifareCherryCommands);
%shared_ptr(logicalaccess::MifareChip);
%shared_ptr(logicalaccess::MifareClassicUIDChangerCardService);
%shared_ptr(logicalaccess::MifareCommands);
%shared_ptr(logicalaccess::MifareKey);
%shared_ptr(logicalaccess::MifareLocation);
%shared_ptr(logicalaccess::MifareNFCCommands);
%shared_ptr(logicalaccess::MifareNFCTagCardService);
%shared_ptr(logicalaccess::MifareOK5553Commands);
%shared_ptr(logicalaccess::MifareOmnikeyXX21Commands);
%shared_ptr(logicalaccess::MifareOmnikeyXX27ResultChecker);
%shared_ptr(logicalaccess::MifarePCSCCommands);
%shared_ptr(logicalaccess::MifarePlusACSACR1222L_SL1Commands);
%shared_ptr(logicalaccess::MifarePlusACSACR1222L_SL1Commands::GenericSessionGuard);
%shared_ptr(logicalaccess::MifarePlusACSACR1222L_SL1Commands::GenericSessionGuard::Adapter);
%shared_ptr(logicalaccess::MifarePlusAESAuth);
%shared_ptr(logicalaccess::MifarePlusChip);
%shared_ptr(logicalaccess::MifarePlusISO7816ResultChecker);
%shared_ptr(logicalaccess::MifarePlusLocation);
%shared_ptr(logicalaccess::MifarePlusOmnikeyXX21SL1Commands);
%shared_ptr(logicalaccess::MifarePlusOmnikeyXX21SL1Commands::GenericSessionGuard);
%shared_ptr(logicalaccess::MifarePlusOmnikeyXX21SL1Commands::GenericSessionGuard::Adapter);
%shared_ptr(logicalaccess::MifarePlusSChip);
%shared_ptr(logicalaccess::MifarePlusSL0Chip);
%shared_ptr(logicalaccess::MifarePlusSL0Commands);
%shared_ptr(logicalaccess::MifarePlusSL0_2kChip);
%shared_ptr(logicalaccess::MifarePlusSL0_4kChip);
%shared_ptr(logicalaccess::MifarePlusSL1AccessInfo);
%shared_ptr(logicalaccess::MifarePlusSL1Chip);
%shared_ptr(logicalaccess::MifarePlusSL1Commands);
%shared_ptr(logicalaccess::MifarePlusSL1StorageCardService);
%shared_ptr(logicalaccess::MifarePlusSL1_2kChip);
%shared_ptr(logicalaccess::MifarePlusSL1_4kChip);
%shared_ptr(logicalaccess::MifarePlusSL3Auth);
%shared_ptr(logicalaccess::MifarePlusSL3Chip);
%shared_ptr(logicalaccess::MifarePlusSL3Commands_NEW);
%shared_ptr(logicalaccess::MifarePlusSL3PCSCCommands);
%shared_ptr(logicalaccess::MifarePlusSpringcardAES_SL1_Auth);
%shared_ptr(logicalaccess::MifarePlusSpringcardSL1Commands);
%shared_ptr(logicalaccess::MifarePlusXChip);
%shared_ptr(logicalaccess::MifareSCMCommands);
%shared_ptr(logicalaccess::MifareSTidSTRCommands);
%shared_ptr(logicalaccess::MifareSmartIDCardProvider);
%shared_ptr(logicalaccess::MifareSmartIDCommands);
%shared_ptr(logicalaccess::MifareSmartIDReaderCardAdapter);
%shared_ptr(logicalaccess::MifareSpringCardCommands);
%shared_ptr(logicalaccess::MifareStorageCardService);
%shared_ptr(logicalaccess::MifareUltralightAccessInfo);
%shared_ptr(logicalaccess::MifareUltralightCACSACRCommands);
%shared_ptr(logicalaccess::MifareUltralightCAccessInfo);
%shared_ptr(logicalaccess::MifareUltralightCChip);
%shared_ptr(logicalaccess::MifareUltralightCCommands);
%shared_ptr(logicalaccess::MifareUltralightCOmnikeyXX21Commands);
%shared_ptr(logicalaccess::MifareUltralightCOmnikeyXX22Commands);
%shared_ptr(logicalaccess::MifareUltralightCPCSCCommands);
%shared_ptr(logicalaccess::MifareUltralightCSpringCardCommands);
%shared_ptr(logicalaccess::MifareUltralightCStorageCardService);
%shared_ptr(logicalaccess::MifareUltralightChip);
%shared_ptr(logicalaccess::MifareUltralightCommands);
%shared_ptr(logicalaccess::MifareUltralightLocation);
%shared_ptr(logicalaccess::MifareUltralightOK5553Commands);
%shared_ptr(logicalaccess::MifareUltralightPCSCCommands);
%shared_ptr(logicalaccess::MifareUltralightStorageCardService);
%shared_ptr(logicalaccess::MifareUltralightUIDChangerCardService);
%shared_ptr(logicalaccess::MyDivInfo);
%shared_ptr(logicalaccess::NFCDataTransport);
%shared_ptr(logicalaccess::NFCReaderCardAdapter);
%shared_ptr(logicalaccess::NFCReaderProvider);
%shared_ptr(logicalaccess::NFCReaderUnit);
%shared_ptr(logicalaccess::NFCReaderUnit::WriteUIDConfigGuard);
%shared_ptr(logicalaccess::NFCReaderUnitConfiguration);
%shared_ptr(logicalaccess::NFCTag1CardService);
%shared_ptr(logicalaccess::NFCTag2CardService);
%shared_ptr(logicalaccess::NFCTag3CardService);
%shared_ptr(logicalaccess::NFCTagCardService);
%shared_ptr(logicalaccess::NXPAV1KeyDiversification);
%shared_ptr(logicalaccess::NXPAV2KeyDiversification);
%shared_ptr(logicalaccess::NXPKeyDiversification);
%shared_ptr(logicalaccess::NdefMessage);
%shared_ptr(logicalaccess::NdefRecord);
%shared_ptr(logicalaccess::NoDataRepresentation);
%shared_ptr(logicalaccess::NumberDataField);
%shared_ptr(logicalaccess::OK5553ReaderCardAdapter);
%shared_ptr(logicalaccess::OK5553ReaderProvider);
%shared_ptr(logicalaccess::OK5553ReaderUnit);
%shared_ptr(logicalaccess::OK5553ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OSDPBufferParser);
%shared_ptr(logicalaccess::OSDPChannel);
%shared_ptr(logicalaccess::OSDPCommands);
%shared_ptr(logicalaccess::OSDPRReaderProvider);
%shared_ptr(logicalaccess::OSDPReaderCardAdapter);
%shared_ptr(logicalaccess::OSDPReaderProvider);
%shared_ptr(logicalaccess::OSDPReaderUnit);
%shared_ptr(logicalaccess::OSDPReaderUnitConfiguration);
%shared_ptr(logicalaccess::OSDPSecureChannel);
%shared_ptr(logicalaccess::OSDPSerialPortDataTransport);
%shared_ptr(logicalaccess::Omnikey5023AccessControlCardService);
%shared_ptr(logicalaccess::Omnikey5427ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OmnikeyHIDiClassDataTransport);
%shared_ptr(logicalaccess::OmnikeyLANXX21ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnit::SecureModeStatus);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OmnikeyXX22ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX23ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX25ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX27AccessControlCardService);
%shared_ptr(logicalaccess::OmnikeyXX27ReaderUnit);
%shared_ptr(logicalaccess::OmnitechKeyDiversification);
%shared_ptr(logicalaccess::PCSCConnection);
%shared_ptr(logicalaccess::PCSCControlDataTransport);
%shared_ptr(logicalaccess::PCSCDataTransport);
%shared_ptr(logicalaccess::PCSCHIDiClassDataTransport);
%shared_ptr(logicalaccess::PCSCReaderCardAdapter);
%shared_ptr(logicalaccess::PCSCReaderProvider);
%shared_ptr(logicalaccess::PCSCReaderUnit);
%shared_ptr(logicalaccess::PCSCReaderUnitConfiguration);
%shared_ptr(logicalaccess::PKCSKeyStorage);
%shared_ptr(logicalaccess::ParityDataField);
%shared_ptr(logicalaccess::PicoPassCommands);
%shared_ptr(logicalaccess::PicoPassSimpleCommands);
%shared_ptr(logicalaccess::Profile);
%shared_ptr(logicalaccess::PromagBufferParser);
%shared_ptr(logicalaccess::PromagReaderCardAdapter);
%shared_ptr(logicalaccess::PromagReaderProvider);
%shared_ptr(logicalaccess::PromagReaderUnit);
%shared_ptr(logicalaccess::PromagReaderUnitConfiguration);
%shared_ptr(logicalaccess::PromagSerialPortDataTransport);
%shared_ptr(logicalaccess::ProxAccessControlCardService);
%shared_ptr(logicalaccess::ProxChip);
%shared_ptr(logicalaccess::ProxLiteChip);
%shared_ptr(logicalaccess::ProxLocation);
%shared_ptr(logicalaccess::RandomHelper);
%shared_ptr(logicalaccess::RawFormat);
%shared_ptr(logicalaccess::ReaderCardAdapter);
%shared_ptr(logicalaccess::ReaderCommunication);
%shared_ptr(logicalaccess::ReaderConfiguration);
%shared_ptr(logicalaccess::ReaderFormatComposite);
%shared_ptr(logicalaccess::ReaderMemoryKeyStorage);
%shared_ptr(logicalaccess::ReaderProvider);
%shared_ptr(logicalaccess::ReaderService);
%shared_ptr(logicalaccess::ReaderUnit);
%shared_ptr(logicalaccess::ReaderUnitConfiguration);
%shared_ptr(logicalaccess::RemoteCrypto);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::RplethDataTransport);
%shared_ptr(logicalaccess::RplethLCDDisplay);
%shared_ptr(logicalaccess::RplethLEDBuzzerDisplay);
%shared_ptr(logicalaccess::RplethReaderCardAdapter);
%shared_ptr(logicalaccess::RplethReaderProvider);
%shared_ptr(logicalaccess::RplethReaderUnit);
%shared_ptr(logicalaccess::RplethReaderUnitConfiguration);
%shared_ptr(logicalaccess::SAMAV1Chip);
%shared_ptr(logicalaccess::SAMAV1ISO7816Commands);
%shared_ptr(logicalaccess::SAMAV2Chip);
%shared_ptr(logicalaccess::SAMAV2ISO7816Commands);
%shared_ptr(logicalaccess::SAMBasicKeyEntry);
%shared_ptr(logicalaccess::SAMChip);
%shared_ptr(logicalaccess::SAMDESfireCrypto);
%shared_ptr(logicalaccess::SAMISO7816ResultChecker);
%shared_ptr(logicalaccess::SAMKeyStorage);
%shared_ptr(logicalaccess::SAMKucEntry);
%shared_ptr(logicalaccess::SCIELReaderCardAdapter);
%shared_ptr(logicalaccess::SCIELReaderProvider);
%shared_ptr(logicalaccess::SCIELReaderUnit);
%shared_ptr(logicalaccess::SCIELReaderUnit::Finder);
%shared_ptr(logicalaccess::SCIELReaderUnitConfiguration);
%shared_ptr(logicalaccess::SCMReaderUnit);
%shared_ptr(logicalaccess::SEProcessorChip);
%shared_ptr(logicalaccess::SEProcessorCommands);
%shared_ptr(logicalaccess::SEProcessorCrypto);
%shared_ptr(logicalaccess::SEProcessorISO7816Commands);
%shared_ptr(logicalaccess::SEProcessorMessageHeader);
%shared_ptr(logicalaccess::SEProcessorOmnikeyXX27Commands);
%shared_ptr(logicalaccess::SIO::AsymmetricAlgoId);
%shared_ptr(logicalaccess::SIO::CryptoContext);
%shared_ptr(logicalaccess::SIO::Identifier);
%shared_ptr(logicalaccess::SIO::License);
%shared_ptr(logicalaccess::SIO::SecureObject);
%shared_ptr(logicalaccess::SIO::SymmetricAlgoId);
%shared_ptr(logicalaccess::STidPRGBufferParser);
%shared_ptr(logicalaccess::STidPRGProxAccessControlCardService);
%shared_ptr(logicalaccess::STidPRGReaderCardAdapter);
%shared_ptr(logicalaccess::STidPRGReaderProvider);
%shared_ptr(logicalaccess::STidPRGReaderUnit);
%shared_ptr(logicalaccess::STidPRGReaderUnit::BuzzerModeGuard);
%shared_ptr(logicalaccess::STidPRGReaderUnitConfiguration);
%shared_ptr(logicalaccess::STidPRGResultChecker);
%shared_ptr(logicalaccess::STidPRGSerialPortDataTransport);
%shared_ptr(logicalaccess::STidPRGUtils);
%shared_ptr(logicalaccess::STidSTRBufferParser);
%shared_ptr(logicalaccess::STidSTRLEDBuzzerDisplay);
%shared_ptr(logicalaccess::STidSTRReaderCardAdapter);
%shared_ptr(logicalaccess::STidSTRReaderProvider);
%shared_ptr(logicalaccess::STidSTRReaderUnit);
%shared_ptr(logicalaccess::STidSTRReaderUnit::STidSTRInformation);
%shared_ptr(logicalaccess::STidSTRReaderUnitConfiguration);
%shared_ptr(logicalaccess::STidSTRSerialPortDataTransport);
%shared_ptr(logicalaccess::SagemKeyDiversification);
%shared_ptr(logicalaccess::ScielBufferParser);
%shared_ptr(logicalaccess::ScielSerialPortDataTransport);
%shared_ptr(logicalaccess::SeosAccessInfo);
%shared_ptr(logicalaccess::SeosChip);
%shared_ptr(logicalaccess::SeosCommands);
%shared_ptr(logicalaccess::SeosCrypto);
%shared_ptr(logicalaccess::SeosFormat);
%shared_ptr(logicalaccess::SeosISO7816Commands);
%shared_ptr(logicalaccess::SeosKey);
%shared_ptr(logicalaccess::SeosLocation);
%shared_ptr(logicalaccess::SeosSEAccessControlCardService);
%shared_ptr(logicalaccess::SeosValueAccessInfo);
%shared_ptr(logicalaccess::SerialPort);
%shared_ptr(logicalaccess::SerialPortDataTransport);
%shared_ptr(logicalaccess::SerialPortXml);
%shared_ptr(logicalaccess::SignatureHelper);
%shared_ptr(logicalaccess::SignatureResult);
%shared_ptr(logicalaccess::SignatureResult::Description);
%shared_ptr(logicalaccess::SmartFrameChip);
%shared_ptr(logicalaccess::SmartIDLEDBuzzerDisplay);
%shared_ptr(logicalaccess::SmartIDReaderCardAdapter);
%shared_ptr(logicalaccess::SmartIDReaderProvider);
%shared_ptr(logicalaccess::SmartIDReaderUnit);
%shared_ptr(logicalaccess::SmartIDReaderUnitConfiguration);
%shared_ptr(logicalaccess::SpringCardReaderUnit);
%shared_ptr(logicalaccess::SpringCardResultChecker);
%shared_ptr(logicalaccess::StaticFormat);
%shared_ptr(logicalaccess::StmLri512Chip);
%shared_ptr(logicalaccess::StorageCardService);
%shared_ptr(logicalaccess::StringDataField);
%shared_ptr(logicalaccess::TCPDataTransport);
%shared_ptr(logicalaccess::TLV);
%shared_ptr(logicalaccess::TagItChip);
%shared_ptr(logicalaccess::TagItCommands);
%shared_ptr(logicalaccess::TopazACSACRCommands);
%shared_ptr(logicalaccess::TopazAccessInfo);
%shared_ptr(logicalaccess::TopazChip);
%shared_ptr(logicalaccess::TopazCommands);
%shared_ptr(logicalaccess::TopazLocation);
%shared_ptr(logicalaccess::TopazOmnikeyXX27Commands);
%shared_ptr(logicalaccess::TopazPCSCCommands);
%shared_ptr(logicalaccess::TopazSCMCommands);
%shared_ptr(logicalaccess::TopazStorageCardService);
%shared_ptr(logicalaccess::TripleDESKey);
%shared_ptr(logicalaccess::TwicAccessControlCardService);
%shared_ptr(logicalaccess::TwicCardProvider);
%shared_ptr(logicalaccess::TwicChip);
%shared_ptr(logicalaccess::TwicCommands);
%shared_ptr(logicalaccess::TwicISO7816Commands);
%shared_ptr(logicalaccess::TwicLocation);
%shared_ptr(logicalaccess::TwicProfile);
%shared_ptr(logicalaccess::TwicStorageCardService);
%shared_ptr(logicalaccess::UDPDataTransport);
%shared_ptr(logicalaccess::UIDChangerCardService);
%shared_ptr(logicalaccess::ValueDataField);
%shared_ptr(logicalaccess::Wiegand26Format);
%shared_ptr(logicalaccess::Wiegand34Format);
%shared_ptr(logicalaccess::Wiegand34WithFacilityFormat);
%shared_ptr(logicalaccess::Wiegand35Format);
%shared_ptr(logicalaccess::Wiegand37Format);
%shared_ptr(logicalaccess::Wiegand37WithFacilityFormat);
%shared_ptr(logicalaccess::Wiegand37WithFacilityRightParity2Format);
%shared_ptr(logicalaccess::WiegandFormat);
%shared_ptr(logicalaccess::XmlSerializable);
%shared_ptr(logicalaccess::iks::IslogKeyServer);
%shared_ptr(logicalaccess::iks::IslogKeyServer::IKSConfig);
%shared_ptr(logicalaccess::openssl::AESCipher);
%shared_ptr(logicalaccess::openssl::AESInitializationVector);
%shared_ptr(logicalaccess::openssl::AESSymmetricKey);
%shared_ptr(logicalaccess::openssl::CMACCrypto);
%shared_ptr(logicalaccess::openssl::DESCipher);
%shared_ptr(logicalaccess::openssl::DESInitializationVector);
%shared_ptr(logicalaccess::openssl::DESSymmetricKey);
%shared_ptr(logicalaccess::openssl::InitializationVector);
%shared_ptr(logicalaccess::openssl::OpenSSLException);
%shared_ptr(logicalaccess::openssl::OpenSSLInitializer);
%shared_ptr(logicalaccess::openssl::OpenSSLSymmetricCipher);
%shared_ptr(logicalaccess::openssl::OpenSSLSymmetricCipherContext);
%shared_ptr(logicalaccess::openssl::OpenSSLSymmetricCipherContext::Information);
%shared_ptr(logicalaccess::openssl::SymmetricCipher);
%shared_ptr(logicalaccess::openssl::SymmetricKey);
%shared_ptr(logicalaccess::s_EXTSET);
%shared_ptr(logicalaccess::s_KeyEntryAV1Information);
%shared_ptr(logicalaccess::s_KeyEntryAV2Information);
%shared_ptr(logicalaccess::s_KeyEntryUpdateSettings);
%shared_ptr(logicalaccess::s_KucEntryUpdateSettings);
%shared_ptr(logicalaccess::s_SAMKUCEntry);
%shared_ptr(logicalaccess::s_SAMManufactureInformation);
%shared_ptr(logicalaccess::s_SAMVersion);
%shared_ptr(logicalaccess::s_SAMVersionInformation);
%shared_ptr(logicalaccess::s_SETAV1);
%shared_ptr(logicalaccess::s_SETAV2);
%shared_ptr(logicalaccess::s_changeKeyDiversification);
%shared_ptr(logicalaccess::s_changeKeyInfo);
%shared_ptr(logicalaccess::se::AlgoInfo);
%shared_ptr(logicalaccess::t_buz_cmd);
%shared_ptr(logicalaccess::t_led_cmd);
%shared_ptr(A3MLGM5600LCDDisplay);
%shared_ptr(A3MLGM5600LEDBuzzerDisplay);
%shared_ptr(A3MLGM5600ReaderCardAdapter);
%shared_ptr(A3MLGM5600ReaderProvider);
%shared_ptr(A3MLGM5600ReaderUnit);
%shared_ptr(A3MLGM5600ReaderUnitConfiguration);
%shared_ptr(ACSACR1222LLCDDisplay);
%shared_ptr(ACSACR1222LLEDBuzzerDisplay);
%shared_ptr(ACSACR1222LReaderUnit);
%shared_ptr(ACSACR1222LReaderUnitConfiguration);
%shared_ptr(ACSACRReaderUnit);
%shared_ptr(ACSACRResultChecker);
%shared_ptr(AES128Key);
%shared_ptr(AESCryptoService);
%shared_ptr(AESHelper);
%shared_ptr(ASCIIFormat);
%shared_ptr(ASN1);
%shared_ptr(ATRParser);
%shared_ptr(ATRParser::ATRInfo);
%shared_ptr(AccessControlCardService);
%shared_ptr(AccessInfo);
%shared_ptr(AdmittoBufferParser);
%shared_ptr(AdmittoReaderCardAdapter);
%shared_ptr(AdmittoReaderProvider);
%shared_ptr(AdmittoReaderUnit);
%shared_ptr(AdmittoReaderUnitConfiguration);
%shared_ptr(AdmittoSerialPortDataTransport);
%shared_ptr(AxessTMC13BufferParser);
%shared_ptr(AxessTMC13ReaderCardAdapter);
%shared_ptr(AxessTMC13ReaderProvider);
%shared_ptr(AxessTMC13ReaderUnit);
%shared_ptr(AxessTMC13ReaderUnitConfiguration);
%shared_ptr(AxessTMC13SerialPortDataTransport);
%shared_ptr(AxessTMCLegicBufferParser);
%shared_ptr(AxessTMCLegicReaderCardAdapter);
%shared_ptr(AxessTMCLegicReaderProvider);
%shared_ptr(AxessTMCLegicReaderUnit);
%shared_ptr(AxessTMCLegicReaderUnitConfiguration);
%shared_ptr(AxessTMCLegicSerialPortDataTransport);
%shared_ptr(BCDByteDataType);
%shared_ptr(BCDNibbleDataType);
%shared_ptr(BariumFerritePCSCFormat);
%shared_ptr(BigEndianDataRepresentation);
%shared_ptr(BinaryDataField);
%shared_ptr(BinaryDataType);
%shared_ptr(BinaryFieldValue);
%shared_ptr(BitHelper);
%shared_ptr(BitsetStream);
%shared_ptr(BufferHelper);
%shared_ptr(CL1356PlusUtils);
%shared_ptr(CL1356PlusUtils::CardCount);
%shared_ptr(CL1356PlusUtils::Info);
%shared_ptr(CPS3Chip);
%shared_ptr(CPS3Commands);
%shared_ptr(CPS3Location);
%shared_ptr(CPS3StorageCardService);
%shared_ptr(CardException);
%shared_ptr(CardProbe);
%shared_ptr(CardService);
%shared_ptr(CardsFormatComposite);
%shared_ptr(ChecksumDataField);
%shared_ptr(CherryReaderUnit);
%shared_ptr(Chip);
%shared_ptr(CircularBufferParser);
%shared_ptr(Commands);
%shared_ptr(ComputerMemoryKeyStorage);
%shared_ptr(CustomFormat);
%shared_ptr(DESFireAccessInfo);
%shared_ptr(DESFireAccessRights);
%shared_ptr(DESFireChip);
%shared_ptr(DESFireCommands);
%shared_ptr(DESFireCommands::DESFireCardVersion);
%shared_ptr(DESFireCommands::DataFileSetting);
%shared_ptr(DESFireCommands::FileSetting);
%shared_ptr(DESFireCommands::RecordFileSetting);
%shared_ptr(DESFireCommands::ValueFileSetting);
%shared_ptr(DESFireCrypto);
%shared_ptr(DESFireEV1Chip);
%shared_ptr(DESFireEV1Commands);
%shared_ptr(DESFireEV1ISO7816Commands);
%shared_ptr(DESFireEV1Location);
%shared_ptr(DESFireEV1NFCTag4CardService);
%shared_ptr(DESFireEV1STidSTRCommands);
%shared_ptr(DESFireEV2Chip);
%shared_ptr(DESFireEV2Commands);
%shared_ptr(DESFireEV2Crypto);
%shared_ptr(DESFireEV2ISO7816Commands);
%shared_ptr(DESFireISO7816Commands);
%shared_ptr(DESFireISO7816ResultChecker);
%shared_ptr(DESFireKey);
%shared_ptr(DESFireLocation);
%shared_ptr(DESFireStorageCardService);
%shared_ptr(DESHelper);
%shared_ptr(DFName);
%shared_ptr(DataClockFormat);
%shared_ptr(DataField);
%shared_ptr(DataRepresentation);
%shared_ptr(DataTransport);
%shared_ptr(DataType);
%shared_ptr(DeisterBufferParser);
%shared_ptr(DeisterReaderCardAdapter);
%shared_ptr(DeisterReaderProvider);
%shared_ptr(DeisterReaderUnit);
%shared_ptr(DeisterReaderUnitConfiguration);
%shared_ptr(DeisterSerialPortDataTransport);
%shared_ptr(DummyCommands);
%shared_ptr(EM4102Chip);
%shared_ptr(EM4135Chip);
%shared_ptr(EPassAccessInfo);
%shared_ptr(EPassChip);
%shared_ptr(EPassCommands);
%shared_ptr(EPassCrypto);
%shared_ptr(EPassDG1);
%shared_ptr(EPassDG2);
%shared_ptr(EPassDG2::BioInfo);
%shared_ptr(EPassEFCOM);
%shared_ptr(EPassISO7816Commands);
%shared_ptr(EPassIdentityCardService);
%shared_ptr(EPassUtils);
%shared_ptr(ElapsedTimeCounter);
%shared_ptr(ElatecBufferParser);
%shared_ptr(ElatecReaderCardAdapter);
%shared_ptr(ElatecReaderProvider);
%shared_ptr(ElatecReaderUnit);
%shared_ptr(ElatecReaderUnitConfiguration);
%shared_ptr(ElatecSerialPortDataTransport);
%shared_ptr(EncapsulateGuard);
%shared_ptr(EncapsulateGuard::Adapter);
%shared_ptr(Encoding);
%shared_ptr(FASCN200BitFormat);
%shared_ptr(FeliCaChip);
%shared_ptr(FeliCaCommands);
%shared_ptr(FeliCaLocation);
%shared_ptr(FeliCaSCMCommands);
%shared_ptr(FeliCaSpringCardCommands);
%shared_ptr(FeliCaStorageCardService);
%shared_ptr(Format);
%shared_ptr(FormatInfos);
%shared_ptr(GenericTagAccessControlCardService);
%shared_ptr(GenericTagCardProvider);
%shared_ptr(GenericTagChip);
%shared_ptr(GenericTagIdOnDemandAccessControlCardService);
%shared_ptr(GenericTagIdOnDemandChip);
%shared_ptr(GenericTagIdOnDemandCommands);
%shared_ptr(Getronik40BitFormat);
%shared_ptr(GigaTMSBufferParser);
%shared_ptr(GigaTMSReaderCardAdapter);
%shared_ptr(GigaTMSReaderProvider);
%shared_ptr(GigaTMSReaderUnit);
%shared_ptr(GigaTMSReaderUnitConfiguration);
%shared_ptr(GigaTMSSerialPortDataTransport);
%shared_ptr(GunneboBufferParser);
%shared_ptr(GunneboReaderCardAdapter);
%shared_ptr(GunneboReaderProvider);
%shared_ptr(GunneboReaderUnit);
%shared_ptr(GunneboReaderUnitConfiguration);
%shared_ptr(GunneboSerialPortDataTransport);
%shared_ptr(HIDConstant);
%shared_ptr(HIDConstant::KeyNumber);
%shared_ptr(HIDHoneywell40BitFormat);
%shared_ptr(HIDiClass16KSChip);
%shared_ptr(HIDiClass2KSChip);
%shared_ptr(HIDiClass32KS_16_16Chip);
%shared_ptr(HIDiClass32KS_16_8x2Chip);
%shared_ptr(HIDiClass32KS_8x2_16Chip);
%shared_ptr(HIDiClass32KS_8x2_8x2Chip);
%shared_ptr(HIDiClass8x2KSChip);
%shared_ptr(HIDiClassAccessControlCardService);
%shared_ptr(HIDiClassAccessInfo);
%shared_ptr(HIDiClassCardProvider);
%shared_ptr(HIDiClassChip);
%shared_ptr(HIDiClassKey);
%shared_ptr(HIDiClassLocation);
%shared_ptr(HIDiClassOmnikeyXX27Commands);
%shared_ptr(HIDiClassPCSCCommands);
%shared_ptr(HIDiClassPCSCCommands::SecureModeGuard);
%shared_ptr(HIDiClassStorageCardService);
%shared_ptr(HMAC1Key);
%shared_ptr(IAESCryptoService);
%shared_ptr(IChip);
%shared_ptr(ICode1Chip);
%shared_ptr(ICode2Chip);
%shared_ptr(ICommands);
%shared_ptr(ID3ReaderUnit);
%shared_ptr(ID3ReaderUnit::APDUWrapperGuard);
%shared_ptr(ID3ReaderUnit::APDUWrapperGuard::Adapter);
%shared_ptr(ID3ResultChecker);
%shared_ptr(IKSCryptoWrapper);
%shared_ptr(IKSException);
%shared_ptr(IKSStorage);
%shared_ptr(ISO14443AReaderCommunication);
%shared_ptr(ISO14443BReaderCommunication);
%shared_ptr(ISO14443ReaderCommunication);
%shared_ptr(ISO15693Chip);
%shared_ptr(ISO15693Commands);
%shared_ptr(ISO15693Commands::SystemInformation);
%shared_ptr(ISO15693Location);
%shared_ptr(ISO15693PCSCCommands);
%shared_ptr(ISO15693ReaderCommunication);
%shared_ptr(ISO15693StorageCardService);
%shared_ptr(ISO24727Crypto);
%shared_ptr(ISO7816Chip);
%shared_ptr(ISO7816Commands);
%shared_ptr(ISO7816FuzzingReaderCardAdapter);
%shared_ptr(ISO7816ISO7816Commands);
%shared_ptr(ISO7816Location);
%shared_ptr(ISO7816NFCTag4CardService);
%shared_ptr(ISO7816OK5553ReaderCardAdapter);
%shared_ptr(ISO7816ReaderCardAdapter);
%shared_ptr(ISO7816ReaderProvider);
%shared_ptr(ISO7816ReaderUnit);
%shared_ptr(ISO7816ReaderUnitConfiguration);
%shared_ptr(ISO7816Response);
%shared_ptr(ISO7816ResultChecker);
%shared_ptr(ISO7816StorageCardService);
%shared_ptr(IdOnDemandReaderCardAdapter);
%shared_ptr(IdOnDemandReaderProvider);
%shared_ptr(IdOnDemandReaderUnit);
%shared_ptr(IdOnDemandReaderUnitConfiguration);
%shared_ptr(IdentityCardService);
%shared_ptr(IndalaChip);
%shared_ptr(InfineonMYDChip);
%shared_ptr(InitializationVector);
%shared_ptr(InvalidTLVException);
%shared_ptr(Key);
%shared_ptr(KeyDiversification);
%shared_ptr(KeyStorage);
%shared_ptr(LCDDisplay);
%shared_ptr(LEDBuzzerDisplay);
%shared_ptr(LegicPrimeChip);
%shared_ptr(LibLogicalAccessException);
%shared_ptr(LicenseCheckerService);
%shared_ptr(Linearizable);
%shared_ptr(LittleEndianDataRepresentation);
%shared_ptr(Location);
%shared_ptr(LocationNode);
%shared_ptr(LogContext);
%shared_ptr(LogDisabler);
%shared_ptr(Logs);
%shared_ptr(ManchesterEncoder);
%shared_ptr(Mifare1KChip);
%shared_ptr(Mifare4KChip);
%shared_ptr(MifareACR1222LCommands);
%shared_ptr(MifareAccessInfo);
%shared_ptr(MifareAccessInfo::SectorAccessBits);
%shared_ptr(MifareCL1356Commands);
%shared_ptr(MifareCherryCommands);
%shared_ptr(MifareChip);
%shared_ptr(MifareClassicUIDChangerCardService);
%shared_ptr(MifareCommands);
%shared_ptr(MifareKey);
%shared_ptr(MifareLocation);
%shared_ptr(MifareNFCCommands);
%shared_ptr(MifareNFCTagCardService);
%shared_ptr(MifareOK5553Commands);
%shared_ptr(MifareOmnikeyXX21Commands);
%shared_ptr(MifareOmnikeyXX27ResultChecker);
%shared_ptr(MifarePCSCCommands);
%shared_ptr(MifarePlusACSACR1222L_SL1Commands);
%shared_ptr(MifarePlusACSACR1222L_SL1Commands::GenericSessionGuard);
%shared_ptr(MifarePlusACSACR1222L_SL1Commands::GenericSessionGuard::Adapter);
%shared_ptr(MifarePlusAESAuth);
%shared_ptr(MifarePlusChip);
%shared_ptr(MifarePlusISO7816ResultChecker);
%shared_ptr(MifarePlusLocation);
%shared_ptr(MifarePlusOmnikeyXX21SL1Commands);
%shared_ptr(MifarePlusOmnikeyXX21SL1Commands::GenericSessionGuard);
%shared_ptr(MifarePlusOmnikeyXX21SL1Commands::GenericSessionGuard::Adapter);
%shared_ptr(MifarePlusSChip);
%shared_ptr(MifarePlusSL0Chip);
%shared_ptr(MifarePlusSL0Commands);
%shared_ptr(MifarePlusSL0_2kChip);
%shared_ptr(MifarePlusSL0_4kChip);
%shared_ptr(MifarePlusSL1AccessInfo);
%shared_ptr(MifarePlusSL1Chip);
%shared_ptr(MifarePlusSL1Commands);
%shared_ptr(MifarePlusSL1StorageCardService);
%shared_ptr(MifarePlusSL1_2kChip);
%shared_ptr(MifarePlusSL1_4kChip);
%shared_ptr(MifarePlusSL3Auth);
%shared_ptr(MifarePlusSL3Chip);
%shared_ptr(MifarePlusSL3Commands_NEW);
%shared_ptr(MifarePlusSL3PCSCCommands);
%shared_ptr(MifarePlusSpringcardAES_SL1_Auth);
%shared_ptr(MifarePlusSpringcardSL1Commands);
%shared_ptr(MifarePlusXChip);
%shared_ptr(MifareSCMCommands);
%shared_ptr(MifareSTidSTRCommands);
%shared_ptr(MifareSmartIDCardProvider);
%shared_ptr(MifareSmartIDCommands);
%shared_ptr(MifareSmartIDReaderCardAdapter);
%shared_ptr(MifareSpringCardCommands);
%shared_ptr(MifareStorageCardService);
%shared_ptr(MifareUltralightAccessInfo);
%shared_ptr(MifareUltralightCACSACRCommands);
%shared_ptr(MifareUltralightCAccessInfo);
%shared_ptr(MifareUltralightCChip);
%shared_ptr(MifareUltralightCCommands);
%shared_ptr(MifareUltralightCOmnikeyXX21Commands);
%shared_ptr(MifareUltralightCOmnikeyXX22Commands);
%shared_ptr(MifareUltralightCPCSCCommands);
%shared_ptr(MifareUltralightCSpringCardCommands);
%shared_ptr(MifareUltralightCStorageCardService);
%shared_ptr(MifareUltralightChip);
%shared_ptr(MifareUltralightCommands);
%shared_ptr(MifareUltralightLocation);
%shared_ptr(MifareUltralightOK5553Commands);
%shared_ptr(MifareUltralightPCSCCommands);
%shared_ptr(MifareUltralightStorageCardService);
%shared_ptr(MifareUltralightUIDChangerCardService);
%shared_ptr(MyDivInfo);
%shared_ptr(NFCDataTransport);
%shared_ptr(NFCReaderCardAdapter);
%shared_ptr(NFCReaderProvider);
%shared_ptr(NFCReaderUnit);
%shared_ptr(NFCReaderUnit::WriteUIDConfigGuard);
%shared_ptr(NFCReaderUnitConfiguration);
%shared_ptr(NFCTag1CardService);
%shared_ptr(NFCTag2CardService);
%shared_ptr(NFCTag3CardService);
%shared_ptr(NFCTagCardService);
%shared_ptr(NXPAV1KeyDiversification);
%shared_ptr(NXPAV2KeyDiversification);
%shared_ptr(NXPKeyDiversification);
%shared_ptr(NdefMessage);
%shared_ptr(NdefRecord);
%shared_ptr(NoDataRepresentation);
%shared_ptr(NumberDataField);
%shared_ptr(OK5553ReaderCardAdapter);
%shared_ptr(OK5553ReaderProvider);
%shared_ptr(OK5553ReaderUnit);
%shared_ptr(OK5553ReaderUnitConfiguration);
%shared_ptr(OSDPBufferParser);
%shared_ptr(OSDPChannel);
%shared_ptr(OSDPCommands);
%shared_ptr(OSDPRReaderProvider);
%shared_ptr(OSDPReaderCardAdapter);
%shared_ptr(OSDPReaderProvider);
%shared_ptr(OSDPReaderUnit);
%shared_ptr(OSDPReaderUnitConfiguration);
%shared_ptr(OSDPSecureChannel);
%shared_ptr(OSDPSerialPortDataTransport);
%shared_ptr(Omnikey5023AccessControlCardService);
%shared_ptr(Omnikey5427ReaderUnitConfiguration);
%shared_ptr(OmnikeyHIDiClassDataTransport);
%shared_ptr(OmnikeyLANXX21ReaderUnit);
%shared_ptr(OmnikeyReaderUnit);
%shared_ptr(OmnikeyXX21ReaderUnit);
%shared_ptr(OmnikeyXX21ReaderUnit::SecureModeStatus);
%shared_ptr(OmnikeyXX21ReaderUnitConfiguration);
%shared_ptr(OmnikeyXX22ReaderUnit);
%shared_ptr(OmnikeyXX23ReaderUnit);
%shared_ptr(OmnikeyXX25ReaderUnit);
%shared_ptr(OmnikeyXX27AccessControlCardService);
%shared_ptr(OmnikeyXX27ReaderUnit);
%shared_ptr(OmnitechKeyDiversification);
%shared_ptr(PCSCConnection);
%shared_ptr(PCSCControlDataTransport);
%shared_ptr(PCSCDataTransport);
%shared_ptr(PCSCHIDiClassDataTransport);
%shared_ptr(PCSCReaderCardAdapter);
%shared_ptr(PCSCReaderProvider);
%shared_ptr(PCSCReaderUnit);
%shared_ptr(PCSCReaderUnitConfiguration);
%shared_ptr(PKCSKeyStorage);
%shared_ptr(ParityDataField);
%shared_ptr(PicoPassCommands);
%shared_ptr(PicoPassSimpleCommands);
%shared_ptr(Profile);
%shared_ptr(PromagBufferParser);
%shared_ptr(PromagReaderCardAdapter);
%shared_ptr(PromagReaderProvider);
%shared_ptr(PromagReaderUnit);
%shared_ptr(PromagReaderUnitConfiguration);
%shared_ptr(PromagSerialPortDataTransport);
%shared_ptr(ProxAccessControlCardService);
%shared_ptr(ProxChip);
%shared_ptr(ProxLiteChip);
%shared_ptr(ProxLocation);
%shared_ptr(RandomHelper);
%shared_ptr(RawFormat);
%shared_ptr(ReaderCardAdapter);
%shared_ptr(ReaderCommunication);
%shared_ptr(ReaderConfiguration);
%shared_ptr(ReaderFormatComposite);
%shared_ptr(ReaderMemoryKeyStorage);
%shared_ptr(ReaderProvider);
%shared_ptr(ReaderService);
%shared_ptr(ReaderUnit);
%shared_ptr(ReaderUnitConfiguration);
%shared_ptr(RemoteCrypto);
%shared_ptr(ResultChecker);
%shared_ptr(RplethDataTransport);
%shared_ptr(RplethLCDDisplay);
%shared_ptr(RplethLEDBuzzerDisplay);
%shared_ptr(RplethReaderCardAdapter);
%shared_ptr(RplethReaderProvider);
%shared_ptr(RplethReaderUnit);
%shared_ptr(RplethReaderUnitConfiguration);
%shared_ptr(SAMAV1Chip);
%shared_ptr(SAMAV1ISO7816Commands);
%shared_ptr(SAMAV2Chip);
%shared_ptr(SAMAV2ISO7816Commands);
%shared_ptr(SAMBasicKeyEntry);
%shared_ptr(SAMChip);
%shared_ptr(SAMDESfireCrypto);
%shared_ptr(SAMISO7816ResultChecker);
%shared_ptr(SAMKeyStorage);
%shared_ptr(SAMKucEntry);
%shared_ptr(SCIELReaderCardAdapter);
%shared_ptr(SCIELReaderProvider);
%shared_ptr(SCIELReaderUnit);
%shared_ptr(SCIELReaderUnit::Finder);
%shared_ptr(SCIELReaderUnitConfiguration);
%shared_ptr(SCMReaderUnit);
%shared_ptr(SEProcessorChip);
%shared_ptr(SEProcessorCommands);
%shared_ptr(SEProcessorCrypto);
%shared_ptr(SEProcessorISO7816Commands);
%shared_ptr(SEProcessorMessageHeader);
%shared_ptr(SEProcessorOmnikeyXX27Commands);
%shared_ptr(SIO::AsymmetricAlgoId);
%shared_ptr(SIO::CryptoContext);
%shared_ptr(SIO::Identifier);
%shared_ptr(SIO::License);
%shared_ptr(SIO::SecureObject);
%shared_ptr(SIO::SymmetricAlgoId);
%shared_ptr(STidPRGBufferParser);
%shared_ptr(STidPRGProxAccessControlCardService);
%shared_ptr(STidPRGReaderCardAdapter);
%shared_ptr(STidPRGReaderProvider);
%shared_ptr(STidPRGReaderUnit);
%shared_ptr(STidPRGReaderUnit::BuzzerModeGuard);
%shared_ptr(STidPRGReaderUnitConfiguration);
%shared_ptr(STidPRGResultChecker);
%shared_ptr(STidPRGSerialPortDataTransport);
%shared_ptr(STidPRGUtils);
%shared_ptr(STidSTRBufferParser);
%shared_ptr(STidSTRLEDBuzzerDisplay);
%shared_ptr(STidSTRReaderCardAdapter);
%shared_ptr(STidSTRReaderProvider);
%shared_ptr(STidSTRReaderUnit);
%shared_ptr(STidSTRReaderUnit::STidSTRInformation);
%shared_ptr(STidSTRReaderUnitConfiguration);
%shared_ptr(STidSTRSerialPortDataTransport);
%shared_ptr(SagemKeyDiversification);
%shared_ptr(ScielBufferParser);
%shared_ptr(ScielSerialPortDataTransport);
%shared_ptr(SeosAccessInfo);
%shared_ptr(SeosChip);
%shared_ptr(SeosCommands);
%shared_ptr(SeosCrypto);
%shared_ptr(SeosFormat);
%shared_ptr(SeosISO7816Commands);
%shared_ptr(SeosKey);
%shared_ptr(SeosLocation);
%shared_ptr(SeosSEAccessControlCardService);
%shared_ptr(SeosValueAccessInfo);
%shared_ptr(SerialPort);
%shared_ptr(SerialPortDataTransport);
%shared_ptr(SerialPortXml);
%shared_ptr(SignatureHelper);
%shared_ptr(SignatureResult);
%shared_ptr(SignatureResult::Description);
%shared_ptr(SmartFrameChip);
%shared_ptr(SmartIDLEDBuzzerDisplay);
%shared_ptr(SmartIDReaderCardAdapter);
%shared_ptr(SmartIDReaderProvider);
%shared_ptr(SmartIDReaderUnit);
%shared_ptr(SmartIDReaderUnitConfiguration);
%shared_ptr(SpringCardReaderUnit);
%shared_ptr(SpringCardResultChecker);
%shared_ptr(StaticFormat);
%shared_ptr(StmLri512Chip);
%shared_ptr(StorageCardService);
%shared_ptr(StringDataField);
%shared_ptr(TCPDataTransport);
%shared_ptr(TLV);
%shared_ptr(TagItChip);
%shared_ptr(TagItCommands);
%shared_ptr(TopazACSACRCommands);
%shared_ptr(TopazAccessInfo);
%shared_ptr(TopazChip);
%shared_ptr(TopazCommands);
%shared_ptr(TopazLocation);
%shared_ptr(TopazOmnikeyXX27Commands);
%shared_ptr(TopazPCSCCommands);
%shared_ptr(TopazSCMCommands);
%shared_ptr(TopazStorageCardService);
%shared_ptr(TripleDESKey);
%shared_ptr(TwicAccessControlCardService);
%shared_ptr(TwicCardProvider);
%shared_ptr(TwicChip);
%shared_ptr(TwicCommands);
%shared_ptr(TwicISO7816Commands);
%shared_ptr(TwicLocation);
%shared_ptr(TwicProfile);
%shared_ptr(TwicStorageCardService);
%shared_ptr(UDPDataTransport);
%shared_ptr(UIDChangerCardService);
%shared_ptr(ValueDataField);
%shared_ptr(Wiegand26Format);
%shared_ptr(Wiegand34Format);
%shared_ptr(Wiegand34WithFacilityFormat);
%shared_ptr(Wiegand35Format);
%shared_ptr(Wiegand37Format);
%shared_ptr(Wiegand37WithFacilityFormat);
%shared_ptr(Wiegand37WithFacilityRightParity2Format);
%shared_ptr(WiegandFormat);
%shared_ptr(XmlSerializable);
%shared_ptr(iks::IslogKeyServer);
%shared_ptr(iks::IslogKeyServer::IKSConfig);
%shared_ptr(openssl::AESCipher);
%shared_ptr(openssl::AESInitializationVector);
%shared_ptr(openssl::AESSymmetricKey);
%shared_ptr(openssl::CMACCrypto);
%shared_ptr(openssl::DESCipher);
%shared_ptr(openssl::DESInitializationVector);
%shared_ptr(openssl::DESSymmetricKey);
%shared_ptr(openssl::InitializationVector);
%shared_ptr(openssl::OpenSSLException);
%shared_ptr(openssl::OpenSSLInitializer);
%shared_ptr(openssl::OpenSSLSymmetricCipher);
%shared_ptr(openssl::OpenSSLSymmetricCipherContext);
%shared_ptr(openssl::OpenSSLSymmetricCipherContext::Information);
%shared_ptr(openssl::SymmetricCipher);
%shared_ptr(openssl::SymmetricKey);
%shared_ptr(s_EXTSET);
%shared_ptr(s_KeyEntryAV1Information);
%shared_ptr(s_KeyEntryAV2Information);
%shared_ptr(s_KeyEntryUpdateSettings);
%shared_ptr(s_KucEntryUpdateSettings);
%shared_ptr(s_SAMKUCEntry);
%shared_ptr(s_SAMManufactureInformation);
%shared_ptr(s_SAMVersion);
%shared_ptr(s_SAMVersionInformation);
%shared_ptr(s_SETAV1);
%shared_ptr(s_SETAV2);
%shared_ptr(s_changeKeyDiversification);
%shared_ptr(s_changeKeyInfo);
%shared_ptr(se::AlgoInfo);
%shared_ptr(t_buz_cmd);
%shared_ptr(t_led_cmd);

/*** MULTIPLE INHERITANCE ***/

%define INTERFACEPTR(CTYPE)
%typemap(csinterfacecode,
         declaration="  System.IntPtr $interfacename_GetInterfaceCPtr();\n",
         cptrmethod="$interfacename_GetInterfaceCPtr") CTYPE %{
  public System.IntPtr $interfacename_GetInterfaceCPtr() {
    return $imclassname.$csclazzname$interfacename_GetInterfaceCPtr(swigCPtr.Handle);
  }
%}
%enddef

// ReaderCommunication + ISO14443BReaderCommunication + ISO14443AReaderCommunication 

%interface_custom("ReaderCommunication", "IReaderCommunication", ReaderCommunication)
INTERFACEPTR(logicalaccess::ReaderCommunication);
%interface_custom("ISO14443AReaderCommunication", "IISO14443AReaderCommunication", ISO14443AReaderCommunication)
INTERFACEPTR(logicalaccess::ISO14443AReaderCommunication);
%interface_custom("ISO14443BReaderCommunication", "IISO14443BReaderCommunication", ISO14443BReaderCommunication)
INTERFACEPTR(logicalaccess::ISO14443BReaderCommunication);

%interface_custom("ISO14443ReaderCommunication", "IISO14443ReaderCommunication", ISO14443ReaderCommunication)
%typemap(csclassmodifiers) logicalaccess::ISO14443ReaderCommunication "public abstract class";
INTERFACEPTR(logicalaccess::ISO14443ReaderCommunication);

%interface_custom("ISO15693ReaderCommunication", "IISO15693ReaderCommunication", ISO15693ReaderCommunication)
INTERFACEPTR(logicalaccess::ISO15693ReaderCommunication);

/*****EXCPETION HANDLING*****/

%insert(runtime) %{
typedef void (SWIGSTDCALL* CSharpExceptionCallback_t)(const char *, const char *);
static CSharpExceptionCallback_t customExceptionCallback = NULL;

#ifdef __cplusplus
extern "C"
#endif
SWIGEXPORT
void SWIGSTDCALL CustomExceptionRegisterCallback_$module(CSharpExceptionCallback_t customCallback) {
  customExceptionCallback = customCallback;
}

static void SWIG_CSharpSetPendingExceptionCustom(const char *name, const char *message) {
  customExceptionCallback(name, message);
}
%}

%pragma(csharp) imclasscode=%{
  class CustomExceptionHelper {
    // C# delegate for the C/C++ customExceptionCallback
	public delegate void CustomExceptionDelegate(string exceptionName, string message);
    static CustomExceptionDelegate customDelegate =
                                   new CustomExceptionDelegate(SetPendingCustomException);

    [global::System.Runtime.InteropServices.DllImport("$dllimport", EntryPoint="CustomExceptionRegisterCallback_$module")]
    public static extern void CustomExceptionRegisterCallback_$module(CustomExceptionDelegate customDelegate);

    static void SetPendingCustomException(string exceptionName, string message) {
	  System.Type type = System.Type.GetType("LibLogicalAccess." + exceptionName.Split(new string[] { "::" }, System.StringSplitOptions.None)[exceptionName.Split(new string[] { "::" }, System.StringSplitOptions.None).Length - 1] + ", LibLogicalAccessNet");
      var exception = (LibLogicalAccess.CustomException)System.Activator.CreateInstance(type, new object[] { message });
	  SWIGPendingException.Set(exception);
    }

    static CustomExceptionHelper() {
      CustomExceptionRegisterCallback_$module(customDelegate);
    }
  }
  static CustomExceptionHelper exceptionHelper = new CustomExceptionHelper();
%}

%exception %{
try 
{
	$action
}
catch (logicalaccess::IKSException &e) \
{
	SWIG_CSharpSetPendingExceptionCustom("IKSException", e.what());
	return $null;
}
catch (logicalaccess::CardException &e)
{
	SWIG_CSharpSetPendingExceptionCustom("CardException", e.what());
	return $null;
}
catch (logicalaccess::LibLogicalAccessException &e)
{
	SWIG_CSharpSetPendingExceptionCustom("LibLogicalAccessException", e.what());
	return $null;
}
catch (std::out_of_range &e)
{
	SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentOutOfRangeException, e.what(), "unknown");
	return $null;
}
catch (std::logic_error &e)
{
	SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentException, e.what(), "unknown");
	return $null;
}
catch (std::range_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOutOfMemoryException, e.what());
	return $null;
}
catch (std::overflow_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOverflowException, e.what());
	return $null;
}
catch (std::underflow_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOverflowException, e.what());
	return $null;
}
catch (std::runtime_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpSystemException, e.what());
	return $null;
}
catch (std::bad_cast &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpInvalidCastException, e.what());
	return $null;
}
catch (std::exception &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpSystemException, e.what());
	return $null;
}
%}

/*****POST PROCESSING INSTRUCTIONS*****/

%{
#include "msliblogicalaccessswigwin32.h"
#include <algorithm>

using namespace std;

#include <logicalaccess/myexception.hpp>
%}

%inline %{
  template<class T>
  T getVectorPart(std::vector<T> vector, int i)
  {
    return vector[i];
  }
%}
