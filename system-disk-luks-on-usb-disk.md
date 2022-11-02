# LUKS on USB disk


## Requirements
- [_] cryptsetup

## Init LUKS USB disk
```
# Detect usb disk
blkid && lsblk
export LUKSDISK=/dev/sdc1
export DISKNAME=black-disk

# Reset disk
wipefs -a $LUKSDISK

# Init LUKS parition
cryptsetup luksFormat ${LUKSDISK}
cryptsetup config ${LUKSDISK} --label luks-${DISKNAME}

# Open previous created LUKS disk
cryptsetup luksOpen /dev/disk/by-label/luks-${DISKNAME} luks-${DISKNAME}

# Create parition
mkfs.ext4 /dev/mapper/luks-${DISKNAME} -L usb-${DISKNAME}

# Mount partition
mkdir -p /mnt/usb-${DISKNAME}
mount /dev/mapper/luks-${DISKNAME} /mnt/usb-${DISKNAME}
```

## Mount/umount LUKS disk
```
# Mount encrypted luks disk
cryptsetup luksOpen /dev/disk/by-label/luks-${DISKNAME} luks-${DISKNAME}
mount /dev/mapper/luks-${DISKNAME} /mnt/usb-${DISKNAME}

# Umount
cryptsetup luksClose luks-${DISKNAME}
```

## Misc
```
# Show opened luks disk
dmsetup ls

# Show luks informations
cryptsetup luksDump ${LUKSDISK}
```
