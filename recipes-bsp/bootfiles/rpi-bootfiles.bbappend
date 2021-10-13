do_deploy:append() {
	wget https://datasheets.raspberrypi.org/cmio/dt-blob-disp1-cam2.bin -O ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/dt-blob.bin
}
