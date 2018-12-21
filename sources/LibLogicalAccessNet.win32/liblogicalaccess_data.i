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
#include <stdint.h>

using namespace logicalaccess;
%}

%define CSHARP_MEMBER_ARRAYS( CTYPE, CSTYPE )

%typemap(ctype)		CTYPE MBINOUT[] "CTYPE*"
%typemap(cstype)	CTYPE MBINOUT[] "CSTYPE[]"
%typemap(imtype, out="System.IntPtr")
					CTYPE MBINOUT[] "CSTYPE[]"
%typemap(csin)		CTYPE MBINOUT[] "$csinput"
%typemap(in)		CTYPE MBINOUT[] "$1 = $input;"
%typemap(csout, excode=SWIGEXCODE)
					CTYPE MBINOUT[] {
	CSTYPE[] ret = new CSTYPE[$1_dim0]; 
	System.IntPtr data = $imcall; 
	System.Runtime.InteropServices.Marshal.Copy(data, ret, 0, $1_dim0);$excode 
	return ret; 
}
%typemap(csvarout, excode=SWIGEXCODE2) 
					CTYPE MBINOUT[] %{ 
		get { 
		  CSTYPE[] ret = new CSTYPE[$1_dim0]; 
		  System.IntPtr data = $imcall;
          System.Runtime.InteropServices.Marshal.Copy(data, ret, 0, $1_dim0);$excode
		  return ret; 
		}
%}
%typemap(csvarin, excode=SWIGEXCODE2) 
					CTYPE MBINOUT[] %{ 
		set { 
          if ($csinput.Length > $1_dim0) {
            throw new System.IndexOutOfRangeException();
		  }
          $imcall;$excode
		}
%}
%typemap(freearg)	CTYPE MBINOUT[] ""
%typemap(argout)	CTYPE MBINOUT[] ""

%enddef // CSHARP_MEMBER_ARRAYS

%define CSHARP_MEMBER_STRUCT_ARRAYS( CTYPE, CSTYPE )

%typemap(ctype)		CTYPE MBINOUT[] "CTYPE*"
%typemap(cstype)	CTYPE MBINOUT[] "CSTYPE[]"
%typemap(imtype, out="System.IntPtr")
					CTYPE MBINOUT[] "CSTYPE[]"
%typemap(csin)		CTYPE MBINOUT[] "$csinput"
%typemap(in)		CTYPE MBINOUT[] "$1 = $input;"
%typemap(csout, excode=SWIGEXCODE)
					CTYPE MBINOUT[] {
		CSTYPE[] ret = new CSTYPE[$1_dim0]; 
		System.IntPtr data = $imcall;
		for (int i = 0; i < $1_dim0; i++) 
		{
			System.IntPtr = CSTYPE.getItem(data, i);
			ret[i] = new CSTYPE(ptr, $owner);
		}$excode
		return ret; 
}
%typemap(csvarout, excode=SWIGEXCODE2) 
					CTYPE MBINOUT[] %{ 
		get { 
			CSTYPE[] ret = new CSTYPE[$1_dim0]; 
			System.IntPtr data = $imcall;
			for (int i = 0; i < $1_dim0; i++) 
			{
				System.IntPtr ptr = CSTYPE.getItem(data, i);
				ret[i] = new CSTYPE(ptr, $owner);
			}$excode
			return ret; 
		}
%}
%typemap(csvarin, excode=SWIGEXCODE2) 
					CTYPE MBINOUT[] %{ 
		set { 
          if ($csinput.Length > $1_dim0) {
            throw new System.IndexOutOfRangeException();
		  }
		  for (int i = 0; i < $1_dim0; i++)
		  {
			CSTYPE.setItem((System.IntPtr)swigCPtr, value[i], i);
		  }
          $imcall;$excode
		}
%}
%typemap(freearg)	CTYPE MBINOUT[] ""
%typemap(argout)	CTYPE MBINOUT[] ""

%enddef // CSHARP_MEMBER_STRUCT_ARRAYS

CSHARP_MEMBER_ARRAYS(unsigned char, byte)
CSHARP_MEMBER_STRUCT_ARRAYS(logicalaccess::MifareAccessInfo::DataBlockAccessBits, MifareAccessInfo.DataBlockAccessBits)

%typemap(ctype) unsigned char * "unsigned char *"
%typemap(cstype) unsigned char * "string"
%typemap(imtype, out="System.IntPtr") unsigned char * "string"
%typemap(in) unsigned char * %{ $1 = ($1_ltype)$input; %}
%typemap(out) unsigned char * %{ $result = (unsigned char *)SWIG_csharp_string_callback((const char *)$1); %}
%typemap(directorout, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) unsigned char * %{ $result = ($1_ltype)$input; %}
%typemap(directorin) unsigned char * %{ $input = (unsigned char *)SWIG_csharp_string_callback((const char *)$1); %}
%typemap(csdirectorin) unsigned char * "$iminput"
%typemap(csdirectorout) unsigned char * "$cscall"
%typemap(csin) unsigned char * "$csinput"
%typemap(csout, excode=SWIGEXCODE) unsigned char * {
	System.IntPtr data = $imcall; 
	string ret = System.Runtime.InteropServices.Marshal.PtrToStringAuto(data);$excode 
	return ret; 
}
%typemap(csvarin, excode=SWIGEXCODE2) unsigned char * %{
    set {
      $imcall;$excode
	  } %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned char * %{
    get {
      System.IntPtr data = $imcall; 
	  string ret = System.Runtime.InteropServices.Marshal.PtrToStringAuto(data);$excode 
	  return ret; 
	  } %}

%typemap(ctype) void**, const void** "void**"
%typemap(cstype) void**, const void** "global::System.IntPtr[]"
%typemap(imtype) void**, const void** "global::System.IntPtr[]"
%typemap(in) void**, const void** %{ $1 = ($1_ltype)$input; %}
%typemap(out) void**, const void** %{ $result = (void **)$1; %} 
%typemap(csin) void**, const void** "$csinput"
%typemap(csout, excode=SWIGEXCODE) void**, const void** {
	global::System.IntPtr[] ret = $imcall;$excode
	return ret;
}
%typemap(csdirectorin) void**, const void** "$iminput"
%typemap(csdirectorout) void**, const void** "$cscall"

%apply char { int8_t }
%apply char { const int8_t & }
%apply unsigned char { uint8_t }
%apply unsigned char { const uint8_t & }
%apply short { int16_t }
%apply short { const int16_t &}
%apply unsigned short { uint16_t }
%apply unsigned short { const uint16_t & }
%apply int { int32_t }
%apply int { const int32_t & }
%apply unsigned int { uint32_t }
%apply unsigned int { const uint32_t & }
%apply long { int64_t }
%apply long { const int64_t & }
%apply unsigned long { uint64_t }
%apply unsigned long { const uint64_t & }
%apply void *VOID_INT_PTR { SCARDHANDLE, const SCARDHANDLE &, SCARDCONTEXT, const SCARDCONTEXT & }
%apply void *VOID_INT_PTR { void * }
%apply bool &OUTPUT { bool & }
%apply unsigned int &OUTPUT { unsigned int & }
%apply bool *INOUT { bool * }
%apply unsigned char *OUTPUT { unsigned char & }
%apply unsigned char INPUT[] { const unsigned char *data }
%apply unsigned int *INOUT { unsigned int *pos }
%apply unsigned int INPUT[] { unsigned int *positions, unsigned int *locations }



%typemap(ctype) const unsigned char * "const unsigned char *"
%typemap(cstype) const unsigned char * "byte[]"
%typemap(imtype, out="System.IntPtr") const unsigned char * "byte[]"
%typemap(csin) const unsigned char * "$csinput"
%typemap(csout, excode=SWIGEXCODE) const unsigned char * {
	byte[] ret = $imcall;$excode
	return ret;
}

%ignore *::getData() const;

%typemap(cstype) size_t* "ref uint"
%typemap(csin) size_t* %{ref $csinput%}  
%typemap(imtype) size_t* "ref uint"

%typemap(cstype) size_t& "out uint"
%typemap(csin) size_t& %{out $csinput%}  
%typemap(imtype) size_t& "out uint"

%typemap(cstype) char & "out char"
%typemap(csin) char & %{out $csinput%}  
%typemap(imtype) char & "out char"

%typemap(ctype) std::string & "char **"
%typemap(cstype) std::string & "out string"
%typemap(csin) std::string & %{out $csinput%}  
%typemap(imtype) std::string & "out string"

%typemap(ctype) uint8_t & "uint8_t*"
%typemap(cstype) uint8_t & "out byte"
%typemap(csin) uint8_t & %{out $csinput%}  
%typemap(imtype) uint8_t & "out byte"

%typemap(ctype) uint16_t & "uint16_t*"
%typemap(cstype) uint16_t & "out ushort"
%typemap(csin) uint16_t & %{out $csinput%}  
%typemap(imtype) uint16_t & "out ushort"

%typemap(ctype) int32_t & "int32_t*"
%typemap(cstype) int32_t & "out int"
%typemap(csin) int32_t & %{out $csinput%}  
%typemap(imtype) int32_t & "out int"

%typemap(cstype) const std::array<uint8_t, 16> & "out byte[]"
%typemap(csin) const std::array<uint8_t, 16> & %{out $csinput%}  
%typemap(imtype) const std::array<uint8_t, 16> & "out byte[]"

%typemap(cstype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"
%typemap(csin) logicalaccess::STidTamperSwitchBehavior& %{out $csinput%}  
%typemap(imtype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"

%typemap(ctype) boost::circular_buffer<unsigned char>& "void *"
%typemap(cstype) boost::circular_buffer<unsigned char>& "System.IntPtr"
%typemap(csin) boost::circular_buffer<unsigned char>& %{ $csinput%}  
%typemap(imtype) boost::circular_buffer<unsigned char>& "System.IntPtr"
%typemap(csout, excode=SWIGEXCODE) boost::circular_buffer<unsigned char>& {
    System.IntPtr ret = $imcall;$excode
	return ret;
}

%typemap(ctype) boost::property_tree::ptree& "void *"
%typemap(cstype) boost::property_tree::ptree& "System.IntPtr"
%typemap(csin) boost::property_tree::ptree& %{$csinput%}  
%typemap(imtype) boost::property_tree::ptree& "System.IntPtr"
%typemap(csout, excode=SWIGEXCODE) boost::property_tree::ptree& {
    System.IntPtr ret = $imcall;$excode
	return ret;
}


namespace std {
	%template(UByteVector) vector<uint8_t>;
	%template(UShortCollection) vector<unsigned short>;
	%template(UCharCollectionCollection) vector<vector<unsigned char> >;
	%template(StringCollection) vector<string>;
	%template(BoolCollection) vector<bool>;
	%template(UIntCollection) vector<unsigned int>;

	%typemap(cstype) vector<bool> & "out BoolCollection"
	%typemap(csin) vector<bool> & %{out $csinput%}  
	%typemap(imtype) vector<bool> & "out BoolCollection"
	%typemap(csout, excode=SWIGEXCODE) vector<bool> & {
		BoolCollection ret = $imcall;$excode
		return ret;
	}
};

%ignore logicalaccess::DataTransport::getReaderUnit;
%ignore logicalaccess::DataTransport::setReaderUnit;

namespace std {
    template <class T> class enable_shared_from_this {
    public:
        shared_ptr<T> shared_from_this();
        //shared_ptr<const T> shared_from_this() const;
	protected:
		enable_shared_from_this();
        enable_shared_from_this(const enable_shared_from_this &);
		~enable_shared_from_this();
    };
}

namespace std {
	template<class Ty> 
	class weak_ptr {
	public:
	    typedef Ty element_type;
	
	    weak_ptr();
	    weak_ptr(const weak_ptr&);
	    template<class Other>
	        weak_ptr(const weak_ptr<Other>&);
	    template<class Other>
	        weak_ptr(const shared_ptr<Other>&);
	
	    weak_ptr(const shared_ptr<Ty>&);
	
	
	    void swap(weak_ptr&);
	    void reset();
	
	    long use_count() const;
	    bool expired() const;
	    shared_ptr<Ty> lock() const;
	};
}

%pragma(csharp) imclasscode=%{

	public static System.Collections.Generic.Dictionary<string, System.Type> formatDictionary;

	public static Format	createFormat(System.IntPtr cPtr, bool owner)
	{
		Format ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
        int ft = (liblogicalaccess_dataPINVOKE.Format_getType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (liblogicalaccess_dataPINVOKE.SWIGPendingException.Pending) throw liblogicalaccess_dataPINVOKE.SWIGPendingException.Retrieve();
        switch ((FormatType)ft)
        {
            case FormatType.FT_WIEGAND26: return new Wiegand26Format();
            case FormatType.FT_WIEGAND34: return new Wiegand34Format();
            case FormatType.FT_WIEGAND34FACILITY: return new Wiegand34WithFacilityFormat();
            case FormatType.FT_WIEGAND37: return new Wiegand37Format();
            case FormatType.FT_WIEGAND37FACILITY: return new Wiegand37WithFacilityFormat();
            case FormatType.FT_WIEGAND35: return new Wiegand35Format();
            case FormatType.FT_DATACLOCK: return new DataClockFormat();
            case FormatType.FT_FASCN200BIT: return new FASCN200BitFormat();
            case FormatType.FT_HIDHONEYWELL: return new HIDHoneywell40BitFormat();
            case FormatType.FT_GETRONIK40BIT: return new Getronik40BitFormat();
            case FormatType.FT_BARIUM_FERRITE_PCSC: return new BariumFerritePCSCFormat();
            case FormatType.FT_RAW: return new RawFormat();
            case FormatType.FT_CUSTOM: return new CustomFormat();
            case FormatType.FT_ASCII: return new ASCIIFormat();
            default:
                throw new LibLogicalAccessNetException($"Unknown format type: {ft}");
        }
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

%typemap(ctype) ByteVector::const_iterator "ByteVector::const_iterator"
%typemap(cstype) ByteVector::const_iterator "UByteVector.UByteVectorEnumerator"
%typemap(csin) ByteVector::const_iterator  %{$csinput%}  
%typemap(imtype) ByteVector::const_iterator "LogicalAccess.UByteVector.UByteVectorEnumerator"
%typemap(csout, excode=SWIGEXCODE) ByteVector::const_iterator {
	UByteVector.UByteVectorEnumerator ret = $imcall;$excode
	return ret;
}

%typemap(cstype) std::vector<unsigned char>::const_iterator& "out UByteVector.UByteVectorEnumerator"
%typemap(csin) std::vector<unsigned char>::const_iterator& %{out $csinput%}  
%typemap(imtype) std::vector<unsigned char>::const_iterator& "out UByteVector.UByteVectorEnumerator"

%template(PairByteVectorByteVector) std::pair<ByteVector, ByteVector>;

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
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/cards/keydiversification.hpp>

%template(DataFieldVector) std::vector<std::shared_ptr<logicalaccess::DataField> >;