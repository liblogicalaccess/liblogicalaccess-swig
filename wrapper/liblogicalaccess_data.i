/* File : liblogicalaccess_data.i */
%module(directors="1") liblogicalaccess_data

%include "liblogicalaccess.i"

%include <std_vector.i>
namespace std {
   %template(UCharCollection) vector<unsigned char>;
   %template(UShortCollection) vector<unsigned short>;
   %template(UCharCollectionCollection) vector<vector<unsigned char> >;
   %template(StringCollection) vector<string>;
};

%shared_ptr(logicalaccess::XmlSerializable);
%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::ReaderCardAdapter);

%ignore logicalaccess::DataTransport::getReaderUnit;
%ignore logicalaccess::DataTransport::setReaderUnit;

typedef std::shared_ptr<logicalaccess::DataTransport> DataTransportPtr;

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

%{
#include <logicalaccess/cards/readercardadapter.hpp>
%}

%include <logicalaccess/xmlserializable.hpp>
%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/resultchecker.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
