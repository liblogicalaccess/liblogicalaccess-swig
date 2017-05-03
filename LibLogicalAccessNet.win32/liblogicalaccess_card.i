/* File : liblogicalaccess_card.i */
%module(directors="1") liblogicalaccess_card

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_core.i"
%import "liblogicalaccess_iks.i"

%{

/* Additional_include */

#include <logicalaccess/plugins/cards/cps3/cps3chip.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3commands.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3location.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3storagecardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1nfctag4cardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirestoragecardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpav1keydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpav2keydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpkeydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/omnitechkeydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/sagemkeydiversification.hpp>
#include <logicalaccess/plugins/cards/em4102/em4102chip.hpp>
#include <logicalaccess/plugins/cards/em4135/em4135chip.hpp>
#include <logicalaccess/plugins/cards/epass/epassaccessinfo.hpp>
#include <logicalaccess/plugins/cards/epass/epasschip.hpp>
#include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
#include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
#include <logicalaccess/plugins/cards/epass/epassidentityservice.hpp>
#include <logicalaccess/plugins/cards/epass/epassreadercardadapter.hpp>
#include <logicalaccess/plugins/cards/epass/utils.hpp>
#include <logicalaccess/plugins/cards/felica/felicachip.hpp>
#include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
#include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
#include <logicalaccess/plugins/cards/felica/felicastoragecardservice.hpp>
#include <logicalaccess/plugins/cards/felica/nfctag3cardservice.hpp>
#include <logicalaccess/plugins/cards/generictag/generictagaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/generictag/generictagchip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass16kschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass2kschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_16chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_8x2chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_16chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_8x2chip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclass8x2kschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclassaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclassaccessinfo.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasschip.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasskey.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasslocation.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclasspcsccommands.hpp>
#include <logicalaccess/plugins/cards/iclass/hidiclassstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/iclass/omnikeyhidiclassdatatransport.hpp>
#include <logicalaccess/plugins/cards/iclass/OmnikeyXX21LicenseCheckerService.hpp>
#include <logicalaccess/plugins/cards/iclass/pcschidiclassdatatransport.hpp>
#include <logicalaccess/plugins/cards/iclass/picopasscommands.hpp>
#include <logicalaccess/plugins/cards/iclass/picopasssimple.hpp>
#include <logicalaccess/plugins/cards/iclass_5321/omnikeyhidiclassdatatransportimpl.hpp>
#include <logicalaccess/plugins/cards/icode1/icode1chip.hpp>
#include <logicalaccess/plugins/cards/icode2/icode2chip.hpp>
#include <logicalaccess/plugins/cards/indala/indalachip.hpp>
#include <logicalaccess/plugins/cards/infineonmyd/infineonmydchip.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693chip.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693storagecardservice.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816chip.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816nfctag4cardservice.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816storagecardservice.hpp>
#include <logicalaccess/plugins/cards/legicprime/legicprimechip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifare1kchip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifare4kchip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarechip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarelocation.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarenfctagcardservice.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarestoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusaccessinfo_sl1.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusAESAuth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifarepluschip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifarepluslocation.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL1Chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Auth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusstoragecardservice_sl1.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightuidchangerservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/nfctag2cardservice.hpp>
#include <logicalaccess/plugins/cards/prox/proxaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/prox/proxchip.hpp>
#include <logicalaccess/plugins/cards/prox/proxlocation.hpp>
#include <logicalaccess/plugins/cards/proxlite/proxlitechip.hpp>
#include <logicalaccess/plugins/cards/samav2/samav1chip.hpp>
#include <logicalaccess/plugins/cards/samav2/samav2chip.hpp>
#include <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
#include <logicalaccess/plugins/cards/samav2/sambasickeyentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samchip.hpp>
#include <logicalaccess/plugins/cards/samav2/samcommands.hpp>
#include <logicalaccess/plugins/cards/samav2/samcrypto.hpp>
#include <logicalaccess/plugins/cards/samav2/samkeyentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samkucentry.hpp>
#include <logicalaccess/plugins/cards/seos/seoschip.hpp>
#include <logicalaccess/plugins/cards/smartframe/smartframechip.hpp>
#include <logicalaccess/plugins/cards/stmlri512/stmlri512chip.hpp>
#include <logicalaccess/plugins/cards/tagit/tagitchip.hpp>
#include <logicalaccess/plugins/cards/tagit/tagitcommands.hpp>
#include <logicalaccess/plugins/cards/topaz/nfctag1cardservice.hpp>
#include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
#include <logicalaccess/plugins/cards/topaz/topazchip.hpp>
#include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
#include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
#include <logicalaccess/plugins/cards/topaz/topazstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/twic/twicaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/twic/twicchip.hpp>
#include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
#include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
#include <logicalaccess/plugins/cards/twic/twicstoragecardservice.hpp>

/* END_Additional_include */

#include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>

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

%typemap(ctype) size_t* indexByte "size_t*"
%typemap(cstype) size_t* indexByte "out uint"
%typemap(csin) size_t* indexByte %{out $csinput%}  
%typemap(imtype) size_t* indexByte "out uint"

%typemap(ctype) EncryptionMode "EncryptionMode"
%typemap(cstype) EncryptionMode "EncryptionMode"
%typemap(csin) EncryptionMode %{$csinput%}  
%typemap(imtype) EncryptionMode "EncryptionMode"
%typemap(csout, excode=SWIGEXCODE) EncryptionMode {
	EncryptionMode ret = $imcall;$excode
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

%typemap(ctype) OmnikeyXX21ReaderUnit::SecureModeStatus "OmnikeyXX21ReaderUnit::SecureModeStatus"
%typemap(cstype) OmnikeyXX21ReaderUnit::SecureModeStatus "OmnikeyXX21ReaderUnit.SecureModeStatus"
%typemap(csin) OmnikeyXX21ReaderUnit::SecureModeStatus %{$csinput%}  
%typemap(imtype) OmnikeyXX21ReaderUnit::SecureModeStatus "LibLogicalAccess.Reader.OmnikeyXX21ReaderUnit.SecureModeStatus"
%typemap(csout, excode=SWIGEXCODE) OmnikeyXX21ReaderUnit::SecureModeStatus {
	OmnikeyXX21ReaderUnit.SecureModeStatus ret = $imcall;$excode
	return ret;
}

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

CSHARP_MEMBER_ARRAYS(unsigned char recordSize[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char maxNumberRecords[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char currentNumberRecords[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char accessRights[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char uid[ANY], byte )
CSHARP_MEMBER_ARRAYS(unsigned char batchNo[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char fileSize[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char keytype[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char rfu[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char desfireAid[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char set[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char keyclass[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char dfname[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char limit[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char curval[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char productionbatchnumber[ANY], byte)
CSHARP_MEMBER_ARRAYS(unsigned char uniqueserialnumber[ANY], byte)

//%ignore logicalaccess::Commands;
%ignore pcsc_share_mode_to_string;
%ignore pcsc_protocol_to_string;

/* Include_section */

%include <logicalaccess/plugins/cards/cps3/cps3chip.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3commands.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3location.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3storagecardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1nfctag4cardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirestoragecardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpav1keydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpav2keydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpkeydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/omnitechkeydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/sagemkeydiversification.hpp>
%include <logicalaccess/plugins/cards/em4102/em4102chip.hpp>
%include <logicalaccess/plugins/cards/em4135/em4135chip.hpp>
%include <logicalaccess/plugins/cards/epass/epassaccessinfo.hpp>
%include <logicalaccess/plugins/cards/epass/epasschip.hpp>
%include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
%include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
%include <logicalaccess/plugins/cards/epass/epassidentityservice.hpp>
%include <logicalaccess/plugins/cards/epass/epassreadercardadapter.hpp>
%include <logicalaccess/plugins/cards/epass/utils.hpp>
%include <logicalaccess/plugins/cards/felica/felicachip.hpp>
%include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
%include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
%include <logicalaccess/plugins/cards/felica/felicastoragecardservice.hpp>
%include <logicalaccess/plugins/cards/felica/nfctag3cardservice.hpp>
%include <logicalaccess/plugins/cards/generictag/generictagaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/generictag/generictagchip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass16kschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass2kschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_16chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_16_8x2chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_16chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass32ks_8x2_8x2chip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclass8x2kschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclassaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclassaccessinfo.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasschip.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasskey.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasslocation.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclasspcsccommands.hpp>
%include <logicalaccess/plugins/cards/iclass/hidiclassstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/iclass/omnikeyhidiclassdatatransport.hpp>
%include <logicalaccess/plugins/cards/iclass/OmnikeyXX21LicenseCheckerService.hpp>
%include <logicalaccess/plugins/cards/iclass/pcschidiclassdatatransport.hpp>
%include <logicalaccess/plugins/cards/iclass/picopasscommands.hpp>
%include <logicalaccess/plugins/cards/iclass/picopasssimple.hpp>
%include <logicalaccess/plugins/cards/iclass_5321/omnikeyhidiclassdatatransportimpl.hpp>
%include <logicalaccess/plugins/cards/icode1/icode1chip.hpp>
%include <logicalaccess/plugins/cards/icode2/icode2chip.hpp>
%include <logicalaccess/plugins/cards/indala/indalachip.hpp>
%include <logicalaccess/plugins/cards/infineonmyd/infineonmydchip.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693chip.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693storagecardservice.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816chip.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816nfctag4cardservice.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816storagecardservice.hpp>
%include <logicalaccess/plugins/cards/legicprime/legicprimechip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifare1kchip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifare4kchip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarechip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarelocation.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarenfctagcardservice.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarestoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusaccessinfo_sl1.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusAESAuth.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifarepluschip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifarepluslocation.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL1Chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Auth.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusstoragecardservice_sl1.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightuidchangerservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/nfctag2cardservice.hpp>
%include <logicalaccess/plugins/cards/prox/proxaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/prox/proxchip.hpp>
%include <logicalaccess/plugins/cards/prox/proxlocation.hpp>
%include <logicalaccess/plugins/cards/proxlite/proxlitechip.hpp>
%include <logicalaccess/plugins/cards/samav2/samav1chip.hpp>
%include <logicalaccess/plugins/cards/samav2/samav2chip.hpp>
%include <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
%include <logicalaccess/plugins/cards/samav2/sambasickeyentry.hpp>
%include <logicalaccess/plugins/cards/samav2/samchip.hpp>
%include <logicalaccess/plugins/cards/samav2/samcommands.hpp>
%include <logicalaccess/plugins/cards/samav2/samcrypto.hpp>
%include <logicalaccess/plugins/cards/samav2/samkeyentry.hpp>
%include <logicalaccess/plugins/cards/samav2/samkucentry.hpp>
%include <logicalaccess/plugins/cards/seos/seoschip.hpp>
%include <logicalaccess/plugins/cards/smartframe/smartframechip.hpp>
%include <logicalaccess/plugins/cards/stmlri512/stmlri512chip.hpp>
%include <logicalaccess/plugins/cards/tagit/tagitchip.hpp>
%include <logicalaccess/plugins/cards/tagit/tagitcommands.hpp>
%include <logicalaccess/plugins/cards/topaz/nfctag1cardservice.hpp>
%include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
%include <logicalaccess/plugins/cards/topaz/topazchip.hpp>
%include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
%include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
%include <logicalaccess/plugins/cards/topaz/topazstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/twic/twicaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/twic/twicchip.hpp>
%include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
%include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
%include <logicalaccess/plugins/cards/twic/twicstoragecardservice.hpp>

/* END_Include_section */

//%include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
//%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
//%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
//%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>

%feature("flatnested") EPassDG2::BioInfo; 

%template(DFNameCollection) std::vector<logicalaccess::DFName>;
%template(BioInfosVector) std::vector<logicalaccess::EPassDG2::BioInfo>;
%template(AV1SAMCommands) logicalaccess::SAMCommands<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>;
%template(AV2SAMCommands) logicalaccess::SAMCommands<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;
%template(AV1SAMKeyEntry) logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>;
%template(AV2SAMKeyEntry) logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>;