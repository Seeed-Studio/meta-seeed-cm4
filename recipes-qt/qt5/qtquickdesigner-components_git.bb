LICENSE = "GPL-3.0 | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = " \
    file://LICENSE.GPL3;md5=d32239bcb673463ab874e80d47fae504 \
"

include recipes-qt/qt5/qt5-git.inc
include recipes-qt/qt5/qt5.inc

QT_GIT_PROJECT = "qt-labs"
QT_MODULE_BRANCH = "dev"

DEPENDS += "qtbase qtdeclarative qtquickcontrols2"

SRCREV = "f6c319620574b3f99960f2a8d84b47b678d8f1ba"

FILES_${PN} += "${libdir}/*"
