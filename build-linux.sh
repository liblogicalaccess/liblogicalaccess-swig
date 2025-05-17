#!/bin/bash

set -x
set -e

(cd installer && conan install . --update  --build=missing)
#(cd sources/scripts/ && pip3 install -r requirements.txt --break-system-packages)
(cd sources/scripts/ && python3 lla.py)

# Build
pushd sources
rm -f ./LibLogicalAccessNet/Generated/*.cs
rm -f ./LibLogicalAccessNet/Generated/Reader/*.cs
rm -f ./LibLogicalAccessNet/Generated/Card/*.cs
rm -f ./LibLogicalAccessNet/Generated/Core/*.cs
rm -f ./LibLogicalAccessNet/Generated/Crypto/*.cs

nice -n -19 swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Card" -namespace LibLogicalAccess.Card -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_card.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_data.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Exception" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_exception.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_library.i &

nice -n -19 swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Reader" -namespace LibLogicalAccess.Reader -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_reader.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Crypto" -namespace LibLogicalAccess.Crypto -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_crypto.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated/Core" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/liblogicalaccess_core.i &

nice swig -Wall -csharp -c++ -I"../swig/csharp" -I"../installer/packages/include" -outdir "LibLogicalAccessNet/Generated" -namespace LibLogicalAccess -dllimport LogicalAccessNetNative LibLogicalAccessNet.native/lla_std_types.i &

wait
popd

(cd sources/scripts/ && python3 adaptExceptionClass.py)
