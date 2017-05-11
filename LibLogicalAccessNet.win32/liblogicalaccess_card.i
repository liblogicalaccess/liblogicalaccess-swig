/* File : liblogicalaccess_card.i */
%module(directors="1") liblogicalaccess_card

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_core.i"
%import "liblogicalaccess_iks.i"

%{
/* Additional_include */

#include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816chip.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3location.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3commands.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3chip.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816storagecardservice.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3storagecardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816nfctag4cardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1nfctag4cardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirestoragecardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpkeydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpav1keydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpav2keydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/omnitechkeydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/sagemkeydiversification.hpp>
#include <logicalaccess/plugins/cards/em4102/em4102chip.hpp>
#include <logicalaccess/plugins/cards/em4135/em4135chip.hpp>
#include <logicalaccess/plugins/cards/epass/epassaccessinfo.hpp>
#include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
#include <logicalaccess/plugins/cards/epass/utils.hpp>
#include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
#include <logicalaccess/plugins/cards/epass/epasschip.hpp>
#include <logicalaccess/plugins/cards/epass/epassidentityservice.hpp>
#include <logicalaccess/plugins/readers/iso7816/readercardadapters/iso7816readercardadapter.hpp>
#include <logicalaccess/plugins/cards/epass/epassreadercardadapter.hpp>
#include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
#include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
#include <logicalaccess/plugins/cards/felica/felicachip.hpp>
#include <logicalaccess/plugins/cards/felica/felicastoragecardservice.hpp>
#include <logicalaccess/plugins/cards/felica/nfctag3cardservice.hpp>
#include <logicalaccess/plugins/cards/generictag/generictagchip.hpp>
#include <logicalaccess/plugins/cards/generictag/generictagaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasskey.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclassaccessinfo.hpp>
#include <logicalaccess/plugins/cards/iclass/picopasscommands.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass16kschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass2kschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_16chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_8x2chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_16chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_8x2chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass8x2kschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclassaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasslocation.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerprovider.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_fwd.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_connection.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
#include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
#include <logicalaccess/plugins/cards/iclass/pcschidiclassdatatransport.hpp>
#include <logicalaccess/plugins/cards/iclass/omnikeyhidiclassdatatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasspcsccommands.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclassstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/iclass/omnikeyxx21licensecheckerservice.hpp>
#include <logicalaccess/plugins/cards/iclass/picopasssimple.hpp>
#include <logicalaccess/plugins/cards/iclass_5321/omnikeyhidiclassdatatransportimpl.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693chip.hpp>
#include <logicalaccess/plugins/cards/icode1/icode1chip.hpp>
#include <logicalaccess/plugins/cards/icode2/icode2chip.hpp>
#include <logicalaccess/plugins/cards/indala/indalachip.hpp>
#include <logicalaccess/plugins/cards/infineonmyd/infineonmydchip.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693storagecardservice.hpp>
#include <logicalaccess/plugins/cards/legicprime/legicprimechip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
#include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarechip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifare1kchip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifare4kchip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarelocation.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarenfctagcardservice.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarestoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusaccessinfo_sl1.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusaesauth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifarepluschip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifarepluslocation.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl0chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl0commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl3auth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl3chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusstoragecardservice_sl1.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightuidchangerservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/nfctag2cardservice.hpp>
#include <logicalaccess/plugins/cards/prox/proxaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/prox/proxchip.hpp>
#include <logicalaccess/plugins/cards/prox/proxlocation.hpp>
#include <logicalaccess/plugins/cards/proxlite/proxlitechip.hpp>
#include <logicalaccess/plugins/cards/samav2/sambasickeyentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samkeyentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samkucentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samcommands.hpp>
#include <logicalaccess/plugins/cards/samav2/samchip.hpp>
#include <logicalaccess/plugins/cards/samav2/samav1chip.hpp>
#include <logicalaccess/plugins/cards/samav2/samav2chip.hpp>
#include <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
#include <logicalaccess/plugins/cards/samav2/samcrypto.hpp>
#include <logicalaccess/plugins/cards/seos/seoschip.hpp>
#include <logicalaccess/plugins/cards/smartframe/smartframechip.hpp>
#include <logicalaccess/plugins/cards/stmlri512/stmlri512chip.hpp>
#include <logicalaccess/plugins/cards/tagit/tagitcommands.hpp>
#include <logicalaccess/plugins/cards/tagit/tagitchip.hpp>
#include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
#include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
#include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
#include <logicalaccess/plugins/cards/topaz/topazchip.hpp>
#include <logicalaccess/plugins/cards/topaz/nfctag1cardservice.hpp>
#include <logicalaccess/plugins/cards/topaz/topazstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
#include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
#include <logicalaccess/plugins/cards/twic/twicchip.hpp>
#include <logicalaccess/plugins/cards/twic/twicaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/twic/twicstoragecardservice.hpp>

/* END_Additional_include */

using namespace logicalaccess;

%}

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Reader;
%}

%shared_ptr(logicalaccess::SAMCommands<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>);
%shared_ptr(logicalaccess::SAMCommands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);
%shared_ptr(logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>);
%shared_ptr(logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);
%shared_ptr(logicalaccess::SAMAV2Commands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);
%shared_ptr(logicalaccess::SAMAV2Commands<KeyEntryAV2Information, SETAV2>);
%shared_ptr(CPS3Commands);

%typemap(ctype) size_t* indexByte "size_t*"
%typemap(cstype) size_t* indexByte "out uint"
%typemap(csin) size_t* indexByte %{out $csinput%}  
%typemap(imtype) size_t* indexByte "out uint"

%typemap(ctype) logicalaccess::OmnikeyReaderUnit "logicalaccess::OmnikeyReaderUnit"
%typemap(cstype) logicalaccess::OmnikeyReaderUnit "OmnikeyReaderUnit"
%typemap(csin) logicalaccess::OmnikeyReaderUnit %{$csinput%}  
%typemap(imtype) logicalaccess::OmnikeyReaderUnit "LibLogicalAccess.Reader.OmnikeyReaderUnit"
%typemap(csout, excode=SWIGEXCODE) logicalaccess::OmnikeyReaderUnit {
	OmnikeyReaderUnit ret = $imcall;$excode
	return ret;
}

%typemap(ctype) logicalaccess::OmnikeyXX21ReaderUnit "logicalaccess::OmnikeyXX21ReaderUnit"
%typemap(cstype) logicalaccess::OmnikeyXX21ReaderUnit "OmnikeyXX21ReaderUnit"
%typemap(csin) logicalaccess::OmnikeyXX21ReaderUnit %{$csinput%}  
%typemap(imtype) logicalaccess::OmnikeyXX21ReaderUnit "LibLogicalAccess.Reader.OmnikeyXX21ReaderUnit"
%typemap(csout, excode=SWIGEXCODE) logicalaccess::OmnikeyXX21ReaderUnit {
	OmnikeyXX21ReaderUnit ret = $imcall;$excode
	return ret;
}

%typemap(ctype) logicalaccess::PCSCReaderCardAdapter "logicalaccess::PCSCReaderCardAdapter"
%typemap(cstype) logicalaccess::PCSCReaderCardAdapter "PCSCReaderCardAdapter"
%typemap(csin) logicalaccess::PCSCReaderCardAdapter %{$csinput%}  
%typemap(imtype) logicalaccess::PCSCReaderCardAdapter "LibLogicalAccess.Reader.PCSCReaderCardAdapter"
%typemap(csout, excode=SWIGEXCODE) logicalaccess::PCSCReaderCardAdapter {
	PCSCReaderCardAdapter ret = $imcall;$excode
	return ret;
}

//%typemap(ctype) DESFireKeyType "DESFireKeyType"
//%typemap(cstype) DESFireKeyType "DESFireKeyType"
//%typemap(csin) DESFireKeyType %{$csinput%}  
//%typemap(imtype) DESFireKeyType "LibLogicalAccess.Card.DESFireKeyType"
//%typemap(csout, excode=SWIGEXCODE) DESFireKeyType {
//	LibLogicalAccess.Card.DESFireKeyType ret = $imcall;$excode
//	return ret;
//}
%typemap(csvarin, excode=SWIGEXCODE2) DESFireKeyType %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) DESFireKeyType %{
    get {
      DESFireKeyType ret = $imcall;$excode
      return ret;
} %}

%typemap(ctype) DESFireKeyType& "DESFireKeyType*"
%typemap(cstype) DESFireKeyType& "out LibLogicalAccess.Card.DESFireKeyType"
%typemap(csin) DESFireKeyType& %{out $csinput%}  
%typemap(imtype) DESFireKeyType& "out LibLogicalAccess.Card.DESFireKeyType"

%typemap(ctype) DESFireKeySettings "DESFireKeySettings"
%typemap(cstype) DESFireKeySettings "DESFireKeySettings"
%typemap(csin) DESFireKeySettings %{$csinput%}  
%typemap(imtype) DESFireKeySettings "LibLogicalAccess.Card.DESFireKeySettings"
%typemap(csout, excode=SWIGEXCODE) DESFireKeySettings {
	DESFireKeySettings ret = $imcall;$excode
	return ret;
}

%typemap(ctype) logicalaccess::DESFireKeySettings & "logicalaccess::DESFireKeySettings*"
%typemap(cstype) logicalaccess::DESFireKeySettings & "out DESFireKeySettings"
%typemap(csin) logicalaccess::DESFireKeySettings & %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeySettings & "out LibLogicalAccess.Card.DESFireKeySettings"


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

%ignore logicalaccess::Commands;
%ignore pcsc_share_mode_to_string;
%ignore pcsc_protocol_to_string;

/* Include_section */

%include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816chip.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3location.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3commands.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3chip.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816storagecardservice.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3storagecardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816nfctag4cardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1nfctag4cardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirestoragecardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpkeydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpav1keydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpav2keydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/omnitechkeydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/sagemkeydiversification.hpp>
%include <logicalaccess/plugins/cards/em4102/em4102chip.hpp>
%include <logicalaccess/plugins/cards/em4135/em4135chip.hpp>
%include <logicalaccess/plugins/cards/epass/epassaccessinfo.hpp>
%include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
%include <logicalaccess/plugins/cards/epass/utils.hpp>
%include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
%include <logicalaccess/plugins/cards/epass/epasschip.hpp>
%include <logicalaccess/plugins/cards/epass/epassidentityservice.hpp>
%include <logicalaccess/plugins/readers/iso7816/readercardadapters/iso7816readercardadapter.hpp>
%include <logicalaccess/plugins/cards/epass/epassreadercardadapter.hpp>
%include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
%include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
%include <logicalaccess/plugins/cards/felica/felicachip.hpp>
%include <logicalaccess/plugins/cards/felica/felicastoragecardservice.hpp>
%include <logicalaccess/plugins/cards/felica/nfctag3cardservice.hpp>
%include <logicalaccess/plugins/cards/generictag/generictagchip.hpp>
%include <logicalaccess/plugins/cards/generictag/generictagaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasskey.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclassaccessinfo.hpp>
%include <logicalaccess/plugins/cards/iclass/picopasscommands.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass16kschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass2kschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_16chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_8x2chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_16chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_8x2chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass8x2kschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclassaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasslocation.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerprovider.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_fwd.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_connection.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
%include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
%include <logicalaccess/plugins/cards/iclass/pcschidiclassdatatransport.hpp>
%include <logicalaccess/plugins/cards/iclass/omnikeyhidiclassdatatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasspcsccommands.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclassstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/iclass/omnikeyxx21licensecheckerservice.hpp>
%include <logicalaccess/plugins/cards/iclass/picopasssimple.hpp>
%include <logicalaccess/plugins/cards/iclass_5321/omnikeyhidiclassdatatransportimpl.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693chip.hpp>
%include <logicalaccess/plugins/cards/icode1/icode1chip.hpp>
%include <logicalaccess/plugins/cards/icode2/icode2chip.hpp>
%include <logicalaccess/plugins/cards/indala/indalachip.hpp>
%include <logicalaccess/plugins/cards/infineonmyd/infineonmydchip.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693storagecardservice.hpp>
%include <logicalaccess/plugins/cards/legicprime/legicprimechip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
%include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarechip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifare1kchip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifare4kchip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarelocation.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarenfctagcardservice.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarestoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusaccessinfo_sl1.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusaesauth.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifarepluschip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifarepluslocation.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl0chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl0commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl1chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl3auth.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl3chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusstoragecardservice_sl1.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightuidchangerservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/nfctag2cardservice.hpp>
%include <logicalaccess/plugins/cards/prox/proxaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/prox/proxchip.hpp>
%include <logicalaccess/plugins/cards/prox/proxlocation.hpp>
%include <logicalaccess/plugins/cards/proxlite/proxlitechip.hpp>
%include <logicalaccess/plugins/cards/samav2/sambasickeyentry.hpp>
%include <logicalaccess/plugins/cards/samav2/samkeyentry.hpp>
%include <logicalaccess/plugins/cards/samav2/samkucentry.hpp>
%include <logicalaccess/plugins/cards/samav2/samcommands.hpp>
%include <logicalaccess/plugins/cards/samav2/samchip.hpp>
%include <logicalaccess/plugins/cards/samav2/samav1chip.hpp>
%include <logicalaccess/plugins/cards/samav2/samav2chip.hpp>
%include <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
%include <logicalaccess/plugins/cards/samav2/samcrypto.hpp>
%include <logicalaccess/plugins/cards/seos/seoschip.hpp>
%include <logicalaccess/plugins/cards/smartframe/smartframechip.hpp>
%include <logicalaccess/plugins/cards/stmlri512/stmlri512chip.hpp>
%include <logicalaccess/plugins/cards/tagit/tagitcommands.hpp>
%include <logicalaccess/plugins/cards/tagit/tagitchip.hpp>
%include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
%include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
%include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
%include <logicalaccess/plugins/cards/topaz/topazchip.hpp>
%include <logicalaccess/plugins/cards/topaz/nfctag1cardservice.hpp>
%include <logicalaccess/plugins/cards/topaz/topazstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
%include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
%include <logicalaccess/plugins/cards/twic/twicchip.hpp>
%include <logicalaccess/plugins/cards/twic/twicaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/twic/twicstoragecardservice.hpp>

/* END_Include_section */

%template(DFNameCollection) std::vector<logicalaccess::DFName>;
%template(BioInfosVector) std::vector<logicalaccess::EPassDG2::BioInfo>;
%template(AV1SAMCommands) logicalaccess::SAMCommands<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>;
%template(AV2SAMCommands) logicalaccess::SAMCommands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;
%template(AV1SAMKeyEntry) logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>;
%template(AV2SAMKeyEntry) logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;
%template(AV2SAMAV2Commands) logicalaccess::SAMAV2Commands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;
