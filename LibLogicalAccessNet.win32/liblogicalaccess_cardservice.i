/* File : liblogicalaccess_cardservice.i */

%import "liblogicalaccess_data.i"

%{
#include <logicalaccess/services/cardservice.hpp>
#include <logicalaccess/services/storage/storagecardservice.hpp>
#include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
#include <logicalaccess/services/accesscontrol/accesscontrolcardservice.hpp>
#include <logicalaccess/services/identity/identity_service.hpp>
#include <logicalaccess/services/nfctag/nfctagcardservice.hpp>
#include <logicalaccess/services/uidchanger/uidchangerservice.hpp>

using namespace logicalaccess;
%}

//%feature("director") CardService;
%feature("director") IdentityCardService;

%typemap(csdirectorin) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< logicalaccess::NdefMessage > "new NdefMessage($iminput, true)"
%typemap(csdirectorout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< logicalaccess::NdefMessage > "NdefMessage.getCPtr($cscall).Handle"
//%typemap(csdirectorin) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< TYPE > "new $1_type($iminput, true)"
//%typemap(csdirectorout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< TYPE > "$1_type.getCPtr($cscall).Handle"
%feature("director") NFCTagCardService;

%ignore FieldSortPredicate;
%ignore logicalaccess::Getronik40BitFormat::calcChecksum;


/* original header files */
%include <logicalaccess/services/cardservice.hpp>
%include <logicalaccess/services/storage/storagecardservice.hpp>

%include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
%include <logicalaccess/services/accesscontrol/accesscontrolcardservice.hpp>

%include <logicalaccess/services/identity/identity_service.hpp>

%include <logicalaccess/services/nfctag/ndefrecord.hpp>
%include <logicalaccess/services/nfctag/ndefmessage.hpp>
%include <logicalaccess/services/nfctag/nfctagcardservice.hpp>

%include <logicalaccess/services/uidchanger/uidchangerservice.hpp>


%template(NdefRecordCollection) std::vector<std::shared_ptr<logicalaccess::NdefRecord> >;
//%template(CardServiceEnableShared) std::enable_shared_from_this<logicalaccess::CardService>;

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