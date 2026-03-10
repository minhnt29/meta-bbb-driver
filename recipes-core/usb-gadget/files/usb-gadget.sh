#!/bin/sh
set -e

modprobe libcomposite || true

G=/sys/kernel/config/usb_gadget/g1

# Cleanup
if [ -d "$G" ]; then
    echo "" > "$G/UDC" || true
    rm -rf "$G"
fi

mkdir -p "$G"

# ===== VID / PID =====
echo 0x045E > "$G/idVendor"
echo 0xF000 > "$G/idProduct"

# RNDIS only (CDC)
echo 0x02 > "$G/bDeviceClass"
echo 0x00 > "$G/bDeviceSubClass"
echo 0x00 > "$G/bDeviceProtocol"

# Strings
mkdir -p "$G/strings/0x409"
echo "0123456789" > "$G/strings/0x409/serialnumber"
echo "BeagleBone" > "$G/strings/0x409/manufacturer"
echo "BeagleBone RNDIS" > "$G/strings/0x409/product"

# Config
mkdir -p "$G/configs/c.1/strings/0x409"
echo "RNDIS" > "$G/configs/c.1/strings/0x409/configuration"

# OS descriptors
mkdir -p "$G/os_desc"
echo 1 > "$G/os_desc/use"
echo 0xcd > "$G/os_desc/b_vendor_code"
echo "MSFT100" > "$G/os_desc/qw_sign"

# RNDIS function
mkdir -p "$G/functions/rndis.usb0"
echo "02:00:00:00:00:01" > "$G/functions/rndis.usb0/host_addr"
echo "02:00:00:00:00:02" > "$G/functions/rndis.usb0/dev_addr"

echo "RNDIS" > "$G/functions/rndis.usb0/os_desc/interface.rndis/compatible_id"
echo "5162001" > "$G/functions/rndis.usb0/os_desc/interface.rndis/sub_compatible_id"

ln -s "$G/functions/rndis.usb0" "$G/configs/c.1/"
ln -s "$G/configs/c.1" "$G/os_desc"

# Bind
UDC=$(ls /sys/class/udc | head -n1)
echo "$UDC" > "$G/UDC"
