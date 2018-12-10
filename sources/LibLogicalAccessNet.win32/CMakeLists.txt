project(LibLogicalAccessNetWin32)

set(CMAKE_SUPPRESS_REGENERATION true)
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

set(LLA_SWIG_SOURCES liblogicalaccess_reader_wrap.cxx
liblogicalaccess_card_wrap.cxx
liblogicalaccess_data_wrap.cxx
liblogicalaccess_library_wrap.cxx
liblogicalaccess_core_wrap.cxx
liblogicalaccess_iks_wrap.cxx
liblogicalaccess_exception_wrap.cxx)

add_library(LibLogicalAccessNet.win32 SHARED ${LLA_SWIG_SOURCES})
#Enable PDB for release
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi")
set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /DEBUG /OPT:REF /OPT:ICF")
#Enable big obj
target_compile_options(LibLogicalAccessNet.win32 PRIVATE "/bigobj")
target_link_libraries(LibLogicalAccessNet.win32 PUBLIC
CONAN_PKG::LogicalAccessPrivate
CONAN_PKG::LogicalAccessNFC)
