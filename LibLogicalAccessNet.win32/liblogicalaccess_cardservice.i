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
//%feature("director") IdentityCardService;

//%typemap(csdirectorin) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< logicalaccess::NdefMessage > "new NdefMessage($iminput, true)"
//%typemap(csdirectorout) SWIG_SHARED_PTR_QNAMESPACE::shared_ptr< logicalaccess::NdefMessage > "NdefMessage.getCPtr($cscall).Handle"
//%feature("director") NFCTagCardService;

%ignore FieldSortPredicate;

%shared_ptr(std::enable_shared_from_this<logicalaccess::CardService>);
%template(CardServiceEnableShared) std::enable_shared_from_this<logicalaccess::CardService>;

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
