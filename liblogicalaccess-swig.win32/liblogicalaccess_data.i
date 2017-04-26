/* File : liblogicalaccess_data.i */
%module(directors="1") liblogicalaccess_data

%include "liblogicalaccess.i"

%{
#include <logicalaccess/cards/readercardadapter.hpp>
#include <logicalaccess/lla_fwd.hpp>
#include <logicalaccess/techno.hpp>
#include <stdint.h>
%}

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
%apply unsigned char*INOUT { unsigned char* }

%typemap(cstype) size_t* "ref uint"
%typemap(csin) size_t* %{out $csinput%}  
%typemap(imtype) size_t* "out uint"

%typemap(cstype) char & "out char"
%typemap(csin) char & %{out $csinput%}  
%typemap(imtype) char & "out char"

%typemap(cstype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"
%typemap(csin) logicalaccess::STidTamperSwitchBehavior& %{out $csinput%}  
%typemap(imtype) logicalaccess::STidTamperSwitchBehavior& "out STidTamperSwitchBehavior"

%include <std_vector.i>

namespace std {
	%template(UCharCollection) vector<unsigned char>;
	%template(UShortCollection) vector<unsigned short>;
	%template(UCharCollectionCollection) vector<vector<unsigned char> >;
	%template(StringCollection) vector<string>;
	//%template(UCharCollectionList) list<vector<unsigned char> >;
	%apply vector<unsigned char> { const vector<unsigned char> & };
	%apply vector<unsigned char> { vector<uint8_t> };
	%apply vector<unsigned char> { const vector<uint8_t> & };
	%apply vector<unsigned char> { ByteVector };
	%apply vector<unsigned char> { const ByteVector & }
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