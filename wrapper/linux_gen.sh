#!/bin/bash
## Generates C# class that wraps logicalaccess.
## The liblogicalaccess-swig.so shared library is then used by the managed code to
## call into liblogicalaccess.

RUN_SWIG="swig3.0 -v -c++ -csharp -I/usr/local/include/ -dllimport liblogicalaccess-swig.so"

$RUN_SWIG -namespace LibLogicalAccess -outdir csharp liblogicalaccess_data.i
$RUN_SWIG -namespace LibLogicalAccess -outdir csharp liblogicalaccess_library.i
$RUN_SWIG -namespace LibLogicalAccess.Card -outdir csharp/Card liblogicalaccess_card.i
$RUN_SWIG -namespace LibLogicalAccess.Reader -outdir csharp/Reader liblogicalaccess_reader.i


echo "Compiling shared library..."
g++ -DUNIX=1 -std=c++11 *.cxx  -llogicalaccess -shared -fPIC -o liblogicalaccess-swig.so
