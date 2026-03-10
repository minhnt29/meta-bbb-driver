SUMMARY = "USB Ethernet gadget for BeagleBone Black"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://usb-gadget.sh \
    file://usb-gadget.service \
"

S = "${WORKDIR}"

inherit systemd

SYSTEMD_SERVICE:${PN} = "usb-gadget.service"

RDEPENDS:${PN} += "bash systemd"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 usb-gadget.sh ${D}${bindir}/usb-gadget.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 usb-gadget.service ${D}${systemd_system_unitdir}
}

FILES:${PN} += "\
    ${bindir}/usb-gadget.sh \
    ${systemd_system_unitdir}/usb-gadget.service \
"

