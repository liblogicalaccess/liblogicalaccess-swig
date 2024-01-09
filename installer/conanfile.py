from conans import ConanFile, tools
from conans.errors import ConanException
import os

class LogicalAccessSwigConan(ConanFile):
    name = "LogicalAccessSwig"
    version = "3.0.0"
    settings = "build_type", "arch", "os"
    options = { 'LLA_BUILD_NFC': [True, False],
                'LLA_BUILD_UNITTEST': [True, False]}
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True', 'LLA_BUILD_NFC=True'
    revision_mode = "scm"
    
    def configure(self):
        self.options['LogicalAccess'].LLA_BUILD_UNITTEST = self.options.LLA_BUILD_UNITTEST
    
    def requirements(self):
        if self.options.LLA_BUILD_NFC:
            self.requires('LogicalAccessNFC/' + self.version)
        else:
            self.requires('LogicalAccess/' + self.version)
    
    def imports(self):
        self.copy("bin/*.dll", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("bin/*.exe", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("lib/*.lib", keep_path=False, dst="./packages/lib/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        
        self.copy("lib/*.so*", keep_path=False, dst="./packages/dll/")
        
        if not os.path.exists("./packages/include"):
            self.copy("include/*.*", dst="./packages")
