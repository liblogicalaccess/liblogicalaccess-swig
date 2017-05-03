/* File : liblogicalaccess.i */

%include <windows.i>

%typemap(csimports) SWIGTYPE
%{ 
	using System;
	using System.Runtime.InteropServices;
%}

#define LIBLOGICALACCESS_API

/*****SWIG INCLUSIONS*****/

%include <typemaps.i>
%include <stl.i>
%include <std_string.i>
%include <std_shared_ptr.i>
%include <std_array.i>
%include <wchar.i>
%include <exception.i>
%include <arrays_csharp.i>
%include <stdint.i>

/*****WARNING SECTION*****/

#pragma SWIG nowarn=516,401,833

//Ignored Warning:
// - 516: Overloaded method ignored 
// - 401: Nothing known about class 'name'. Ignored. 
// - 833: Warning for classname: Base baseclass ignored. Multiple inheritance is not supported in C#. (C#). 

/*****IGNORE SECTION*****/

%ignore newDynLibrary;
%ignore hasEnding;
%ignore logicalaccess::LibraryManager::getCardService;
%ignore logicalaccess::LibraryManager::getReaderService;
%ignore logicalaccess::XmlSerializable::unSerialize(std::istream& is, const std::string& rootNode);
%ignore logicalaccess::XmlSerializable::unSerialize(boost::property_tree::ptree& node);
%ignore logicalaccess::XmlSerializable::unSerialize(boost::property_tree::ptree& node, const std::string& rootNode);
%ignore logicalaccess::XmlSerializable::serialize(boost::property_tree::ptree& parentNode);

/*****SHARED PTR SECTION*****/

%shared_ptr(boost::asio::ip::udp::socket);
%shared_ptr(boost::interprocess::mapped_region);
%shared_ptr(boost::interprocess::named_mutex);
%shared_ptr(logicalaccess::A3MLGM5600ReaderCardAdapter);
%shared_ptr(logicalaccess::A3MLGM5600ReaderProvider);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnit);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnitConfiguration);
%shared_ptr(logicalaccess::ACSACR1222LReaderUnitConfiguration);
%shared_ptr(logicalaccess::AES128Key);
%shared_ptr(logicalaccess::AccessInfo);
%shared_ptr(logicalaccess::Adapter);
%shared_ptr(logicalaccess::AdmittoReaderCardAdapter);
%shared_ptr(logicalaccess::AdmittoReaderProvider);
%shared_ptr(logicalaccess::AdmittoReaderUnitConfiguration);
%shared_ptr(logicalaccess::AxessTMC13ReaderCardAdapter);
%shared_ptr(logicalaccess::AxessTMC13ReaderProvider);
%shared_ptr(logicalaccess::AxessTMC13ReaderUnitConfiguration);
%shared_ptr(logicalaccess::AxessTMCLegicReaderCardAdapter);
%shared_ptr(logicalaccess::AxessTMCLegicReaderProvider);
%shared_ptr(logicalaccess::AxessTMCLegicReaderUnitConfiguration);
%shared_ptr(logicalaccess::BaseResponse);
%shared_ptr(logicalaccess::CPS3Chip);
%shared_ptr(logicalaccess::CPS3Commands);
%shared_ptr(logicalaccess::CSMARTCommon);
%shared_ptr(logicalaccess::CardProbe);
%shared_ptr(logicalaccess::CardService);
%shared_ptr(logicalaccess::CardsFormatComposite);
%shared_ptr(logicalaccess::Chip);
%shared_ptr(logicalaccess::CircularBufferParser);
%shared_ptr(logicalaccess::Commands);
%shared_ptr(logicalaccess::DESFireChip);
%shared_ptr(logicalaccess::DESFireCommands);
%shared_ptr(logicalaccess::DESFireCrypto);
%shared_ptr(logicalaccess::DESFireEV1Chip);
%shared_ptr(logicalaccess::DESFireEV1Commands);
%shared_ptr(logicalaccess::DESFireISO7816ResultChecker);
%shared_ptr(logicalaccess::DESFireKey);
%shared_ptr(logicalaccess::DESFireLocation);
%shared_ptr(logicalaccess::DataField);
%shared_ptr(logicalaccess::DataRepresentation);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::DataType);
%shared_ptr(logicalaccess::DeisterReaderCardAdapter);
%shared_ptr(logicalaccess::DeisterReaderProvider);
%shared_ptr(logicalaccess::DeisterReaderUnitConfiguration);
%shared_ptr(logicalaccess::EPassAccessInfo);
%shared_ptr(logicalaccess::EPassChip);
%shared_ptr(logicalaccess::EPassCommand);
%shared_ptr(logicalaccess::EPassCrypto);
%shared_ptr(logicalaccess::EVP_PKEY);
%shared_ptr(logicalaccess::ElatecReaderCardAdapter);
%shared_ptr(logicalaccess::ElatecReaderProvider);
%shared_ptr(logicalaccess::ElatecReaderUnitConfiguration);
%shared_ptr(logicalaccess::FeliCaChip);
%shared_ptr(logicalaccess::FeliCaCommands);
%shared_ptr(logicalaccess::Format);
%shared_ptr(logicalaccess::GenericTagChip);
%shared_ptr(logicalaccess::GigaTMSReaderCardAdapter);
%shared_ptr(logicalaccess::GigaTMSReaderProvider);
%shared_ptr(logicalaccess::GigaTMSReaderUnitConfiguration);
%shared_ptr(logicalaccess::GunneboReaderCardAdapter);
%shared_ptr(logicalaccess::GunneboReaderProvider);
%shared_ptr(logicalaccess::GunneboReaderUnitConfiguration);
%shared_ptr(logicalaccess::HIDiClassChip);
%shared_ptr(logicalaccess::HIDiClassKey);
%shared_ptr(logicalaccess::HMAC1Key);
%shared_ptr(logicalaccess::IDPReaderCardAdapter);
%shared_ptr(logicalaccess::IDPReaderProvider);
%shared_ptr(logicalaccess::IDPReaderUnit);
%shared_ptr(logicalaccess::IDPReaderUnitConfiguration);
%shared_ptr(logicalaccess::ISO15693Chip);
%shared_ptr(logicalaccess::ISO15693Commands);
%shared_ptr(logicalaccess::ISO7816Chip);
%shared_ptr(logicalaccess::ISO7816Commands);
%shared_ptr(logicalaccess::ISO7816ReaderCardAdapter);
%shared_ptr(logicalaccess::ISO7816ReaderProvider);
%shared_ptr(logicalaccess::ISO7816ReaderUnit);
%shared_ptr(logicalaccess::ISO7816ReaderUnitConfiguration);
%shared_ptr(logicalaccess::IdOnDemandReaderCardAdapter);
%shared_ptr(logicalaccess::IdOnDemandReaderProvider);
%shared_ptr(logicalaccess::IdOnDemandReaderUnitConfiguration);
%shared_ptr(logicalaccess::Information);
%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::KeyDiversification);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::KeyboardReaderProvider);
%shared_ptr(logicalaccess::KeyboardReaderUnitConfiguration);
%shared_ptr(logicalaccess::LCDDisplay);
%shared_ptr(logicalaccess::LEDBuzzerDisplay);
%shared_ptr(logicalaccess::Location);
%shared_ptr(logicalaccess::LocationNode);
%shared_ptr(logicalaccess::MifareChip);
%shared_ptr(logicalaccess::MifareCommands);
%shared_ptr(logicalaccess::MifareKey);
%shared_ptr(logicalaccess::MifareSmartIDReaderCardAdapter);
%shared_ptr(logicalaccess::MifareUltralightCChip);
%shared_ptr(logicalaccess::MifareUltralightCCommands);
%shared_ptr(logicalaccess::MifareUltralightChip);
%shared_ptr(logicalaccess::MifareUltralightCommands);
%shared_ptr(logicalaccess::NFCReaderCardAdapter);
%shared_ptr(logicalaccess::NFCReaderProvider);
%shared_ptr(logicalaccess::NFCReaderUnit);
%shared_ptr(logicalaccess::NFCReaderUnitConfiguration);
%shared_ptr(logicalaccess::NdefMessage);
%shared_ptr(logicalaccess::NdefRecord);
%shared_ptr(logicalaccess::OK5553ReaderCardAdapter);
%shared_ptr(logicalaccess::OK5553ReaderProvider);
%shared_ptr(logicalaccess::OK5553ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OSDPChannel);
%shared_ptr(logicalaccess::OSDPCommands);
%shared_ptr(logicalaccess::OSDPReaderProvider);
%shared_ptr(logicalaccess::OSDPReaderUnitConfiguration);
%shared_ptr(logicalaccess::OSDPSecureChannel);
%shared_ptr(logicalaccess::Omnikey5427ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OmnikeyHIDiClassDataTransport);
%shared_ptr(logicalaccess::OmnikeyReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OmnikeyXX27SecureMode);
%shared_ptr(logicalaccess::PCSCDataTransport);
%shared_ptr(logicalaccess::PCSCHIDiClassDataTransport);
%shared_ptr(logicalaccess::PCSCReaderCardAdapter);
%shared_ptr(logicalaccess::PCSCReaderProvider);
%shared_ptr(logicalaccess::PCSCReaderUnit);
%shared_ptr(logicalaccess::PCSCReaderUnitConfiguration);
%shared_ptr(logicalaccess::PicoPassCommands);
%shared_ptr(logicalaccess::PromagReaderCardAdapter);
%shared_ptr(logicalaccess::PromagReaderProvider);
%shared_ptr(logicalaccess::PromagReaderUnitConfiguration);
%shared_ptr(logicalaccess::RFIDeasReaderProvider);
%shared_ptr(logicalaccess::RFIDeasReaderUnit);
%shared_ptr(logicalaccess::RFIDeasReaderUnitConfiguration);
%shared_ptr(logicalaccess::RSA);
%shared_ptr(logicalaccess::ReaderCardAdapter);
%shared_ptr(logicalaccess::ReaderCommunication);
%shared_ptr(logicalaccess::ReaderConfiguration);
%shared_ptr(logicalaccess::ReaderMemoryKeyStorage);
%shared_ptr(logicalaccess::ReaderProvider);
%shared_ptr(logicalaccess::ReaderService);
%shared_ptr(logicalaccess::ReaderUnit);
%shared_ptr(logicalaccess::ReaderUnitConfiguration);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::RplethReaderCardAdapter);
%shared_ptr(logicalaccess::RplethReaderProvider);
%shared_ptr(logicalaccess::RplethReaderUnitConfiguration);
%shared_ptr(logicalaccess::SAMChip);
%shared_ptr(logicalaccess::SAMCommands<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMCommands<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMDESfireCrypto);
%shared_ptr(logicalaccess::SAMKeyEntry<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMKeyEntry<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMKeyEntry<T, S>);
%shared_ptr(logicalaccess::SAMKucEntry);
%shared_ptr(logicalaccess::SCIELReaderCardAdapter);
%shared_ptr(logicalaccess::SCIELReaderProvider);
%shared_ptr(logicalaccess::SCIELReaderUnitConfiguration);
%shared_ptr(logicalaccess::SSL);
%shared_ptr(logicalaccess::SSL_CTX);
%shared_ptr(logicalaccess::STidPRGReaderProvider);
%shared_ptr(logicalaccess::STidPRGReaderUnitConfiguration);
%shared_ptr(logicalaccess::STidSTRReaderCardAdapter);
%shared_ptr(logicalaccess::STidSTRReaderProvider);
%shared_ptr(logicalaccess::STidSTRReaderUnit);
%shared_ptr(logicalaccess::STidSTRReaderUnitConfiguration);
%shared_ptr(logicalaccess::SerialPort);
%shared_ptr(logicalaccess::SerialPortXml);
%shared_ptr(logicalaccess::SmartIDReaderCardAdapter);
%shared_ptr(logicalaccess::SmartIDReaderProvider);
%shared_ptr(logicalaccess::SmartIDReaderUnitConfiguration);
%shared_ptr(logicalaccess::StorageCardService);
%shared_ptr(logicalaccess::TLV);
%shared_ptr(logicalaccess::TopazChip);
%shared_ptr(logicalaccess::TopazCommands);
%shared_ptr(logicalaccess::TripleDESKey);
%shared_ptr(logicalaccess::TwicChip);
%shared_ptr(logicalaccess::TwicCommands);
%shared_ptr(logicalaccess::TwicLocation);
%shared_ptr(logicalaccess::X509);
%shared_ptr(logicalaccess::X509V3_CTX);
%shared_ptr(openssl::InitializationVector);
%shared_ptr(openssl::OpenSSLSymmetricCipher);
%shared_ptr(openssl::SymmetricKey);

/*****POST PROCESSING INSTRUCTIONS*****/

%{
	#include "msliblogicalaccessswigwin32.h"
	#include <algorithm>

	using namespace std;
%}

