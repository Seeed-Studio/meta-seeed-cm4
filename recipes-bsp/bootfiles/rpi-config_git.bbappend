# KMS display overlay for the Seeed boards. vc4-kms-v3d-pi4 is the
# BCM2711 (Pi 4 / CM4) variant. On the Pi 5 based boards (reComputer R2x,
# R22) meta-raspberrypi's rpi-config already writes dtoverlay=${VC4DTBO}
# (vc4-kms-v3d), and the firmware's overlay_map resolves both that and
# vc4-kms-v3d-pi4 to vc4-kms-v3d-pi5, so the -pi4 line only applied the
# same overlay a second time. Use vc4-kms-v3d there so the grep guard
# below skips the duplicate.
SEEED_VC4DTBO = "vc4-kms-v3d-pi4"
SEEED_VC4DTBO:raspberrypi5 = "vc4-kms-v3d"

# Board config.txt lines: the board's seeed-linux-dtoverlays overlay and
# the buses and parameters its hardware needs. balena-seeed-cm4 writes the
# same list into the balenaOS config.txt, so a board fix made here reaches
# both images. One config.txt line per space-separated token, written in
# order. Distro choices (KMS overlay, USB mode, which UART gets the console
# and which Bluetooth) stay in each layer's own rpi-config append.
#
# spi0 (GPIO7-11) is left off on R100x: the V1.1 board routes GPIO8-11 to
# UART4 (RS485_3) and its TPM sits on spi1 via the reComputer-R100x
# overlay. On the Pi 5 based boards spi=on has no use either.
#
# R100x without an overlay parameter is the V1.1 wiring (PCA9535 on i2c5,
# i2c0 on GPIO44/45, RS485_1-3 on UART2-4). V1.0 boards need
# "dtoverlay=reComputer-R100x,uart2" instead.
#
# reTerminal touch: the panel driver reports the panel as mounted
# rotated, so DRM/fbcon consumers draw landscape, and the touch controller
# already reports landscape coordinates (verified on hardware 2026-11-27).
# tp_rotate=1 rotates the touch points once more for desktops that apply
# an output transform to touch as well (Raspberry Pi OS bookworm with
# kanshi "transform 270"; the lvgl demo carries the matching patch). Set
# SEEED_RETERMINAL_OVERLAY = "reTerminal" for images that draw landscape
# without such a transform.
SEEED_RETERMINAL_OVERLAY ??= "reTerminal,tp_rotate=1,addr=0x38"

SEEED_BOARD_CONFIG_R100X = "dtparam=i2c_arm=on dtoverlay=reComputer-R100x"
SEEED_BOARD_CONFIG_R110X = "dtparam=spi=on dtparam=i2c_arm=on dtoverlay=reComputer-R110x"
SEEED_BOARD_CONFIG_R2X = "dtoverlay=reComputer-R2x-base"
SEEED_BOARD_CONFIG_R22 = "dtoverlay=reComputer-R22"
SEEED_BOARD_CONFIG_RETERMINAL = "dtparam=spi=on dtoverlay=i2c3,pins_4_5 dtoverlay=${SEEED_RETERMINAL_OVERLAY}"
SEEED_BOARD_CONFIG_RETERMINAL_DM = "dtparam=spi=on dtoverlay=reTerminal-DM dtparam=i2c_vc=on dtoverlay=i2c3,pins_4_5 dtparam=i2s=on"
SEEED_BOARD_CONFIG_REROUTER = "dtparam=spi=on"

SEEED_BOARD_CONFIG ?= ""
SEEED_BOARD_CONFIG:seeed-recomputer-r100x = "${SEEED_BOARD_CONFIG_R100X}"
SEEED_BOARD_CONFIG:seeed-recomputer-r100x-mender = "${SEEED_BOARD_CONFIG_R100X}"
SEEED_BOARD_CONFIG:seeed-recomputer-r110x = "${SEEED_BOARD_CONFIG_R110X}"
SEEED_BOARD_CONFIG:seeed-recomputer-r110x-mender = "${SEEED_BOARD_CONFIG_R110X}"
SEEED_BOARD_CONFIG:seeed-recomputer-r2x = "${SEEED_BOARD_CONFIG_R2X}"
SEEED_BOARD_CONFIG:seeed-recomputer-r2x-mender = "${SEEED_BOARD_CONFIG_R2X}"
SEEED_BOARD_CONFIG:seeed-recomputer-r22 = "${SEEED_BOARD_CONFIG_R22}"
SEEED_BOARD_CONFIG:seeed-recomputer-r22-mender = "${SEEED_BOARD_CONFIG_R22}"
SEEED_BOARD_CONFIG:seeed-reterminal = "${SEEED_BOARD_CONFIG_RETERMINAL}"
SEEED_BOARD_CONFIG:seeed-reterminal-mender = "${SEEED_BOARD_CONFIG_RETERMINAL}"
SEEED_BOARD_CONFIG:seeed-reterminal-dm = "${SEEED_BOARD_CONFIG_RETERMINAL_DM}"
SEEED_BOARD_CONFIG:seeed-reterminal-dm-mender = "${SEEED_BOARD_CONFIG_RETERMINAL_DM}"
SEEED_BOARD_CONFIG:seeed-rerouter-cm4 = "${SEEED_BOARD_CONFIG_REROUTER}"
SEEED_BOARD_CONFIG:seeed-rerouter-cm4-mender = "${SEEED_BOARD_CONFIG_REROUTER}"

do_deploy:append() {
    # meta-balena branch: under balenaOS, meta-balena-raspberrypi's own
    # rpi-config append owns config.txt for these machines; writing our
    # lines as well would apply the same overlays twice (e.g. both
    # dtoverlay=reComputer-R100x and its r100x-v11 alias) and cause
    # pinctrl/i2c conflicts. Skip everything when the balena layer set is
    # present. Guarded with a block instead of an early return so appends
    # from higher-priority layers still run afterwards.
    if ${@bb.utils.contains('BBFILE_COLLECTIONS', 'balena-common', 'false', 'true', d)}; then
    CONFIG=${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    grep -q "^dtoverlay=${SEEED_VC4DTBO}$" $CONFIG || echo "dtoverlay=${SEEED_VC4DTBO}" >> $CONFIG
    grep -q "^dtoverlay=dwc2,dr_mode=host$" $CONFIG || echo "dtoverlay=dwc2,dr_mode=host" >> $CONFIG
    grep -q "^enable_uart=1$" $CONFIG || echo "enable_uart=1" >> $CONFIG

    if [ -z "${SEEED_BOARD_CONFIG}" ]; then
        bbdebug 1 "No SEEED_BOARD_CONFIG for ${MACHINE}, check your MACHINE config"
    fi
    for line in ${SEEED_BOARD_CONFIG}; do
        grep -qxF "$line" $CONFIG || echo "$line" >> $CONFIG
    done
    fi
}
