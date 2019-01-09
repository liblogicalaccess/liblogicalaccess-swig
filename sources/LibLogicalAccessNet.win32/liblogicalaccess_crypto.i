/* File : liblogicalaccess_crypto.i */
%module(directors="1") liblogicalaccess_crypto

%include "liblogicalaccess.i"
%import "liblogicalaccess_exception.i"
%import "liblogicalaccess_data.i"
%import "liblogicalaccess_iks.i"

%{
/* Additional_include */

/* END_Additional_include */

using namespace openssl;

%}

/* Include_section */

/* END_Include_section */
