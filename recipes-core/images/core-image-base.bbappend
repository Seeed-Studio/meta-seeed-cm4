IMAGE_FEATURES:append = " \
	ssh-server-dropbear \
	"

IMAGE_INSTALL:append = " \
	i2c-tools \
	iperf3 \
    	v4l2-test-git \
    	"

IMAGE_INSTALL:append:dual-gbe-cm4 = "kernel-module-lan7800"
IMAGE_INSTALL:append:dual-gbe-cm4-mender = "kernel-module-lan7800"
