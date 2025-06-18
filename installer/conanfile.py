from conan import ConanFile
from conan.errors import ConanException
from conan.tools.files import copy
import os

class LogicalAccessSwigConan(ConanFile):
    name = "logicalaccess-swig"
    version = "3.5.1"
    settings = "build_type", "arch", "os"
    options = { 'LLA_BUILD_NFC': [True, False] }
    default_options = { 'logicalaccess/*:LLA_BUILD_PKCS': True, 'LLA_BUILD_NFC': False }
    revision_mode = "scm"
    
    def requirements(self):
        if self.options.LLA_BUILD_NFC:
            self.requires('logicalaccess-nfc/' + self.version)
        else:
            self.requires('logicalaccess/' + self.version)
    
    def generate(self):
        for dep in self.dependencies.values():
            copy(self, "*.dll", dep.cpp_info.bindirs[0], "./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
            copy(self, "*.exe", dep.cpp_info.bindirs[0], "./packages/dll/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
            copy(self, "*.lib", dep.cpp_info.libdirs[0], "./packages/lib/" + str(self.settings.arch) + "/" + str(self.settings.build_type))
            copy(self, "*.so", dep.cpp_info.bindirs[0], "./packages/dll/")
            if not os.path.exists("./packages/include"):
                copy(self, "*.*", dep.cpp_info.includedirs[0], "./packages/include")
