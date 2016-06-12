/* File : liblogicalaccess_reader.i */
%module(directors="1") liblogicalaccess_reader

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_card.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Card;
%}


/* Core */

%shared_ptr(logicalaccess::ReaderConfiguration);
%shared_ptr(logicalaccess::ReaderProvider);
%shared_ptr(logicalaccess::ReaderUnit);
%shared_ptr(logicalaccess::ReaderUnitConfiguration);
%shared_ptr(logicalaccess::LCDDisplay);
%shared_ptr(logicalaccess::LEDBuzzerDisplay);
%shared_ptr(logicalaccess::DataTransport);

/* Plugins */

%shared_ptr(logicalaccess::A3MLGM5600ReaderProvider);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnit);
%shared_ptr(logicalaccess::A3MLGM5600ReaderUnitConfiguration);

%shared_ptr(logicalaccess::AdmittoReaderProvider);
%shared_ptr(logicalaccess::AdmittoReaderUnit);
%shared_ptr(logicalaccess::AdmittoReaderUnitConfiguration);

%shared_ptr(logicalaccess::AxessTMC13ReaderProvider);
%shared_ptr(logicalaccess::AxessTMC13ReaderUnit);
%shared_ptr(logicalaccess::AxessTMC13ReaderUnitConfiguration);

%shared_ptr(logicalaccess::AxessTMCLegicReaderProvider);
%shared_ptr(logicalaccess::AxessTMCLegicReaderUnit);
%shared_ptr(logicalaccess::AxessTMCLegicReaderUnitConfiguration);

%shared_ptr(logicalaccess::DeisterReaderProvider);
%shared_ptr(logicalaccess::DeisterReaderUnit);
%shared_ptr(logicalaccess::DeisterReaderUnitConfiguration);

%shared_ptr(logicalaccess::ElatecReaderProvider);
%shared_ptr(logicalaccess::ElatecReaderUnit);
%shared_ptr(logicalaccess::ElatecReaderUnitConfiguration);

%shared_ptr(logicalaccess::GigaTMSReaderProvider);
%shared_ptr(logicalaccess::GigaTMSReaderUnit);
%shared_ptr(logicalaccess::GigaTMSReaderUnitConfiguration);

%shared_ptr(logicalaccess::GunneboReaderProvider);
%shared_ptr(logicalaccess::GunneboReaderUnit);
%shared_ptr(logicalaccess::GunneboReaderUnitConfiguration);

%shared_ptr(logicalaccess::IdOnDemandReaderProvider);
%shared_ptr(logicalaccess::IdOnDemandReaderUnit);
%shared_ptr(logicalaccess::IdOnDemandReaderUnitConfiguration);

%shared_ptr(logicalaccess::ISO7816ReaderUnit);
%shared_ptr(logicalaccess::ISO7816ReaderUnitConfiguration);

%shared_ptr(logicalaccess::KeyboardReaderProvider);
%shared_ptr(logicalaccess::KeyboardReaderUnit);
%shared_ptr(logicalaccess::KeyboardReaderUnitConfiguration);

%shared_ptr(logicalaccess::OK5553ReaderProvider);
%shared_ptr(logicalaccess::OK5553ReaderUnit);
%shared_ptr(logicalaccess::OK5553ReaderUnitConfiguration);

%shared_ptr(logicalaccess::OSDPReaderProvider);
%shared_ptr(logicalaccess::OSDPReaderUnit);
%shared_ptr(logicalaccess::OSDPReaderUnitConfiguration);

%shared_ptr(logicalaccess::PCSCReaderProvider);
%shared_ptr(logicalaccess::PCSCReaderUnit);
%shared_ptr(logicalaccess::PCSCReaderUnitConfiguration);
%shared_ptr(logicalaccess::PCSCDataTransport);

%shared_ptr(logicalaccess::PromagReaderProvider);
%shared_ptr(logicalaccess::PromagReaderUnit);
%shared_ptr(logicalaccess::PromagReaderUnitConfiguration);

%shared_ptr(logicalaccess::RFIDeasReaderProvider);
%shared_ptr(logicalaccess::RFIDeasReaderUnit);
%shared_ptr(logicalaccess::RFIDeasReaderUnitConfiguration);

%shared_ptr(logicalaccess::RplethReaderProvider);
%shared_ptr(logicalaccess::RplethReaderUnit);
%shared_ptr(logicalaccess::RplethReaderUnitConfiguration);
%shared_ptr(logicalaccess::RplethDataTransport);

%shared_ptr(logicalaccess::SCIELReaderProvider);
%shared_ptr(logicalaccess::SCIELReaderUnit);
%shared_ptr(logicalaccess::SCIELReaderUnitConfiguration);

%shared_ptr(logicalaccess::SmartIDReaderProvider);
%shared_ptr(logicalaccess::SmartIDReaderUnit);
%shared_ptr(logicalaccess::SmartIDReaderUnitConfiguration);

%shared_ptr(logicalaccess::STidPRGReaderProvider);
%shared_ptr(logicalaccess::STidPRGReaderUnit);
%shared_ptr(logicalaccess::STidPRGReaderUnitConfiguration);

%shared_ptr(logicalaccess::STidSTRReaderProvider);
%shared_ptr(logicalaccess::STidSTRReaderUnit);
%shared_ptr(logicalaccess::STidSTRReaderUnitConfiguration);

typedef std::shared_ptr<logicalaccess::ReaderProvider> ReaderProviderPtr;
typedef std::shared_ptr<logicalaccess::ReaderUnit> ReaderUnitPtr;


%{
/* Core */

#include <logicalaccess/readerproviders/readerconfiguration.hpp>
#include <logicalaccess/readerproviders/readerprovider.hpp>
#include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
#include <logicalaccess/readerproviders/lcddisplay.hpp>
#include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
#include <logicalaccess/readerproviders/datatransport.hpp>

/* Plugins */

#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerprovider.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunit.hpp>

#include <logicalaccess/plugins/readers/admitto/admittoreaderprovider.hpp>
#include <logicalaccess/plugins/readers/admitto/admittoreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/admitto/admittoreaderunit.hpp>

#include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerprovider.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunit.hpp>

#include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderprovider.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunit.hpp>

#include <logicalaccess/plugins/readers/deister/deisterreaderprovider.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/deister/deisterreaderunit.hpp>

#include <logicalaccess/plugins/readers/elatec/elatecreaderprovider.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/elatec/elatecreaderunit.hpp>

#include <logicalaccess/plugins/readers/gigatms/gigatmsreaderprovider.hpp>
#include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunit.hpp>

#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderprovider.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunit.hpp>

#include <logicalaccess/plugins/readers/idondemand/idondemandreaderprovider.hpp>
#include <logicalaccess/plugins/readers/idondemand/idondemandreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/idondemand/idondemandreaderunit.hpp>

#include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>

#include <logicalaccess/plugins/readers/keyboard/keyboardreaderprovider.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/keyboard/keyboardreaderunit.hpp>

#include <logicalaccess/plugins/readers/ok5553/ok5553readerprovider.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/ok5553/ok5553readerunit.hpp>

#include <logicalaccess/plugins/readers/osdp/osdpreaderprovider.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/osdp/osdpreaderunit.hpp>

#include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
#include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>

#include <logicalaccess/plugins/readers/promag/promagreaderprovider.hpp>
#include <logicalaccess/plugins/readers/promag/promagreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/promag/promagreaderunit.hpp>

#include <logicalaccess/plugins/readers/rfideas/rfideasreaderprovider.hpp>
#include <logicalaccess/plugins/readers/rfideas/rfideasreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/rfideas/rfideasreaderunit.hpp>

#include <logicalaccess/plugins/readers/rpleth/rplethreaderprovider.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethdatatransport.hpp>
#include <logicalaccess/plugins/readers/rpleth/rplethreaderunit.hpp>

#include <logicalaccess/plugins/readers/sciel/scielreaderprovider.hpp>
#include <logicalaccess/plugins/readers/sciel/scielreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/sciel/scielreaderunit.hpp>

#include <logicalaccess/plugins/readers/smartid/smartidreaderprovider.hpp>
#include <logicalaccess/plugins/readers/smartid/smartidreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/smartid/smartidreaderunit.hpp>

#include <logicalaccess/plugins/readers/stidprg/stidprgreaderprovider.hpp>
#include <logicalaccess/plugins/readers/stidprg/stidprgreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/stidprg/stidprgreaderunit.hpp>

#include <logicalaccess/plugins/readers/stidstr/stidstrreaderprovider.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderunitconfiguration.hpp>
#include <logicalaccess/plugins/readers/stidstr/stidstrreaderunit.hpp>

using namespace logicalaccess;

%}

%ignore logicalaccess::ReaderCardAdapter;
%ignore logicalaccess::PCSCReaderCardAdapter;

/* original header files */
%include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
%include <logicalaccess/readerproviders/lcddisplay.hpp>
%include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>

%include "liblogicalaccess_readerservice.i"

%include <logicalaccess/readerproviders/readerunit.hpp>
%include <logicalaccess/readerproviders/readerprovider.hpp>
%include <logicalaccess/readerproviders/readerconfiguration.hpp>

%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerprovider.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/a3mlgm5600/a3mlgm5600readerunit.hpp>

%include <logicalaccess/plugins/readers/admitto/admittoreaderprovider.hpp>
%include <logicalaccess/plugins/readers/admitto/admittoreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/admitto/admittoreaderunit.hpp>

%include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerprovider.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/axesstmc13/axesstmc13readerunit.hpp>

%include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderprovider.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/axesstmclegic/axesstmclegicreaderunit.hpp>

%include <logicalaccess/plugins/readers/deister/deisterreaderprovider.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/deister/deisterreaderunit.hpp>

%include <logicalaccess/plugins/readers/elatec/elatecreaderprovider.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/elatec/elatecreaderunit.hpp>

%include <logicalaccess/plugins/readers/gigatms/gigatmsreaderprovider.hpp>
%include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/gigatms/gigatmsreaderunit.hpp>

%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderprovider.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/gunnebo/gunneboreaderunit.hpp>

%include <logicalaccess/plugins/readers/idondemand/idondemandreaderprovider.hpp>
%include <logicalaccess/plugins/readers/idondemand/idondemandreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/idondemand/idondemandreaderunit.hpp>

%include <logicalaccess/plugins/readers/iso7816/iso7816readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/iso7816/iso7816readerunit.hpp>

%include <logicalaccess/plugins/readers/keyboard/keyboardreaderprovider.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/keyboard/keyboardreaderunit.hpp>

%include <logicalaccess/plugins/readers/ok5553/ok5553readerprovider.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/ok5553/ok5553readerunit.hpp>

%include <logicalaccess/plugins/readers/osdp/osdpreaderprovider.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/osdp/osdpreaderunit.hpp>

%include <logicalaccess/plugins/readers/pcsc/pcscreaderprovider.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscdatatransport.hpp>
%include <logicalaccess/plugins/readers/pcsc/pcscreaderunit.hpp>

%include <logicalaccess/plugins/readers/promag/promagreaderprovider.hpp>
%include <logicalaccess/plugins/readers/promag/promagreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/promag/promagreaderunit.hpp>

%include <logicalaccess/plugins/readers/rfideas/rfideasreaderprovider.hpp>
%include <logicalaccess/plugins/readers/rfideas/rfideasreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/rfideas/rfideasreaderunit.hpp>

%include <logicalaccess/plugins/readers/rpleth/rplethreaderprovider.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethdatatransport.hpp>
%include <logicalaccess/plugins/readers/rpleth/rplethreaderunit.hpp>

%include <logicalaccess/plugins/readers/sciel/scielreaderprovider.hpp>
%include <logicalaccess/plugins/readers/sciel/scielreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/sciel/scielreaderunit.hpp>

%include <logicalaccess/plugins/readers/smartid/smartidreaderprovider.hpp>
%include <logicalaccess/plugins/readers/smartid/smartidreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/smartid/smartidreaderunit.hpp>

%include <logicalaccess/plugins/readers/stidprg/stidprgreaderprovider.hpp>
%include <logicalaccess/plugins/readers/stidprg/stidprgreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/stidprg/stidprgreaderunit.hpp>

%include <logicalaccess/plugins/readers/stidstr/stidstrreaderprovider.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderunitconfiguration.hpp>
%include <logicalaccess/plugins/readers/stidstr/stidstrreaderunit.hpp>

%template(ReaderUnitCollection) std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >;

%pragma(csharp) imclasscode=%{
  public static ReaderProvider createReaderProvider(System.IntPtr cPtr, bool owner)
  {
    ReaderProvider ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	string rt = ($modulePINVOKE.ReaderProvider_getRPType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
    switch (rt) {
       case "A3MLGM5600":
	     ret = new A3MLGM5600ReaderProvider(cPtr, owner);
	     break;
	   case "Admitto":
	     ret = new AdmittoReaderProvider(cPtr, owner);
	     break;
	   case "AxessTMC13":
	     ret = new AxessTMC13ReaderProvider(cPtr, owner);
		 break;
	   case "AxessTMCLegic":
	     ret = new AxessTMCLegicReaderProvider(cPtr, owner);
		 break;
	   case "Deister":
	     ret = new DeisterReaderProvider(cPtr, owner);
		 break;
	   case "Elatec":
	     ret = new ElatecReaderProvider(cPtr, owner);
		 break;
	   case "GigaTMS":
	     ret = new GigaTMSReaderProvider(cPtr, owner);
		 break;
	   case "Gunnebo":
	     ret = new GunneboReaderProvider(cPtr, owner);
		 break;
	   case "IdOnDemand":
	     ret = new IdOnDemandReaderProvider(cPtr, owner);
		 break;
	   case "Keyboard":
	     ret = new KeyboardReaderProvider(cPtr, owner);
		 break;
	   case "OK5553":
	     ret = new OK5553ReaderProvider(cPtr, owner);
		 break;
	   case "OSDP":
	     ret = new OSDPReaderProvider(cPtr, owner);
		 break;
	   case "PCSC":
	     ret = new PCSCReaderProvider(cPtr, owner);
		 break;
	   case "Promag":
	     ret = new PromagReaderProvider(cPtr, owner);
		 break;
	   case "RFIDeas":
	     ret = new RFIDeasReaderProvider(cPtr, owner);
		 break;
	   case "Rpleth":
	     ret = new RplethReaderProvider(cPtr, owner);
		 break;
	   case "SCIEL":
	     ret = new SCIELReaderProvider(cPtr, owner);
		 break;
	   case "SmartID":
	     ret = new SmartIDReaderProvider(cPtr, owner);
		 break;
	   case "STidPRG":
	     ret = new STidPRGReaderProvider(cPtr, owner);
		 break;
	   case "STidSTR":
	     ret = new STidSTRReaderProvider(cPtr, owner);
		 break;
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::ReaderProvider*, std::shared_ptr<logicalaccess::ReaderProvider> {
    System.IntPtr cPtr = $imcall;
    ReaderProvider ret = liblogicalaccess_readerPINVOKE.createReaderProvider(cPtr, $owner);$excode
    return ret;
}