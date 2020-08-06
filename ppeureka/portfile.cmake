# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
#vcpkg_download_distfile(ARCHIVE
#    URLS "file://D:/svn/9/ppeureka.zip"
#    FILENAME "ppeureka.zip"
#    SHA512 af13fdbeade99a5868c215626bfcb4243d37ff403d16765a34a97278229c64d5dfceab33a5fa2fd8dbdeaaea5e567e8d02a05d49eddd6d5ffbc889064be14e44
#)

#message(STATUS "Begin to extract files ...")
#vcpkg_extract_source_archive_ex(
#    OUT_SOURCE_PATH SOURCE_PATH
#    ARCHIVE "${ARCHIVE}"
#)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO shadowxiali/ppeureka
    REF 0.0.1
    SHA512 14570f99862c13e5d4c6f066b35c8a0cf96843890725ad9b2a5310e66c81efa4b76cf50711b7893ab2c7ae819aa3f1d59b6a5414e70ca6b2fa8ec74fb0fc830b
    HEAD_REF master
)
 
message(STATUS "CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE}")

message(STATUS "")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH cmake)

file(INSTALL ${SOURCE_PATH}/LICENSE_1_0.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
