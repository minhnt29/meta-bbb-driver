FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += ""

# Include custom BBB overlay in kernel-devicetree package and deploy/images output.
KERNEL_DEVICETREE:append = " ti/omap/BB-I2C2-AHT30.dtbo"
