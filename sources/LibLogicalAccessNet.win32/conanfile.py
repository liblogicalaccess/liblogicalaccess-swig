from conans import ConanFile, CMake, tools
import os

class LLASwig(ConanFile):
    name = "LogicalAccessSwig"
    version = "2.1.0"
    license = "<Put the package license here>"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "<Description of LLA here>"
    settings = "os", "compiler", "build_type", "arch"
    requires = 'LogicalAccessPrivate/' + version + '@islog/develop', 'LogicalAccessNFC/' + version + '@islog/develop'
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True','LogicalAccess:LLA_BUILD_IKS=True', 'LogicalAccess:LLA_BUILD_UNITTEST=True', 'LogicalAccess:LLA_BUILD_RFIDEAS=True'
    generators = "cmake"

    def configure(self):
        pass
    
    def configure_cmake(self):
        cmake = CMake(self, toolset='v141')
        cmake.configure()
        return cmake

    def build(self):
        cmake = self.configure_cmake()
        cmake.build()

    def package(self):
        cmake = self.configure_cmake()
        cmake.install()
	
    def package_info(self):
        pass
