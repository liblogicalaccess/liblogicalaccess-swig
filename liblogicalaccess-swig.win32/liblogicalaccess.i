/* File : liblogicalaccess.i */

%include <windows.i>

%typemap(csimports) SWIGTYPE
%{ 
	using System;
	using System.Runtime.InteropServices;
%}

#define LIBLOGICALACCESS_API

/*****SWIG INCLUSIONS*****/

%include <typemaps.i>
%include <std_string.i>
%include <std_shared_ptr.i>
%include <exception.i>

/*****IGNORE SECTION*****/

%ignore newDynLibrary;
%ignore hasEnding;
%ignore logicalaccess::LibraryManager::getCardService;
%ignore logicalaccess::LibraryManager::getReaderService;
%ignore logicalaccess::XmlSerializable::unSerialize(std::istream& is, const std::string& rootNode);
%ignore logicalaccess::XmlSerializable::unSerialize(boost::property_tree::ptree& node);
%ignore logicalaccess::XmlSerializable::unSerialize(boost::property_tree::ptree& node, const std::string& rootNode);
%ignore logicalaccess::XmlSerializable::serialize(boost::property_tree::ptree& parentNode);

/*****POST PROCESSING INSTRUCTIONS*****/

%{
	#include "msliblogicalaccessswigwin32.h"
	#include <algorithm>
%}
