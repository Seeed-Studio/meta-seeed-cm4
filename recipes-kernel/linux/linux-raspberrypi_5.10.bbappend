FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://0003-add-reTerminal-dtoverlay-for-yocto.patch \
    "

RPI_KERNEL_DEVICETREE_OVERLAYS_append = " overlays/reTerminal.dtbo"
