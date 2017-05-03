/* File : liblogicalaccess_core.i */
%module(directors="1") liblogicalaccess_core

%include "liblogicalaccess.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_iks.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Reader;
%}

%{
/* Additional_include */

#include <logicalaccess/cards/accessinfo.hpp>
#include <logicalaccess/cards/aes128key.hpp>
#include <logicalaccess/cards/chip.hpp>
#include <logicalaccess/cards/commands.hpp>
#include <logicalaccess/cards/computermemorykeystorage.hpp>
#include <logicalaccess/cards/hmac1key.hpp>
#include <logicalaccess/cards/IKSStorage.hpp>
#include <logicalaccess/cards/keydiversification.hpp>
#include <logicalaccess/cards/keystorage.hpp>
#include <logicalaccess/cards/location.hpp>
#include <logicalaccess/cards/locationnode.hpp>
#include <logicalaccess/cards/readercardadapter.hpp>
#include <logicalaccess/cards/readermemorykeystorage.hpp>
#include <logicalaccess/cards/samkeystorage.hpp>
#include <logicalaccess/cards/tripledeskey.hpp>
#include <logicalaccess/readerproviders/circularbufferparser.hpp>
#include <logicalaccess/readerproviders/datatransport.hpp>
#include <logicalaccess/readerproviders/iso14443areadercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443breadercommunication.hpp>
#include <logicalaccess/readerproviders/iso14443readercommunication.hpp>
#include <logicalaccess/readerproviders/iso15693readercommunication.hpp>
#include <logicalaccess/readerproviders/lcddisplay.hpp>
#include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
#include <logicalaccess/readerproviders/readercommunication.hpp>
#include <logicalaccess/readerproviders/readerconfiguration.hpp>
#include <logicalaccess/readerproviders/readerprovider.hpp>
#include <logicalaccess/readerproviders/readerunit.hpp>
#include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
#include <logicalaccess/readerproviders/serialport.hpp>
#include <logicalaccess/readerproviders/serialportdatatransport.hpp>
#include <logicalaccess/readerproviders/serialportxml.hpp>
#include <logicalaccess/readerproviders/tcpdatatransport.hpp>
#include <logicalaccess/readerproviders/udpdatatransport.hpp>

/* END_Additional_include */

using namespace logicalaccess;

%}

/* Shared_ptr */

/* END_Shared_ptr */

/* Configuration_section */

%apply unsigned int *INOUT { unsigned int* pos }
%apply unsigned int INOUT[] { unsigned int* locations, unsigned int* positions }
%apply unsigned char INPUT[] { const unsigned char* data }

%typemap(ctype) CardServiceType "CardServiceType"
%typemap(cstype) CardServiceType "CardServiceType"
%typemap(csin) CardServiceType %{$csinput%}  
%typemap(imtype) CardServiceType "CardServiceType"
%typemap(csout, excode=SWIGEXCODE) CardServiceType {
	CardServiceType ret = $imcall;$excode
	return ret;
}

%typemap(ctype) KeyStorageType "KeyStorageType"
%typemap(cstype) KeyStorageType "KeyStorageType"
%typemap(csin) KeyStorageType %{$csinput%}  
%typemap(imtype) KeyStorageType "KeyStorageType"
%typemap(csout, excode=SWIGEXCODE) KeyStorageType {
	KeyStorageType ret = $imcall;$excode
	return ret;
}

%typemap(ctype) const ReaderServiceType & "const ReaderServiceType *"
%typemap(cstype) const ReaderServiceType & "ReaderServiceType"
%typemap(csin) const ReaderServiceType & %{$csinput%}  
%typemap(imtype) const ReaderServiceType & "ReaderServiceType"
%typemap(csout, excode=SWIGEXCODE) const ReaderServiceType & {
	ReaderServiceType ret = $imcall;$excode
	return ret;
}


typedef std::shared_ptr<logicalaccess::Chip> ChipPtr;
typedef std::shared_ptr<logicalaccess::Key> KeyPtr;

%template(ChipCollection) std::vector<std::shared_ptr<logicalaccess::Chip> >;
%template(LocationNodeCollection) std::vector<std::shared_ptr<logicalaccess::LocationNode> >;

%template(LocationNodeWeakPtr) std::weak_ptr<logicalaccess::LocationNode>;
%template(ReaderProviderWeakPtr) std::weak_ptr<logicalaccess::ReaderProvider>;
%template(ReaderUnitWeakPtr) std::weak_ptr<logicalaccess::ReaderUnit>;
%template(FormatPtrVector) std::vector<std::shared_ptr<logicalaccess::Format> >;
%template(ReaderUnitPtrVector) std::vector<std::shared_ptr<logicalaccess::ReaderUnit> >;
%template(SerialPortXmlPtrVector) std::vector<std::shared_ptr<logicalaccess::SerialPortXml> >;


%rename(IsEqual) operator==;
%rename(IsDifferent) operator!=;
%rename(CompareTo) operator<;
%ignore operator<<;

/* END_Configuration_section */

/* Include_section */

%include <logicalaccess/cards/accessinfo.hpp>
%include <logicalaccess/cards/aes128key.hpp>
%include <logicalaccess/cards/chip.hpp>
%include <logicalaccess/cards/commands.hpp>
%include <logicalaccess/cards/computermemorykeystorage.hpp>
%include <logicalaccess/cards/hmac1key.hpp>
%include <logicalaccess/cards/IKSStorage.hpp>
%include <logicalaccess/cards/keydiversification.hpp>
%include <logicalaccess/cards/keystorage.hpp>
%include <logicalaccess/cards/location.hpp>
%include <logicalaccess/cards/locationnode.hpp>
%include <logicalaccess/cards/readercardadapter.hpp>
%include <logicalaccess/cards/readermemorykeystorage.hpp>
%include <logicalaccess/cards/samkeystorage.hpp>
%include <logicalaccess/cards/tripledeskey.hpp>
%include <logicalaccess/readerproviders/circularbufferparser.hpp>
%include <logicalaccess/readerproviders/datatransport.hpp>
%include <logicalaccess/readerproviders/iso14443areadercommunication.hpp>
%include <logicalaccess/readerproviders/iso14443breadercommunication.hpp>
%include <logicalaccess/readerproviders/iso14443readercommunication.hpp>
%include <logicalaccess/readerproviders/iso15693readercommunication.hpp>
%include <logicalaccess/readerproviders/lcddisplay.hpp>
%include <logicalaccess/readerproviders/ledbuzzerdisplay.hpp>
%include <logicalaccess/readerproviders/readercommunication.hpp>
%include <logicalaccess/readerproviders/readerconfiguration.hpp>
%include <logicalaccess/readerproviders/readerprovider.hpp>
%include <logicalaccess/readerproviders/readerunit.hpp>
%include <logicalaccess/readerproviders/readerunitconfiguration.hpp>
%include <logicalaccess/readerproviders/serialport.hpp>
%include <logicalaccess/readerproviders/serialportdatatransport.hpp>
%include <logicalaccess/readerproviders/serialportxml.hpp>
%include <logicalaccess/readerproviders/tcpdatatransport.hpp>
%include <logicalaccess/readerproviders/udpdatatransport.hpp>

/* END_Include_section */

%include "liblogicalaccess_cardservice.i"
%include "liblogicalaccess_readerservice.i"

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> chipDictionary;

	public static System.Collections.Generic.Dictionary<string, System.Type> createDictionary<T>() where T : class
	{
        System.Collections.Generic.Dictionary<string, System.Type> dictionary = new System.Collections.Generic.Dictionary<string, System.Type>();
        foreach (System.Type type in
            System.Reflection.Assembly.GetAssembly(typeof(T)).GetTypes())
        {
            if (type.IsClass && !type.IsAbstract && type.IsSubclassOf(typeof(T)))
            {
                string tmp = type.ToString().Split('.')[type.ToString().Split('.').Length - 1].Substring(0, type.ToString().Split('.')[type.ToString().Split('.').Length - 1].IndexOf(typeof(T).Name));
                dictionary.Add(tmp, type);
            }
        }
        return dictionary;
	}

	public static Chip	createChip(System.IntPtr cPtr, bool owner)
	{
		Chip ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = (liblogicalaccess_cardPINVOKE.Chip_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (chipDictionary == null)
			chipDictionary = createDictionary<Chip>();
        if (chipDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Chip)System.Activator.CreateInstance(chipDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Chip*, std::shared_ptr<logicalaccess::Chip> {
    System.IntPtr cPtr = $imcall;
    Chip ret = liblogicalaccess_cardPINVOKE.createChip(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> locationDictionary;

	public static Location	createLocation(System.IntPtr cPtr, bool owner)
	{
		Location ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($modulePINVOKE.Location_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (locationDictionary == null)
			locationDictionary = createDictionary<Location>();
        if (locationDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (Location)System.Activator.CreateInstance(locationDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::Location*, std::shared_ptr<logicalaccess::Location> {
    System.IntPtr cPtr = $imcall;
    Location ret = liblogicalaccess_cardPINVOKE.createLocation(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
	public static System.Collections.Generic.Dictionary<string, System.Type> accessInfoDictionary;

	public static AccessInfo	createAccessInfo(System.IntPtr cPtr, bool owner)
	{
		AccessInfo ret = null;
		if (cPtr == System.IntPtr.Zero) {
		  return ret;
		}
		string ct = ($modulePINVOKE.AccessInfo_getCardType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
		if (accessInfoDictionary == null)
			accessInfoDictionary = createDictionary<AccessInfo>();
        if (accessInfoDictionary.ContainsKey(ct))
        {
            System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance;
            ret = (AccessInfo)System.Activator.CreateInstance(accessInfoDictionary[ct], flags, null, new object[] { cPtr, owner }, null);
        }
		return ret;
	}
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::AccessInfo*, std::shared_ptr<logicalaccess::AccessInfo> {
    System.IntPtr cPtr = $imcall;
    AccessInfo ret = liblogicalaccess_cardPINVOKE.createAccessInfo(cPtr, $owner);$excode
    return ret;
}

%pragma(csharp) imclasscode=%{
  public static KeyStorage createKeyStorage(System.IntPtr cPtr, bool owner)
  {
    KeyStorage ret = null;
    if (cPtr == System.IntPtr.Zero) {
      return ret;
    }
	KeyStorageType ks = (KeyStorageType)($modulePINVOKE.KeyStorage_getType(new System.Runtime.InteropServices.HandleRef(null, cPtr)));
    switch (ks) {
	   case KeyStorageType.KST_COMPUTER_MEMORY:
	     ret = new ComputerMemoryKeyStorage(cPtr, owner);
	     break;
	   case KeyStorageType.KST_READER_MEMORY:
	     ret = new ReaderMemoryKeyStorage(cPtr, owner);
		 break;
	   case KeyStorageType.KST_SAM:
	     ret = new SAMKeyStorage(cPtr, owner);
		 break;
	   case KeyStorageType.KST_SERVER:
	     ret = new IKSStorage(cPtr, owner);
		 break;
      }
      return ret;
    }
%}

%typemap(csout, excode=SWIGEXCODE)
  logicalaccess::KeyStorage*, std::shared_ptr<logicalaccess::KeyStorage> {
    System.IntPtr cPtr = $imcall;
    KeyStorage ret = liblogicalaccess_cardPINVOKE.createKeyStorage(cPtr, $owner);$excode
    return ret;
}