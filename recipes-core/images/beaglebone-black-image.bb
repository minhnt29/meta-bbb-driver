SUMMARY = "Custom image for BeagleBone Black with UART console and USB Ethernet"
LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    kernel-module-spidev \
    usb-gadget \
    dnsmasq \
    systemd-serialgetty \
    iproute2 \
    openssh \
    openssh-sshd \
    openssh-sftp-server \
    nano \
    libstdc++ \
    gdbserver \
"

KERNEL_MODULE_AUTOLOAD += "spidev"

IMAGE_FEATURES += "allow-root-login"

