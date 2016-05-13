#!/bin/bash
## Generates C# class that wraps logicalaccess.
## The lla_swig.so shared library is then used by the managed code to
## call into liblogicalaccess.

RUN_SWIG="swig3.0 -v -c++ -csharp -I/usr/local/include/ -dllimport lla_swig.so"

$RUN_SWIG -namespace LibLogicalAccess -outdir gencs liblogicalaccess_data.i
$RUN_SWIG -namespace LibLogicalAccess -outdir gencs liblogicalaccess_library.i
$RUN_SWIG -namespace LibLogicalAccess.Card -outdir gencs/Card liblogicalaccess_card.i
$RUN_SWIG -namespace LibLogicalAccess.Reader -outdir gencs/Reader liblogicalaccess_reader.i


echo "Compiling shared library..."
g++ -DUNIX=1 -std=c++11 *.cxx  -llogicalaccess -shared -fPIC -o lla_swig.so
