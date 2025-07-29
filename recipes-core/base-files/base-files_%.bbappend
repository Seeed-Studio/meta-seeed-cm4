do_install:append() {
    sed -i 's/^\[ "\$HOME" != "[^"]*" \] || //g' ${D}${sysconfdir}/profile
}
