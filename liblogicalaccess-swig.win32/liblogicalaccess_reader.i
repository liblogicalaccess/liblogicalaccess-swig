/* File : liblogicalaccess_reader.i */
%module(directors="1") liblogicalaccess_reader

%include "liblogicalaccess.i"

%import "liblogicalaccess_card.i"

%{
/* Additional_include */

#include <logicalaccess/readerproviders/circularbufferparser.hpp>
#include <logicalaccess/readerproviders/datatransport.hpp>
#include <logicalaccess/readerproviders/iso14443areadercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443breadercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443readercommunication.hpp>
#include <logicalaccess/readerproviders/iso15693readercommunication.hpp>
#include <logicalaccess/readerproviders/lcddisplay.hpp>
#include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
#include <logicalaccess/readerproviders/readercommunication.hpp>
#include <logicalaccess/readerproviders/readerconfiguration.hpp>
#include <logicalaccess/readerproviders/readerprovider.hpp>
#include <logicalaccess/readerproviders/readerunit.hpp>
#include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
#include <logicalaccess/readerproviders/serialport.hpp>
#include <logicalaccess/readerproviders/serialportdatatransport.hpp>
#include <logicalaccess/readerproviders/serialportxml.hpp>
#include <logicalaccess/readerproviders/tcpdatatransport.hpp>
#include <logicalaccess/readerproviders/udpdatatransport.hpp>

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
#include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx27commands.hpp>
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
#include <logicalaccess/plugins/readers/pcsc/readers/springcardllcpinitiator.hpp>
#include <logicalaccess/plugins/readers/pcsc/readers/springcardnfcp2preaderservice.hpp>
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

using namespace logicalaccess;

%}

%typemap(csimports) SWIGTYPE
%{
	using LibLogicalAccess;
	using LibLogicalAccess.Card;
%}

/* Shared_ptr */

%shared_ptr(logicalaccess::ReaderUnit);
%shared_ptr(logicalaccess::ReaderCardAdapter);
%shared_ptr(logicalaccess::ReaderProvider);
%shared_ptr(logicalaccess::Chip);
%shared_ptr(logicalaccess::CardsFormatComposite);
%shared_ptr(logicalaccess::ReaderUnitConfiguration);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::LCDDisplay);
%shared_ptr(logicalaccess::LEDBuzzerDisplay);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::CardProbe);
%shared_ptr(logicalaccess::CircularBufferParser);
%shared_ptr(logicalaccess::std::thread);
%shared_ptr(logicalaccess::SerialPortXml);
%shared_ptr(logicalaccess::SerialPort);
%shared_ptr(logicalaccess::boost::asio::ip::udp::socket);
%shared_ptr(logicalaccess::A3MLGM5600ReaderCardAdapter);
%shared_ptr(logicalaccess::A3MLGM5600ReaderProvider);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnitConfiguration);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnit);
%shared_ptr(logicalaccess::AdmittoReaderProvider);
%shared_ptr(logicalaccess::AdmittoReaderCardAdapter);
%shared_ptr(logicalaccess::AdmittoReaderUnitConfiguration);
%shared_ptr(logicalaccess::AxessTMC13ReaderProvider);
%shared_ptr(logicalaccess::AxessTMC13ReaderCardAdapter);
%shared_ptr(logicalaccess::AxessTMC13ReaderUnitConfiguration);
%shared_ptr(logicalaccess::AxessTMCLegicReaderProvider);
%shared_ptr(logicalaccess::AxessTMCLegicReaderCardAdapter);
%shared_ptr(logicalaccess::AxessTMCLegicReaderUnitConfiguration);
%shared_ptr(logicalaccess::DeisterReaderProvider);
%shared_ptr(logicalaccess::DeisterReaderCardAdapter);
%shared_ptr(logicalaccess::DeisterReaderUnitConfiguration);
%shared_ptr(logicalaccess::ElatecReaderProvider);
%shared_ptr(logicalaccess::ElatecReaderCardAdapter);
%shared_ptr(logicalaccess::ElatecReaderUnitConfiguration);
%shared_ptr(logicalaccess::GigaTMSReaderProvider);
%shared_ptr(logicalaccess::GigaTMSReaderCardAdapter);
%shared_ptr(logicalaccess::GigaTMSReaderUnitConfiguration);
%shared_ptr(logicalaccess::GunneboReaderProvider);
%shared_ptr(logicalaccess::GunneboReaderCardAdapter);
%shared_ptr(logicalaccess::GunneboReaderUnitConfiguration);
%shared_ptr(logicalaccess::CardService);
%shared_ptr(logicalaccess::IdOnDemandReaderProvider);
%shared_ptr(logicalaccess::IdOnDemandReaderCardAdapter);
%shared_ptr(logicalaccess::IdOnDemandReaderUnitConfiguration);
%shared_ptr(logicalaccess::Format);
%shared_ptr(logicalaccess::Location);
%shared_ptr(logicalaccess::AccessInfo);
%shared_ptr(logicalaccess::IDPReaderUnit);
%shared_ptr(logicalaccess::IDPReaderProvider);
%shared_ptr(logicalaccess::CSMARTCommon);
%shared_ptr(logicalaccess::IDPReaderCardAdapter);
%shared_ptr(logicalaccess::IDPReaderUnitConfiguration);
%shared_ptr(logicalaccess::ISO7816ReaderUnit);
%shared_ptr(logicalaccess::SAMChip);
%shared_ptr(logicalaccess::ISO7816ReaderProvider);
%shared_ptr(logicalaccess::ISO7816ReaderUnitConfiguration);
%shared_ptr(logicalaccess::DESFireKey);
%shared_ptr(logicalaccess::ISO7816ReaderCardAdapter);
%shared_ptr(logicalaccess::SAMKeyEntry<KeyEntryAV1Information, SETAV1>);
%shared_ptr(logicalaccess::SAMKucEntry);
%shared_ptr(logicalaccess::SAMKeyEntry<KeyEntryAV2Information, SETAV2>);
%shared_ptr(logicalaccess::SAMDESfireCrypto);
%shared_ptr(logicalaccess::openssl::OpenSSLSymmetricCipher);
%shared_ptr(logicalaccess::openssl::SymmetricKey);
%shared_ptr(logicalaccess::openssl::InitializationVector);
%shared_ptr(logicalaccess::boost::interprocess::mapped_region);
%shared_ptr(logicalaccess::boost::interprocess::named_mutex);
%shared_ptr(logicalaccess::KeyboardReaderProvider);
%shared_ptr(logicalaccess::KeyboardReaderUnitConfiguration);
%shared_ptr(logicalaccess::NFCReaderUnit);
%shared_ptr(logicalaccess::NFCReaderProvider);
%shared_ptr(logicalaccess::NFCReaderCardAdapter);
%shared_ptr(logicalaccess::NFCReaderUnitConfiguration);
%shared_ptr(logicalaccess::MifareKey);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::OK5553ReaderProvider);
%shared_ptr(logicalaccess::OK5553ReaderCardAdapter);
%shared_ptr(logicalaccess::OK5553ReaderUnitConfiguration);
%shared_ptr(logicalaccess::OSDPSecureChannel);
%shared_ptr(logicalaccess::OSDPChannel);
%shared_ptr(logicalaccess::OSDPReaderProvider);
%shared_ptr(logicalaccess::OSDPReaderUnitConfiguration);
%shared_ptr(logicalaccess::OSDPCommands);
%shared_ptr(logicalaccess::AES128Key);
%shared_ptr(logicalaccess::DESFireISO7816ResultChecker);
%shared_ptr(logicalaccess::PCSCReaderUnit);
%shared_ptr(logicalaccess::PCSCReaderProvider);
%shared_ptr(logicalaccess::PCSCReaderCardAdapter);
%shared_ptr(logicalaccess::ReaderMemoryKeyStorage);
%shared_ptr(logicalaccess::PCSCReaderUnitConfiguration);
%shared_ptr(logicalaccess::Commands);
%shared_ptr(logicalaccess::std::string);
%shared_ptr(logicalaccess::Adapter);
%shared_ptr(logicalaccess::TripleDESKey);
%shared_ptr(logicalaccess::ACSACR1222LReaderUnitConfiguration);
%shared_ptr(logicalaccess::OmnikeyXX21ReaderUnitConfiguration);
%shared_ptr(logicalaccess::LLCP_PDU);
%shared_ptr(logicalaccess::LLCPInitiator);
%shared_ptr(logicalaccess::PCSCDataTransport);
%shared_ptr(logicalaccess::TLV);
%shared_ptr(logicalaccess::OmnikeyXX27SecureMode);
%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::Omnikey5427ReaderUnitConfiguration);
%shared_ptr(logicalaccess::PromagReaderProvider);
%shared_ptr(logicalaccess::PromagReaderCardAdapter);
%shared_ptr(logicalaccess::PromagReaderUnitConfiguration);
%shared_ptr(logicalaccess::RFIDeasReaderProvider);
%shared_ptr(logicalaccess::RFIDeasReaderUnitConfiguration);
%shared_ptr(logicalaccess::RFIDeasReaderUnit);
%shared_ptr(logicalaccess::RplethReaderCardAdapter);
%shared_ptr(logicalaccess::RplethReaderProvider);
%shared_ptr(logicalaccess::RplethReaderUnitConfiguration);
%shared_ptr(logicalaccess::SCIELReaderProvider);
%shared_ptr(logicalaccess::SCIELReaderCardAdapter);
%shared_ptr(logicalaccess::SCIELReaderUnitConfiguration);
%shared_ptr(logicalaccess::SmartIDReaderCardAdapter);
%shared_ptr(logicalaccess::SmartIDReaderProvider);
%shared_ptr(logicalaccess::ReaderCommunication);
%shared_ptr(logicalaccess::SmartIDReaderUnitConfiguration);
%shared_ptr(logicalaccess::MifareSmartIDReaderCardAdapter);
%shared_ptr(logicalaccess::STidPRGReaderProvider);
%shared_ptr(logicalaccess::STidPRGReaderUnitConfiguration);
%shared_ptr(logicalaccess::STidSTRReaderCardAdapter);
%shared_ptr(logicalaccess::STidSTRReaderProvider);
%shared_ptr(logicalaccess::STidSTRReaderUnitConfiguration);
%shared_ptr(logicalaccess::HMAC1Key);
%shared_ptr(logicalaccess::DESFireProfile);
%shared_ptr(logicalaccess::STidSTRReaderUnit);

/* END_Shared_ptr */

//typedef std::shared_ptr<logicalaccess::ReaderProvider> ReaderProviderPtr;
//typedef std::shared_ptr<logicalaccess::ReaderUnit> ReaderUnitPtr;

%include "liblogicalaccess_readerservice.i"

/* Include_section */


%include <logicalaccess/readerproviders/circularbufferparser.hpp>
%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/readerproviders/iso14443areadercommunication.hpp>
%include <logicalaccess/readerproviders/iso14443breadercommunication.hpp>
%include <logicalaccess/readerproviders/iso14443readercommunication.hpp>
%include <logicalaccess/readerproviders/iso15693readercommunication.hpp>
%include <logicalaccess/readerproviders/lcddisplay.hpp>
%include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
%include <logicalaccess/readerproviders/readercommunication.hpp>
%include <logicalaccess/readerproviders/readerconfiguration.hpp>
%include <logicalaccess/readerproviders/readerprovider.hpp>
%include <logicalaccess/readerproviders/readerunit.hpp>
%include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
%include <logicalaccess/readerproviders/serialport.hpp>
%include <logicalaccess/readerproviders/serialportdatatransport.hpp>
%include <logicalaccess/readerproviders/serialportxml.hpp>
%include <logicalaccess/readerproviders/tcpdatatransport.hpp>
%include <logicalaccess/readerproviders/udpdatatransport.hpp>

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
%include <logicalaccess/plugins/readers/pcsc/commands/mifareomnikeyxx27commands.hpp>
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
%include <logicalaccess/plugins/readers/pcsc/readers/springcardllcpinitiator.hpp>
%include <logicalaccess/plugins/readers/pcsc/readers/springcardnfcp2preaderservice.hpp>
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

%template(ReaderUnitCollection) std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >;
//%template(ChipPtrCollection) std::list<std::shared_ptr<Chip> >;
%template(ReaderUnitWeakPtr) std::weak_ptr<ReaderUnit>;