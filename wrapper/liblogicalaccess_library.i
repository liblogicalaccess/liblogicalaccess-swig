/* File : liblogicalaccess_library.i */
%module(directors="1") liblogicalaccess_library

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_reader.i"
%import "liblogicalaccess_card.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess.Card;
using LibLogicalAccess.Reader;
%}

%shared_ptr(logicalaccess::Key);

%{
#include <logicalaccess/dynlibrary/idynlibrary.hpp>
#include <logicalaccess/dynlibrary/librarymanager.hpp>

using namespace logicalaccess;

%}

/* original header files */
%include <logicalaccess/dynlibrary/idynlibrary.hpp>
%include <logicalaccess/dynlibrary/librarymanager.hpp>
