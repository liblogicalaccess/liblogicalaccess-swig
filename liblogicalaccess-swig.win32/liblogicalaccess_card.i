/* File : liblogicalaccess_card.i */
%module(directors="1") liblogicalaccess_card

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"

%typemap(csimports) SWIGTYPE
%{
	using LibLogicalAccess;
%}

%{

/* Additional_include */

#include <logicalaccess/cards/accessinfo.hpp>
#include <logicalaccess/cards/aes128key.hpp>
#include <logicalaccess/cards/chip.hpp>
#include <logicalaccess/cards/commands.hpp>
#include <logicalaccess/cards/computermemorykeystorage.hpp>
#include <logicalaccess/cards/hmac1key.hpp>
#include <logicalaccess/cards/IKSStorage.hpp>
#include <logicalaccess/cards/keydiversification.hpp>
#include <logicalaccess/cards/keystorage.hpp>
#include <logicalaccess/cards/location.hpp>
#include <logicalaccess/cards/locationnode.hpp>
#include <logicalaccess/cards/readercardadapter.hpp>
#include <logicalaccess/cards/readermemorykeystorage.hpp>
#include <logicalaccess/cards/samkeystorage.hpp>
#include <logicalaccess/cards/tripledeskey.hpp>

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
#include <logicalaccess/plugins/cards/iclass_5321/omnikeylib/sm5x21.h>
#include <logicalaccess/plugins/cards/iclass_5321/omnikeylib/sm5x21i.h>

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

using namespace logicalaccess;

%}

/* Shared_ptr */

%shared_ptr(logicalaccess::LocationNode);
%shared_ptr(logicalaccess::Commands);
%shared_ptr(logicalaccess::AccessInfo);
%shared_ptr(logicalaccess::Location);
%shared_ptr(logicalaccess::CardService);
%shared_ptr(logicalaccess::Chip);
%shared_ptr(logicalaccess::ReaderCardAdapter);
%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::KeyDiversification);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::CPS3Commands);
%shared_ptr(logicalaccess::CPS3Chip);
%shared_ptr(logicalaccess::DESFireKey);
%shared_ptr(logicalaccess::DESFireLocation);
%shared_ptr(logicalaccess::DESFireCommands);
%shared_ptr(logicalaccess::DESFireCrypto);
%shared_ptr(logicalaccess::DESFireChip);
%shared_ptr(logicalaccess::openssl::OpenSSLSymmetricCipher);
%shared_ptr(logicalaccess::DESFireEV1Commands);
%shared_ptr(logicalaccess::DESFireEV1Chip);
%shared_ptr(logicalaccess::logicalaccess::DESFireKey);
%shared_ptr(logicalaccess::logicalaccess::NdefMessage);
%shared_ptr(logicalaccess::EPassCommand);
%shared_ptr(logicalaccess::EPassCrypto);
%shared_ptr(logicalaccess::EPassChip);
%shared_ptr(logicalaccess::EPassAccessInfo);
%shared_ptr(logicalaccess::FeliCaCommands);
%shared_ptr(logicalaccess::FeliCaChip);
%shared_ptr(logicalaccess::Format);
%shared_ptr(logicalaccess::GenericTagChip);
%shared_ptr(logicalaccess::HIDiClassChip);
%shared_ptr(logicalaccess::HIDiClassKey);
%shared_ptr(logicalaccess::PicoPassCommands);
%shared_ptr(logicalaccess::PCSCReaderCardAdapter);
%shared_ptr(logicalaccess::PCSCHIDiClassDataTransport);
%shared_ptr(logicalaccess::OmnikeyHIDiClassDataTransport);
%shared_ptr(logicalaccess::TripleDESKey);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnit);
%shared_ptr(logicalaccess::OmnikeyReaderUnit);
%shared_ptr(logicalaccess::ISO15693Commands);
%shared_ptr(logicalaccess::ISO15693Chip);
%shared_ptr(logicalaccess::ISO7816Commands);
%shared_ptr(logicalaccess::ISO7816Chip);
%shared_ptr(logicalaccess::MifareKey);
%shared_ptr(logicalaccess::MifareCommands);
%shared_ptr(logicalaccess::MifareChip);
%shared_ptr(logicalaccess::AES128Key);
%shared_ptr(logicalaccess::MifareUltralightCCommands);
%shared_ptr(logicalaccess::MifareUltralightCChip);
%shared_ptr(logicalaccess::MifareUltralightCommands);
%shared_ptr(logicalaccess::MifareUltralightChip);
%shared_ptr(logicalaccess::StorageCardService);
%shared_ptr(logicalaccess::SAMCommands<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMCommands<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMKeyEntry<T, S>);
%shared_ptr(logicalaccess::SAMKucEntry);
%shared_ptr(logicalaccess::TopazChip);
%shared_ptr(logicalaccess::TopazCommands);
%shared_ptr(logicalaccess::TwicChip);
%shared_ptr(logicalaccess::TwicCommands);
%shared_ptr(logicalaccess::TwicLocation);

/* END_Shared_ptr */

typedef std::shared_ptr<logicalaccess::Chip> ChipPtr;
typedef std::shared_ptr<logicalaccess::Key> KeyPtr;

%apply unsigned int *INOUT { unsigned int* pos };
%apply unsigned int INOUT[] { unsigned int* locations, unsigned int* positions };

//%ignore logicalaccess::Commands;
%ignore pcsc_share_mode_to_string;
%ignore pcsc_protocol_to_string;

%rename(IsEqual) operator==;
%rename(IsDifferent) operator!=;
%rename(CompareTo) operator<;
%ignore operator<<;

%include "liblogicalaccess_cardservice.i"

/* Include_section */

%include <logicalaccess/cards/accessinfo.hpp>
%include <logicalaccess/cards/aes128key.hpp>
%include <logicalaccess/cards/chip.hpp>
%include <logicalaccess/cards/commands.hpp>
%include <logicalaccess/cards/computermemorykeystorage.hpp>
%include <logicalaccess/cards/hmac1key.hpp>
%include <logicalaccess/cards/IKSStorage.hpp>
%include <logicalaccess/cards/keydiversification.hpp>
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/cards/location.hpp>
%include <logicalaccess/cards/locationnode.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
%include <logicalaccess/cards/readermemorykeystorage.hpp>
%include <logicalaccess/cards/samkeystorage.hpp>
%include <logicalaccess/cards/tripledeskey.hpp>

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
%include <logicalaccess/plugins/cards/iclass_5321/omnikeylib/sm5x21.h>
%include <logicalaccess/plugins/cards/iclass_5321/omnikeylib/sm5x21i.h>

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

%template(ChipCollection) std::vector<std::shared_ptr<logicalaccess::Chip> >;
%template(LocationNodeCollection) std::vector<std::shared_ptr<logicalaccess::LocationNode> >;
%template(DFNameCollection) std::vector<logicalaccess::DFName>;

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> chipDictionary;

	public static System.Collections.Generic.Dictionary<string, System.Type> createDictionary<T>() where T : class
	{
        System.Collections.Generic.Dictionary<string, System.Type> dictionary = new System.Collections.Generic.Dictionary<string, System.Type>();
        foreach (System.Type type in
            System.Reflection.Assembly.GetAssembly(typeof(T)).GetTypes())
        {
            if (type.IsClass && !type.IsAbstract && type.IsSubclassOf(typeof(T)))
            {
                string tmp = type.ToString().Split('.')[type.ToString().Split('.').Length - 1].Substring(0, type.ToString().Split('.')[type.ToString().Split('.').Length - 1].IndexOf(typeof(T).Name));
                dictionary.Add(tmp, type);
            }
        }
        return dictionary;
	}

	public static Chip	createChip(System.IntPtr cPtr, bool owner)
	{
		Chip ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = (liblogicalaccess_cardPINVOKE.Chip_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (chipDictionary == null)
			chipDictionary = createDictionary<Chip>();
        if (chipDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Chip)System.Activator.CreateInstance(chipDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Chip*, std::shared_ptr<logicalaccess::Chip> {
    System.IntPtr cPtr = $imcall;
    Chip ret = liblogicalaccess_cardPINVOKE.createChip(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> locationDictionary;

	public static Location	createLocation(System.IntPtr cPtr, bool owner)
	{
		Location ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($modulePINVOKE.Location_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (locationDictionary == null)
			locationDictionary = createDictionary<Location>();
        if (locationDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Location)System.Activator.CreateInstance(locationDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Location*, std::shared_ptr<logicalaccess::Location> {
    System.IntPtr cPtr = $imcall;
    Location ret = liblogicalaccess_cardPINVOKE.createLocation(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> accessInfoDictionary;

	public static AccessInfo	createAccessInfo(System.IntPtr cPtr, bool owner)
	{
		AccessInfo ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($modulePINVOKE.AccessInfo_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (accessInfoDictionary == null)
			accessInfoDictionary = createDictionary<AccessInfo>();
        if (accessInfoDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (AccessInfo)System.Activator.CreateInstance(accessInfoDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::AccessInfo*, std::shared_ptr<logicalaccess::AccessInfo> {
    System.IntPtr cPtr = $imcall;
    AccessInfo ret = liblogicalaccess_cardPINVOKE.createAccessInfo(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
  public static KeyStorage createKeyStorage(System.IntPtr cPtr, bool owner)
  {
    KeyStorage ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	KeyStorageType ks = (KeyStorageType)($modulePINVOKE.KeyStorage_getType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
    switch (ks) {
	   case KeyStorageType.KST_COMPUTER_MEMORY:
	     ret = new ComputerMemoryKeyStorage(cPtr, owner);
	     break;
	   case KeyStorageType.KST_READER_MEMORY:
	     ret = new ReaderMemoryKeyStorage(cPtr, owner);
		 break;
	   case KeyStorageType.KST_SAM:
	     ret = new SAMKeyStorage(cPtr, owner);
		 break;
	   case KeyStorageType.KST_SERVER:
	     ret = new IKSStorage(cPtr, owner);
		 break;
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::KeyStorage*, std::shared_ptr<logicalaccess::KeyStorage> {
    System.IntPtr cPtr = $imcall;
    KeyStorage ret = liblogicalaccess_cardPINVOKE.createKeyStorage(cPtr, $owner);$excode
    return ret;
}