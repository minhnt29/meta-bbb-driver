FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://dnsmasq.service \
    file://dnsmasq-usb.sh \
    file://usb.conf \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "dnsmasq.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

FILES:${PN} += " \
    ${bindir}/dnsmasq-usb.sh \
    ${sysconfdir}/dnsmasq.d/usb.conf \
    ${systemd_system_unitdir}/dnsmasq.service \
"

do_install:append() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/dnsmasq-usb.sh \
        ${D}${bindir}/dnsmasq-usb.sh

    install -d ${D}${sysconfdir}/dnsmasq.d
    install -m 0644 ${WORKDIR}/usb.conf \
        ${D}${sysconfdir}/dnsmasq.d/usb.conf

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/dnsmasq.service \
        ${D}${systemd_system_unitdir}/dnsmasq.service
}

