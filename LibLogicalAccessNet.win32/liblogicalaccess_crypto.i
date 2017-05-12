/* File : liblogicalaccess_crypto.i */

%{
/* Additional_include */

#include <logicalaccess/crypto/initialization_vector.hpp>
#include <logicalaccess/crypto/symmetric_cipher.hpp>
#include <logicalaccess/crypto/openssl_symmetric_cipher.hpp>
#include <logicalaccess/crypto/aes_cipher.hpp>
#include <logicalaccess/crypto/aes_helper.hpp>
#include <logicalaccess/crypto/aes_initialization_vector.hpp>
#include <logicalaccess/crypto/symmetric_key.hpp>
#include <logicalaccess/crypto/aes_symmetric_key.hpp>
#include <logicalaccess/crypto/openssl.hpp>
#include <logicalaccess/crypto/asymmetric_key.hpp>
#include <logicalaccess/crypto/asymmetric_cipher.hpp>
#include <logicalaccess/crypto/cmac.hpp>
#include <logicalaccess/crypto/des_cipher.hpp>
#include <logicalaccess/crypto/des_helper.hpp>
#include <logicalaccess/crypto/des_initialization_vector.hpp>
#include <logicalaccess/crypto/des_symmetric_key.hpp>
#include <logicalaccess/crypto/pem.hpp>
#include <logicalaccess/crypto/evp_pkey.hpp>
#include <logicalaccess/crypto/lla_random.hpp>
#include <logicalaccess/crypto/null_deleter.hpp>
#include <logicalaccess/crypto/openssl_asymmetric_cipher.hpp>
#include <logicalaccess/crypto/openssl_exception.hpp>
#include <logicalaccess/crypto/openssl_symmetric_cipher_context.hpp>
#include <logicalaccess/crypto/rsa_cipher.hpp>
#include <logicalaccess/crypto/rsa_key.hpp>
#include <logicalaccess/crypto/sha.hpp>
#include <logicalaccess/crypto/ssl_context.hpp>
#include <logicalaccess/crypto/ssl_object.hpp>

/* END_Additional_include */

%}

%rename(NullDeltion) operator();

/* Include_section */

%include <logicalaccess/crypto/initialization_vector.hpp>
%include <logicalaccess/crypto/symmetric_cipher.hpp>
%include <logicalaccess/crypto/openssl_symmetric_cipher.hpp>
%include <logicalaccess/crypto/aes_cipher.hpp>
%include <logicalaccess/crypto/aes_helper.hpp>
%include <logicalaccess/crypto/aes_initialization_vector.hpp>
%include <logicalaccess/crypto/symmetric_key.hpp>
%include <logicalaccess/crypto/aes_symmetric_key.hpp>
%include <logicalaccess/crypto/openssl.hpp>
%include <logicalaccess/crypto/asymmetric_key.hpp>
%include <logicalaccess/crypto/asymmetric_cipher.hpp>
%include <logicalaccess/crypto/cmac.hpp>
%include <logicalaccess/crypto/des_cipher.hpp>
%include <logicalaccess/crypto/des_helper.hpp>
%include <logicalaccess/crypto/des_initialization_vector.hpp>
%include <logicalaccess/crypto/des_symmetric_key.hpp>
%include <logicalaccess/crypto/pem.hpp>
%include <logicalaccess/crypto/evp_pkey.hpp>
%include <logicalaccess/crypto/lla_random.hpp>
%include <logicalaccess/crypto/null_deleter.hpp>
%include <logicalaccess/crypto/openssl_asymmetric_cipher.hpp>
%include <logicalaccess/crypto/openssl_exception.hpp>
%include <logicalaccess/crypto/openssl_symmetric_cipher_context.hpp>
%include <logicalaccess/crypto/rsa_cipher.hpp>
%include <logicalaccess/crypto/rsa_key.hpp>
%include <logicalaccess/crypto/sha.hpp>
%include <logicalaccess/crypto/ssl_context.hpp>
%include <logicalaccess/crypto/ssl_object.hpp>

/* END_Include_section */
