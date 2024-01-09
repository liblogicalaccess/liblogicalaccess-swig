#!/bin/bash

cd sources/LibLogicalAccessNet.native/ && mkdir -p build && cd build
conan install --build=missing ..
conan build ..
