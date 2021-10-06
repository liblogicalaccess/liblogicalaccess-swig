#!/bin/bash

cd sources/LibLogicalAccessNet.win32/ && mkdir -p build && cd build
conan install --profile compilers/x64_gcc6_release -o LLA_BUILD_PRIVATE=false ..
conan build ..
