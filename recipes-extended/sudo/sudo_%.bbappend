do_install:append() {
    CONFIG="${D}${sysconfdir}/sudoers"
    grep -q "^recomputer ALL=(ALL) ALL$" $CONFIG || echo "recomputer ALL=(ALL) ALL" >> $CONFIG
}
