do_deploy:append() {
    CONFIG=${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    grep -q "^dtoverlay=vc4-kms-v3d-pi4$" $CONFIG || echo "dtoverlay=vc4-kms-v3d-pi4" >> $CONFIG
    grep -q "^dtoverlay=dwc2,dr_mode=host$" $CONFIG || echo "dtoverlay=dwc2,dr_mode=host" >> $CONFIG
    grep -q "^enable_uart=1$" $CONFIG || echo "enable_uart=1" >> $CONFIG

    # SPI0 (GPIO8-11) is V1.0 R100x wiring; V1.1 boards use SPI1 via the
    # reComputer-R100x overlay and wire GPIO8-11 to UART4 (RS485_3), so
    # enabling spi0 there only produces a pinctrl conflict.
    if ! ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r2x', 'true', 'false', d)} \
        && ! ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r2x-mender', 'true', 'false', d)} \
        && ! ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r22-mender', 'true', 'false', d)} \
        && ! ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x', 'true', 'false', d)} \
        && ! ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x-mender', 'true', 'false', d)} ; then
        grep -q "^dtparam=spi=on$" $CONFIG || echo "dtparam=spi=on" >> $CONFIG
    fi
    
    if ${@bb.utils.contains('MACHINE', 'seeed-reterminal-DM', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-reterminal-DM-mender', 'true', 'false', d)}; then
        grep -q "^dtoverlay=reTerminal-DM$" $CONFIG || echo "dtoverlay=reTerminal-DM" >> $CONFIG
        grep -q "^dtparam=i2c_vc=on$" $CONFIG || echo "dtparam=i2c_vc=on" >> $CONFIG
        grep -q "^dtoverlay=i2c3,pins_4_5$" $CONFIG || echo "dtoverlay=i2c3,pins_4_5" >> $CONFIG
        grep -q "^dtparam=i2s=on$" $CONFIG || echo "dtparam=i2s=on" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-reterminal', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-reterminal-mender', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'dual-gbe-cm4', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'dual-gbe-cm4-mender', 'true', 'false', d)}; then
        grep -q "^dtoverlay=i2c3,pins_4_5$" $CONFIG || echo "dtoverlay=i2c3,pins_4_5" >> $CONFIG
        grep -q "^dtparam=i2c_vc=on$" $CONFIG || echo "dtparam=i2c_vc=on" >> $CONFIG
        grep -q "^dtoverlay=reTerminal,tp_rotate=1,addr=0x38$" $CONFIG || echo "dtoverlay=reTerminal,tp_rotate=1,addr=0x38" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x-mender', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x', 'true', 'false', d)}; then
        grep -q "^dtparam=i2c_arm=on$" $CONFIG || echo "dtparam=i2c_arm=on" >> $CONFIG
        grep -q "^dtoverlay=i2c1,pins_44_45$" $CONFIG || echo "dtoverlay=i2c1,pins_44_45" >> $CONFIG
        grep -q "^dtoverlay=i2c6,pins_22_23$" $CONFIG || echo "dtoverlay=i2c6,pins_22_23" >> $CONFIG
        # V1.0 wired an analog speaker to GPIO18/19 (audio PWM); V1.1 dropped
        # the speaker and moved GPIO18/19 to SPI1 (TPM CE0 / MISO). Keeping the
        # audio remap would let snd_bcm2835 steal the SPI1 pins whenever the
        # audio driver loads, silently breaking the TPM bus.
        # V1.1 boards wire the pca9535 expander to i2c5 (GPIO12/13). Without a
        # parameter the reComputer-R100x overlay enables i2c5 and places the
        # expander there. The legacy ",uart2" parameter is the V1.0 wiring: it
        # retargets the expander to i2c3 (GPIO2/3), which V1.1 boards leave
        # unconnected - the expander probe then fails with -5 and the whole
        # deferred island (vdd_out, eeprom, LEDs, buzzer, RS485/4G enables)
        # never comes up. Verified on r100x V1.1 hardware: with this line the
        # pca953x driver probes 5-0021 at ~3.2s and all consumers bind.
        # V1.0 boards need "dtoverlay=reComputer-R100x,uart2" instead.
        grep -q "^dtoverlay=reComputer-R100x$" $CONFIG || echo "dtoverlay=reComputer-R100x" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r110x-mender', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r110x', 'true', 'false', d)}; then
        grep -q "^dtparam=i2c_arm=on$" $CONFIG || echo "dtparam=i2c_arm=on" >> $CONFIG
        grep -q "^dtoverlay=reComputer-R110x$" $CONFIG || echo "dtoverlay=reComputer-R110x" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r2x', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r2x-mender', 'true', 'false', d)} ; then
        grep -q "^dtoverlay=reComputer-R2x-base$" $CONFIG || echo "dtoverlay=reComputer-R2x-base" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r22', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r22-mender', 'true', 'false', d)} ; then
        grep -q "^dtoverlay=reComputer-R22$" $CONFIG || echo "dtoverlay=reComputer-R22" >> $CONFIG
    else
        bbdebug 1 "No target device tree specified, check your MACHINE config"
    fi
}
