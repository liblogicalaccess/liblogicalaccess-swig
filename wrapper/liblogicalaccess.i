/* File : liblogicalaccess.i */
%include <windows.i>

%typemap(csimports) SWIGTYPE
%{ 
using System;
using System.Runtime.InteropServices;
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

CSHARP_MEMBER_ARRAYS(unsigned char, byte);


%include <typemaps.i>
%include <std_string.i>
%include <std_shared_ptr.i>

#define LIBLOGICALACCESS_API

%ignore newDynLibrary;
%ignore hasEnding;
%ignore logicalaccess::LibraryManager::getCardService;
%ignore logicalaccess::LibraryManager::getReaderService;
%ignore logicalaccess::ReaderCardAdapter::getResultChecker;
%ignore logicalaccess::ReaderCardAdapter::setResultChecker;
%ignore logicalaccess::XmlSerializable::unSerialize(std::istream& is, const std::string& rootNode);
%ignore logicalaccess::XmlSerializable::unSerialize(boost::property_tree::ptree& node);
%ignore logicalaccess::XmlSerializable::unSerialize(boost::property_tree::ptree& node, const std::string& rootNode);
%ignore logicalaccess::XmlSerializable::serialize(boost::property_tree::ptree& parentNode);

%ignore *::operator==;
%ignore *::operator!=;
%ignore *::operator<<;
%ignore *::operator>>;

%{
#include "msliblogicalaccessswigwin32.h"
#include <algorithm>
%}
