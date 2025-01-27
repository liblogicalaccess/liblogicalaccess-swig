from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMakeDeps, CMake, cmake_layout
from conan.errors import ConanException
from conan.tools.files import copy
import os

class LLASwig(ConanFile):
    name = "logicalaccess-swig"
    version = "3.2.0"
    license = "LGPL"
    url = "https://github.com/liblogicalaccess/liblogicalaccess-swig"
    description = "SWIG wrapper for LibLogicalAccess"
    settings = "os", "compiler", "build_type", "arch"
    options = { 'LLA_BUILD_NFC': [True, False] }
    default_options = { 'logicalaccess/*:LLA_BUILD_PKCS': True, 'LLA_BUILD_NFC': False }
    revision_mode = "scm"

    def requirements(self):
        if self.options.LLA_BUILD_NFC:
            self.requires('logicalaccess-nfc/' + self.version)
        else:
            self.requires('logicalaccess/'+ self.version)
        self.requires('nlohmann_json/3.11.3') # shoulnd't be required

    def layout(self):
        cmake_layout(self)
        
    def generate(self):
        for dep in self.dependencies.values():
            if len(dep.cpp_info.bindirs) > 0:
                copy(self, "*.so", dep.cpp_info.bindirs[0], "lib")
        
        tc = CMakeToolchain(self)
        if self.options.LLA_BUILD_NFC:
            tc.variables['LLA_BUILD_NFC'] = True
        else:
            tc.variables['LLA_BUILD_NFC'] = False
        
        tc.generate()
        
        deps = CMakeDeps(self)
        deps.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()
	
    def package_info(self):
        pass
