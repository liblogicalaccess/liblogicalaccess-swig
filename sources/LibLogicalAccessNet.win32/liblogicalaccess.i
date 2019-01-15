/* File : liblogicalaccess.i */

%include <windows.i>

%typemap(csimports) SWIGTYPE
%{ 
	using System;
	using System.Runtime.InteropServices;
%}


#define LLA_CORE_API
#define LLA_CARDS_CPS3_API
#define LLA_CARDS_DESFIRE_API
#define LLA_CARDS_EM4102_API
#define LLA_CARDS_EM4135_API
#define LLA_CARDS_EPASS_API
#define LLA_CARDS_FELICA_API
#define LLA_CARDS_GENERICTAG_API
#define LLA_CARDS_ICODE1_API
#define LLA_CARDS_ICODE2_API
#define LLA_CARDS_INDALA_API
#define LLA_CARDS_INFINEONMYD_API
#define LLA_CARDS_ISO15693_API
#define LLA_CARDS_ISO7816_API
#define LLA_READERS_PRIVATE_KEYBOARD_API
#define LLA_CARDS_LEGICPRIME_API
#define LLA_CARDS_MIFARE_API
#define LLA_CARDS_MIFAREPLUS_API
#define LLA_CARDS_MIFAREULTRALIGHT_API
#define LLA_CARDS_PROX_API
#define LLA_CARDS_PROXLITE_API
#define LLA_CARDS_SAMAV2_API
#define LLA_CARDS_SEOS_API
#define LLA_CARDS_SMARTFRAME_API
#define LLA_CARDS_STMLRI_API
#define LLA_CARDS_TAGIT_API
#define LLA_CARDS_TOPAZ_API
#define LLA_CARDS_TWIC_API
#define LLA_CRYPTO_API
#define LLA_COMMON_API
#define LLA_READERS_A3MLGM5600_API
#define LLA_READERS_ADMITTO_API
#define LLA_READERS_A3MLGM5600_API
#define LLA_READERS_ADMITTO_API
#define LLA_READERS_A3MLGM5600_API
#define LLA_READERS_ADMITTO_API
#define LLA_READERS_AXESSTMC13_API
#define LLA_READERS_AXESSTMCLEGIC_API
#define LLA_READERS_DEISTER_API
#define LLA_READERS_ELATEC_API
#define LLA_READERS_GIGATMS_API
#define LLA_READERS_GUNNEBO_API
#define LLA_READERS_IDONDEMAND_API
#define LLA_READERS_ISO7816_API
#define LLA_READERS_PRIVATE_KEYBOARD_API
#define LLA_READERS_OK5553_API
#define LLA_READERS_OSDP_API
#define LLA_READERS_PCSC_API
#define LLA_READERS_PROMAG_API
#define LLA_READERS_RFIDEAS_API
#define LLA_READERS_RPLETH_API
#define LLA_READERS_SCIEL_API
#define LLA_READERS_SMARTID_API
#define LLA_READERS_STIDPRG_API
#define LLA_READERS_STIDSTR_API
#define LLA_CORE_API
#define LLA_CARDS_PRIVATE_DESFIRE2_API
#define LLA_CARDS_PRIVATE_ICLASS_API
#define LLA_CARDS_PRIVATE_ICLASS5321_API
#define LLA_CARDS_PRIVATE_ICLASS_API
#define LLA_CARDS_PRIVATE_ICLASS5321_API
#define LLA_READERS_PRIVATE_IDP_API
#define LLA_READERS_PRIVATE_ISO7816_API
#define LLA_READERS_PRIVATE_PCSC_API
#define LLA_READERS_NFC_NFC_API
#define LLA_CARDS_PRIVATE_SEPROCESSOR_API

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

/*****EXCPETION HANDLING*****/

%insert(runtime) %{
typedef void (SWIGSTDCALL* CSharpExceptionCallback_t)(const char *, const char *);
static CSharpExceptionCallback_t customExceptionCallback = NULL;

#ifdef __cplusplus
extern "C"
#endif
SWIGEXPORT
void SWIGSTDCALL CustomExceptionRegisterCallback_$module(CSharpExceptionCallback_t customCallback) {
  customExceptionCallback = customCallback;
}

static void SWIG_CSharpSetPendingExceptionCustom(const char *name, const char *message) {
  customExceptionCallback(name, message);
}
%}

%pragma(csharp) imclasscode=%{
  class CustomExceptionHelper {
    // C# delegate for the C/C++ customExceptionCallback
	public delegate void CustomExceptionDelegate(string exceptionName, string message);
    static CustomExceptionDelegate customDelegate =
                                   new CustomExceptionDelegate(SetPendingCustomException);

    [global::System.Runtime.InteropServices.DllImport("$dllimport", EntryPoint="CustomExceptionRegisterCallback_$module")]
    public static extern void CustomExceptionRegisterCallback_$module(CustomExceptionDelegate customDelegate);

    static void SetPendingCustomException(string exceptionName, string message) {
	  System.Type type = System.Type.GetType("LibLogicalAccess." + exceptionName.Split(new string[] { "::" }, System.StringSplitOptions.None)[exceptionName.Split(new string[] { "::" }, System.StringSplitOptions.None).Length - 1] + ", LibLogicalAccessNet");
      var exception = (LibLogicalAccess.CustomException)System.Activator.CreateInstance(type, new object[] { message });
	  SWIGPendingException.Set(exception);
    }

    static CustomExceptionHelper() {
      CustomExceptionRegisterCallback_$module(customDelegate);
    }
  }
  static CustomExceptionHelper exceptionHelper = new CustomExceptionHelper();
%}

%exception %{
try 
{
	$action
}
catch (logicalaccess::IKSException &e) \
{
	std::string name(typeid(e).name());
	if (name.find("class ") != std::string::npos)
		name.erase(0, name.find(" ") + 1);
	SWIG_CSharpSetPendingExceptionCustom(name.c_str(), e.what());
	return $null;
}
catch (logicalaccess::CardException &e)
{
	std::string name(typeid(e).name());
	if (name.find("class ") != std::string::npos)
		name.erase(0, name.find(" ") + 1);
	SWIG_CSharpSetPendingExceptionCustom(name.c_str(), e.what());
	return $null;
}
catch (logicalaccess::LibLogicalAccessException &e)
{
	std::string name(typeid(e).name());
	if (name.find("class ") != std::string::npos)
		name.erase(0, name.find(" ") + 1);
	SWIG_CSharpSetPendingExceptionCustom(name.c_str(), e.what());
	return $null;
}
catch (std::out_of_range &e)
{
	SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentOutOfRangeException, e.what(), "unknown");
	return $null;
}
catch (std::logic_error &e)
{
	SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentException, e.what(), "unknown");
	return $null;
}
catch (std::range_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOutOfMemoryException, e.what());
	return $null;
}
catch (std::overflow_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOverflowException, e.what());
	return $null;
}
catch (std::underflow_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOverflowException, e.what());
	return $null;
}
catch (std::runtime_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpSystemException, e.what());
	return $null;
}
catch (std::bad_cast &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpInvalidCastException, e.what());
	return $null;
}
catch (std::exception &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpSystemException, e.what());
	return $null;
}
%}

/*****POST PROCESSING INSTRUCTIONS*****/

%{
#include "msliblogicalaccessswigwin32.h"
#include <algorithm>

using namespace std;

#include <logicalaccess/myexception.hpp>
%}

%inline %{
  template<class T>
  T getVectorPart(std::vector<T> vector, int i)
  {
    return vector[i];
  }
%}
