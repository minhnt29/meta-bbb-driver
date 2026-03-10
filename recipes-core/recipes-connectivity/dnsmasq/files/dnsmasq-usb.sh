#!/bin/sh

USB_IF=usb0
TIMEOUT=10
IP_ADDR=192.168.7.2/24

echo "Waiting for ${USB_IF}..."

while [ $TIMEOUT -gt 0 ]; do
    if ip link show ${USB_IF} >/dev/null 2>&1; then
        break
    fi
    sleep 1
    TIMEOUT=$((TIMEOUT - 1))
done

if ! ip link show ${USB_IF} >/dev/null 2>&1; then
    echo "ERROR: ${USB_IF} not found"
    exit 1
fi

ip link set usb0 up
ip addr flush dev usb0
ip addr add $IP_ADDR dev usb0

echo "${USB_IF} ready, starting dnsmasq"

exec /usr/bin/dnsmasq \
    --no-daemon \
    --conf-dir=/etc/dnsmasq.d \
    --local-service
