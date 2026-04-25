set(VCPKG_TARGET_ARCHITECTURE arm64)
set(VCPKG_CRT_LINKAGE dynamic)

if ((${PORT} MATCHES ".*qt5.*") OR (${PORT} MATCHES "openssl") OR (${PORT} MATCHES "openh264") OR (${PORT} MATCHES "wxwidgets") OR (${PORT} MATCHES "openal") OR (${PORT} MATCHES "librtmp") OR (${PORT} MATCHES "libiconv") OR (${PORT} MATCHES "ffmpeg"))
  set(VCPKG_LIBRARY_LINKAGE dynamic)
else()
  set(VCPKG_LIBRARY_LINKAGE static)
endif()

set(VCPKG_CMAKE_SYSTEM_NAME Linux)
set(VCPKG_FIXUP_ELF_RPATH ON)
