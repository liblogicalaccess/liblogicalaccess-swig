/* File : liblogicalaccess_data.i */
%module(directors="1") liblogicalaccess_data

%include "liblogicalaccess.i"

%{
#include <logicalaccess/plugins/readers/pcsc-private/type_fwd.hpp>
#include <logicalaccess/lla_fwd.hpp>
#include <logicalaccess/techno.hpp>
#include <logicalaccess/key.hpp>
#include <logicalaccess/xmlserializable.hpp>
#include <logicalaccess/readerproviders/datatransport.hpp>
#include <logicalaccess/resultchecker.hpp>
#include <logicalaccess/cards/readercardadapter.hpp>
#include <stdint.h>
%}

%include <arrays_csharp.i>

%define CSHARP_MEMBER_ARRAYS( CTYPE, CSTYPE )

%typemap(csvarout, excode=SWIGEXCODE2) CTYPE MBINOUT[] %{ 
  get { 
    CSTYPE[] ret = new CSTYPE[$1_dim0]; 
        IntPtr data = $imcall; 
        System.Runtime.InteropServices.Marshal.Copy(data, ret, 0, $1_dim0);
 	$excode 
    return ret; 
  }
%}

%typemap(csvarin, excode=SWIGEXCODE2) CTYPE MBINOUT[] %{ 
  set { 
		if ($csinput.Length < $1_dim0)
		{
			throw new Exception("The array value must be $1_dim0 long !");
		}
		$imcall;$excode
  }
%}

%typemap(imtype, out="IntPtr") CTYPE MBINOUT[] "CSTYPE[]"

%enddef // CSHARP_MEMBER_ARRAYS

CSHARP_ARRAYS(unsigned char, byte);

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
%apply unsigned int { size_t }
%apply unsigned int { const size_t & }
%apply long { int64_t }
%apply long { const int64_t & }
%apply unsigned long { uint64_t }
%apply unsigned long { const uint64_t & }
%apply void *VOID_INT_PTR { SCARDHANDLE, const SCARDHANDLE &, SCARDCONTEXT, const SCARDCONTEXT & }
%apply void *VOID_INT_PTR { void * }
%apply bool &OUTPUT { bool & }
//%apply unsigned char INPUT[] { unsigned char* }
%apply unsigned int &OUTPUT { unsigned int & }
%apply bool *INOUT { bool * }

//%typemap(cstype) size_t* "ref uint"
//%typemap(csin) size_t* %{ref $csinput%}  
//%typemap(imtype) size_t* "ref uint"

%typemap(cstype) size_t& "out uint"
%typemap(csin) size_t& %{out $csinput%}  
%typemap(imtype) size_t& "out uint"

%typemap(cstype) char & "out char"
%typemap(csin) char & %{out $csinput%}  
%typemap(imtype) char & "out char"

//%typemap(cstype) unsigned char* "byte[]"
//%typemap(csin) unsigned char* %{$csinput%}  
//%typemap(imtype) unsigned char* "byte[]"

//%typemap(cstype) unsigned int* "uint[]"
//%typemap(csin) unsigned int* %{$csinput%}  
//%typemap(imtype) unsigned int* "uint[]"

%typemap(cstype) std::string & "out string"
%typemap(csin) std::string & %{out $csinput%}  
%typemap(imtype) std::string & "out string"

%typemap(cstype) uint8_t & "out byte"
%typemap(csin) uint8_t & %{out $csinput%}  
%typemap(imtype) uint8_t & "out byte"

%typemap(cstype) uint16_t & "out ushort"
%typemap(csin) uint16_t & %{out $csinput%}  
%typemap(imtype) uint16_t & "out ushort"

%typemap(cstype) int32_t & "out int"
%typemap(csin) int32_t & %{out $csinput%}  
%typemap(imtype) int32_t & "out int"

%typemap(cstype) const std::array<uint8_t, 16> & "out byte[]"
%typemap(csin) const std::array<uint8_t, 16> & %{out $csinput%}  
%typemap(imtype) const std::array<uint8_t, 16> & "out byte[]"

%typemap(cstype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"
%typemap(csin) logicalaccess::STidTamperSwitchBehavior& %{out $csinput%}  
%typemap(imtype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"

%typemap(cstype) logicalaccess::DESFireKeySettings& "out DESFireKeySettings"
%typemap(csin) logicalaccess::DESFireKeySettings& %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeySettings& "out DESFireKeySettings"

%typemap(cstype) logicalaccess::DESFireKeyType& "out DESFireKeyType"
%typemap(csin) logicalaccess::DESFireKeyType& %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeyType& "out DESFireKeyType"

%include <std_vector.i>

namespace std {
	
	%typemap(cstype) vector<bool> & "out BoolCollection"
	%typemap(csin) vector<bool> & %{out $csinput%}  
	%typemap(imtype) vector<bool> & "out BoolCollection"

	%typemap(cstype) vector<uint8_t> "UCharCollection"
	%typemap(csin) vector<uint8_t> %{$csinput%}  
	%typemap(imtype) vector<uint8_t> "UCharCollection"

	%typemap(cstype) const vector<uint8_t> &"UCharCollection"
	%typemap(csin) const vector<uint8_t> & %{$csinput%}  
	%typemap(imtype) const vector<uint8_t> & "UCharCollection"

	%typemap(cstype) const vector<unsigned char> &"UCharCollection"
	%typemap(csin) const vector<unsigned char> & %{$csinput%}  
	%typemap(imtype) const vector<unsigned char> & "UCharCollection"

	%template(UCharCollection) vector<unsigned char>;
	%template(UShortCollection) vector<unsigned short>;
	%template(UCharCollectionCollection) vector<vector<unsigned char> >;
	%template(StringCollection) vector<string>;
	%template(BoolCollection) vector<bool>;
	%template(UIntCollection) vector<unsigned int>;
	//%template(UCharCollectionList) list<vector<unsigned char> >;
	//%apply list<vector<unsigned char> > {list<vector<unsigned char> > &}

};

%shared_ptr(logicalaccess::XmlSerializable);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::ReaderCardAdapter);

%ignore logicalaccess::DataTransport::getReaderUnit;
%ignore logicalaccess::DataTransport::setReaderUnit;

namespace std {
    template <class T> class enable_shared_from_this {
    public:
        ~enable_shared_from_this();
        shared_ptr<T> shared_from_this();
        shared_ptr<const T> shared_from_this() const;
    protected:
        enable_shared_from_this();
        enable_shared_from_this(const enable_shared_from_this &);
    };
}

namespace std {
	template<class Ty> class weak_ptr {
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

%include <logicalaccess/lla_fwd.hpp>
%include <logicalaccess/techno.hpp>
%include <logicalaccess/xmlserializable.hpp>
%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/resultchecker.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
%include <logicalaccess/key.hpp>
