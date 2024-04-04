#!/usr/bin/env bash

#
# setup.sh
#

# Load plugin
source libs/PInfo.sh

# second.sh url
SECOND_SH="https://raw.githubusercontent.com/kitty-panics/arch-installer/master/bin/second.sh"

Set_Console_Fonts() {
    setfont sun12x22
    PInfo "r" "=> Set temporary console fonts."
}
Set_Console_Fonts

Show_Suggestions() {
    PInfo "r" "=> Show important suggestions."
    PInfo "g" "\n => Please read the following carefully:\n"

    PInfo "y" "#########################################################################  "
    PInfo "y" "* Ensure the equipment is in a high-speed and stable network environment.  "
    PInfo "y" "* Ensure that important files in the equipment are backed up.              "
    PInfo "y" "#########################################################################  "
    PInfo "y" "* There must be two blank disks.                                           "
    PInfo "y" "=> One as the primary disk, at least 30G of space.                         "
    PInfo "y" "=> One as the second disk , must be a USB with at least 8G of space.       "
    PInfo "y" "#########################################################################\n"

    PInfo "g" "=> Do you want to continue? Yes(any)/No(n)"
    read -r YES_NO
    if [ "$YES_NO" == "n" ]; then
        PInfo "r" "=> Installation script has quit."
        exit
    fi
}
Show_Suggestions

Update_System_Clock() {
    PInfo "r" "=> Update the system clock."
    timedatectl set-ntp true
}
Update_System_Clock

Partition_Disk() {
    PInfo "r" "=> Partition the disks"
    parted -s --align optimal /dev/"$2" mklabel gpt
    parted -s --align optimal /dev/"$2" mkpart primary 0% 1G # /dev/"$2"1 (1G, EFI)
    parted -s --align optimal /dev/"$2" mkpart primary 1G 2G # /dev/"$2"2 (1G, BOOT)

    PInfo "r" "=> Encrypt the second disks (Follow the prompts to enter the password)."
    # 创建密钥
    dd if=/dev/random of=BOOT bs=2048 count=1 status=progress
    dd if=/dev/random of=ROOT bs=2048 count=1 status=progress
    # 加密磁盘
    cryptsetup -v --type luks1 luksFormat /dev/"$2"2
    cryptsetup -v luksAddKey /dev/"$2"2 BOOT
    cryptsetup -v --type luks2 --cipher aes-xts-plain64 --key-size 512 --hash sha256 --iter-time 2048 --use-urandom --verify-passphrase --key-file ROOT luksFormat /dev/"$1"
    # 打开加密磁盘
    cryptsetup -v --key-file=BOOT open /dev/"$2"2 BOOT
    cryptsetup -v --key-file=ROOT open /dev/"$1"  ROOT
}

Format_Disk() {
    PInfo "r" "=> Format the partitions."
    mkfs.fat -F 32 /dev/"$2"1
    mkfs.xfs /dev/mapper/BOOT
    mkfs.xfs /dev/mapper/ROOT
}

Mount_Disk(){
    PInfo "r" "=> Mount the filesystems."
    # "/" 分区
    mount /dev/mapper/ROOT /mnt
    # "/boot" 分区
    mkdir -p /mnt/boot/efi
    mount /dev/mapper/BOOT /mnt/boot
    # "/boot/efi" 分区
    mount /dev/"$2"1 /mnt/boot/efi

    # 复制密钥
    cp -rf *OOT /mnt/boot/
    chmod 000 /mnt/boot/*OOT
}

# 磁盘信息
PInfo "r" "=> Please select a disk."
lsblk -f
# 选择磁盘
PInfo "g" "=> Enter the primary disk device name (Direct input):"
read -r primary_Disk
PInfo "g" "=> Enter the second disk device name (Direct input):"
read -r second_Disk
Partition_Disk "$primary_Disk" "$second_Disk"
Format_Disk    "$primary_Disk" "$second_Disk"
Mount_Disk     "$primary_Disk" "$second_Disk"

Installation_System() {
    PInfo "r" "=> Select the mirrors."
    PInfo "g" "=> \"mirrorlist\" file will be edited (Enter key continues)."
    read -r PAUSE
    vim /etc/pacman.d/mirrorlist

    PInfo "r" "=> Install the base group."
    pacstrap -K /mnt base linux linux-firmware xfsprogs dhcpcd vi
}
Installation_System

Configure_The_System() {
    PInfo "r" "=> Generate an fstab file."
    cp /mnt/etc/fstab /mnt/etc/fstab.bak
    genfstab -U /mnt >> /mnt/etc/fstab

    # 在 initramfs 解密
    cp /mnt/etc/crypttab.initramfs /mnt/etc/crypttab.initramfs.bak
    cp -rf /mnt/etc/crypttab /mnt/etc/crypttab.initramfs
    echo -e "  BOOT    UUID=$(lsblk -f | grep "$second_Disk"2  | awk '{print $3}')    /boot/BOOT" >> /mnt/etc/crypttab.initramfs
    echo -e "  ROOT    UUID=$(lsblk -f | grep "$primary_Disk"  | awk '{print $3}')    /boot/ROOT" >> /mnt/etc/crypttab.initramfs
    chmod 600 /mnt/boot/initramfs-linux*

    PInfo "r" "=> Change root into the new system."
    curl -sL "$SECOND_SH" -o /mnt/root/second.sh
    chmod +x /mnt/root/second.sh
    sync
    arch-chroot /mnt /root/second.sh
    rm -rf /mnt/root/second.sh
}
Configure_The_System

PInfo "r" "=> Installation completed."
sync
umount -R /mnt
cryptsetup -v close BOOT
cryptsetup -v close ROOT
exit
