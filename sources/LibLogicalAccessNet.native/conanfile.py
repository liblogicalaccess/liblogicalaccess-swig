from conans import ConanFile, CMake, tools
from conans.errors import ConanException
import os

class LLASwig(ConanFile):
    name = "LogicalAccessSwig"
    version = "3.0.0"
    license = "LGPL"
    url = "https://github.com/liblogicalaccess/liblogicalaccess-swig"
    description = "SWIG wrapper for LibLogicalAccess"
    settings = "os", "compiler", "build_type", "arch"
    options = { 'LLA_BUILD_NFC': [True, False],
                'LLA_BUILD_UNITTEST': [True, False]}
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True', 'LLA_BUILD_NFC=False', 'LLA_BUILD_UNITTEST=False'
    generators = "cmake"
    revision_mode = "scm"

    def requirements(self):
        if self.options.LLA_BUILD_NFC:
            self.requires('LogicalAccessNFC/' + self.version)
        else:
            self.requires('LogicalAccess/'+ self.version)
    
    def configure(self):
        self.options['LogicalAccess'].LLA_BUILD_UNITTEST = self.options.LLA_BUILD_UNITTEST
        self.options['LogicalAccessPrivate'].LLA_BUILD_UNITTEST = self.options.LLA_BUILD_UNITTEST
    
    def configure_cmake(self):
        cmake = CMake(self, build_type=self.settings.build_type)
        if self.options.LLA_BUILD_NFC:
            cmake.definitions['LLA_BUILD_NFC'] = True
        else:
            cmake.definitions['LLA_BUILD_NFC'] = False            
        cmake.configure()
        return cmake

    def build(self):
        cmake = self.configure_cmake()
        cmake.build()

    def package(self):
        cmake = self.configure_cmake()
        cmake.install()

    def imports(self):
        self.copy("*.so*", "lib", "lib")
	
    def package_info(self):
        pass
