#header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tiny-dnn/tiny-dnn
    REF c0f576f5cb7b35893f62127cb7aec18f77a3bcc5
    SHA512 8566e9b99ad64b9132dd4a9441e4502ad7676a7271e70a21e048bc18c7bc748f1611ec3d7f22d97b3edefb55bb1c7106ad68769dde99442bd495fe59cd6c77da
    HEAD_REF master
)

file(COPY ${SOURCE_PATH}/tiny_dnn DESTINATION ${CURRENT_PACKAGES_DIR}/include/)

file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/tiny-dnn)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/tiny-dnn/LICENSE ${CURRENT_PACKAGES_DIR}/share/tiny-dnn/copyright)
