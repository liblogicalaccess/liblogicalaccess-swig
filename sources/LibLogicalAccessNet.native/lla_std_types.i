/* File : lla_std_types.i */
%module(directors="1") lla_std_types

%include <windows.i>

/*****SWIG INCLUSIONS*****/

%include <typemaps.i>
%include <stl.i>
%include <std_string.i>
%include <std_shared_ptr.i>
%include <std_array.i>
%include <std_list.i>
%include <wchar.i>
%include <exception.i>
%include <carrays.i>
%include <arrays_csharp.i>
%include <stdint.i>
%include <swiginterface.i>
%include <cpointer.i>
%include <std_pair.i>
%include <std_vector.i>

%{
#include <stdint.h>
#include <vector>
%}

#pragma SWIG nowarn=314

//Ignored Warning:
// - 314: 'lock' is a C# keyword, renaming to 'lock_'

/*****OVERRIDE STRING NULL EXCEPTION*****/

%{
#include <string>
%}

%typemap(in) std::string 
%{
	if (!$input) {
		$1.clear();
	} else {
		$1.assign($input);
	}
%}

%typemap(in) const std::string&
%{
	$*1_ltype $1_str;
	if ($input) {
		$1_str = $*1_ltype($input);
	}
	$1 = &$1_str;
%}

%typemap(directorout, canthrow=1) std::string
%{ 
	if (!$input) {
		$result.clear();
	} else {
		$result.assign($input);
	}
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
//%apply bool &INOUT { bool & }
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
	%template(ByteVector) vector<uint8_t>;
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

%typemap(ctype) ByteVector::const_iterator "ByteVector::const_iterator"
%typemap(cstype) ByteVector::const_iterator "ByteVector.ByteVectorEnumerator"
%typemap(csin) ByteVector::const_iterator  %{$csinput%}  
%typemap(imtype) ByteVector::const_iterator "LibLogicalAccess.ByteVector.ByteVectorEnumerator"
%typemap(csout, excode=SWIGEXCODE) ByteVector::const_iterator {
	ByteVector.ByteVectorEnumerator ret = $imcall;$excode
	return ret;
}

%typemap(cstype) std::vector<unsigned char>::const_iterator& "out ByteVector.ByteVectorEnumerator"
%typemap(csin) std::vector<unsigned char>::const_iterator& %{out $csinput%}  
%typemap(imtype) std::vector<unsigned char>::const_iterator& "out ByteVector.ByteVectorEnumerator"

%template(PairByteVectorByteVector) std::pair<std::vector<uint8_t>, std::vector<uint8_t>>;
%template(ByteVectorList) std::list<std::vector<uint8_t> >;
