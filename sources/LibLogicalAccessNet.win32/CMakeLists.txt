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
liblogicalaccess_exception_wrap.cxx
liblogicalaccess_crypto_wrap.cxx
lla_std_types_wrap.cxx)

if (MSVC)
  set(TARGET_NAME LibLogicalAccessNet.win32)
else()
  set(TARGET_NAME LogicalAccessNetNative)
endif()

add_library(${TARGET_NAME} SHARED ${LLA_SWIG_SOURCES})
if (MSVC)
  #Enable PDB for release
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi")
  set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} /DEBUG /OPT:REF /OPT:ICF")
  #Enable big obj
  target_compile_options(${TARGET_NAME} PRIVATE "/bigobj")
else()
  target_include_directories(${TARGET_NAME} PUBLIC /usr/include/PCSC)
endif()

set(LLA_ADDITIONAL_LINK)
if (LLA_BUILD_PRIVATE)
	add_compile_definitions(BUILD_PRIVATE)
	list(APPEND LLA_ADDITIONAL_LINK CONAN_PKG::LogicalAccessPrivate)
endif()

target_link_libraries(${TARGET_NAME} PUBLIC
  CONAN_PKG::LogicalAccessNFC
  ${LLA_ADDITIONAL_LINK})
install(TARGETS ${TARGET_NAME} RUNTIME DESTINATION bin LIBRARY DESTINATION lib)
