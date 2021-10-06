#!/bin/bash

set -x
set -e

buildprivate=False
# Full Edition build?
if [[($1 -eq 1) || ($1 -eq 'true') || ($1 -eq 'yes')]]
then
	buildprivate=True
fi

(cd installer && conan install --profile compilers/x64_gcc6_release -o LLA_BUILD_PRIVATE=$buildprivate -u .)
(cd sources/scripts/ && pip3 install -r requirements.txt)
(cd sources/scripts/ && python3 lla.py)

# Build
pushd sources
rm -f ./LibLogicalAccessNet/Generated/*.cs
rm -f ./LibLogicalAccessNet/Generated/Reader/*.cs
rm -f ./LibLogicalAccessNet/Generated/Card/*.cs
rm -f ./LibLogicalAccessNet/Generated/Core/*.cs
rm -f ./LibLogicalAccessNet/Generated/Crypto/*.cs

nice -n -19 swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Card" -namespace LibLogicalAccess.Card -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_card.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_data.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Exception" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_exception.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_library.i &

nice -n -19 swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Reader" -namespace LibLogicalAccess.Reader -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_reader.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_iks.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Crypto" -namespace LibLogicalAccess.Crypto -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_crypto.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Core" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/liblogicalaccess_core.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.win32/lla_std_types.i &

wait
popd

(cd sources/scripts/ && python3 adaptExceptionClass.py)
