/* File : liblogicalaccess_reader.i */
%module(directors="1") liblogicalaccess_reader

%include "liblogicalaccess.i"

%import "liblogicalaccess_crypto.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_core.i"
%import "liblogicalaccess_iks.i"

%{
#include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>
#include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>

/* Additional_include */

#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600lcddisplay.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600ledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerprovider.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunit.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600_fwd.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/readercardadapters/a3mlgm5600readercardadapter.hpp>
#include <logicalaccess/plugins/readers/admitto/admittoreaderprovider.hpp>
#include <logicalaccess/plugins/readers/admitto/admittoreaderunit.hpp>
#include <logicalaccess/plugins/readers/admitto/admittoreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/admitto/readercardadapters/admittobufferparser.hpp>
#include <logicalaccess/plugins/readers/admitto/readercardadapters/admittodatatransport.hpp>
#include <logicalaccess/plugins/readers/admitto/readercardadapters/admittoreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerprovider.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunit.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/readercardadapters/axesstmc13bufferparser.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/readercardadapters/axesstmc13datatransport.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/readercardadapters/axesstmc13readercardadapter.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderprovider.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunit.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/readercardadapters/axesstmclegicbufferparser.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/readercardadapters/axesstmclegicdatatransport.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/readercardadapters/axesstmclegicreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderprovider.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderunit.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/deister/readercardadapters/deisterbufferparser.hpp>
#include <logicalaccess/plugins/readers/deister/readercardadapters/deisterdatatransport.hpp>
#include <logicalaccess/plugins/readers/deister/readercardadapters/deisterreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderprovider.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderunit.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecbufferparser.hpp>
#include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecdatatransport.hpp>
#include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/gigatms/gigatmsreaderprovider.hpp>
#include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunit.hpp>
#include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/gigatms/readercardadapters/gigatmsbufferparser.hpp>
#include <logicalaccess/plugins/readers/gigatms/readercardadapters/gigatmsdatatransport.hpp>
#include <logicalaccess/plugins/readers/gigatms/readercardadapters/gigatmsreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderprovider.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunit.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunnebobufferparser.hpp>
#include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunnebodatatransport.hpp>
#include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunneboreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/idondemand/generictagidondemandchip.hpp>
#include <logicalaccess/plugins/readers/idondemand/idondemandreaderprovider.hpp>
#include <logicalaccess/plugins/readers/idondemand/idondemandreaderunit.hpp>
#include <logicalaccess/plugins/readers/idondemand/idondemandreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/idondemand/commands/generictagidondemandaccesscontrolcardservice.hpp>
#include <logicalaccess/plugins/readers/idondemand/commands/generictagidondemandcommands.hpp>
#include <logicalaccess/plugins/readers/idondemand/readercardadapters/idondemandreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/idp/idpdatatransport.hpp>
#include <logicalaccess/plugins/readers/idp/idpreaderprovider.hpp>
#include <logicalaccess/plugins/readers/idp/idpreaderunit.hpp>
#include <logicalaccess/plugins/readers/idp/idpreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/idp/readercardadapters/idpreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerprovider.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816resultchecker.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/desfireev1iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816resultchecker.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/iso7816iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/mifareplusiso7816resultchecker.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/samiso7816resultchecker.hpp>
#include <logicalaccess/plugins/readers/iso7816/commands/twiciso7816commands.hpp>
#include <logicalaccess/plugins/readers/iso7816/readercardadapters/iso7816fuzzingreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/iso7816/readercardadapters/iso7816readercardadapter.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderprovider.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderunit.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardsharedstruct.hpp>
#include <logicalaccess/plugins/readers/nfc/nfcdatatransport.hpp>
#include <logicalaccess/plugins/readers/nfc/nfcreaderprovider.hpp>
#include <logicalaccess/plugins/readers/nfc/nfcreaderunit.hpp>
#include <logicalaccess/plugins/readers/nfc/nfcreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/nfc/commands/mifareclassicuidchangerservice.hpp>
#include <logicalaccess/plugins/readers/nfc/commands/mifarenfccommands.hpp>
#include <logicalaccess/plugins/readers/nfc/readercardadapters/nfcreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerprovider.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerunit.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/ok5553/commands/mifareok5553commands.hpp>
#include <logicalaccess/plugins/readers/ok5553/commands/mifareultralightok5553commands.hpp>
#include <logicalaccess/plugins/readers/ok5553/readercardadapters/iso7816ok5553readercardadapter.hpp>
#include <logicalaccess/plugins/readers/ok5553/readercardadapters/ok5553readercardadapter.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpchannel.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpcommands.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderprovider.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderunit.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpsecurechannel.hpp>
#include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpbufferparser.hpp>
#include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpdatatransport.hpp>
#include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/pcsc/atrparser.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_connection.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_ctl_datatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcsc_fwd.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/acsacrresultchecker.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/felicascmcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/felicaspringcardcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/id3resultchecker.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/iso15693pcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarecherrycommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx21commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx27resultchecker.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarepcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_acsacr1222l_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_omnikeyxx21_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl3.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_sprincard_sl1.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarescmcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifarespringcardcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcacsacrcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx21commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx22commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcpcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcspringcardcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightpcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifare_acr1222L_commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/mifare_cl1356_commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/proxcommand.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/springcardresultchecker.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazacsacrcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazomnikeyxx27commands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazpcsccommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/commands/topazscmcommands.hpp>
#include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222llcddisplay.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/acsacrreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/cherryreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/CL1356PlusUtils.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/id3readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikey5427readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeylanxx21readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx22readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx25readerunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/scmreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/springcardreaderunit.hpp>
#include <logicalaccess/plugins/readers/pcsc-private/OmnikeyXX27SecureMode.hpp>
#include <logicalaccess/plugins/readers/pcsc-private/TLV.hpp>
#include <logicalaccess/plugins/readers/pcsc-private/type_fwd.hpp>
#include <logicalaccess/plugins/readers/pcsc-private/commands/HIDiClassOmnikeyXX27Commands.hpp>
#include <logicalaccess/plugins/readers/pcsc-private/readers/omnikeyXX27readerunit.hpp>
#include <logicalaccess/plugins/readers/promag/promagreaderprovider.hpp>
#include <logicalaccess/plugins/readers/promag/promagreaderunit.hpp>
#include <logicalaccess/plugins/readers/promag/promagreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/promag/readercardadapters/promagbufferparser.hpp>
#include <logicalaccess/plugins/readers/promag/readercardadapters/promagdatatransport.hpp>
#include <logicalaccess/plugins/readers/promag/readercardadapters/promagreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/rfideas/rfideasreaderprovider.hpp>
#include <logicalaccess/plugins/readers/rfideas/rfideasreaderunit.hpp>
#include <logicalaccess/plugins/readers/rfideas/rfideasreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethdatatransport.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethlcddisplay.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethreaderprovider.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethreaderunit.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/rpleth/rpleth_fwd.hpp>
#include <logicalaccess/plugins/readers/rpleth/readercardadapters/rplethreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/sciel/scielreaderprovider.hpp>
#include <logicalaccess/plugins/readers/sciel/scielreaderunit.hpp>
#include <logicalaccess/plugins/readers/sciel/scielreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/sciel/readercardadapters/scielbufferparser.hpp>
#include <logicalaccess/plugins/readers/sciel/readercardadapters/scieldatatransport.hpp>
#include <logicalaccess/plugins/readers/sciel/readercardadapters/scielreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/smartid/smartidledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/smartid/smartidreaderprovider.hpp>
#include <logicalaccess/plugins/readers/smartid/smartidreaderunit.hpp>
#include <logicalaccess/plugins/readers/smartid/smartidreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/smartid/smartid_fwd.hpp>
#include <logicalaccess/plugins/readers/smartid/readercardadapters/mifaresmartidcommands.hpp>
#include <logicalaccess/plugins/readers/smartid/readercardadapters/mifaresmartidreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/smartid/readercardadapters/smartidreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/stidprg/stidprgreaderprovider.hpp>
#include <logicalaccess/plugins/readers/stidprg/stidprgreaderunit.hpp>
#include <logicalaccess/plugins/readers/stidprg/stidprgreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/stidprg/stidprgresultchecker.hpp>
#include <logicalaccess/plugins/readers/stidprg/STidPRG_Prox_AccessControl.hpp>
#include <logicalaccess/plugins/readers/stidprg/stid_prg_utils.hpp>
#include <logicalaccess/plugins/readers/stidprg/readercardadapters/stidprgbufferparser.hpp>
#include <logicalaccess/plugins/readers/stidprg/readercardadapters/stidprgdatatransport.hpp>
#include <logicalaccess/plugins/readers/stidprg/readercardadapters/stidprgreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrledbuzzerdisplay.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderprovider.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderunit.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstr_fwd.hpp>
#include <logicalaccess/plugins/readers/stidstr/commands/desfireev1stidstrcommands.hpp>
#include <logicalaccess/plugins/readers/stidstr/commands/mifarestidstrcommands.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderbufferparser.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreadercardadapter.hpp>
#include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderdatatransport.hpp>

/* END_Additional_include */

#include <logicalaccess/cards/accessinfo.hpp>

using namespace logicalaccess;

%}

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Card;
%}

/* Shared_ptr */

/* END_Shared_ptr */

%shared_ptr(logicalaccess::ReaderConfiguration);
%shared_ptr(CSMARTCommon);
%shared_ptr(boost::asio::ip::udp::socket);
%shared_ptr(boost::interprocess::mapped_region);
%shared_ptr(boost::interprocess::named_mutex);
%shared_ptr(logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV2Information, logicalaccess::SETAV2>);
%shared_ptr(logicalaccess::SAMKeyEntry<logicalaccess::KeyEntryAV1Information, logicalaccess::SETAV1>);
%shared_ptr(openssl::OpenSSLSymmetricCipher);
%shared_ptr(openssl::SymmetricKey);
%shared_ptr(openssl::InitializationVector);

%template(ReaderUnitCollection) std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >;

%feature("valuewrapper") logicalaccess::OmnikeyXX21ReaderUnit::SecureModeStatus;

%apply unsigned short *INOUT { unsigned short * }
%apply int *INOUT { int * }
%apply unsigned long *OUTPUT { unsigned long* pdwOutLen}
%apply unsigned char OUTPUT[] { unsigned char* pOutBuf }
%apply unsigned char INPUT[] { unsigned char* pInBuf }
%apply unsigned char INPUT[] { uint8_t *atr }
%apply unsigned char OUTPUT[] { unsigned char* pstate }
%apply unsigned char OUTPUT[] { unsigned char* result }
%apply unsigned int *INOUT { size_t* resultlen }

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

//%typemap(ctype) PCSCReaderUnitType "PCSCReaderUnitType"
//%typemap(cstype) PCSCReaderUnitType "PCSCReaderUnitType"
//%typemap(csin) PCSCReaderUnitType %{$csinput%}  
//%typemap(imtype) PCSCReaderUnitType "PCSCReaderUnitType"
//%typemap(csout, excode=SWIGEXCODE) PCSCReaderUnitType {
//	PCSCReaderUnitType ret = $imcall;$excode
//	return ret;
//}

//%typemap(ctype) PCSCShareMode "PCSCShareMode"
//%typemap(cstype) PCSCShareMode "PCSCShareMode"
//%typemap(csin) PCSCShareMode %{$csinput%}  
//%typemap(imtype) PCSCShareMode "PCSCShareMode"
//%typemap(csout, excode=SWIGEXCODE) PCSCShareMode {
//	PCSCShareMode ret = $imcall;$excode
//	return ret;
//}

%typemap(ctype) TLVPtr "TLV*"
%typemap(cstype) TLVPtr "TLV"
%typemap(csin) TLVPtr %{$csinput%}  
%typemap(imtype) TLVPtr "TLV"
%typemap(csout, excode=SWIGEXCODE) TLV {
	TLV ret = $imcall;$excode
	return ret;
}

%typemap(ctype) PCSCDataTransportPtr "PCSCDataTransport*"
%typemap(cstype) PCSCDataTransportPtr "PCSCDataTransport"
%typemap(csin) PCSCDataTransportPtr %{$csinput%}  
%typemap(imtype) PCSCDataTransportPtr "PCSCDataTransport"
%typemap(csout, excode=SWIGEXCODE) PCSCDataTransport {
	PCSCDataTransport ret = $imcall;$excode
	return ret;
}

%typemap(ctype) CardServiceType "CardServiceType"
%typemap(cstype) CardServiceType "CardServiceType"
%typemap(csin) CardServiceType %{$csinput%}  
%typemap(imtype) CardServiceType "CardServiceType"
%typemap(csout, excode=SWIGEXCODE) CardServiceType {
	CardServiceType ret = $imcall;$excode
	return ret;
}

%typemap(ctype) FileSetting "DESFireCommands::FileSetting"
%typemap(cstype) FileSetting "DESFireCommands.FileSetting"
%typemap(in) FileSetting "$1 = $input"
%typemap(csin) FileSetting %{$csinput%}  
%typemap(imtype) FileSetting "LibLogicalAccess.Card.DESFireCommands.FileSetting"
%typemap(csout, excode=SWIGEXCODE) FileSetting {
	DESFireCommands.FileSetting ret = $imcall;$excode
	return ret;
}

%typemap(ctype) FileSetting& "logicalaccess::DESFireCommands::FileSetting*"
%typemap(cstype) FileSetting& "out DESFireCommands.FileSetting"
%typemap(csin) FileSetting& %{out $csinput%} 
%typemap(imtype) FileSetting& "out LibLogicalAccess.Card.DESFireCommands.FileSetting"
%typemap(csout, excode=SWIGEXCODE) FileSetting& {
	DESFireCommands.FileSetting ret = $imcall;$excode
	return ret;
}
%typemap(in) FileSetting& %{ $1 = ($1_ltype)$input; %}
%typemap(out) FileSetting& %{ $result = (FileSetting*)$1; %}

%typemap(ctype) FileSetting* "logicalaccess::DESFireCommands::FileSetting*"
%typemap(cstype) FileSetting* "ref DESFireCommands.FileSetting"
%typemap(csin) FileSetting* %{ref $csinput%}  
%typemap(imtype) FileSetting* "ref LibLogicalAccess.Card.DESFireCommands.FileSetting"
%typemap(csout, excode=SWIGEXCODE) FileSetting* {
	DESFireCommands.FileSetting* ret = $imcall;$excode
	return ret;
}
%typemap(in) FileSetting* %{ $1 = ($1_ltype)$input; %}
%typemap(out) FileSetting* %{ $result = (FileSetting*)$1; %}


%typemap(ctype) DESFireCommands::DESFireCardVersion "DESFireCommands::DESFireCardVersion"
%typemap(cstype) DESFireCommands::DESFireCardVersion "DESFireCommands.DESFireCardVersion"
%typemap(csin) DESFireCommands::DESFireCardVersion %{$csinput%}  
%typemap(imtype) DESFireCommands::DESFireCardVersion "LibLogicalAccess.Card.DESFireCommands.DESFireCardVersion"
%typemap(csout, excode=SWIGEXCODE) DESFireCommands::DESFireCardVersion {
	DESFireCommands.DESFireCardVersion ret = $imcall;$excode
	return ret;
}

//%typemap(ctype) EncryptionMode "EncryptionMode"
//%typemap(cstype) EncryptionMode "LibLogicalAccess.Card.EncryptionMode"
//%typemap(csin) EncryptionMode %{$csinput%}  
//%typemap(imtype) EncryptionMode "LibLogicalAccess.Card.EncryptionMode"
//%typemap(csout, excode=SWIGEXCODE) EncryptionMode {
//	EncryptionMode ret = $imcall;$excode
//	return ret;
//}

%typemap(ctype) HIDEncryptionMode "HIDEncryptionMode"
%typemap(cstype) HIDEncryptionMode "HIDEncryptionMode"
%typemap(csin) HIDEncryptionMode %{$csinput%}  
%typemap(imtype) HIDEncryptionMode "LibLogicalAccess.Reader.HIDEncryptionMode"
%typemap(csout, excode=SWIGEXCODE) HIDEncryptionMode {
	HIDEncryptionMode ret = $imcall;$excode
	return ret;
}

%include <logicalaccess/plugins/cards/desfire/desfirelocation.hpp>
%include <logicalaccess/plugins/cards/desfire/desfirecommands.hpp>

/* Include_section */

%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600lcddisplay.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600ledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerprovider.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunit.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600_fwd.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/readercardadapters/a3mlgm5600readercardadapter.hpp>
%include <logicalaccess/plugins/readers/admitto/admittoreaderprovider.hpp>
%include <logicalaccess/plugins/readers/admitto/admittoreaderunit.hpp>
%include <logicalaccess/plugins/readers/admitto/admittoreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/admitto/readercardadapters/admittobufferparser.hpp>
%include <logicalaccess/plugins/readers/admitto/readercardadapters/admittodatatransport.hpp>
%include <logicalaccess/plugins/readers/admitto/readercardadapters/admittoreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerprovider.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunit.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/readercardadapters/axesstmc13bufferparser.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/readercardadapters/axesstmc13datatransport.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/readercardadapters/axesstmc13readercardadapter.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderprovider.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunit.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/readercardadapters/axesstmclegicbufferparser.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/readercardadapters/axesstmclegicdatatransport.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/readercardadapters/axesstmclegicreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderprovider.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderunit.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/deister/readercardadapters/deisterbufferparser.hpp>
%include <logicalaccess/plugins/readers/deister/readercardadapters/deisterdatatransport.hpp>
%include <logicalaccess/plugins/readers/deister/readercardadapters/deisterreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderprovider.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderunit.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecbufferparser.hpp>
%include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecdatatransport.hpp>
%include <logicalaccess/plugins/readers/elatec/readercardadapters/elatecreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/gigatms/gigatmsreaderprovider.hpp>
%include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunit.hpp>
%include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/gigatms/readercardadapters/gigatmsbufferparser.hpp>
%include <logicalaccess/plugins/readers/gigatms/readercardadapters/gigatmsdatatransport.hpp>
%include <logicalaccess/plugins/readers/gigatms/readercardadapters/gigatmsreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderprovider.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunit.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunnebobufferparser.hpp>
%include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunnebodatatransport.hpp>
%include <logicalaccess/plugins/readers/gunnebo/readercardadapters/gunneboreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/idondemand/generictagidondemandchip.hpp>
%include <logicalaccess/plugins/readers/idondemand/idondemandreaderprovider.hpp>
%include <logicalaccess/plugins/readers/idondemand/idondemandreaderunit.hpp>
%include <logicalaccess/plugins/readers/idondemand/idondemandreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/idondemand/commands/generictagidondemandaccesscontrolcardservice.hpp>
%include <logicalaccess/plugins/readers/idondemand/commands/generictagidondemandcommands.hpp>
%include <logicalaccess/plugins/readers/idondemand/readercardadapters/idondemandreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/idp/idpdatatransport.hpp>
%include <logicalaccess/plugins/readers/idp/idpreaderprovider.hpp>
%include <logicalaccess/plugins/readers/idp/idpreaderunit.hpp>
%include <logicalaccess/plugins/readers/idp/idpreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/idp/readercardadapters/idpreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerprovider.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816resultchecker.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/desfireev1iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/desfireiso7816resultchecker.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/iso7816iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/mifareplusiso7816resultchecker.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samav1iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samav2iso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samiso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/samiso7816resultchecker.hpp>
%include <logicalaccess/plugins/readers/iso7816/commands/twiciso7816commands.hpp>
%include <logicalaccess/plugins/readers/iso7816/readercardadapters/iso7816fuzzingreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/iso7816/readercardadapters/iso7816readercardadapter.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderprovider.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderunit.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardsharedstruct.hpp>
%include <logicalaccess/plugins/readers/nfc/nfcdatatransport.hpp>
%include <logicalaccess/plugins/readers/nfc/nfcreaderprovider.hpp>
%include <logicalaccess/plugins/readers/nfc/nfcreaderunit.hpp>
%include <logicalaccess/plugins/readers/nfc/nfcreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/nfc/commands/mifareclassicuidchangerservice.hpp>
%include <logicalaccess/plugins/readers/nfc/commands/mifarenfccommands.hpp>
%include <logicalaccess/plugins/readers/nfc/readercardadapters/nfcreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerprovider.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerunit.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/ok5553/commands/mifareok5553commands.hpp>
%include <logicalaccess/plugins/readers/ok5553/commands/mifareultralightok5553commands.hpp>
%include <logicalaccess/plugins/readers/ok5553/readercardadapters/iso7816ok5553readercardadapter.hpp>
%include <logicalaccess/plugins/readers/ok5553/readercardadapters/ok5553readercardadapter.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpchannel.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpcommands.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderprovider.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderunit.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpsecurechannel.hpp>
%include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpbufferparser.hpp>
%include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpdatatransport.hpp>
%include <logicalaccess/plugins/readers/osdp/readercardadapters/osdpreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/pcsc/atrparser.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_connection.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_ctl_datatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcsc_fwd.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/acsacrresultchecker.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/felicascmcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/felicaspringcardcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/id3resultchecker.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/iso15693pcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarecherrycommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx21commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx27resultchecker.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarepcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_acsacr1222l_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_omnikeyxx21_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_pcsc_sl3.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareplus_sprincard_sl1.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarescmcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifarespringcardcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcacsacrcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx21commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcomnikeyxx22commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcpcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightcspringcardcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifareultralightpcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifare_acr1222L_commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/mifare_cl1356_commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/proxcommand.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/springcardresultchecker.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazacsacrcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazomnikeyxx27commands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazpcsccommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/commands/topazscmcommands.hpp>
%include <logicalaccess/plugins/readers/pcsc/readercardadapters/pcscreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222llcddisplay.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacr1222lreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/acsacrreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/cherryreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/CL1356PlusUtils.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/id3readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikey5427readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeylanxx21readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx21readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx22readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/omnikeyxx25readerunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/scmreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/springcardreaderunit.hpp>
%include <logicalaccess/plugins/readers/pcsc-private/OmnikeyXX27SecureMode.hpp>
%include <logicalaccess/plugins/readers/pcsc-private/TLV.hpp>
%include <logicalaccess/plugins/readers/pcsc-private/type_fwd.hpp>
%include <logicalaccess/plugins/readers/pcsc-private/commands/HIDiClassOmnikeyXX27Commands.hpp>
%include <logicalaccess/plugins/readers/pcsc-private/readers/omnikeyXX27readerunit.hpp>
%include <logicalaccess/plugins/readers/promag/promagreaderprovider.hpp>
%include <logicalaccess/plugins/readers/promag/promagreaderunit.hpp>
%include <logicalaccess/plugins/readers/promag/promagreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/promag/readercardadapters/promagbufferparser.hpp>
%include <logicalaccess/plugins/readers/promag/readercardadapters/promagdatatransport.hpp>
%include <logicalaccess/plugins/readers/promag/readercardadapters/promagreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/rfideas/rfideasreaderprovider.hpp>
%include <logicalaccess/plugins/readers/rfideas/rfideasreaderunit.hpp>
%include <logicalaccess/plugins/readers/rfideas/rfideasreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethdatatransport.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethlcddisplay.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethreaderprovider.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethreaderunit.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/rpleth/rpleth_fwd.hpp>
%include <logicalaccess/plugins/readers/rpleth/readercardadapters/rplethreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/sciel/scielreaderprovider.hpp>
%include <logicalaccess/plugins/readers/sciel/scielreaderunit.hpp>
%include <logicalaccess/plugins/readers/sciel/scielreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/sciel/readercardadapters/scielbufferparser.hpp>
%include <logicalaccess/plugins/readers/sciel/readercardadapters/scieldatatransport.hpp>
%include <logicalaccess/plugins/readers/sciel/readercardadapters/scielreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/smartid/smartidledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/smartid/smartidreaderprovider.hpp>
%include <logicalaccess/plugins/readers/smartid/smartidreaderunit.hpp>
%include <logicalaccess/plugins/readers/smartid/smartidreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/smartid/smartid_fwd.hpp>
%include <logicalaccess/plugins/readers/smartid/readercardadapters/mifaresmartidcommands.hpp>
%include <logicalaccess/plugins/readers/smartid/readercardadapters/mifaresmartidreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/smartid/readercardadapters/smartidreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/stidprg/stidprgreaderprovider.hpp>
%include <logicalaccess/plugins/readers/stidprg/stidprgreaderunit.hpp>
%include <logicalaccess/plugins/readers/stidprg/stidprgreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/stidprg/stidprgresultchecker.hpp>
%include <logicalaccess/plugins/readers/stidprg/STidPRG_Prox_AccessControl.hpp>
%include <logicalaccess/plugins/readers/stidprg/stid_prg_utils.hpp>
%include <logicalaccess/plugins/readers/stidprg/readercardadapters/stidprgbufferparser.hpp>
%include <logicalaccess/plugins/readers/stidprg/readercardadapters/stidprgdatatransport.hpp>
%include <logicalaccess/plugins/readers/stidprg/readercardadapters/stidprgreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrledbuzzerdisplay.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderprovider.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderunit.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstr_fwd.hpp>
%include <logicalaccess/plugins/readers/stidstr/commands/desfireev1stidstrcommands.hpp>
%include <logicalaccess/plugins/readers/stidstr/commands/mifarestidstrcommands.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderbufferparser.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreadercardadapter.hpp>
%include <logicalaccess/plugins/readers/stidstr/readercardadapters/stidstrreaderdatatransport.hpp>

/* END_Include_section */

%include <logicalaccess/plugins/readers/idp/SMART-DLL/SMARTComm70.h>
