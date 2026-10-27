# Set root password for core-image-base
# This bbappend adds SSH access with default password "seeed"

# Function to set root password
set_root_passwd() {
    echo 'root:seeed' | chpasswd -R ${IMAGE_ROOTFS}
}

# Add the function to the post-process commands
ROOTFS_POSTPROCESS_COMMAND:append = " set_root_passwd; "

IMAGE_FEATURES:append = " \
	ssh-server-dropbear \
	"

IMAGE_INSTALL:append = " \
	kernel-modules \
	sudo wget nano \
	net-tools i2c-tools \
  "

IMAGE_INSTALL:append:dual-gbe-cm4 = "kernel-module-lan7800"
IMAGE_INSTALL:append:dual-gbe-cm4-mender = "kernel-module-lan7800"
