# Set root password for core-image-minimal
# This bbappend adds SSH access with default password "seeed"

# Function to set root password
set_root_passwd() {
    echo 'root:seeed' | chpasswd -R ${IMAGE_ROOTFS}
}

# Add the function to the post-process commands
ROOTFS_POSTPROCESS_COMMAND:append = " set_root_passwd; "
