from conans import ConanFile, tools
from conans.errors import ConanException
import os

class LogicalAccessSwigConan(ConanFile):
    name = "LogicalAccessSwig"
    version = "2.4.0"
    settings = "build_type", "arch", "os"
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True','LogicalAccess:LLA_BUILD_IKS=True', 'LogicalAccess:LLA_BUILD_UNITTEST=True', \
                        'LogicalAccessPrivate:LLA_BUILD_UNITTEST=True'
    revision_mode = "scm"
    
    def configure(self):
        if self.settings.os == 'Windows':
            self.options['LogicalAccess'].LLA_BUILD_RFIDEAS = True

    def requirements(self):
        try:
            self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + self.channel)
            self.requires('LogicalAccessNFC/' + self.version + '@islog/' + self.channel)
        except ConanException:
            self.requires('LogicalAccessPrivate/' + self.version + '@islog/' + tools.Git().get_branch())
            self.requires('LogicalAccessNFC/' + self.version + '@islog/' + tools.Git().get_branch())
    
    def imports(self):
        self.copy("bin/*.dll", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("bin/*.exe", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("lib/*.lib", keep_path=False, dst="./packages/lib/" + str(self.settings.arch) + "/" + str(self.settings.build_type))

        self.copy("lib/*.so*", keep_path=False, dst="./packages/dll/")
        
        if not os.path.exists("./packages/include"):
            self.copy("include/*.*", dst="./packages")
