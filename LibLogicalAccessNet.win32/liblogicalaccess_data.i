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
#include <logicalaccess/cards/keystorage.hpp">
#include <logicalaccess/cards/keydiversification.hpp">
#include <stdint.h>
%}

%define CSHARP_MEMBER_ARRAYS( CTYPE, CSTYPE )

%typemap(ctype) CTYPE "CTYPE[]"
%typemap(cstype) CTYPE "CSTYPE[]"
%typemap(imtype, out="System.IntPtr") CTYPE "CSTYPE[]"
%typemap(csin) CTYPE "$csinput"
%typemap(csvarout, excode=SWIGEXCODE2) CTYPE %{ 
		get { 
			CSTYPE[] ret = new CSTYPE[$1_dim0]; 
			System.IntPtr data = $imcall; 
			System.Runtime.InteropServices.Marshal.Copy(data, ret, 0, $1_dim0);$excode 
		    return ret; 
		}
%}
%typemap(csvarin, excode=SWIGEXCODE2) CTYPE %{ 
		set { 
			if ($csinput.Length > $1_dim0)
			{
                throw new System.IndexOutOfRangeException();
			}
			$imcall;$excode
		}
%}
%typemap(freearg) CTYPE ""
%typemap(argout)  CTYPE ""

%enddef // CSHARP_MEMBER_ARRAYS

%typemap(ctype) unsigned char * "unsigned char *"
%typemap(cstype) unsigned char * "string"
%typemap(imtype, out="System.IntPtr") unsigned char * "string"
%typemap(in) unsigned char * %{ $1 = ($1_ltype)$input; %}
%typemap(out) unsigned char * %{ $result = SWIG_csharp_string_callback((const unsigned char *)$1); %}
%typemap(directorout, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) unsigned char * %{ $result = ($1_ltype)$input; %}
%typemap(directorin) unsigned char * %{ $input = SWIG_csharp_string_callback((const unsigned char *)$1); %}
%typemap(csdirectorin) unsigned char * "$iminput"
%typemap(csdirectorout) unsigned char * "$cscall"
%typemap(csin) unsigned char * "$csinput"
%typemap(csout, excode=SWIGEXCODE) unsigned char * {
    string ret = $imcall;$excode
    return ret;
}
%typemap(csvarin, excode=SWIGEXCODE2) unsigned char * %{
    set {
      $imcall;$excode
} %}
%typemap(csvarout, excode=SWIGEXCODE2) unsigned char * %{
    get {
      string ret = $imcall;$excode
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
%apply unsigned int { size_t }
%apply unsigned int { const size_t & }
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

%typemap(ctype) const unsigned char * "const unsigned char *"
%typemap(cstype) const unsigned char * "byte[]"
%typemap(imtype, out="System.IntPtr") const unsigned char * "byte[]"
%typemap(csin) const unsigned char * "$csinput"
%typemap(csout, excode=SWIGEXCODE) const unsigned char * {
	byte[] ret = $imcall;$excode
	return ret;
}

%apply unsigned char OUTPUT[] { unsigned char* getData() }
%typemap(csout, excode=SWIGEXCODE) unsigned char* getData() {
	byte[] ret = $imcall;$excode
	return ret;
}

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

%typemap(cstype) logicalaccess::DESFireKeySettings& "out DESFireKeySettings"
%typemap(csin) logicalaccess::DESFireKeySettings& %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeySettings& "out DESFireKeySettings"

%typemap(ctype) DESFireKeyType& "DESFireKeyType*"
%typemap(cstype) DESFireKeyType& "out DESFireKeyType"
%typemap(csin) DESFireKeyType& %{out $csinput%}  
%typemap(imtype) DESFireKeyType& "out DESFireKeyType"
%typemap(csvarin, excode=SWIGEXCODE2) DESFireKeyType %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) DESFireKeyType %{
    get {
      DESFireKeyType ret = $imcall;$excode
      return ret;
} %}

%typemap(ctype) DESFireKeyType "DESFireKeyType"
%typemap(cstype) DESFireKeyType "DESFireKeyType"
%typemap(csin) DESFireKeyType %{$csinput%}  
%typemap(imtype) DESFireKeyType "DESFireKeyType"
%typemap(csout, excode=SWIGEXCODE) DESFireKeyType {
	DESFireKeyType ret = $imcall;$excode
	return ret;
}

%typemap(ctype) DESFireKeyType "DESFireKeyType"
%typemap(cstype) DESFireKeyType "DESFireKeyType"
%typemap(csin) DESFireKeyType %{$csinput%}  
%typemap(imtype) DESFireKeyType "DESFireKeyType"
%typemap(csout, excode=SWIGEXCODE) DESFireKeyType {
	DESFireKeyType ret = $imcall;$excode
	return ret;
}

%include <std_vector.i>

namespace std {
	%template(UByteVector) vector<unsigned char>;
	%template(UShortCollection) vector<unsigned short>;
	%template(UCharCollectionCollection) vector<vector<unsigned char> >;
	%template(StringCollection) vector<string>;
	%template(BoolCollection) vector<bool>;
	%template(UIntCollection) vector<unsigned int>;
	//%template(UCharCollectionList) list<vector<unsigned char> >;
	//%apply list<vector<unsigned char> > {list<vector<unsigned char> > &}

	%typemap(cstype) vector<bool> & "out BoolCollection"
	%typemap(csin) vector<bool> & %{out $csinput%}  
	%typemap(imtype) vector<bool> & "out BoolCollection"

	%typemap(cstype) vector<uint8_t> "UByteVector"
	%typemap(csin) vector<uint8_t> %{$csinput%}  
	%typemap(imtype) vector<uint8_t> "UByteVector"
	
	%typemap(cstype) const vector<uint8_t> &"UByteVector"
	%typemap(csin) const vector<uint8_t> & %{$csinput%}  
	%typemap(imtype) const vector<uint8_t> & "UByteVector"
	
	%typemap(cstype) const vector<unsigned char> &"UByteVector"
	%typemap(csin) const vector<unsigned char> & %{$csinput%}  
	%typemap(imtype) const vector<unsigned char> & "UByteVector"
	%typemap(csout, excode=SWIGEXCODE) const vector<unsigned char> & {
		UByteVector ret = $imcall;$excode
		return ret;
}
};

%shared_ptr(logicalaccess::XmlSerializable);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::ReaderCardAdapter);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::KeyDiversification);

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
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/cards/keydiversification.hpp>