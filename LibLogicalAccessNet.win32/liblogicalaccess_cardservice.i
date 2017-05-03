/* File : liblogicalaccess_cardservice.i */

%import "liblogicalaccess_data.i"

%{
#include <logicalaccess/services/cardservice.hpp>
#include <logicalaccess/services/storage/storagecardservice.hpp>
#include <logicalaccess/services/accesscontrol/encodings/binarydatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bcdbytedatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bcdnibbledatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bigendiandatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/littleendiandatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/nodatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/datafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/binarydatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/numberdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/paritydatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/stringdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/customformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/format.hpp>
#include <logicalaccess/services/accesscontrol/formats/rawformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand26format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand34format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand34withfacilityformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityrightparity2format.hpp>
#include <logicalaccess/services/accesscontrol/formats/hidhoneywellformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/getronik40bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/fascn200bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/dataclockformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/bariumferritepcscformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/asciiformat.hpp>
#include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
#include <logicalaccess/services/accesscontrol/accesscontrolcardservice.hpp>
#include <logicalaccess/services/identity/identity_service.hpp>
#include <logicalaccess/services/nfctag/nfctagcardservice.hpp>
#include <logicalaccess/services/uidchanger/uidchangerservice.hpp>
%}

%shared_ptr(logicalaccess::CardService);
%feature("director") CardService;

%shared_ptr(logicalaccess::StorageCardService);
//%feature("director") StorageCardService;

%shared_ptr(logicalaccess::CardsFormatComposite);
%shared_ptr(logicalaccess::AccessControlCardService);
//%feature("director") AccessControlCardService;
%shared_ptr(logicalaccess::Encoding);
%shared_ptr(logicalaccess::DataRepresentation);
%shared_ptr(logicalaccess::DataType);
%shared_ptr(logicalaccess::BinaryDataType);
%shared_ptr(logicalaccess::BCDByteDataType);
%shared_ptr(logicalaccess::BCDNibbleDataType);
%shared_ptr(logicalaccess::BigEndianDataRepresentation);
%shared_ptr(logicalaccess::LittleEndianDataRepresentation);
%shared_ptr(logicalaccess::NoDataRepresentation);
%shared_ptr(logicalaccess::Format);
%shared_ptr(logicalaccess::StaticFormat);
%shared_ptr(logicalaccess::WiegandFormat);
%shared_ptr(logicalaccess::DataField);
%shared_ptr(logicalaccess::ValueDataField);
%shared_ptr(logicalaccess::BinaryFieldValue);
%shared_ptr(logicalaccess::BinaryDataField);
%shared_ptr(logicalaccess::NumberDataField);
%shared_ptr(logicalaccess::ParityDataField);
%shared_ptr(logicalaccess::StringDataField);
%shared_ptr(logicalaccess::CustomFormat);
%shared_ptr(logicalaccess::RawFormat);
%shared_ptr(logicalaccess::Wiegand26Format);
%shared_ptr(logicalaccess::Wiegand34Format);
%shared_ptr(logicalaccess::Wiegand34WithFacilityFormat);
%shared_ptr(logicalaccess::Wiegand37Format);
%shared_ptr(logicalaccess::Wiegand37WithFacilityFormat);
%shared_ptr(logicalaccess::Wiegand37WithFacilityRightParity2Format);
%shared_ptr(logicalaccess::HIDHoneywellFormat);
%shared_ptr(logicalaccess::Getronik40BitFormat);
%shared_ptr(logicalaccess::FASCN200BitFormat);
%shared_ptr(logicalaccess::DataClockFormat);
%shared_ptr(logicalaccess::BariumFerritePCSCFormat);
%shared_ptr(logicalaccess::ASCIIFormat);
%shared_ptr(logicalaccess::ReaderUnit);

%shared_ptr(logicalaccess::IdentityCardService);
%feature("director") IdentityCardService;

%shared_ptr(logicalaccess::NdefRecord);
%shared_ptr(logicalaccess::NdefMessage);
%typemap(csdirectorin) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< logicalaccess::NdefMessage > "new NdefMessage($iminput, true)"
%typemap(csdirectorout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< logicalaccess::NdefMessage > "NdefMessage.getCPtr($cscall).Handle"
//%typemap(csdirectorin) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< TYPE > "new $1_type($iminput, true)"
//%typemap(csdirectorout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< TYPE > "$1_type.getCPtr($cscall).Handle"
%shared_ptr(logicalaccess::NFCTagCardService);
%feature("director") NFCTagCardService;

%shared_ptr(logicalaccess::UIDChangerService);
//%feature("director") UIDChangerService;


%ignore FieldSortPredicate;
%ignore logicalaccess::Getronik40BitFormat::calcChecksum;


/* original header files */
%include <logicalaccess/services/cardservice.hpp>
%include <logicalaccess/services/storage/storagecardservice.hpp>

%include <logicalaccess/services/accesscontrol/encodings/encoding.hpp>
%include <logicalaccess/services/accesscontrol/encodings/datarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/datatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/binarydatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bcdbytedatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bcdnibbledatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bigendiandatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/littleendiandatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/nodatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/formats/format.hpp>
%include <logicalaccess/services/accesscontrol/formats/staticformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegandformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/datafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/valuedatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/binarydatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/numberdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/paritydatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/stringdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/customformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/rawformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand26format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand34format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand34withfacilityformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityrightparity2format.hpp>
%include <logicalaccess/services/accesscontrol/formats/hidhoneywellformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/getronik40bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/fascn200bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/dataclockformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/bariumferritepcscformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/asciiformat.hpp>
%include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
%include <logicalaccess/services/accesscontrol/accesscontrolcardservice.hpp>

%include <logicalaccess/services/identity/identity_service.hpp>

%include <logicalaccess/services/nfctag/ndefrecord.hpp>
%include <logicalaccess/services/nfctag/ndefmessage.hpp>
%include <logicalaccess/services/nfctag/nfctagcardservice.hpp>

%include <logicalaccess/services/uidchanger/uidchangerservice.hpp>


%template(NdefRecordCollection) std::vector<std::shared_ptr<logicalaccess::NdefRecord> >;

%pragma(csharp) imclasscode=%{
  public static CardService createCardService(System.IntPtr cPtr, bool owner)
  {
    CardService ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	CardServiceType svcType = (CardServiceType)($modulePINVOKE.CardService_getServiceType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
	//ret = new CardService(cPtr, true);
    //if (liblogicalaccess_cardPINVOKE.SWIGPendingException.Pending) throw $modulePINVOKE.SWIGPendingException.Retrieve();
	//CardServiceType svcType = ret.getServiceType();
    switch (svcType) {
       case CardServiceType.CST_ACCESS_CONTROL:
	     ret = new AccessControlCardService(cPtr, owner);
	     break;
	   case CardServiceType.CST_IDENTITY:
	     ret = new IdentityCardService(cPtr, owner);
	     break;
	   case CardServiceType.CST_NFC_TAG:
	     ret = new NFCTagCardService(cPtr, owner);
	     break;
	   case CardServiceType.CST_STORAGE:
	     ret = new StorageCardService(cPtr, owner);
	     break;
	   case CardServiceType.CST_UID_CHANGER:
	     ret = new UIDChangerService(cPtr, owner);
	     break;
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::CardService*, std::shared_ptr<logicalaccess::CardService> {
    System.IntPtr cPtr = $imcall;
    CardService ret = $modulePINVOKE.createCardService(cPtr, $owner);$excode
    return ret;
}