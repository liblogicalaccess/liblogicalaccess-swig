/* File : liblogicalaccess_data.i */
%module(directors="1") liblogicalaccess_data

%include "liblogicalaccess.i"
%import "liblogicalaccess_exception.i"

%{
#include <logicalaccess/lla_fwd.hpp>
#include <logicalaccess/utils.hpp>
#include <logicalaccess/xmlserializable.hpp>
#include "logicalaccess/cards/keystorage.hpp"
#include <logicalaccess/plugins/readers/private-pcsc/type_fwd.hpp>
#include <logicalaccess/techno.hpp>
#include <logicalaccess/key.hpp>
#include <logicalaccess/tlv.hpp>
#include <logicalaccess/cards/readercardadapter.hpp>
#include <logicalaccess/readerproviders/datatransport.hpp>
#include <logicalaccess/resultchecker.hpp>
#include <logicalaccess/cards/accessinfo.hpp>
#include <logicalaccess/cards/location.hpp>
#include <logicalaccess/services/accesscontrol/formatinfos.hpp>
#include <logicalaccess/services/accesscontrol/formats/BitsetStream.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/datafield.hpp>
#include <logicalaccess/services/accesscontrol/encodings/binarydatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bcdbytedatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bcdnibbledatatype.hpp>
#include <logicalaccess/services/accesscontrol/encodings/bigendiandatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/littleendiandatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/encodings/nodatarepresentation.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/binarydatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/numberdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/paritydatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/stringdatafield.hpp>
#include <logicalaccess/services/accesscontrol/formats/customformat/customformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/format.hpp>
#include <logicalaccess/services/accesscontrol/formats/staticformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand35format.hpp>
#include <logicalaccess/services/accesscontrol/formats/rawformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand26format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand34format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand34withfacilityformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37format.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityrightparity2format.hpp>
#include <logicalaccess/services/accesscontrol/formats/hidhoneywell40bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/getronik40bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/fascn200bitformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/dataclockformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/bariumferritepcscformat.hpp>
#include <logicalaccess/services/accesscontrol/formats/asciiformat.hpp>
#include <logicalaccess/services/nfctag/ndefrecord.hpp>
#include <logicalaccess/services/nfctag/textrecord.hpp>
#include <logicalaccess/services/nfctag/urirecord.hpp>

using namespace logicalaccess;
%}

CSHARP_MEMBER_STRUCT_ARRAYS(logicalaccess::MifareAccessInfo::DataBlockAccessBits, MifareAccessInfo.DataBlockAccessBits)

%typemap(cstype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"
%typemap(csin) logicalaccess::STidTamperSwitchBehavior& %{out $csinput%}  
%typemap(imtype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"

%ignore logicalaccess::DataTransport::getReaderUnit;
%ignore logicalaccess::DataTransport::setReaderUnit;

%pragma(csharp) imclasscode=%{

	public static Format	createFormat(System.IntPtr cPtr, bool owner)
	{
		Format ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
        int ft = (liblogicalaccess_dataPINVOKE.Format_getType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
                var csType = typeof(CustomFormat); // Just a default
        switch ((FormatType)ft)
        {
            case FormatType.FT_WIEGAND26: { csType = typeof(Wiegand26Format); break; }
            case FormatType.FT_WIEGAND34: { csType = typeof(Wiegand34Format); break; }
            case FormatType.FT_WIEGAND34FACILITY: { csType = typeof(Wiegand34WithFacilityFormat); break; }
            case FormatType.FT_WIEGAND37: { csType = typeof(Wiegand37Format); break; }
            case FormatType.FT_WIEGAND37FACILITY: { csType = typeof(Wiegand37WithFacilityFormat); break; }
            case FormatType.FT_WIEGAND35: { csType = typeof(Wiegand35Format); break; }
            case FormatType.FT_DATACLOCK: { csType = typeof(DataClockFormat); break; }
            case FormatType.FT_FASCN200BIT: { csType = typeof(FASCN200BitFormat); break; }
            case FormatType.FT_HIDHONEYWELL: { csType = typeof(HIDHoneywell40BitFormat); break; }
            case FormatType.FT_GETRONIK40BIT: { csType = typeof(Getronik40BitFormat); break; }
            case FormatType.FT_BARIUM_FERRITE_PCSC: { csType = typeof(BariumFerritePCSCFormat); break; }
            case FormatType.FT_RAW: { csType = typeof(RawFormat); break; }
            case FormatType.FT_CUSTOM: { csType = typeof(CustomFormat); break; }
            case FormatType.FT_ASCII: { csType = typeof(ASCIIFormat); break; }
            default:
                throw new LibLogicalAccessNetException($"Unknown format type: {ft}");
        }
        System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
        ret = (Format)System.Activator.CreateInstance(csType, flags, null, new object[] { cPtr, owner }, null);
        return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Format*, std::shared_ptr<logicalaccess::Format>, std::shared_ptr<logicalaccess::Format> & {
    System.IntPtr cPtr = $imcall;
    Format ret = liblogicalaccess_dataPINVOKE.createFormat(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> dataTransportDictionary;

	public static DataTransport	createDataTransport(System.IntPtr cPtr, bool owner)
	{
		DataTransport ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($imclassname.DataTransport_getTransportType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (dataTransportDictionary == null)
			dataTransportDictionary = liblogicalaccess_corePINVOKE.createDictionary<DataTransport>();
        if (dataTransportDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (DataTransport)System.Activator.CreateInstance(dataTransportDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
        else
            throw new LibLogicalAccessNetException($"Unknown DataTransport type: {ct}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::DataTransport*, std::shared_ptr<logicalaccess::DataTransport>, std::shared_ptr<logicalaccess::DataTransport> & {
    System.IntPtr cPtr = $imcall;
    DataTransport ret = liblogicalaccess_dataPINVOKE.createDataTransport(cPtr, $owner);$excode
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
		string ct = ($imclassname.AccessInfo_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (accessInfoDictionary == null)
			accessInfoDictionary = liblogicalaccess_corePINVOKE.createDictionary<AccessInfo>();
        if (accessInfoDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (AccessInfo)System.Activator.CreateInstance(accessInfoDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
        else
            throw new LibLogicalAccessNetException($"Unknown AccessInfo type: {ct}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::AccessInfo*, std::shared_ptr<logicalaccess::AccessInfo>, std::shared_ptr<logicalaccess::AccessInfo> & {
    System.IntPtr cPtr = $imcall;
    AccessInfo ret = liblogicalaccess_dataPINVOKE.createAccessInfo(cPtr, $owner);$excode
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
		string ct = ($imclassname.Location_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
		if (locationDictionary == null)
			locationDictionary = liblogicalaccess_corePINVOKE.createDictionary<Location>();
        if (locationDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Location)System.Activator.CreateInstance(locationDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
        else
            throw new LibLogicalAccessNetException($"Unknown Location type: {ct}");
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Location*, std::shared_ptr<logicalaccess::Location>, std::shared_ptr<logicalaccess::Location> & {
    System.IntPtr cPtr = $imcall;
    Location ret = liblogicalaccess_dataPINVOKE.createLocation(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
  public static KeyStorage createKeyStorage(System.IntPtr cPtr, bool owner)
  {
    KeyStorage ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	KeyStorageType ks = (KeyStorageType)(liblogicalaccess_dataPINVOKE.KeyStorage_getType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
	if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
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
	   default:
         throw new LibLogicalAccessNetException($"Unknown KeyStorage type: {ks}");
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::KeyStorage*, std::shared_ptr<logicalaccess::KeyStorage>, std::shared_ptr<logicalaccess::KeyStorage> & {
    System.IntPtr cPtr = $imcall;
    KeyStorage ret = liblogicalaccess_dataPINVOKE.createKeyStorage(cPtr, $owner);$excode
    return ret;
}

%template(getVectorDataField) getVectorPart<std::shared_ptr<logicalaccess::DataField> >;

%typemap(csout, excode=SWIGEXCODE)
  std::vector<logicalaccess::DataField*>, std::vector<std::shared_ptr<logicalaccess::DataField> >, 
  const std::vector<logicalaccess::DataField*>&, const std::vector<std::shared_ptr<logicalaccess::DataField> >& {
	System.IntPtr cPtr = $imcall;
	DataFieldVector tmp = new DataFieldVector(cPtr, $owner);
	DataFieldVector ret = new DataFieldVector();
	for (int i = 0; i < tmp.Count; i++)
	{
	  ret.Add(liblogicalaccess_dataPINVOKE.createDataField(liblogicalaccess_dataPINVOKE.getVectorDataField(DataFieldVector.getCPtr(tmp), i), $owner));
	}$excode;
	return ret;
  }

%pragma(csharp) imclasscode=%{
  public static DataField createDataField(System.IntPtr cPtr, bool owner)
  {
    DataField ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	DataFieldType df = (DataFieldType)(liblogicalaccess_dataPINVOKE.DataField_getDFType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
	if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
    switch (df) {
	   case DataFieldType.DFT_VALUE:
	     ret = new ValueDataField(cPtr, owner);
	     break;
	  /* Not implemented yet.
	   case DataFieldType.DFT_CHECKSUM:
	     ret = new ChecksumDataField(cPtr, owner);
		 break;*/
	   case DataFieldType.DFT_PARITY:
	     ret = new ParityDataField(cPtr, owner);
		 break;
	   case DataFieldType.DFT_BINARY:
	     ret = new BinaryDataField(cPtr, owner);
		 break;
	   case DataFieldType.DFT_NUMBER:
	     ret = new NumberDataField(cPtr, owner);
		 break;
	   case DataFieldType.DFT_STRING:
	     ret = new StringDataField(cPtr, owner);
		 break;
	   default:
         throw new LibLogicalAccessNetException($"Unknown DataField type: {df}");
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::DataField*, std::shared_ptr<logicalaccess::DataField>, std::shared_ptr<logicalaccess::DataField> & {
    System.IntPtr cPtr = $imcall;
    DataField ret = liblogicalaccess_dataPINVOKE.createDataField(cPtr, $owner);$excode
    return ret;
  }

/**************************************/

%shared_ptr(std::enable_shared_from_this<logicalaccess::Key>);
%shared_ptr(std::enable_shared_from_this<logicalaccess::DataField>);
%shared_ptr(std::enable_shared_from_this<logicalaccess::KeyStorage>);
%template(KeyEnableShared) std::enable_shared_from_this<logicalaccess::Key>;
%template(DataFieldEnableShared) std::enable_shared_from_this<logicalaccess::DataField>;
%template(KeyStorageEnableShared) std::enable_shared_from_this<logicalaccess::KeyStorage>;

%include <logicalaccess/lla_fwd.hpp>
%include <logicalaccess/xmlserializable.hpp>
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/techno.hpp>
%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/resultchecker.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
%include <logicalaccess/key.hpp>
%include <logicalaccess/tlv.hpp>
%include <logicalaccess/cards/accessinfo.hpp>
%include <logicalaccess/cards/location.hpp>
%include <logicalaccess/services/accesscontrol/formatinfos.hpp>
%include <logicalaccess/services/accesscontrol/formats/BitsetStream.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/datafield.hpp>
%include <logicalaccess/services/accesscontrol/encodings/encoding.hpp>
%include <logicalaccess/services/accesscontrol/encodings/datarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/datatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/binarydatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bcdbytedatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bcdnibbledatatype.hpp>
%include <logicalaccess/services/accesscontrol/encodings/bigendiandatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/littleendiandatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/encodings/nodatarepresentation.hpp>
%include <logicalaccess/services/accesscontrol/formats/format.hpp>
%include <logicalaccess/services/accesscontrol/formats/staticformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand35format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegandformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/valuedatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/binarydatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/numberdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/paritydatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/stringdatafield.hpp>
%include <logicalaccess/services/accesscontrol/formats/customformat/customformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/rawformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand26format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand34format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand34withfacilityformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37format.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/wiegand37withfacilityrightparity2format.hpp>
%include <logicalaccess/services/accesscontrol/formats/hidhoneywell40bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/getronik40bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/fascn200bitformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/dataclockformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/bariumferritepcscformat.hpp>
%include <logicalaccess/services/accesscontrol/formats/asciiformat.hpp>
%include <logicalaccess/services/nfctag/ndefrecord.hpp>
%include <logicalaccess/services/nfctag/textrecord.hpp>
%include <logicalaccess/services/nfctag/urirecord.hpp>
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/cards/keydiversification.hpp>

%template(DataFieldVector) std::vector<std::shared_ptr<logicalaccess::DataField> >;
%template(TLVVector) std::vector<std::shared_ptr<logicalaccess::TLV> >;
