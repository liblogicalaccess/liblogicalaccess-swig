#!/bin/bash

buildprivate=False
# Full Edition build?
if [[($1 -eq 1) || ($1 = 'true') || ($1 = 'yes')]]
then
	buildprivate=True
fi

cd sources/LibLogicalAccessNet.win32/ && mkdir -p build && cd build
conan install -o LLA_BUILD_PRIVATE=$buildprivate --build=missing ..
conan build ..
