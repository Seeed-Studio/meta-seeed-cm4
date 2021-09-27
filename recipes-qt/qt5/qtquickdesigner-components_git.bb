LICENSE = "GPL-3.0 | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = " \
    file://LICENSE.GPL3;md5=d32239bcb673463ab874e80d47fae504 \
"

include recipes-qt/qt5/qt5-git.inc
include recipes-qt/qt5/qt5.inc

QT_GIT_PROJECT = "qt-labs"
QT_MODULE_BRANCH = "dev"

DEPENDS += "qtbase qtdeclarative qtquickcontrols2"

SRCREV = "6b97f7b0ac5083b1ed96a412a15b5be4faa43023"

FILES_${PN} += "${libdir}/*"
