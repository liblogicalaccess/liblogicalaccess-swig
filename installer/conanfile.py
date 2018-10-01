# x64_msvc_debug / x64_msvc_release / x86_msvc_debug / x86_msvc_release
from conans import ConanFile
import os

class LogicalAccessSwigConan(ConanFile):
    name = "LogicalAccessSwig"
    version = "2.1.0"
    requires = 'LogicalAccessPrivate/' + version + '@islog/develop', 'LogicalAccessNFC/' + version + '@islog/develop'
    settings = "build_type", "arch"
    default_options = 'LogicalAccess:LLA_BUILD_PKCS=True','LogicalAccess:LLA_BUILD_IKS=True', 'LogicalAccess:LLA_BUILD_UNITTEST=True', 'LogicalAccess:LLA_BUILD_RFIDEAS=True'

    def imports(self):
        self.copy("bin/*.dll", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("bin/*.exe", keep_path=False, dst="./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        self.copy("lib/*.lib", keep_path=False, dst="./packages/lib/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
        if not os.path.exists("./packages/include"):
            self.copy("include/*.*", dst="./packages")