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


%shared_ptr(logicalaccess::DataTransport);
%shared_ptr(logicalaccess::ResultChecker);
%shared_ptr(logicalaccess::ReaderCardAdapter);

%ignore logicalaccess::DataTransport::getReaderUnit;
%ignore logicalaccess::DataTransport::setReaderUnit;

typedef std::shared_ptr<logicalaccess::DataTransport> DataTransportPtr;

%{
#include <logicalaccess/cards/readercardadapter.hpp>
%}

%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/resultchecker.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
