/* File : liblogicalaccess_crypto.i */
%module(directors="1") liblogicalaccess_crypto

%include "liblogicalaccess.i"
%import "liblogicalaccess_exception.i"
%import "liblogicalaccess_data.i"
%import "liblogicalaccess_iks.i"

%{
/* Additional_include */

#include <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/aes_cipher.hpp>
#include <logicalaccess/plugins/crypto/aes_helper.hpp>
#include <logicalaccess/plugins/crypto/aes_symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/openssl.hpp>
#include <logicalaccess/plugins/crypto/asymmetric_key.hpp>
#include <logicalaccess/plugins/crypto/asymmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/cmac.hpp>
#include <logicalaccess/plugins/crypto/des_cipher.hpp>
#include <logicalaccess/plugins/crypto/des_helper.hpp>
#include <logicalaccess/plugins/crypto/des_initialization_vector.hpp>
#include <logicalaccess/plugins/crypto/des_symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/pem.hpp>
#include <logicalaccess/plugins/crypto/evp_pkey.hpp>
#include <logicalaccess/plugins/crypto/lla_random.hpp>
#include <logicalaccess/plugins/crypto/null_deleter.hpp>
#include <logicalaccess/plugins/crypto/openssl_asymmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/rsa_cipher.hpp>
#include <logicalaccess/plugins/crypto/rsa_key.hpp>
#include <logicalaccess/plugins/crypto/sha.hpp>
#include <logicalaccess/plugins/crypto/ssl_context.hpp>
#include <logicalaccess/plugins/crypto/ssl_object.hpp>
#include <logicalaccess/plugins/crypto/openssl_symmetric_cipher_context.hpp>
#include <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
#include <logicalaccess/plugins/crypto/symmetric_key.hpp>
#include <logicalaccess/plugins/crypto/initialization_vector.hpp>

#include <logicalaccess/x509_certificate.hpp>

/* END_Additional_include */

using namespace openssl;

%}

%shared_ptr(RSA)
%shared_ptr(SSL_CTX)
%shared_ptr(SSL)

%rename(NullDeletion) operator();

/* Include_section */

%include <logicalaccess/plugins/crypto/initialization_vector.hpp>
%include <logicalaccess/plugins/crypto/symmetric_key.hpp>
%include <logicalaccess/plugins/crypto/openssl_symmetric_cipher.hpp>
%include <logicalaccess/plugins/crypto/aes_cipher.hpp>
%include <logicalaccess/plugins/crypto/aes_helper.hpp>
%include <logicalaccess/plugins/crypto/aes_symmetric_key.hpp>
%include <logicalaccess/plugins/crypto/openssl.hpp>
%include <logicalaccess/plugins/crypto/asymmetric_key.hpp>
%include <logicalaccess/plugins/crypto/asymmetric_cipher.hpp>
%include <logicalaccess/plugins/crypto/cmac.hpp>
%include <logicalaccess/plugins/crypto/des_cipher.hpp>
%include <logicalaccess/plugins/crypto/des_helper.hpp>
%include <logicalaccess/plugins/crypto/des_initialization_vector.hpp>
%include <logicalaccess/plugins/crypto/des_symmetric_key.hpp>
%include <logicalaccess/plugins/crypto/pem.hpp>
%include <logicalaccess/plugins/crypto/evp_pkey.hpp>
%include <logicalaccess/plugins/crypto/lla_random.hpp>
%include <logicalaccess/plugins/crypto/null_deleter.hpp>
%include <logicalaccess/plugins/crypto/openssl_asymmetric_cipher.hpp>
%include <logicalaccess/plugins/crypto/rsa_cipher.hpp>
%include <logicalaccess/plugins/crypto/rsa_key.hpp>
%include <logicalaccess/plugins/crypto/sha.hpp>
%include <logicalaccess/plugins/crypto/ssl_context.hpp>
%include <logicalaccess/plugins/crypto/ssl_object.hpp>
%include <logicalaccess/plugins/crypto/aes_initialization_vector.hpp>
%include <logicalaccess/plugins/crypto/symmetric_cipher.hpp>
%include <logicalaccess/plugins/crypto/openssl_symmetric_cipher_context.hpp>
%import <logicalaccess/x509_certificate.hpp>

/* END_Include_section */
