/* File : liblogicalaccess_library.i */
%module(directors="1") liblogicalaccess_library

%include "liblogicalaccess.i"

%import "liblogicalaccess_exception.i"
%import "liblogicalaccess_data.i"
%import "liblogicalaccess_iks.i"
%import "liblogicalaccess_core.i"
%import "liblogicalaccess_reader.i"
%import "liblogicalaccess_card.i"

%typemap(csimports) SWIGTYPE
%{
	using LibLogicalAccess.Card;
	using LibLogicalAccess.Reader;
%}

%{
#include <logicalaccess/dynlibrary/idynlibrary.hpp>
#include <logicalaccess/dynlibrary/librarymanager.hpp>
%}

%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::Chip);

/* original header files */
%include <logicalaccess/dynlibrary/idynlibrary.hpp>
%include <logicalaccess/dynlibrary/librarymanager.hpp>
