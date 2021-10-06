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
    options = {'LLA_BUILD_PRIVATE': [True, False]}
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True','LogicalAccess:LLA_BUILD_IKS=True', 'LogicalAccess:LLA_BUILD_UNITTEST=True', \
                        'LogicalAccessPrivate:LLA_BUILD_UNITTEST=True', 'LLA_BUILD_PRIVATE=False'
    generators = "cmake"
    revision_mode = "scm"

    def requirements(self):
        try:
            if self.options.LLA_BUILD_PRIVATE:
                self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + self.channel)
            self.requires('LogicalAccessNFC/' + self.version + '@islog/' + self.channel)
        except ConanException:
            if self.options.LLA_BUILD_PRIVATE:
                self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + tools.Git().get_branch())
            self.requires('LogicalAccessNFC/' + self.version + '@islog/' + tools.Git().get_branch())

    
    def configure(self):
        if self.settings.os == 'Windows':
            self.options['LogicalAccess'].LLA_BUILD_RFIDEAS = True
    
    def configure_cmake(self):
        cmake = CMake(self)
		if self.options.LLA_BUILD_PRIVATE:
            cmake.definitions['LLA_BUILD_PRIVATE'] = True
        else:
            cmake.definitions['LLA_BUILD_PRIVATE'] = False
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
