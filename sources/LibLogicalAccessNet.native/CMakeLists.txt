cmake_minimum_required(VERSION 3.10)
project(LibLogicalAccessNetNative)

set(CMAKE_SUPPRESS_REGENERATION true)
MESSAGE(STATUS "DIR: ${CMAKE_BINARY_DIR}")

if(LLA_BUILD_NFC)
  find_package(logicalaccess-nfc)
endif()
find_package(logicalaccess)
find_package(nlohmann_json)

set(LLA_SWIG_SOURCES liblogicalaccess_reader_wrap.cxx
liblogicalaccess_card_wrap.cxx
liblogicalaccess_data_wrap.cxx
liblogicalaccess_library_wrap.cxx
liblogicalaccess_core_wrap.cxx
liblogicalaccess_exception_wrap.cxx
liblogicalaccess_crypto_wrap.cxx
lla_std_types_wrap.cxx)

set(TARGET_NAME LibLogicalAccessNet.native)

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

set(LLA_LINK)
if(LLA_BUILD_NFC)
  add_compile_definitions(BUILD_NFC)
  list(APPEND LLA_LINK logicalaccess-nfc::logicalaccess-nfc)
else()
  list(APPEND LLA_LINK logicalaccess::logicalaccess)
endif()

target_link_libraries(${TARGET_NAME} PUBLIC
  ${LLA_LINK})
install(TARGETS ${TARGET_NAME} RUNTIME DESTINATION bin LIBRARY DESTINATION lib)
