from conans import ConanFile, CMake, tools
from conans.errors import ConanException
import os

class LLASwig(ConanFile):
    name = "LogicalAccessSwig"
    version = "2.4.0"
    license = "LGPL"
    url = "https://github.com/islog/liblogicalaccess-swig"
    description = "SWIG wrapper for LibLogicalAccess"
    settings = "os", "compiler", "build_type", "arch"
    options = { 'LLA_BUILD_PRIVATE': [True, False],
                'LLA_BUILD_NFC': [True, False],
                'LLA_BUILD_RFIDEAS': [True, False]}
    default_options = 'LLA_BUILD_PRIVATE=False', 'LLA_BUILD_NFC=True', 'LLA_BUILD_RFIDEAS=True'
    generators = "cmake"
    revision_mode = "scm"

    def requirements(self):
        try:
            if self.options.LLA_BUILD_PRIVATE:
                self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + self.channel)
            if self.options.LLA_BUILD_NFC:
                self.requires('LogicalAccessNFC/' + self.version + '@islog/' + self.channel)
            else:
                self.requires('LogicalAccess/'+ self.version)
        except ConanException:
            if self.options.LLA_BUILD_PRIVATE:
                self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + tools.Git().get_branch())
            #self.requires('LogicalAccessNFC/' + self.version + '@islog/' + tools.Git().get_branch())

    
    def configure(self):
        if self.settings.os == 'Windows' and self.options.LLA_BUILD_RFIDEAS:
            self.options['LogicalAccess'].LLA_BUILD_RFIDEAS = True
    
    def configure_cmake(self):
        cmake = CMake(self, build_type=self.settings.build_type)
        if self.options.LLA_BUILD_PRIVATE:
            cmake.definitions['LLA_BUILD_PRIVATE'] = True
        else:
            cmake.definitions['LLA_BUILD_PRIVATE'] = False

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
