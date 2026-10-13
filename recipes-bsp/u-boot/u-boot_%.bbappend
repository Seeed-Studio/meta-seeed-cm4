FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:rpi = " file://rpi-enable-bootscr.cfg"

# Backport of upstream 8de24e226d7: sdhci_brcmstb_init_2712() must force
# card-present for non-removable/polled hosts. On BCM2712/CM5 (reComputer
# R22) U-Boot 2026.01 otherwise writes SD_PIN_SEL = SD on the eMMC
# controller; the value survives SDHCI resets and wedges Linux's first
# eMMC power-up (races the POWER_ON latch), and the wrong CD routing can
# break U-Boot's own eMMC init depending on the carrier/chip.
SRC_URI:append:rpi = " file://0005-mmc-bcmstb-fix-non-removable-check-in-bcm2712-init.patch"
