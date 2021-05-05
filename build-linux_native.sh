#!/bin/bash

cd sources/LibLogicalAccessNet.win32/ && mkdir -p build && cd build
conan install -p compilers/x64_gcc6_release ..
conan build ..
