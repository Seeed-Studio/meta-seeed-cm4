# Override SRCREV to use latest commit from rpi-6.12.y branch
# This fixes the issue where the original recipe references a non-existent commit

# Use AUTOREV to always get the latest commit from the branch
SRCREV_machine = "${AUTOREV}"

# Also use AUTOREV for meta to ensure compatibility
SRCREV_meta = "${AUTOREV}"

# Skip kernel version sanity check since we're using AUTOREV
# This allows us to use the latest kernel without version mismatch errors
KERNEL_VERSION_SANITY_SKIP = "1"

# Set warning only for dangling features to avoid build failures
# This allows the build to continue even if some kernel config features are missing
KERNEL_DANGLING_FEATURES_WARN_ONLY = "1"

# Alternatively, you can update the kernel version to match the latest
# LINUX_VERSION = "6.12.41"
