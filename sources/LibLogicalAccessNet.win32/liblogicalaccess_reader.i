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

#include <logicalaccess/plugins/readers/deister/lla_readers_deister_api.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderunit.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderprovider.hpp>
#include <logicalaccess/plugins/readers/deister/readercardadapters/deisterbufferparser.hpp>
#include <logicalaccess/plugins/readers/deister/readercardadapters/deisterreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/deister/readercardadapters/deisterserialportdatatransport.hpp>
#include <logicalaccess/plugins/readers/elatec/lla_readers_elatec_api.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderunit.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderprovider.hpp>
#include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecbufferparser.hpp>
#include <logicalaccess/plugins/llacommon/lla_common_api.hpp>
#include <logicalaccess/plugins/llacommon/logs.hpp>
#include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecserialportdatatransport.hpp>
#include <logicalaccess/plugins/readers/gunnebo/lla_readers_gunnebo_api.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunit.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderprovider.hpp>
#include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunnebobufferparser.hpp>
#include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunneboreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunneboserialportdatatransport.hpp>
#include <logicalaccess/plugins/cards/desfire/lla_cards_desfire_api.hpp>
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
#include <logicalaccess/plugins/cards/iso7816/lla_cards_iso7816_api.hpp>
#include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816response.hpp>
#include <logicalaccess/plugins/crypto/sha.hpp>
#include <logicalaccess/plugins/crypto/iso24727crypto.hpp>
#include <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816readercardadapter.hpp>
#include <logicalaccess/plugins/readers/iso7816/lla_readers_iso7816_api.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
#include <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/iso7816iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/desfireev1iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816resultchecker.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816resultchecker.hpp>
#include <logicalaccess/plugins/cards/epass/lla_cards_epass_api.hpp>
#include <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
#include <logicalaccess/plugins/cards/epass/utils.hpp>
#include <logicalaccess/plugins/cards/epass/epasscommands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/epassiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/mifareplusiso7816resultchecker.hpp>
#include <logicalaccess/plugins/cards/samav2/lla_cards_samav2_api.hpp>
#include <logicalaccess/plugins/cards/samav2/sambasickeyentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samkeyentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samkucentry.hpp>
#include <logicalaccess/plugins/cards/samav2/samcommands.hpp>
#include <logicalaccess/plugins/cards/samav2/samcrypto.hpp>
#include <logicalaccess/plugins/crypto/symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/aes_symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/openssl.hpp>
#include <logicalaccess/plugins/crypto/cmac.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
#include <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samiso7816resultchecker.hpp>
#include <logicalaccess/plugins/cards/twic/lla_cards_twic_api.hpp>
#include <logicalaccess/plugins/cards/twic/twiclocation.hpp>
#include <logicalaccess/plugins/cards/twic/twiccommands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/twiciso7816commands.hpp>
#include <logicalaccess/plugins/cards/yubikey/lla_cards_yubikey_api.hpp>
#include <logicalaccess/plugins/cards/yubikey/yubikeycommands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/yubikeyiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerprovider.hpp>
#include <logicalaccess/plugins/readers/keyboard/lla_readers_private_keyboard_api.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardsharedstruct.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderunit.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderprovider.hpp>
#include <logicalaccess/plugins/cards/mifare/lla_cards_mifare_api.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
#include <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
#include <logicalaccess/plugins/readers/ok5553/lla_readers_ok5553_api.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerunit.hpp>
#include <logicalaccess/plugins/readers/ok5553/readercardadapters/ok5553readercardadapter.hpp>
#include <logicalaccess/plugins/readers/ok5553/commands/mifareok5553commands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/lla_cards_mifareultralight_api.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
#include <logicalaccess/plugins/readers/ok5553/commands/mifareultralightok5553commands.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerprovider.hpp>
#include <logicalaccess/plugins/readers/ok5553/readercardadapters/iso7816ok5553readercardadapter.hpp>
#include <logicalaccess/plugins/readers/osdp/lla_readers_osdp_api.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpsecurechannel.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpchannel.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpcommands.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderunit.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderprovider.hpp>
#include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpbufferparser.hpp>
#include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpserialportdatatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/lla_readers_pcsc_api.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/atrparser.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/acsacrresultchecker.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/dummycommand.hpp>
#include <logicalaccess/plugins/cards/felica/lla_cards_felica_api.hpp>
#include <logicalaccess/plugins/cards/felica/felicalocation.hpp>
#include <logicalaccess/plugins/cards/felica/felicacommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_fwd.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_connection.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
#include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/felicascmcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/felicaspringcardcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/id3resultchecker.hpp>
#include <logicalaccess/plugins/cards/iso15693/lla_cards_iso15693_api.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
#include <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/iso15693pcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarepcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifare_acr1222L_commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifare_cl1356_commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarecherrycommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx21commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx27resultchecker.hpp>
#include <logicalaccess/plugins/cards/mifareplus/lla_cards_mifareplus_api.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_acsacr1222l_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_omnikeyxx21_sl1.hpp>
#include <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Auth.hpp>
#include <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl3.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarespringcardcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_sprincard_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarescmcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightpcsccommands.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
#include <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcpcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcacsacrcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx21commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx22commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcspringcardcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/springcardresultchecker.hpp>
#include <logicalaccess/plugins/cards/topaz/lla_cards_topaz_api.hpp>
#include <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
#include <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
#include <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazacsacrcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazomnikeyxx27commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazpcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazscmcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsccontroldatatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/CL1356PlusUtils.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222llcddisplay.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacrreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/cherryreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/id3readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikey5427readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeylanxx21readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx22readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx25readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/scmreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/springcardreaderunit.hpp>
#include <logicalaccess/plugins/readers/stidstr/lla_readers_stidstr_api.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
#include <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstr_fwd.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderunit.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/desfireev1stidstrcommands.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/mifarestidstrcommands.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderbufferparser.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderserialportdatatransport.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderprovider.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderunitconfiguration.hpp>

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

/* Include_section */

%include <logicalaccess/plugins/readers/deister/lla_readers_deister_api.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderunit.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderprovider.hpp>
%include <logicalaccess/plugins/readers/deister/readercardadapters/deisterbufferparser.hpp>
%include <logicalaccess/plugins/readers/deister/readercardadapters/deisterreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/deister/readercardadapters/deisterserialportdatatransport.hpp>
%include <logicalaccess/plugins/readers/elatec/lla_readers_elatec_api.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderunit.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderprovider.hpp>
%include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecbufferparser.hpp>
%import <logicalaccess/plugins/llacommon/lla_common_api.hpp>
%import <logicalaccess/plugins/llacommon/logs.hpp>
%include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecserialportdatatransport.hpp>
%include <logicalaccess/plugins/readers/gunnebo/lla_readers_gunnebo_api.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunit.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderprovider.hpp>
%include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunnebobufferparser.hpp>
%include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunneboreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunneboserialportdatatransport.hpp>
%import <logicalaccess/plugins/cards/desfire/lla_cards_desfire_api.hpp>
%import <logicalaccess/plugins/cards/desfire/desfirekey.hpp>
%import <logicalaccess/plugins/cards/desfire/desfireaccessinfo.hpp>
%import <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
%import <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
%import <logicalaccess/plugins/crypto/lla_crypto_api.hpp>
%import <logicalaccess/plugins/crypto/initialization_vector.hpp>
%import <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
%import <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>
%import <logicalaccess/plugins/crypto/des_cipher.hpp>
%import <logicalaccess/plugins/crypto/aes_cipher.hpp>
%import <logicalaccess/plugins/cards/desfire/desfirecrypto.hpp>
%import <logicalaccess/plugins/cards/iso7816/lla_cards_iso7816_api.hpp>
%import <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816response.hpp>
%import <logicalaccess/plugins/crypto/sha.hpp>
%import <logicalaccess/plugins/crypto/iso24727crypto.hpp>
%import <logicalaccess/plugins/cards/iso7816/readercardadapters/iso7816readercardadapter.hpp>
%include <logicalaccess/plugins/readers/iso7816/lla_readers_iso7816_api.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816commands.hpp>
%import <logicalaccess/plugins/cards/desfire/desfireev1location.hpp>
%import <logicalaccess/plugins/cards/iso7816/iso7816location.hpp>
%import <logicalaccess/plugins/cards/iso7816/iso7816commands.hpp>
%import <logicalaccess/plugins/cards/desfire/desfireev1commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/iso7816iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/desfireev1iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816resultchecker.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816resultchecker.hpp>
%import <logicalaccess/plugins/cards/epass/lla_cards_epass_api.hpp>
%import <logicalaccess/plugins/cards/epass/epasscrypto.hpp>
%import <logicalaccess/plugins/cards/epass/utils.hpp>
%import <logicalaccess/plugins/cards/epass/epasscommands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/epassiso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/mifareplusiso7816resultchecker.hpp>
%import <logicalaccess/plugins/cards/samav2/lla_cards_samav2_api.hpp>
%import <logicalaccess/plugins/cards/samav2/sambasickeyentry.hpp>
%import <logicalaccess/plugins/cards/samav2/samkeyentry.hpp>
%import <logicalaccess/plugins/cards/samav2/samkucentry.hpp>
%import <logicalaccess/plugins/cards/samav2/samcommands.hpp>
%import <logicalaccess/plugins/cards/samav2/samcrypto.hpp>
%import <logicalaccess/plugins/crypto/symmetric_key.hpp>
%import <logicalaccess/plugins/crypto/aes_symmetric_key.hpp>
%import <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
%import <logicalaccess/plugins/crypto/openssl.hpp>
%import <logicalaccess/plugins/crypto/cmac.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
%import <logicalaccess/plugins/cards/samav2/samav2commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samiso7816resultchecker.hpp>
%import <logicalaccess/plugins/cards/twic/lla_cards_twic_api.hpp>
%import <logicalaccess/plugins/cards/twic/twiclocation.hpp>
%import <logicalaccess/plugins/cards/twic/twiccommands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/twiciso7816commands.hpp>
%import <logicalaccess/plugins/cards/yubikey/lla_cards_yubikey_api.hpp>
%import <logicalaccess/plugins/cards/yubikey/yubikeycommands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/yubikeyiso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerprovider.hpp>
%include <logicalaccess/plugins/readers/keyboard/lla_readers_private_keyboard_api.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardsharedstruct.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderunit.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderprovider.hpp>
%import <logicalaccess/plugins/cards/mifare/lla_cards_mifare_api.hpp>
%import <logicalaccess/plugins/cards/mifare/mifarekey.hpp>
%import <logicalaccess/plugins/cards/mifare/mifareaccessinfo.hpp>
%import <logicalaccess/plugins/cards/mifare/mifarecommands.hpp>
%include <logicalaccess/plugins/readers/ok5553/lla_readers_ok5553_api.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerunit.hpp>
%include <logicalaccess/plugins/readers/ok5553/readercardadapters/ok5553readercardadapter.hpp>
%include <logicalaccess/plugins/readers/ok5553/commands/mifareok5553commands.hpp>
%import <logicalaccess/plugins/cards/mifareultralight/lla_cards_mifareultralight_api.hpp>
%import <logicalaccess/plugins/cards/mifareultralight/mifareultralightaccessinfo.hpp>
%import <logicalaccess/plugins/cards/mifareultralight/mifareultralightlocation.hpp>
%import <logicalaccess/plugins/cards/mifareultralight/mifareultralightcommands.hpp>
%include <logicalaccess/plugins/readers/ok5553/commands/mifareultralightok5553commands.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerprovider.hpp>
%include <logicalaccess/plugins/readers/ok5553/readercardadapters/iso7816ok5553readercardadapter.hpp>
%include <logicalaccess/plugins/readers/osdp/lla_readers_osdp_api.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpsecurechannel.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpchannel.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpcommands.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderunit.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderprovider.hpp>
%include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpbufferparser.hpp>
%include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpserialportdatatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/lla_readers_pcsc_api.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/atrparser.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/acsacrresultchecker.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/dummycommand.hpp>
%import <logicalaccess/plugins/cards/felica/lla_cards_felica_api.hpp>
%import <logicalaccess/plugins/cards/felica/felicalocation.hpp>
%import <logicalaccess/plugins/cards/felica/felicacommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_fwd.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_connection.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
%include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/felicascmcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/felicaspringcardcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/id3resultchecker.hpp>
%import <logicalaccess/plugins/cards/iso15693/lla_cards_iso15693_api.hpp>
%import <logicalaccess/plugins/cards/iso15693/iso15693location.hpp>
%import <logicalaccess/plugins/cards/iso15693/iso15693commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/iso15693pcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarepcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifare_acr1222L_commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifare_cl1356_commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarecherrycommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx21commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx27resultchecker.hpp>
%import <logicalaccess/plugins/cards/mifareplus/lla_cards_mifareplus_api.hpp>
%import <logicalaccess/plugins/cards/mifareplus/mifareplussl1commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_acsacr1222l_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_omnikeyxx21_sl1.hpp>
%import <logicalaccess/plugins/cards/mifareplus/MifarePlusSL3Auth.hpp>
%import <logicalaccess/plugins/cards/mifareplus/mifareplussl3commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl3.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarespringcardcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_sprincard_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarescmcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightpcsccommands.hpp>
%import <logicalaccess/plugins/cards/mifareultralight/mifareultralightcaccessinfo.hpp>
%import <logicalaccess/plugins/cards/mifareultralight/mifareultralightccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcpcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcacsacrcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx21commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx22commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcspringcardcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/springcardresultchecker.hpp>
%import <logicalaccess/plugins/cards/topaz/lla_cards_topaz_api.hpp>
%import <logicalaccess/plugins/cards/topaz/topazaccessinfo.hpp>
%import <logicalaccess/plugins/cards/topaz/topazlocation.hpp>
%import <logicalaccess/plugins/cards/topaz/topazcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazacsacrcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazomnikeyxx27commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazpcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazscmcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsccontroldatatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/CL1356PlusUtils.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222llcddisplay.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacrreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/cherryreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/id3readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikey5427readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeylanxx21readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx22readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx25readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/scmreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/springcardreaderunit.hpp>
%include <logicalaccess/plugins/readers/stidstr/lla_readers_stidstr_api.hpp>
%import <logicalaccess/plugins/cards/desfire/desfirechip.hpp>
%import <logicalaccess/plugins/cards/desfire/desfireev1chip.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstr_fwd.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderunit.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/desfireev1stidstrcommands.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/mifarestidstrcommands.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderbufferparser.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderserialportdatatransport.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderprovider.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderunitconfiguration.hpp>

/* END_Include_section */

%template(MifarePlusSL1PCSCCommands) logicalaccess::MifarePlusSL1Policy<logicalaccess::MifarePlusSL1Commands, logicalaccess::MifarePCSCCommands>;

%template(ChipList) std::list<std::shared_ptr<logicalaccess::Chip> >;
#ifdef BUILD_PRIVATE
%template(SIOCryptoContextVector) std::vector<logicalaccess::SIO::CryptoContext>;
#endif

