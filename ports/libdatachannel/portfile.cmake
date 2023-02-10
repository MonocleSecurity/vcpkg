set(PATCHES 0001-fix-for-vcpkg.patch 0002-fix.patch 0003-fix.patch)

if(VCPKG_TARGET_IS_UWP)
    list(APPEND PATCHES uwp-warnings.patch)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO paullouisageneau/libdatachannel
    REF 4df86b6ccbb348731ad4ba1e9045944cc77498bc #v0.18.12
    SHA512 70ab58ae92e915f4bc7b9125648ba1e6bad8c97e4c6ad8e61bd3b12a467cb0008318baafc4ad1f0664f52e1ce71ace1371b1b98b165cb3ee886adb9077b058a9
    HEAD_REF master
    PATCHES
        ${PATCHES}
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        stdcall CAPI_STDCALL
    INVERTED_FEATURES
        ws NO_WEBSOCKET
        srtp NO_MEDIA
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DUSE_SYSTEM_SRTP=ON
        -DUSE_SYSTEM_JUICE=ON
        -DNO_EXAMPLES=ON
        -DNO_TESTS=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME LibDataChannel CONFIG_PATH lib/cmake/LibDataChannel)
vcpkg_fixup_pkgconfig()

file(READ "${CURRENT_PACKAGES_DIR}/share/LibDataChannel/LibDataChannelConfig.cmake" DATACHANNEL_CONFIG)
file(WRITE "${CURRENT_PACKAGES_DIR}/share/LibDataChannel/LibDataChannelConfig.cmake" "
include(CMakeFindDependencyMacro)
find_dependency(Threads)
find_dependency(OpenSSL)
find_dependency(LibJuice)
${DATACHANNEL_CONFIG}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
