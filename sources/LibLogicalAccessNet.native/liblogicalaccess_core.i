/* File : liblogicalaccess_core.i */
%module(directors="1") liblogicalaccess_core

%include "liblogicalaccess.i"
%import "liblogicalaccess_exception.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Reader;
using LibLogicalAccess.Crypto;
%}

%{

#include <boost/asio/ssl.hpp>

#include <logicalaccess/plugins/crypto/symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/openssl_symmetric_cipher_context.hpp>
#include <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>

/* Additional_include */

#include <logicalaccess/lla_core_api.hpp>
#include <logicalaccess/lla_fwd.hpp>
#include <logicalaccess/asn1.hpp>
#include <logicalaccess/boost_version_types.hpp>
#include <logicalaccess/bufferhelper.hpp>
#include <logicalaccess/cardprobe.hpp>
#include <logicalaccess/xmlserializable.hpp>
#include <logicalaccess/techno.hpp>
#include <logicalaccess/services/reader_service.hpp>
#include <logicalaccess/readerproviders/readerunit.hpp>
#include <logicalaccess/readerproviders/readerprovider.hpp>
#include <logicalaccess/linearizable.hpp>
#include <logicalaccess/cards/keystorage.hpp>
#include <logicalaccess/cards/keydiversification.hpp>
#include <logicalaccess/key.hpp>
#include <logicalaccess/cards/accessinfo.hpp>
#include <logicalaccess/cards/aes128key.hpp>
#include <logicalaccess/services/cardservice.hpp>
#include <logicalaccess/cards/ichip.hpp>
#include <logicalaccess/cards/chip.hpp>
#include <logicalaccess/readerproviders/datatransport.hpp>
#include <logicalaccess/myexception.hpp>
#include <logicalaccess/resultchecker.hpp>
#include <logicalaccess/cards/readercardadapter.hpp>
#include <logicalaccess/cards/icommands.hpp>
#include <logicalaccess/cards/commands.hpp>
#include <logicalaccess/cards/computermemorykeystorage.hpp>
#include <logicalaccess/cards/hmac1key.hpp>
#include <logicalaccess/cards/location.hpp>
#include <logicalaccess/cards/locationnode.hpp>
#include <logicalaccess/cards/pkcskeystorage.hpp>
#include <logicalaccess/cards/readermemorykeystorage.hpp>
#include <logicalaccess/cards/samchip.hpp>
#include <logicalaccess/cards/samkeystorage.hpp>
#include <logicalaccess/cards/tripledeskey.hpp>
#include <logicalaccess/colorize.hpp>
#include <logicalaccess/readerproviders/circularbufferparser.hpp>
#include <logicalaccess/readerproviders/dummydatatransport.hpp>
#include <logicalaccess/readerproviders/dummyreaderunit.hpp>
#include <logicalaccess/readerproviders/readercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443areadercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443breadercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443readercommunication.hpp>
#include <logicalaccess/readerproviders/iso15693readercommunication.hpp>
#include <logicalaccess/readerproviders/lcddisplay.hpp>
#include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
#include <logicalaccess/readerproviders/readerconfiguration.hpp>
#include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
#include <logicalaccess/readerproviders/serialport.hpp>
#include <logicalaccess/readerproviders/serialportxml.hpp>
#include <logicalaccess/readerproviders/serialportdatatransport.hpp>
#include <logicalaccess/readerproviders/tcpdatatransport.hpp>
#include <logicalaccess/readerproviders/udpdatatransport.hpp>
#include <logicalaccess/services/accesscontrol/encodings/encoding.hpp>
#include <logicalaccess/services/accesscontrol/formats/BitsetStream.hpp>
#include <logicalaccess/services/accesscontrol/encodings/datarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/datatype.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/datafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/format.hpp>
#include <logicalaccess/services/accesscontrol/accesscontrolcardservice.hpp>
#include <logicalaccess/services/accesscontrol/formatinfos.hpp>
#include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bcdbytedatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bcdnibbledatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bigendiandatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/binarydatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/littleendiandatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/nodatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/formats/staticformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/asciiformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/bariumferritepcscformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/bithelper.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/valuedatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/binarydatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/checksumdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/customformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/numberdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/paritydatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/stringdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/tlvdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/dataclockformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/fascn200bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/getronik40bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/hidhoneywell40bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/rawformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/seosformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegandformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand26format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand34format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand34withfacilityformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand35format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityrightparity2format.hpp>
#include <logicalaccess/services/accesscontrol/readerformatcomposite.hpp>
#include <logicalaccess/services/aes_crypto_service.hpp>
#include <logicalaccess/services/challenge/challengecardservice.hpp>
#include <logicalaccess/services/identity/identity_service.hpp>
#include <logicalaccess/services/json/json_dump_card_service.hpp>
#include <logicalaccess/services/licensechecker/license_checker_service.hpp>
#include <logicalaccess/services/nfctag/nfcdata.hpp>
#include <logicalaccess/services/nfctag/lockcontroltlv.hpp>
#include <logicalaccess/services/nfctag/memorycontroltlv.hpp>
#include <logicalaccess/services/nfctag/ndefrecord.hpp>
#include <logicalaccess/services/nfctag/textrecord.hpp>
#include <logicalaccess/services/nfctag/urirecord.hpp>
#include <logicalaccess/services/nfctag/ndefmessage.hpp>
#include <logicalaccess/services/nfctag/nfctagcardservice.hpp>
#include <logicalaccess/services/storage/storagecardservice.hpp>
#include <logicalaccess/services/uidchanger/uidchangerservice.hpp>
#include <logicalaccess/tlv.hpp>
#include <logicalaccess/utils.hpp>
#include <logicalaccess/windowsregistry.hpp>

/* END_Additional_include */

using namespace logicalaccess;

%}

/* Configuration_section */

%apply unsigned int *INOUT { unsigned int* pos }
%apply unsigned int INOUT[] { unsigned int* locations, unsigned int* positions }
%apply unsigned char INPUT[] { const unsigned char* data }

%typemap(ctype) KeyStorageType "KeyStorageType"
%typemap(cstype) KeyStorageType "KeyStorageType"
%typemap(csin) KeyStorageType %{$csinput%}  
%typemap(imtype) KeyStorageType "KeyStorageType"
%typemap(csout, excode=SWIGEXCODE) KeyStorageType {
	KeyStorageType ret = $imcall;$excode
	return ret;
}

%typemap(ctype) const ReaderServiceType & "const ReaderServiceType *"
%typemap(cstype) const ReaderServiceType & "ReaderServiceType"
%typemap(csin) const ReaderServiceType & %{$csinput%}  
%typemap(imtype) const ReaderServiceType & "ReaderServiceType"
%typemap(csout, excode=SWIGEXCODE) const ReaderServiceType & {
	ReaderServiceType ret = $imcall;$excode
	return ret;
}

typedef std::shared_ptr<logicalaccess::Chip> ChipPtr;
typedef std::shared_ptr<logicalaccess::Key> KeyPtr;

%nodefaultctor ISO15693ReaderCommunication;
%nodefaultdtor ISO15693ReaderCommunication;

%ignore logicalaccess::TcpDataTransport::connect();
%ignore *::getTime;
%ignore logicalaccess::PKCSKeyStorage::get_pkcs_properties;
%ignore logicalaccess::PKCSKeyStorage::set_pkcs_properties;

%shared_ptr(std::enable_shared_from_this<logicalaccess::Chip>);
%shared_ptr(std::enable_shared_from_this<logicalaccess::ReaderProvider>);
%shared_ptr(std::enable_shared_from_this<logicalaccess::ReaderUnit>);
%template(ChipEnableShared) std::enable_shared_from_this<logicalaccess::Chip>;
%template(ReaderProviderEnableShared) std::enable_shared_from_this<logicalaccess::ReaderProvider>;
%template(ReaderUnitEnableShared) std::enable_shared_from_this<logicalaccess::ReaderUnit>;

%pragma(csharp) imclasscode=%{
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

	public static System.Collections.Generic.Dictionary<string, System.Type> chipDictionary;

	public static Chip	createChip(System.IntPtr cPtr, bool owner)
	{
		Chip ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($imclassname.Chip_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (chipDictionary == null)
			chipDictionary = createDictionary<Chip>();
        if (chipDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.CreateInstance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Chip)System.Activator.CreateInstance(chipDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		else
		{
			ret = new Chip(cPtr, owner);
		}
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Chip*, std::shared_ptr<logicalaccess::Chip>, std::shared_ptr<logicalaccess::Chip> & {
    System.IntPtr cPtr = $imcall;
    Chip ret = liblogicalaccess_corePINVOKE.createChip(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> cmdDictionary;

	public static Commands	createCommands(System.IntPtr cPtr, bool owner)
	{
		Commands ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($imclassname.Commands_getCmdType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (cmdDictionary == null)
			cmdDictionary = createDictionary<Commands>();
        if (cmdDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.CreateInstance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Commands)System.Activator.CreateInstance(cmdDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
        else
            throw new LibLogicalAccessNetException($"Unknown Command type: {ct}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Commands*, std::shared_ptr<logicalaccess::Commands>, std::shared_ptr<logicalaccess::Commands>& {
    System.IntPtr cPtr = $imcall;
    Commands ret = liblogicalaccess_corePINVOKE.createCommands(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> readerUnitDictionary;

	public static ReaderUnit createReaderUnit(System.IntPtr cPtr, bool owner)
	{
		ReaderUnit ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string rpt = ($imclassname.ReaderUnit_getRPType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (readerUnitDictionary == null)
			readerUnitDictionary = createDictionary<ReaderUnit>();
        if (readerUnitDictionary.ContainsKey(rpt))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (ReaderUnit)System.Activator.CreateInstance(readerUnitDictionary[rpt], flags, null, new object[] { cPtr, owner }, null);
        }
		else
            throw new LibLogicalAccessNetException($"Unknown ReaderUnit type: {rpt}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::ReaderUnit*, std::shared_ptr<logicalaccess::ReaderUnit>, std::shared_ptr<logicalaccess::ReaderUnit> & {
    System.IntPtr cPtr = $imcall;
    ReaderUnit ret = liblogicalaccess_corePINVOKE.createReaderUnit(cPtr, $owner);$excode
    return ret;
  }

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> ReaderUnitConfigurationDictionary;

	public static ReaderUnitConfiguration createReaderUnitConfiguration(System.IntPtr cPtr, bool owner)
	{
		ReaderUnitConfiguration ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string rpt = ($imclassname.ReaderUnitConfiguration_getRPType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (ReaderUnitConfigurationDictionary == null)
			ReaderUnitConfigurationDictionary = createDictionary<ReaderUnitConfiguration>();
        if (ReaderUnitConfigurationDictionary.ContainsKey(rpt))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (ReaderUnitConfiguration)System.Activator.CreateInstance(ReaderUnitConfigurationDictionary[rpt], flags, null, new object[] { cPtr, owner }, null);
        }
		else
            throw new LibLogicalAccessNetException($"Unknown ReaderUnitConfiguration type: {rpt}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::ReaderUnitConfiguration*, std::shared_ptr<logicalaccess::ReaderUnitConfiguration>, std::shared_ptr<logicalaccess::ReaderUnitConfiguration> & {
    System.IntPtr cPtr = $imcall;
    ReaderUnitConfiguration ret = liblogicalaccess_corePINVOKE.createReaderUnitConfiguration(cPtr, $owner);$excode
    return ret;
  }

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> ReaderProviderDictionary;

	public static ReaderProvider createReaderProvider(System.IntPtr cPtr, bool owner)
	{
		ReaderProvider ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string rpt = ($imclassname.ReaderProvider_getRPType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (ReaderProviderDictionary == null)
			ReaderProviderDictionary = createDictionary<ReaderProvider>();
        if (ReaderProviderDictionary.ContainsKey(rpt))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (ReaderProvider)System.Activator.CreateInstance(ReaderProviderDictionary[rpt], flags, null, new object[] { cPtr, owner }, null);
        }
		else
            throw new LibLogicalAccessNetException($"Unknown ReaderProvider type: {rpt}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::ReaderProvider*, std::shared_ptr<logicalaccess::ReaderProvider>, std::shared_ptr<logicalaccess::ReaderProvider> & {
    System.IntPtr cPtr = $imcall;
    ReaderProvider ret = liblogicalaccess_corePINVOKE.createReaderProvider(cPtr, $owner);$excode
    return ret;
  }

%template(getVectorReaderUnit) getVectorPart<std::shared_ptr<logicalaccess::ReaderUnit> >;

%typemap(csout, excode=SWIGEXCODE)
  std::vector<logicalaccess::ReaderUnit*>, std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >, 
  const std::vector<logicalaccess::ReaderUnit*>&, const std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >& {
	System.IntPtr cPtr = $imcall;
	ReaderUnitVector tmp = new ReaderUnitVector(cPtr, $owner);
	ReaderUnitVector ret = new ReaderUnitVector();
	for (int i = 0; i < tmp.Count; i++)
	{
	  ret.Add(liblogicalaccess_corePINVOKE.createReaderUnit(liblogicalaccess_corePINVOKE.getVectorReaderUnit(ReaderUnitVector.getCPtr(tmp), i), $owner));
	}$excode;
	return ret;
  }

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> cardServiceDictionary;

	public static CardService	createCardService(System.IntPtr cPtr, bool owner)
	{
		CardService ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($imclassname.CardService_getCSType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (cardServiceDictionary == null)
			cardServiceDictionary = createDictionary<CardService>();
        if (cardServiceDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (CardService)System.Activator.CreateInstance(cardServiceDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
        else
            throw new LibLogicalAccessNetException($"Unknown CardService type: {ct}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::CardService*, std::shared_ptr<logicalaccess::CardService>, std::shared_ptr<logicalaccess::CardService> & {
    System.IntPtr cPtr = $imcall;
    CardService ret = liblogicalaccess_corePINVOKE.createCardService(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
  public static ReaderService createReaderService(System.IntPtr cPtr, bool owner)
  {
    ReaderService ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	ReaderServiceType svcType = (ReaderServiceType)($imclassname.ReaderService_getServiceType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
	if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
    switch (svcType) {
       case ReaderServiceType.RST_LICENSE_CHECKER:
	     ret = new LicenseCheckerService(cPtr, owner);
	     break;
		default:
            throw new LibLogicalAccessNetException($"Unknown ReaderService type: {svcType}");
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::ReaderService*, std::shared_ptr<logicalaccess::ReaderService>, std::shared_ptr<logicalaccess::ReaderService> & {
    System.IntPtr cPtr = $imcall;
    ReaderService ret = liblogicalaccess_corePINVOKE.createReaderService(cPtr, $owner);$excode
    return ret;
}

/* END_Configuration_section */

/* Include external swig after typemap */
%include "liblogicalaccess_readerservice.i"
%include "liblogicalaccess_cardservice.i"

%import <logicalaccess/plugins/crypto/symmetric_key.hpp>
%import <logicalaccess/plugins/crypto/initialization_vector.hpp>
%import <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
%import <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
%import <logicalaccess/plugins/crypto/openssl_symmetric_cipher_context.hpp>
%import <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>

%feature("director") DummyReaderUnit;
%feature("director") DummyDataTransport;

/* Include_section */

%include <logicalaccess/lla_core_api.hpp>
%include <logicalaccess/lla_fwd.hpp>
%include <logicalaccess/asn1.hpp>
%include <logicalaccess/boost_version_types.hpp>
%include <logicalaccess/bufferhelper.hpp>
%include <logicalaccess/cardprobe.hpp>
%include <logicalaccess/xmlserializable.hpp>
%include <logicalaccess/techno.hpp>
%include <logicalaccess/services/reader_service.hpp>
%include <logicalaccess/readerproviders/readerunit.hpp>
%include <logicalaccess/readerproviders/readerprovider.hpp>
%include <logicalaccess/linearizable.hpp>
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/cards/keydiversification.hpp>
%include <logicalaccess/key.hpp>
%include <logicalaccess/cards/accessinfo.hpp>
%include <logicalaccess/cards/aes128key.hpp>
%include <logicalaccess/services/cardservice.hpp>
%include <logicalaccess/cards/ichip.hpp>
%include <logicalaccess/cards/chip.hpp>
%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/myexception.hpp>
%include <logicalaccess/resultchecker.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
%include <logicalaccess/cards/icommands.hpp>
%include <logicalaccess/cards/commands.hpp>
%include <logicalaccess/cards/computermemorykeystorage.hpp>
%include <logicalaccess/cards/hmac1key.hpp>
%include <logicalaccess/cards/location.hpp>
%include <logicalaccess/cards/locationnode.hpp>
%include <logicalaccess/cards/pkcskeystorage.hpp>
%include <logicalaccess/cards/readermemorykeystorage.hpp>
%include <logicalaccess/cards/samchip.hpp>
%include <logicalaccess/cards/samkeystorage.hpp>
%include <logicalaccess/cards/tripledeskey.hpp>
%include <logicalaccess/colorize.hpp>
%include <logicalaccess/readerproviders/circularbufferparser.hpp>
%include <logicalaccess/readerproviders/dummydatatransport.hpp>
%include <logicalaccess/readerproviders/dummyreaderunit.hpp>
%include <logicalaccess/readerproviders/readercommunication.hpp>
%import <logicalaccess/plugins/llacommon/lla_common_api.hpp>
%import <logicalaccess/plugins/llacommon/logs.hpp>
%include <logicalaccess/readerproviders/iso14443areadercommunication.hpp>
%include <logicalaccess/readerproviders/iso14443breadercommunication.hpp>
%include <logicalaccess/readerproviders/iso14443readercommunication.hpp>
%include <logicalaccess/readerproviders/iso15693readercommunication.hpp>
%include <logicalaccess/readerproviders/lcddisplay.hpp>
%include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
%include <logicalaccess/readerproviders/readerconfiguration.hpp>
%include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
%include <logicalaccess/readerproviders/serialport.hpp>
%include <logicalaccess/readerproviders/serialportxml.hpp>
%include <logicalaccess/readerproviders/serialportdatatransport.hpp>
%include <logicalaccess/readerproviders/tcpdatatransport.hpp>
%include <logicalaccess/readerproviders/udpdatatransport.hpp>
%include <logicalaccess/services/accesscontrol/encodings/encoding.hpp>
%include <logicalaccess/services/accesscontrol/formats/BitsetStream.hpp>
%include <logicalaccess/services/accesscontrol/encodings/datarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/datatype.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/datafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/format.hpp>
%include <logicalaccess/services/accesscontrol/accesscontrolcardservice.hpp>
%include <logicalaccess/services/accesscontrol/formatinfos.hpp>
%include <logicalaccess/services/accesscontrol/cardsformatcomposite.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bcdbytedatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bcdnibbledatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bigendiandatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/binarydatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/littleendiandatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/nodatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/formats/staticformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/asciiformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/bariumferritepcscformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/bithelper.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/valuedatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/binarydatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/checksumdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/customformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/numberdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/paritydatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/stringdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/tlvdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/dataclockformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/fascn200bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/getronik40bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/hidhoneywell40bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/rawformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/seosformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegandformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand26format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand34format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand34withfacilityformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand35format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityrightparity2format.hpp>
%include <logicalaccess/services/accesscontrol/readerformatcomposite.hpp>
%include <logicalaccess/services/aes_crypto_service.hpp>
%include <logicalaccess/services/challenge/challengecardservice.hpp>
%include <logicalaccess/services/identity/identity_service.hpp>
%include <logicalaccess/services/json/json_dump_card_service.hpp>
%include <logicalaccess/services/licensechecker/license_checker_service.hpp>
%include <logicalaccess/services/nfctag/nfcdata.hpp>
%include <logicalaccess/services/nfctag/lockcontroltlv.hpp>
%include <logicalaccess/services/nfctag/memorycontroltlv.hpp>
%include <logicalaccess/services/nfctag/ndefrecord.hpp>
%include <logicalaccess/services/nfctag/textrecord.hpp>
%include <logicalaccess/services/nfctag/urirecord.hpp>
%include <logicalaccess/services/nfctag/ndefmessage.hpp>
%include <logicalaccess/services/nfctag/nfctagcardservice.hpp>
%include <logicalaccess/services/storage/storagecardservice.hpp>
%include <logicalaccess/services/uidchanger/uidchangerservice.hpp>
%include <logicalaccess/tlv.hpp>
%include <logicalaccess/utils.hpp>
%include <logicalaccess/windowsregistry.hpp>

/* END_Include_section */

%template(ChipVector) std::vector<std::shared_ptr<logicalaccess::Chip> >;
%template(LocationNodePtrCollection) std::vector<std::shared_ptr<logicalaccess::LocationNode> >;
%template(ReaderUnitVector) std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >;
%template(FormatVector) std::vector<std::shared_ptr<logicalaccess::Format> >;
%template(SerialPortXmlVector) std::vector<std::shared_ptr<logicalaccess::SerialPortXml> >;
%template(NfcDataVector) std::vector<std::shared_ptr<logicalaccess::NfcData> >;

%template(StringFormatMap) std::map<std::string, std::shared_ptr<logicalaccess::Format> >;
%template(StringKeyMap) std::map<std::string, std::shared_ptr<logicalaccess::Key> >;
%template(StringFormatInfosMap) std::map<std::string, std::shared_ptr<logicalaccess::FormatInfos> >;

%template(LocationNodeWeakPtr) std::weak_ptr<logicalaccess::LocationNode>;
%template(ReaderProviderWeakPtr) std::weak_ptr<logicalaccess::ReaderProvider>;
%template(ReaderUnitWeakPtr) std::weak_ptr<logicalaccess::ReaderUnit>;


