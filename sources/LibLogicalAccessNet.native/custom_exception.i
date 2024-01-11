/* File : custom_exception.i */
%module(directors="1") custom_exception

%include <exception.i>

%{
#include <logicalaccess/myexception.hpp>
%}

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

// Catch and convert custom exception for any LLA throw type

%include <exception.i>

%exception %{
try 
{
	$action
}
catch (logicalaccess::CardException &e)
{
	SWIG_CSharpSetPendingExceptionCustom("CardException", e.what());
	return $null;
}
catch (logicalaccess::LibLogicalAccessException &e)
{
	SWIG_CSharpSetPendingExceptionCustom("LibLogicalAccessException", e.what());
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