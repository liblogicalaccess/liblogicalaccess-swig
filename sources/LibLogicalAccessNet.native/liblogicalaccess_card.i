/* File : liblogicalaccess_card.i */
%module(directors="1") liblogicalaccess_card

%include "liblogicalaccess.i"
%import "liblogicalaccess_exception.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_core.i"

%{
/* Additional_include */

#include <logicalaccess/plugins/cards/iso7816/lla_cards_iso7816_api.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816chip.hpp>
#include <logicalaccess/plugins/cards/cps3/lla_cards_cps3_api.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3location.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3commands.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3chip.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816storagecardservice.hpp>
#include <logicalaccess/plugins/cards/cps3/cps3storagecardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/lla_cards_desfire_api.hpp>
#include <logicalaccess/plugins/llacommon/lla_common_api.hpp>
#include <logicalaccess/plugins/llacommon/logs.hpp>
#include <logicalaccess/plugins/cards/desfire/desfire_json_dump_card_service.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
#include <logicalaccess/plugins/crypto/lla_crypto_api.hpp>
#include <logicalaccess/plugins/crypto/initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/des_cipher.hpp>
#include <logicalaccess/plugins/crypto/aes_cipher.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816nfctag4cardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1nfctag4cardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev2commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev2chip.hpp>
#include <logicalaccess/plugins/cards/samav/lla_cards_samav_api.hpp>
#include <logicalaccess/plugins/cards/samav/sambasickeyentry.hpp>
#include <logicalaccess/plugins/cards/samav/samkeyentry.hpp>
#include <logicalaccess/plugins/cards/samav/samkucentry.hpp>
#include <logicalaccess/plugins/cards/samav/samcommands.hpp>
#include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816response.hpp>
#include <logicalaccess/plugins/crypto/sha.hpp>
#include <logicalaccess/plugins/crypto/iso24727crypto.hpp>
#include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816readercardadapter.hpp>
#include <logicalaccess/plugins/readers/iso7816/lla_readers_iso7816_api.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
#include <logicalaccess/plugins/cards/samav/samcrypto.hpp>
#include <logicalaccess/plugins/crypto/symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/aes_symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/openssl.hpp>
#include <logicalaccess/plugins/crypto/cmac.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
#include <logicalaccess/plugins/cards/samav/samav2commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
#include <logicalaccess/plugins/cards/samav/samav3commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav3iso7816commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev2crypto.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev3commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev3chip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirestoragecardservice.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpkeydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpav1keydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/nxpav2keydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/omnitechkeydiversification.hpp>
#include <logicalaccess/plugins/cards/desfire/sagemkeydiversification.hpp>
#include <logicalaccess/plugins/cards/em4102/lla_cards_em4102_api.hpp>
#include <logicalaccess/plugins/cards/em4102/em4102chip.hpp>
#include <logicalaccess/plugins/cards/em4135/lla_cards_em4135_api.hpp>
#include <logicalaccess/plugins/cards/em4135/em4135chip.hpp>
#include <logicalaccess/plugins/cards/epass/lla_cards_epass_api.hpp>
#include <logicalaccess/plugins/cards/epass/epassaccessinfo.hpp>
#include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
#include <logicalaccess/plugins/cards/epass/utils.hpp>
#include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
#include <logicalaccess/plugins/cards/epass/epasschip.hpp>
#include <logicalaccess/plugins/cards/epass/epassidentitycardservice.hpp>
#include <logicalaccess/plugins/cards/felica/lla_cards_felica_api.hpp>
#include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
#include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
#include <logicalaccess/plugins/cards/felica/felicachip.hpp>
#include <logicalaccess/plugins/cards/felica/felicastoragecardservice.hpp>
#include <logicalaccess/plugins/cards/felica/nfctag3cardservice.hpp>
#include <logicalaccess/plugins/cards/generictag/lla_cards_generictag_api.hpp>
#include <logicalaccess/plugins/cards/generictag/generictagchip.hpp>
#include <logicalaccess/plugins/cards/generictag/generictagaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/iso15693/lla_cards_iso15693_api.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693chip.hpp>
#include <logicalaccess/plugins/cards/icode1/lla_cards_icode1_api.hpp>
#include <logicalaccess/plugins/cards/icode1/icode1chip.hpp>
#include <logicalaccess/plugins/cards/icode2/lla_cards_icode2_api.hpp>
#include <logicalaccess/plugins/cards/icode2/icode2chip.hpp>
#include <logicalaccess/plugins/cards/indala/lla_cards_indala_api.hpp>
#include <logicalaccess/plugins/cards/indala/indalachip.hpp>
#include <logicalaccess/plugins/cards/infineonmyd/lla_cards_infineonmyd_api.hpp>
#include <logicalaccess/plugins/cards/infineonmyd/infineonmydchip.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693storagecardservice.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816fuzzingreadercardadapter.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816readercardadapter.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816response.hpp>
#include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816fuzzingreadercardadapter.hpp>
#include <logicalaccess/plugins/cards/keyboard/lla_readers_private_keyboard_api.hpp>
#include <logicalaccess/plugins/cards/legicprime/lla_cards_legicprime_api.hpp>
#include <logicalaccess/plugins/cards/legicprime/legicprimechip.hpp>
#include <logicalaccess/plugins/cards/mifare/lla_cards_mifare_api.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
#include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarechip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifare1kchip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifare4kchip.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarelocation.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarenfctagcardservice.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarestoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareplus/lla_cards_mifareplus_api.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusAESAuth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifarepluschip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL1Chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Auth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Chip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifarepluslocation.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusschip.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1accessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1storagecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplusxchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/lla_cards_mifareultralight_api.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcchip.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightuidchangercardservice.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/nfctag2cardservice.hpp>
#include <logicalaccess/plugins/cards/prox/lla_cards_prox_api.hpp>
#include <logicalaccess/plugins/cards/prox/proxaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/prox/proxchip.hpp>
#include <logicalaccess/plugins/cards/prox/proxlocation.hpp>
#include <logicalaccess/plugins/cards/proxlite/lla_cards_proxlite_api.hpp>
#include <logicalaccess/plugins/cards/proxlite/proxlitechip.hpp>
#include <logicalaccess/plugins/cards/samav/samav1chip.hpp>
#include <logicalaccess/plugins/cards/samav/samav2chip.hpp>
#include <logicalaccess/plugins/cards/samav/samav3chip.hpp>
#include <logicalaccess/plugins/cards/seos/lla_cards_seos_api.hpp>
#include <logicalaccess/plugins/cards/seos/seoscommands.hpp>
#include <logicalaccess/plugins/cards/seos/seoschip.hpp>
#include <logicalaccess/plugins/cards/seos/seoskey.hpp>
#include <logicalaccess/plugins/cards/smartframe/lla_cards_smartframe_api.hpp>
#include <logicalaccess/plugins/cards/smartframe/smartframechip.hpp>
#include <logicalaccess/plugins/cards/stmlri/lla_cards_stmlri_api.hpp>
#include <logicalaccess/plugins/cards/stmlri/stmlri512chip.hpp>
#include <logicalaccess/plugins/cards/tagit/lla_cards_tagit_api.hpp>
#include <logicalaccess/plugins/cards/tagit/tagitcommands.hpp>
#include <logicalaccess/plugins/cards/tagit/tagitchip.hpp>
#include <logicalaccess/plugins/cards/topaz/lla_cards_topaz_api.hpp>
#include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
#include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
#include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
#include <logicalaccess/plugins/cards/topaz/topazchip.hpp>
#include <logicalaccess/plugins/cards/topaz/nfctag1cardservice.hpp>
#include <logicalaccess/plugins/cards/topaz/topazstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/twic/lla_cards_twic_api.hpp>
#include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
#include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
#include <logicalaccess/plugins/cards/twic/twicchip.hpp>
#include <logicalaccess/plugins/cards/twic/twicaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/cards/twic/twicstoragecardservice.hpp>
#include <logicalaccess/plugins/cards/yubikey/lla_cards_yubikey_api.hpp>
#include <logicalaccess/plugins/cards/yubikey/yubikeycommands.hpp>
#include <logicalaccess/plugins/cards/yubikey/yubikeychip.hpp>
#include <logicalaccess/plugins/cards/yubikey/yubikeychallengecardservice.hpp>

/* END_Additional_include */

using namespace logicalaccess;

%}

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Crypto;
using LibLogicalAccess.Reader;
%}

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

%typemap(csvarin, excode=SWIGEXCODE2) DESFireKeyType %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) DESFireKeyType %{
    get {
      DESFireKeyType ret = $imcall;$excode
      return ret;
} %}

%typemap(ctype) logicalaccess::DESFireKeyType& "DESFireKeyType*"
%typemap(cstype) logicalaccess::DESFireKeyType& "out DESFireKeyType"
%typemap(csin) logicalaccess::DESFireKeyType& %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeyType& "out LibLogicalAccess.Card.DESFireKeyType"

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
%apply logicalaccess::MifareAccessInfo::DataBlockAccessBits MBINOUT[] { logicalaccess::MifareAccessInfo::DataBlockAccessBits d_data_blocks_access_bits[ANY] }

%ignore logicalaccess::Commands;
%ignore pcsc_share_mode_to_string;
%ignore pcsc_protocol_to_string;
%ignore *::getTime;

%include "liblogicalaccess_card_sam.i"
%import "liblogicalaccess_reader_sam.i"

/* Include_section */

%include <logicalaccess/plugins/cards/iso7816/lla_cards_iso7816_api.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816chip.hpp>
%include <logicalaccess/plugins/cards/cps3/lla_cards_cps3_api.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3location.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3commands.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3chip.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816storagecardservice.hpp>
%include <logicalaccess/plugins/cards/cps3/cps3storagecardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/lla_cards_desfire_api.hpp>
%import <logicalaccess/plugins/llacommon/lla_common_api.hpp>
%import <logicalaccess/plugins/llacommon/logs.hpp>
%include <logicalaccess/plugins/cards/desfire/desfire_json_dump_card_service.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
%import <logicalaccess/plugins/crypto/lla_crypto_api.hpp>
%import <logicalaccess/plugins/crypto/initialization_vector.hpp>
%import <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
%import <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>
%import <logicalaccess/plugins/crypto/des_cipher.hpp>
%import <logicalaccess/plugins/crypto/aes_cipher.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816nfctag4cardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev1nfctag4cardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev2commands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev2chip.hpp>
%include <logicalaccess/plugins/cards/samav/lla_cards_samav_api.hpp>
%include <logicalaccess/plugins/cards/samav/sambasickeyentry.hpp>
%include <logicalaccess/plugins/cards/samav/samkeyentry.hpp>
%include <logicalaccess/plugins/cards/samav/samkucentry.hpp>
%include <logicalaccess/plugins/cards/samav/samcommands.hpp>
%include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816response.hpp>
%import <logicalaccess/plugins/crypto/sha.hpp>
%import <logicalaccess/plugins/crypto/iso24727crypto.hpp>
%include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816readercardadapter.hpp>
%import <logicalaccess/plugins/readers/iso7816/lla_readers_iso7816_api.hpp>
%import <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
%include <logicalaccess/plugins/cards/samav/samcrypto.hpp>
%import <logicalaccess/plugins/crypto/symmetric_key.hpp>
%import <logicalaccess/plugins/crypto/aes_symmetric_key.hpp>
%import <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
%import <logicalaccess/plugins/crypto/openssl.hpp>
%import <logicalaccess/plugins/crypto/cmac.hpp>
%import <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
%import <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
%include <logicalaccess/plugins/cards/samav/samav2commands.hpp>
%import <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
%include <logicalaccess/plugins/cards/samav/samav3commands.hpp>
%import <logicalaccess/plugins/readers/iso7816/commands/samav3iso7816commands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev2crypto.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev3commands.hpp>
%include <logicalaccess/plugins/cards/desfire/desfireev3chip.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirestoragecardservice.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpkeydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpav1keydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/nxpav2keydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/omnitechkeydiversification.hpp>
%include <logicalaccess/plugins/cards/desfire/sagemkeydiversification.hpp>
%include <logicalaccess/plugins/cards/em4102/lla_cards_em4102_api.hpp>
%include <logicalaccess/plugins/cards/em4102/em4102chip.hpp>
%include <logicalaccess/plugins/cards/em4135/lla_cards_em4135_api.hpp>
%include <logicalaccess/plugins/cards/em4135/em4135chip.hpp>
%include <logicalaccess/plugins/cards/epass/lla_cards_epass_api.hpp>
%include <logicalaccess/plugins/cards/epass/epassaccessinfo.hpp>
%include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
%include <logicalaccess/plugins/cards/epass/utils.hpp>
%include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
%include <logicalaccess/plugins/cards/epass/epasschip.hpp>
%include <logicalaccess/plugins/cards/epass/epassidentitycardservice.hpp>
%include <logicalaccess/plugins/cards/felica/lla_cards_felica_api.hpp>
%include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
%include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
%include <logicalaccess/plugins/cards/felica/felicachip.hpp>
%include <logicalaccess/plugins/cards/felica/felicastoragecardservice.hpp>
%include <logicalaccess/plugins/cards/felica/nfctag3cardservice.hpp>
%include <logicalaccess/plugins/cards/generictag/lla_cards_generictag_api.hpp>
%include <logicalaccess/plugins/cards/generictag/generictagchip.hpp>
%include <logicalaccess/plugins/cards/generictag/generictagaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/iso15693/lla_cards_iso15693_api.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693chip.hpp>
%include <logicalaccess/plugins/cards/icode1/lla_cards_icode1_api.hpp>
%include <logicalaccess/plugins/cards/icode1/icode1chip.hpp>
%include <logicalaccess/plugins/cards/icode2/lla_cards_icode2_api.hpp>
%include <logicalaccess/plugins/cards/icode2/icode2chip.hpp>
%include <logicalaccess/plugins/cards/indala/lla_cards_indala_api.hpp>
%include <logicalaccess/plugins/cards/indala/indalachip.hpp>
%include <logicalaccess/plugins/cards/infineonmyd/lla_cards_infineonmyd_api.hpp>
%include <logicalaccess/plugins/cards/infineonmyd/infineonmydchip.hpp>
%include <logicalaccess/plugins/cards/iso15693/iso15693storagecardservice.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816fuzzingreadercardadapter.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816readercardadapter.hpp>
%include <logicalaccess/plugins/cards/iso7816/iso7816response.hpp>
%include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816fuzzingreadercardadapter.hpp>
%include <logicalaccess/plugins/cards/keyboard/lla_readers_private_keyboard_api.hpp>
%include <logicalaccess/plugins/cards/legicprime/lla_cards_legicprime_api.hpp>
%include <logicalaccess/plugins/cards/legicprime/legicprimechip.hpp>
%include <logicalaccess/plugins/cards/mifare/lla_cards_mifare_api.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
%include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarechip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifare1kchip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifare4kchip.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarelocation.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarenfctagcardservice.hpp>
%include <logicalaccess/plugins/cards/mifare/mifarestoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareplus/lla_cards_mifareplus_api.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusAESAuth.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifarepluschip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL0Commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL1Chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Auth.hpp>
%include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Chip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifarepluslocation.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusschip.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl1accessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl1storagecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
%include <logicalaccess/plugins/cards/mifareplus/mifareplusxchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/lla_cards_mifareultralight_api.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcchip.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/mifareultralightuidchangercardservice.hpp>
%include <logicalaccess/plugins/cards/mifareultralight/nfctag2cardservice.hpp>
%include <logicalaccess/plugins/cards/prox/lla_cards_prox_api.hpp>
%include <logicalaccess/plugins/cards/prox/proxaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/prox/proxchip.hpp>
%include <logicalaccess/plugins/cards/prox/proxlocation.hpp>
%include <logicalaccess/plugins/cards/proxlite/lla_cards_proxlite_api.hpp>
%include <logicalaccess/plugins/cards/proxlite/proxlitechip.hpp>
%include <logicalaccess/plugins/cards/samav/samav1chip.hpp>
%include <logicalaccess/plugins/cards/samav/samav2chip.hpp>
%include <logicalaccess/plugins/cards/samav/samav3chip.hpp>
%include <logicalaccess/plugins/cards/seos/lla_cards_seos_api.hpp>
%include <logicalaccess/plugins/cards/seos/seoscommands.hpp>
%include <logicalaccess/plugins/cards/seos/seoschip.hpp>
%include <logicalaccess/plugins/cards/seos/seoskey.hpp>
%include <logicalaccess/plugins/cards/smartframe/lla_cards_smartframe_api.hpp>
%include <logicalaccess/plugins/cards/smartframe/smartframechip.hpp>
%include <logicalaccess/plugins/cards/stmlri/lla_cards_stmlri_api.hpp>
%include <logicalaccess/plugins/cards/stmlri/stmlri512chip.hpp>
%include <logicalaccess/plugins/cards/tagit/lla_cards_tagit_api.hpp>
%include <logicalaccess/plugins/cards/tagit/tagitcommands.hpp>
%include <logicalaccess/plugins/cards/tagit/tagitchip.hpp>
%include <logicalaccess/plugins/cards/topaz/lla_cards_topaz_api.hpp>
%include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
%include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
%include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
%include <logicalaccess/plugins/cards/topaz/topazchip.hpp>
%include <logicalaccess/plugins/cards/topaz/nfctag1cardservice.hpp>
%include <logicalaccess/plugins/cards/topaz/topazstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/twic/lla_cards_twic_api.hpp>
%include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
%include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
%include <logicalaccess/plugins/cards/twic/twicchip.hpp>
%include <logicalaccess/plugins/cards/twic/twicaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/cards/twic/twicstoragecardservice.hpp>
%include <logicalaccess/plugins/cards/yubikey/lla_cards_yubikey_api.hpp>
%include <logicalaccess/plugins/cards/yubikey/yubikeycommands.hpp>
%include <logicalaccess/plugins/cards/yubikey/yubikeychip.hpp>
%include <logicalaccess/plugins/cards/yubikey/yubikeychallengecardservice.hpp>

/* END_Include_section */

%template(BioInfosVector) std::vector<logicalaccess::EPassDG2::BioInfo>;
%template(DFNameVector) std::vector<logicalaccess::DFName>;
%template(DESFireAccessRightsVector) std::vector<logicalaccess::DESFireAccessRights>;
%template(YubikeyListItemVector) std::vector<logicalaccess::s_YubikeyListItem>;
%template(YubikeyCalculateResponseVector) std::vector<logicalaccess::s_YubikeyCalculateResponse>;