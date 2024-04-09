include recipes-core/images/core-image-base.bb

IMAGE_FEATURES:append = " \
	ssh-server-dropbear \
	"

IMAGE_INSTALL:append = " \
	kernel-modules \
	seeed-linux-dtoverlays \
	i2c-tools \
	python3-pip \
	spidev-test \
	"

