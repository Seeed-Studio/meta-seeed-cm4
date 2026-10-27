FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://dt-blob-disp1-cam2.bin"

# Vendored from https://datasheets.raspberrypi.org/cmio/dt-blob-disp1-cam2.bin
# (recovered via cleverca22/rptl-datasheets, md5 97ea1d8a91093eb4920cd51c70b242ee)
# because the old URL now 404s after the datasheets site migration. Shipping the
# blob in-layer removes the deploy-time network dependency entirely.
do_deploy:append() {
	install -m 0644 ${UNPACKDIR}/dt-blob-disp1-cam2.bin ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/dt-blob.bin
}
