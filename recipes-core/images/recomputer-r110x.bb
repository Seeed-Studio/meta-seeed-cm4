include recipes-core/images/rpi-test-image.bb

SPLASH = "psplash-raspberrypi"

IMAGE_FEATURES:append = " \
	ssh-server-dropbear \
	splash \
	"

IMAGE_INSTALL:append = " \
	kernel-modules \
	seeed-linux-dtoverlays \
	iperf3 \
	i2c-tools \
	util-linux \
	e2fsprogs-resize2fs \
	parted \
	glibc \
	python3-pip \
	spidev-test \
	"

