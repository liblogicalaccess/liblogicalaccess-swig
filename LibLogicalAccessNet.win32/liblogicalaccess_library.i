/* File : liblogicalaccess_library.i */
%module(directors="1") liblogicalaccess_library

%include "liblogicalaccess.i"

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

%shared_ptr(logicalaccess::Key);
%shared_ptr(logicalaccess::Chip);

/* original header files */
%include <logicalaccess/dynlibrary/idynlibrary.hpp>
%include <logicalaccess/dynlibrary/librarymanager.hpp>

/*****EXCPETION HANDLING*****/

%insert(runtime) %{
  typedef void (SWIGSTDCALL* CSharpExceptionCallback_t)(const char *, const char *);
  CSharpExceptionCallback_t customExceptionCallback = NULL;

  extern "C" SWIGEXPORT
  void SWIGSTDCALL CustomExceptionRegisterCallback(CSharpExceptionCallback_t customCallback) {
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

    [global::System.Runtime.InteropServices.DllImport("$dllimport", EntryPoint="CustomExceptionRegisterCallback")]
    public static extern
           void CustomExceptionRegisterCallback(CustomExceptionDelegate customCallback);

    static void SetPendingCustomException(string exceptionName, string message) {
	  var exception = (swig.CustomException)System.Activator.CreateInstance("swig", "swig." + exceptionName, false, 0, null, new System.String[1] { message }, null, null, null).Unwrap();
	  SWIGPendingException.Set(exception);
    }

    static CustomExceptionHelper() {
      CustomExceptionRegisterCallback(customDelegate);
    }
  }
  static CustomExceptionHelper exceptionHelper = new CustomExceptionHelper();
%}

/** ATTENTION PAS FINI ICI **/

%{
#define CATCH_CSE(EXCEPT) \
	catch (EXCEPT e) \
	{ \
	  std::string name(typeid(e).name());\
	  if (name.find("class ") != std::string::npos)\
		 name.erase(0, name.find(" ") + 1);\
	  SWIG_CSharpSetPendingExceptionCustom(name.c_str(), e.what());\
	}\

#define FOR_EACH_EXCEPTION(ACTION)\
	ACTION(NotAwakeException)\
	ACTION(NotBornException)\
	ACTION(NotAliveException)\
%}

%exception %{
try 
{
  $action
} 
FOR_EACH_EXCEPTION( CATCH_CSE )
catch (std::out_of_range &e)
{
	SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentOutOfRangeException, e.what(), "unknown");
}
catch (std::logic_error &e)
{
	SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentException, e.what(), "unknown");
}
catch (std::range_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOutOfMemoryException, e.what());
}
catch (std::overflow_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOverflowException, e.what());
}
catch (std::underflow_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpOverflowException, e.what());
}
catch (std::runtime_error &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpSystemException, e.what());
}
catch (std::bad_cast &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpInvalidCastException, e.what());
}
catch (std::exception &e)
{
	SWIG_CSharpSetPendingException(SWIG_CSharpSystemException, e.what());
}
%}

%{
	#include <logicalaccess/dynlibrary/idynlibrary.hpp>
	#include <logicalaccess/dynlibrary/librarymanager.hpp>

	using namespace logicalaccess;
%}