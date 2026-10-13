FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://0001-fix-string-view-conversion-for-gcc15.patch \
                   file://0002-fix-string-view-conversion-options-cpp-gcc15.patch \
"
