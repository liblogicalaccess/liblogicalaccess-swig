/* File : liblogicalaccess_card.i */
%module(directors="1") liblogicalaccess_card

%include "liblogicalaccess.i"
%import "liblogicalaccess_exception.i"

%import "liblogicalaccess_data.i"
%import "liblogicalaccess_core.i"
%import "liblogicalaccess_iks.i"

%{
/* Additional_include */

/* END_Additional_include */

using namespace logicalaccess;

%}

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
using LibLogicalAccess.Crypto;
using LibLogicalAccess.Reader;
%}

%shared_ptr(CPS3Commands);

%typemap(ctype) size_t* indexByte "size_t*"
%typemap(cstype) size_t* indexByte "out uint"
%typemap(csin) size_t* indexByte %{out $csinput%}  
%typemap(imtype) size_t* indexByte "out uint"

%typemap(ctype) logicalaccess::OmnikeyReaderUnit "logicalaccess::OmnikeyReaderUnit"
%typemap(cstype) logicalaccess::OmnikeyReaderUnit "OmnikeyReaderUnit"
%typemap(csin) logicalaccess::OmnikeyReaderUnit %{$csinput%}  
%typemap(imtype) logicalaccess::OmnikeyReaderUnit "LibLogicalAccess.Reader.OmnikeyReaderUnit"
%typemap(csout, excode=SWIGEXCODE) logicalaccess::OmnikeyReaderUnit {
	OmnikeyReaderUnit ret = $imcall;$excode
	return ret;
}

%typemap(ctype) logicalaccess::OmnikeyXX21ReaderUnit "logicalaccess::OmnikeyXX21ReaderUnit"
%typemap(cstype) logicalaccess::OmnikeyXX21ReaderUnit "OmnikeyXX21ReaderUnit"
%typemap(csin) logicalaccess::OmnikeyXX21ReaderUnit %{$csinput%}  
%typemap(imtype) logicalaccess::OmnikeyXX21ReaderUnit "LibLogicalAccess.Reader.OmnikeyXX21ReaderUnit"
%typemap(csout, excode=SWIGEXCODE) logicalaccess::OmnikeyXX21ReaderUnit {
	OmnikeyXX21ReaderUnit ret = $imcall;$excode
	return ret;
}

%typemap(ctype) logicalaccess::PCSCReaderCardAdapter "logicalaccess::PCSCReaderCardAdapter"
%typemap(cstype) logicalaccess::PCSCReaderCardAdapter "PCSCReaderCardAdapter"
%typemap(csin) logicalaccess::PCSCReaderCardAdapter %{$csinput%}  
%typemap(imtype) logicalaccess::PCSCReaderCardAdapter "LibLogicalAccess.Reader.PCSCReaderCardAdapter"
%typemap(csout, excode=SWIGEXCODE) logicalaccess::PCSCReaderCardAdapter {
	PCSCReaderCardAdapter ret = $imcall;$excode
	return ret;
}

%typemap(csvarin, excode=SWIGEXCODE2) DESFireKeyType %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) DESFireKeyType %{
    get {
      DESFireKeyType ret = $imcall;$excode
      return ret;
} %}

%typemap(ctype) logicalaccess::DESFireKeyType& "DESFireKeyType*"
%typemap(cstype) logicalaccess::DESFireKeyType& "out DESFireKeyType"
%typemap(csin) logicalaccess::DESFireKeyType& %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeyType& "out LibLogicalAccess.Card.DESFireKeyType"

%typemap(ctype) DESFireKeySettings "DESFireKeySettings"
%typemap(cstype) DESFireKeySettings "DESFireKeySettings"
%typemap(csin) DESFireKeySettings %{$csinput%}  
%typemap(imtype) DESFireKeySettings "LibLogicalAccess.Card.DESFireKeySettings"
%typemap(csout, excode=SWIGEXCODE) DESFireKeySettings {
	DESFireKeySettings ret = $imcall;$excode
	return ret;
}

%typemap(ctype) logicalaccess::DESFireKeySettings & "logicalaccess::DESFireKeySettings*"
%typemap(cstype) logicalaccess::DESFireKeySettings & "out DESFireKeySettings"
%typemap(csin) logicalaccess::DESFireKeySettings & %{out $csinput%}  
%typemap(imtype) logicalaccess::DESFireKeySettings & "out LibLogicalAccess.Card.DESFireKeySettings"

%apply unsigned char MBINOUT[] { unsigned char recordSize[ANY] }
%apply unsigned char MBINOUT[] { unsigned char maxNumberRecords[ANY] }
%apply unsigned char MBINOUT[] { unsigned char currentNumberRecords[ANY] }
%apply unsigned char MBINOUT[] { unsigned char accessRights[ANY] }
%apply unsigned char MBINOUT[] { unsigned char uid[ANY] }
%apply unsigned char MBINOUT[] { unsigned char batchNo[ANY] }
%apply unsigned char MBINOUT[] { unsigned char fileSize[ANY] }
%apply unsigned char MBINOUT[] { unsigned char keytype[ANY] }
%apply unsigned char MBINOUT[] { unsigned char rfu[ANY] }
%apply unsigned char MBINOUT[] { unsigned char desfireAid[ANY] }
%apply unsigned char MBINOUT[] { unsigned char set[ANY] }
%apply unsigned char MBINOUT[] { unsigned char keyclass[ANY] }
%apply unsigned char MBINOUT[] { unsigned char dfname[ANY] }
%apply unsigned char MBINOUT[] { unsigned char limit[ANY] }
%apply unsigned char MBINOUT[] { unsigned char curval[ANY] }
%apply unsigned char MBINOUT[] { unsigned char productionbatchnumber[ANY] }
%apply unsigned char MBINOUT[] { unsigned char uniqueserialnumber[ANY] }
%apply logicalaccess::MifareAccessInfo::DataBlockAccessBits MBINOUT[] { logicalaccess::MifareAccessInfo::DataBlockAccessBits d_data_blocks_access_bits[ANY] }

%ignore logicalaccess::Commands;
%ignore pcsc_share_mode_to_string;
%ignore pcsc_protocol_to_string;
%ignore *::getTime;

%include "liblogicalaccess_card_sam.i"
%import "liblogicalaccess_reader_sam.i"

/* Include_section */

/* END_Include_section */

%template(BioInfosVector) std::vector<logicalaccess::EPassDG2::BioInfo>;
%template(DFNameVector) std::vector<logicalaccess::DFName>;
%template(DESFireAccessRightsVector) std::vector<logicalaccess::DESFireAccessRights>;