from conans import ConanFile, tools
from conans.errors import ConanException
import os

class LogicalAccessSwigConan(ConanFile):
    name = "LogicalAccessSwig"
    version = "2.4.1"
    settings = "build_type", "arch", "os"
    options = { 'LLA_BUILD_PRIVATE': [True, False],
                'LLA_BUILD_NFC': [True, False],
                'LLA_BUILD_RFIDEAS': [True, False]}
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True', 'LogicalAccess:LLA_BUILD_UNITTEST=True', \
                        'LogicalAccessPrivate:LLA_BUILD_UNITTEST=True', 'LLA_BUILD_PRIVATE=True', \
                        'LLA_BUILD_NFC=True', 'LLA_BUILD_RFIDEAS=True'
    revision_mode = "scm"
    
    def configure(self):
        if self.settings.os == 'Windows' and self.options.LLA_BUILD_RFIDEAS:
            self.options['LogicalAccess'].LLA_BUILD_RFIDEAS = True

    def requirements(self):
        try:
            if self.options.LLA_BUILD_PRIVATE:
                self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + self.channel)
            if self.options.LLA_BUILD_NFC:
                self.requires('LogicalAccessNFC/' + self.version + '@islog/' + self.channel)
            else:
                self.requires('LogicalAccess/' + self.version + '@islog/' + self.channel)
        except ConanException:
            if self.options.LLA_BUILD_PRIVATE:
                self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + tools.Git().get_branch())
            if self.options.LLA_BUILD_NFC:
                self.requires('LogicalAccessNFC/' + self.version + '@islog/' + tools.Git().get_branch())
            else:
                self.requires('LogicalAccess/' + self.version + '@islog/' + tools.Git().get_branch())
    
    def imports(self):
        self.copy("bin/*.dll", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("bin/*.exe", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("lib/*.lib", keep_path=False, dst="./packages/lib/" + str(self.settings.arch) + "/" + str(self.settings.build_type))

        self.copy("lib/*.so*", keep_path=False, dst="./packages/dll/")
        
        if not os.path.exists("./packages/include"):
            self.copy("include/*.*", dst="./packages")
