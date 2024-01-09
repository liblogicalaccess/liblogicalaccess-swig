/* File : liblogicalaccess.i */

%import <lla_std_types.i>
%include "custom_exception.i"

%typemap(csimports) SWIGTYPE
%{ 
	using System;
	using System.Runtime.InteropServices;
%}

/* Define_section */

#define LLA_READERS_STIDSTR_API
#define LLA_READERS_PRIVATE_KEYBOARD_API
#define LLA_READERS_PCSC_API
#define LLA_READERS_OSDP_API
#define LLA_READERS_OK5553_API
#define LLA_READERS_ISO7816_API
#define LLA_READERS_GUNNEBO_API
#define LLA_READERS_ELATEC_API
#define LLA_READERS_DEISTER_API
#define LLA_CRYPTO_API
#define LLA_CORE_API
#define LLA_COMMON_API
#define LLA_CARDS_YUBIKEY_API
#define LLA_CARDS_TWIC_API
#define LLA_CARDS_TOPAZ_API
#define LLA_CARDS_TAGIT_API
#define LLA_CARDS_STMLRI_API
#define LLA_CARDS_SMARTFRAME_API
#define LLA_CARDS_SEOS_API
#define LLA_CARDS_SAMAV_API
#define LLA_CARDS_PROX_API
#define LLA_CARDS_PROXLITE_API
#define LLA_CARDS_MIFARE_API
#define LLA_CARDS_MIFAREULTRALIGHT_API
#define LLA_CARDS_MIFAREPLUS_API
#define LLA_CARDS_LEGICPRIME_API
#define LLA_CARDS_ISO7816_API
#define LLA_CARDS_ISO15693_API
#define LLA_CARDS_INFINEONMYD_API
#define LLA_CARDS_INDALA_API
#define LLA_CARDS_ICODE2_API
#define LLA_CARDS_ICODE1_API
#define LLA_CARDS_GENERICTAG_API
#define LLA_CARDS_FELICA_API
#define LLA_CARDS_EPASS_API
#define LLA_CARDS_EM4135_API
#define LLA_CARDS_EM4102_API
#define LLA_CARDS_DESFIRE_API
#define LLA_CARDS_CPS3_API

/* END_Define_section */

/*****WARNING SECTION*****/

#pragma SWIG nowarn=314,401,833

//Ignored Warning:
// - 314: 'lock' is a C# keyword, renaming to 'lock_'
// - 516: Overloaded method ignored 
// - 401: Nothing known about class 'name'. Ignored. 
// - 833: Warning for classname: Base baseclass ignored. Multiple inheritance is not supported in C#. (C#). 

/*****IGNORE SECTION*****/

%ignore newDynLibrary;
%ignore hasEnding;

%rename(IsEqual) operator==;
%rename(IsDifferent) operator!=;
%rename(CompareTo) operator<;
%ignore operator<<;
%ignore operator=;
%ignore operator bool;
%ignore operator int;
%ignore std::ostream;

/*****SHARED PTR SECTION*****/

/*** MULTIPLE INHERITANCE ***/

%define INTERFACEPTR(CTYPE)
%typemap(csinterfacecode,
         declaration="  System.IntPtr $interfacename_GetInterfaceCPtr();\n",
         cptrmethod="$interfacename_GetInterfaceCPtr") CTYPE %{
  public System.IntPtr $interfacename_GetInterfaceCPtr() {
    return $imclassname.$csclazzname$interfacename_GetInterfaceCPtr(swigCPtr.Handle);
  }
%}
%enddef

// ReaderCommunication + ISO14443BReaderCommunication + ISO14443AReaderCommunication 

%interface_custom("ReaderCommunication", "IReaderCommunication", ReaderCommunication)
INTERFACEPTR(logicalaccess::ReaderCommunication);
%interface_custom("ISO14443AReaderCommunication", "IISO14443AReaderCommunication", ISO14443AReaderCommunication)
INTERFACEPTR(logicalaccess::ISO14443AReaderCommunication);
%interface_custom("ISO14443BReaderCommunication", "IISO14443BReaderCommunication", ISO14443BReaderCommunication)
INTERFACEPTR(logicalaccess::ISO14443BReaderCommunication);

%interface_custom("ISO14443ReaderCommunication", "IISO14443ReaderCommunication", ISO14443ReaderCommunication)
%typemap(csclassmodifiers) logicalaccess::ISO14443ReaderCommunication "public abstract class";
INTERFACEPTR(logicalaccess::ISO14443ReaderCommunication);

%interface_custom("ISO15693ReaderCommunication", "IISO15693ReaderCommunication", ISO15693ReaderCommunication)
INTERFACEPTR(logicalaccess::ISO15693ReaderCommunication);

/*****POST PROCESSING INSTRUCTIONS*****/

%{
#include "msliblogicalaccessswigwin32.h"
#include <algorithm>
#include <vector>
%}

%inline %{
  template<class T>
  T getVectorPart(std::vector<T> vector, int i)
  {
    return vector[i];
  }
%}
