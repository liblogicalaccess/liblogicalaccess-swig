#!/bin/bash

buildprivate=False
# Full Edition build?
if [[($1 -eq 1) || ($1 -eq 'true') || ($1 -eq 'yes')]]
then
	buildprivate=True
fi

cd sources/LibLogicalAccessNet.win32/ && mkdir -p build && cd build
conan install --profile compilers/x64_gcc6_release -o LLA_BUILD_PRIVATE=$buildprivate ..
conan build ..
