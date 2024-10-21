do_deploy:append() {
    CONFIG=${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    grep -q "^dtoverlay=vc4-kms-v3d-pi4$" $CONFIG || echo "dtoverlay=vc4-kms-v3d-pi4" >> $CONFIG
    grep -q "^dtoverlay=dwc2,dr_mode=host$" $CONFIG || echo "dtoverlay=dwc2,dr_mode=host" >> $CONFIG
    grep -q "^enable_uart=1$" $CONFIG || echo "enable_uart=1" >> $CONFIG
    grep -q "^dtparam=spi=on$" $CONFIG || echo "dtparam=spi=on" >> $CONFIG
    
    if ${@bb.utils.contains('MACHINE', 'seeed-reterminal-plus', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-reterminal-plus-mender', 'true', 'false', d)}; then
        grep -q "^dtoverlay=reTerminal-plus$" $CONFIG || echo "dtoverlay=reTerminal-plus" >> $CONFIG
        grep -q "^dtparam=i2c_vc=on$" $CONFIG || echo "dtparam=i2c_vc=on" >> $CONFIG
        grep -q "^dtoverlay=i2c3,pins_4_5$" $CONFIG || echo "dtoverlay=i2c3,pins_4_5" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-reterminal', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-reterminal-mender', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'dual-gbe-cm4', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'dual-gbe-cm4-mender', 'true', 'false', d)}; then
        grep -q "^dtoverlay=i2c3,pins_4_5$" $CONFIG || echo "dtoverlay=i2c3,pins_4_5" >> $CONFIG
        grep -q "^dtoverlay=reTerminal,tp_rotate=1$" $CONFIG || echo "dtoverlay=reTerminal,tp_rotate=1" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x-mender', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r100x', 'true', 'false', d)}; then
        grep -q "^dtoverlay=reComputer-R100x$" $CONFIG || echo "dtoverlay=reComputer-R100x" >> $CONFIG
    elif ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r110x-mender', 'true', 'false', d)} \
        || ${@bb.utils.contains('MACHINE', 'seeed-recomputer-r110x', 'true', 'false', d)}; then
        grep -q "^dtoverlay=reComputer-R110x$" $CONFIG || echo "dtoverlay=reComputer-R110x" >> $CONFIG
    else
        bbdebug 1 "No target device tree specified, check your MACHINE config"
    fi
}
