/* File : liblogicalaccess_iks.i */
%module(directors="1") liblogicalaccess_iks

%import "liblogicalaccess_data.i"

%typemap(csimports) SWIGTYPE
%{
using LibLogicalAccess;
%}

%{
#include <logicalaccess/iks/IslogKeyServer.hpp>
#include <logicalaccess/iks/packet/AesEncrypt.hpp>
#include <logicalaccess/iks/packet/Base.hpp>
#include <logicalaccess/iks/packet/DesEncrypt.hpp>
#include <logicalaccess/iks/packet/DesfireAuth.hpp>
#include <logicalaccess/iks/packet/DesfireChangeKey.hpp>
#include <logicalaccess/iks/packet/GenRandom.hpp>
#include <logicalaccess/key.hpp>
#include <logicalaccess/cards/keystorage.hpp">
#include <logicalaccess/cards/keydiversification.hpp">

using namespace logicalaccess;
%}

%template(UByteVector) std::vector<uint8_t>;
%template(UByteArray8) std::array<uint8_t, 8>;
%template(UByteArray16) std::array<uint8_t, 16>;
%template(UByteArray32) std::array<uint8_t, 32>;

%typemap(cstype) const BaseCommand & "BaseCommand"
%typemap(csin) const BaseCommand & %{out $csinput%}
%typemap(imtype) const BaseCommand & "BaseCommand"

%typemap(cstype) uint8_t * "ref byte"
%typemap(csin) uint8_t * %{ref $csinput%}  
%typemap(imtype) uint8_t * "ref byte"

%typemap(cstype) const std::vector<uint8_t> & "UByteVector"
%typemap(csin) const std::vector<uint8_t> & %{ref $csinput%}  
%typemap(imtype) const std::vector<uint8_t> & "UByteVector"

%typemap(ctype) iks::IslogKeyServer::IKSConfig "iks::IslogKeyServer::IKSConfig"
%typemap(cstype) iks::IslogKeyServer::IKSConfig "IslogKeyServer.IKSConfig"
%typemap(csin) iks::IslogKeyServer::IKSConfig %{$csinput%}  
%typemap(imtype) iks::IslogKeyServer::IKSConfig "IslogKeyServer.IKSConfig"
%typemap(csout, excode=SWIGEXCODE) iks::IslogKeyServer::IKSConfig {
	IslogKeyServer.IKSConfig ret = $imcall;$excode
	return ret;
}

%typemap(ctype) const iks::IslogKeyServer::IKSConfig & "iks::IslogKeyServer::IKSConfig"
%typemap(cstype) const iks::IslogKeyServer::IKSConfig & "IslogKeyServer.IKSConfig"
%typemap(csin) const iks::IslogKeyServer::IKSConfig & %{$csinput%}  
%typemap(imtype) const iks::IslogKeyServer::IKSConfig & "IslogKeyServer.IKSConfig"
%typemap(csout, excode=SWIGEXCODE) const iks::IslogKeyServer::IKSConfig & {
	IslogKeyServer.IKSConfig ret = $imcall;$excode
	return ret;
}

/* Shared_ptr */

%shared_ptr(logicalaccess::KeyDiversification);
%shared_ptr(logicalaccess::KeyStorage);
%shared_ptr(logicalaccess::BaseResponse);
%shared_ptr(BaseResponse);
%shared_ptr(logicalaccess::Key);

/* END_Shared_ptr */

%include <logicalaccess/iks/IslogKeyServer.hpp>
%include <logicalaccess/iks/packet/AesEncrypt.hpp>
%include <logicalaccess/iks/packet/Base.hpp>
%include <logicalaccess/iks/packet/DesEncrypt.hpp>
%include <logicalaccess/iks/packet/DesfireAuth.hpp>
%include <logicalaccess/iks/packet/DesfireChangeKey.hpp>
%include <logicalaccess/iks/packet/GenRandom.hpp>
