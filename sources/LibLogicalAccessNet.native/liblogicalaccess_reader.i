/* File : liblogicalaccess_reader.i */
%module(directors="1") liblogicalaccess_reader

%include <typemaps.i>

// Some typemaps to handle bool& in director.
// Need this when PCSCReaderUnit was director.
%typemap(ctype)   bool* , bool&  "/*ctype*/ bool*"
%typemap(imtype)  bool* , bool&  "/*imtype*/ ref bool"
%typemap(cstype)  bool* , bool&  "/*cstype*/ ref bool"
%typemap(csin)    bool* , bool&  "/*csin*/ ref $csinput"
%typemap(csdirectorin) bool* , bool&  "/*csdirectorin*/ ref $iminput"
%typemap(csdirectorout) bool* , bool&  "/*csdirectorout*/ $cscall"

%include "liblogicalaccess.i"

%import "liblogicalaccess_exception.i"
%import "liblogicalaccess_data.i"
%import "liblogicalaccess_core.i"
%import "liblogicalaccess_iks.i"
%import "liblogicalaccess_card_sam.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
using LibLogicalAccess.Crypto;
%}

/* We need to include sam object templated before include other - this required to import iso7816readercardadapter... */
%{
#include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816readercardadapter.hpp>
%}
%import <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816readercardadapter.hpp>
%include "liblogicalaccess_reader_sam.i"

%{

/* Additional_include */


/* END_Additional_include */

#include <logicalaccess/cards/accessinfo.hpp>

using namespace logicalaccess;
using namespace logicalaccess::openssl;
using MifarePlusSL1PCSCCommands = MifarePlusSL1Policy<MifarePlusSL1Commands, MifarePCSCCommands>;

%}

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Card;
using LibLogicalAccess.Crypto;
%}

/* Shared_ptr */

/* END_Shared_ptr */

%shared_ptr(logicalaccess::ReaderConfiguration);
%shared_ptr(boost::asio::ip::udp::socket);
%shared_ptr(boost::interprocess::mapped_region);
%shared_ptr(boost::interprocess::named_mutex);

%shared_ptr(logicalaccess::MifarePlusSL1Policy<logicalaccess::MifarePlusSL1Commands, logicalaccess::MifarePCSCCommands>);
%shared_ptr(openssl::OpenSSLSymmetricCipher);
%shared_ptr(openssl::SymmetricKey);
%shared_ptr(openssl::InitializationVector);

%apply unsigned short *INOUT { unsigned short * }
%apply int *INOUT { int * }
%apply unsigned long *OUTPUT { unsigned long* pdwOutLen}
%apply unsigned char OUTPUT[] { unsigned char* pOutBuf }
%apply unsigned char INPUT[] { unsigned char* pInBuf }
%apply unsigned char INPUT[] { uint8_t *atr }
%apply unsigned char OUTPUT[] { unsigned char* pstate }
%apply unsigned char OUTPUT[] { unsigned char* result }
%apply unsigned int *INOUT { size_t* resultlen }

%apply unsigned char MBINOUT[] { unsigned char recordSize[ANY] }
%apply unsigned char MBINOUT[] { unsigned char maxNumberRecords[ANY] }
%apply unsigned char MBINOUT[] { unsigned char currentNumberRecords[ANY] }
%apply unsigned char MBINOUT[] { unsigned char accessRights[ANY] }
%apply unsigned char MBINOUT[] { unsigned char uid[ANY] }
%apply unsigned char MBINOUT[] { unsigned char batchNo[ANY] }
%apply unsigned char MBINOUT[] { unsigned char fileSize[ANY] }
%apply unsigned char MBINOUT[] { unsigned char keytype[ANY] }
%apply unsigned char MBINOUT[] { unsigned char rfu[ANY] }
%apply unsigned char MBINOUT[] { unsigned char desfireAid[ANY] }
%apply unsigned char MBINOUT[] { unsigned char set[ANY] }
%apply unsigned char MBINOUT[] { unsigned char keyclass[ANY] }
%apply unsigned char MBINOUT[] { unsigned char dfname[ANY] }
%apply unsigned char MBINOUT[] { unsigned char limit[ANY] }
%apply unsigned char MBINOUT[] { unsigned char curval[ANY] }
%apply unsigned char MBINOUT[] { unsigned char productionbatchnumber[ANY] }
%apply unsigned char MBINOUT[] { unsigned char uniqueserialnumber[ANY] }

%typemap(ctype) __int64 "long"
%typemap(cstype) __int64 "long"
%typemap(csin) __int64 %{$csinput%}  
%typemap(imtype) __int64 "long"

%typemap(ctype) __int64* "long*"
%typemap(cstype) __int64* "ref long"
%typemap(csin) __int64* %{ref $csinput%}  
%typemap(imtype) __int64* "ref long"

%typemap(ctype) WCHAR "wchar_t"
%typemap(cstype) WCHAR* "byte[]"
%typemap(csin) WCHAR* %{$csinput%}  
%typemap(imtype) WCHAR* "byte[]"

%typemap(cstype) std::vector<std::shared_ptr<logicalaccess::SerialPortXml> >& "out SerialPortXmlPtrVector"
%typemap(csin) std::vector<std::shared_ptr<logicalaccess::SerialPortXml> >& %{out $csinput%}  
%typemap(imtype) std::vector<std::shared_ptr<logicalaccess::SerialPortXml> >& "out SerialPortXmlPtrVector"

%typemap(ctype) CardServiceType "CardServiceType"
%typemap(cstype) CardServiceType "CardServiceType"
%typemap(csin) CardServiceType %{$csinput%}  
%typemap(imtype) CardServiceType "CardServiceType"
%typemap(csout, excode=SWIGEXCODE) CardServiceType {
	CardServiceType ret = $imcall;$excode
	return ret;
}


%typemap(ctype) DESFireCommands::DESFireCardVersion "DESFireCommands::DESFireCardVersion"
%typemap(cstype) DESFireCommands::DESFireCardVersion "DESFireCommands.DESFireCardVersion"
%typemap(csin) DESFireCommands::DESFireCardVersion %{$csinput%}  
%typemap(imtype) DESFireCommands::DESFireCardVersion "LibLogicalAccess.Card.DESFireCommands.DESFireCardVersion"
%typemap(csout, excode=SWIGEXCODE) DESFireCommands::DESFireCardVersion {
	DESFireCommands.DESFireCardVersion ret = $imcall;$excode
	return ret;
}

%typemap(ctype) HIDEncryptionMode "HIDEncryptionMode"
%typemap(cstype) HIDEncryptionMode "HIDEncryptionMode"
%typemap(csin) HIDEncryptionMode %{$csinput%}  
%typemap(imtype) HIDEncryptionMode "LibLogicalAccess.Reader.HIDEncryptionMode"
%typemap(csout, excode=SWIGEXCODE) HIDEncryptionMode {
	HIDEncryptionMode ret = $imcall;$excode
	return ret;
}

%typemap(ctype) FileSetting& "logicalaccess::DESFireCommands::FileSetting *"
%typemap(in) FileSetting& "$1 = (logicalaccess::DESFireCommands::FileSetting *)$input;"
%typemap(cstype) FileSetting& "out DESFireCommands.FileSetting"
%typemap(csin) FileSetting& %{out $csinput%}  
%typemap(imtype) FileSetting& "out LibLogicalAccess.Card.DESFireCommands.FileSetting"

%typemap(ctype) logicalaccess::DESFireKeyType& "logicalaccess::DESFireKeyType*"
%typemap(cstype) logicalaccess::DESFireKeyType& "out DESFireKeyType"
%typemap(csin) logicalaccess::DESFireKeyType& %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeyType& "out LibLogicalAccess.Card.DESFireKeyType"

%typemap(ctype) logicalaccess::DESFireKeySettings & "logicalaccess::DESFireKeySettings*"
%typemap(cstype) logicalaccess::DESFireKeySettings & "out DESFireKeySettings"
%typemap(csin) logicalaccess::DESFireKeySettings & %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeySettings & "out LibLogicalAccess.Card.DESFireKeySettings"


%typemap(cstype) nfc_context *  "System.IntPtr"
%typemap(csin) nfc_context *  %{$csinput%}  
%typemap(imtype) nfc_context * "System.IntPtr"
%typemap(csout, excode=SWIGEXCODE) nfc_context * {
	System.IntPtr ret = $imcall;$excode
	return ret;
}

%typemap(cstype) nfc_device *  "System.IntPtr"
%typemap(csin) nfc_device *  %{$csinput%}  
%typemap(imtype) nfc_device * "System.IntPtr"
%typemap(csout, excode=SWIGEXCODE) nfc_device * {
	System.IntPtr ret = $imcall;$excode
	return ret;
}

//%typemap(ctype) logicalaccess::PCSCShareMode "logicalaccess::PCSCShareMode"
//%typemap(cstype) logicalaccess::PCSCShareMode "PCSCShareMode"
//%typemap(csin) logicalaccess::PCSCShareMode  %{$csinput%}  
//%typemap(imtype) logicalaccess::PCSCShareMode "LibLogicalAccess.Reader.PCSCShareMode"
//%typemap(csout, excode=SWIGEXCODE) logicalaccess::PCSCShareMode {
//	PCSCShareMode ret = $imcall;$excode
//	return ret;
//}

/**** FORWARD Card Type Vector ****/

%typemap(cstype) std::vector<logicalaccess::DFName> "LibLogicalAccess.Card.DFNameVector"
%typemap(csin) std::vector<logicalaccess::DFName> "LibLogicalAccess.Card.DFNameVector.getCPtr($csinput)"
%typemap(csout, excode=SWIGEXCODE) std::vector<logicalaccess::DFName>, std::vector<logicalaccess::DFName> & {
	LibLogicalAccess.Card.DFNameVector ret = new LibLogicalAccess.Card.DFNameVector($imcall, true);$excode
	return ret;
}

%typemap(cstype) std::vector<logicalaccess::DESFireAccessRights> "LibLogicalAccess.Card.DESFireAccessRightsVector"
%typemap(csin) std::vector<logicalaccess::DESFireAccessRights> "LibLogicalAccess.Card.DESFireAccessRightsVector.getCPtr($csinput)"
%typemap(csout, excode=SWIGEXCODE) std::vector<logicalaccess::DESFireAccessRights> {
	LibLogicalAccess.Card.DESFireAccessRights ret = new LibLogicalAccess.Card.DESFireAccessRights($imcall, true);$excode
	return ret;
}

%typemap(cstype) std::vector<logicalaccess::s_YubikeyListItem> "LibLogicalAccess.Card.YubikeyListItemVector"
%typemap(csin) std::vector<logicalaccess::s_YubikeyListItem> "LibLogicalAccess.Card.YubikeyListItemVector.getCPtr($csinput)"
%typemap(csout, excode=SWIGEXCODE) std::vector<logicalaccess::s_YubikeyListItem>, std::vector<logicalaccess::s_YubikeyListItem> & {
LibLogicalAccess.Card.YubikeyListItemVector ret = new LibLogicalAccess.Card.YubikeyListItemVector($imcall, true);$excode
return ret;
}

%typemap(cstype) std::vector<logicalaccess::s_YubikeyCalculateResponse> "LibLogicalAccess.Card.YubikeyCalculateResponseVector"
%typemap(csin) std::vector<logicalaccess::s_YubikeyCalculateResponse> "LibLogicalAccess.Card.YubikeyCalculateResponseVector.getCPtr($csinput)"
%typemap(csout, excode=SWIGEXCODE) std::vector<logicalaccess::s_YubikeyCalculateResponse> {
	LibLogicalAccess.Card.YubikeyCalculateResponseVector ret = new LibLogicalAccess.Card.YubikeyCalculateResponseVector($imcall, true);$excode
	return ret;
}

%template() std::vector<logicalaccess::DESFireAccessRights>;
%template() std::vector<logicalaccess::DFName>;
%template() std::vector<logicalaccess::s_YubikeyListItem>;
%template() std::vector<logicalaccess::s_YubikeyCalculateResponse>;

/**** FORWARD Card Type Vector END ****/

typedef logicalaccess::MifarePlusSL1PCSCCommands logicalaccess::MifarePlusSL1Policy<logicalaccess::MifarePlusSL1Commands, logicalaccess::MifarePCSCCommands>;

%ignore *::getCSMART;
%ignore logicalaccess::EncapsulateGuard;


%inline %{
typedef enum : uint16_t
{
	PROTOCOL_UNDEFINED = 0x00000000,
	PROTOCOL_T0 = 0x00000001,
	PROTOCOL_T1 = 0x00000002,
	PROTOCOL_ANY = 0x00000003, // SCARD_PROTOCOL_T0 | SCARD_PROTOCOL_T1
	PROTOCOL_RAW = 0x00001111
} SCardProtocol;
%}

%ignore logicalaccess::PCSCReaderUnit::getT_CL_ISOType;
%ignore logicalaccess::PCSCReaderUnit::reconnect;
%feature("director") ISO7816ReaderUnit;
%feature("director") PCSCReaderUnit;

/* Include_section */


/* END_Include_section */

%template(MifarePlusSL1PCSCCommands) logicalaccess::MifarePlusSL1Policy<logicalaccess::MifarePlusSL1Commands, logicalaccess::MifarePCSCCommands>;

%template(ChipList) std::list<std::shared_ptr<logicalaccess::Chip> >;
#ifdef BUILD_PRIVATE
%template(SIOCryptoContextVector) std::vector<logicalaccess::SIO::CryptoContext>;
#endif
