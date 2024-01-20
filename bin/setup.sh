#!/usr/bin/env bash
#
# setup.sh
# @Version: v1.0.5

# Defining variables.

# This color requires special attention from the user.
green='\033[32m'
# This color is used to display the process of script execution.
red='\033[31m'
# This color is used to display additional information.
yellow='\033[33m'
# Color End Flag.
reset='\033[0m'

# second.sh URL
SECOND_SH="https://raw.githubusercontent.com/kitty-panics/arch-installer/master/bin/second.sh"

Set_Console_Fonts() {
    setfont sun12x22
    echo -e "$red >>>>> Set temporary console fonts. $reset"
}
Set_Console_Fonts

Show_Suggestions() {
    echo -e "$red >>>>> Show important suggestions. $reset"
    echo -e "$green \n =>> Please read the following carefully:\n $reset"
    echo -e "$yellow ######################################################################### $reset"
    echo -e "$yellow * Ensure the equipment is in a high-speed and stable network environment. $reset"
    echo -e "$yellow * Ensure that important files in the equipment are backed up.             $reset"
    echo -e "$yellow ######################################################################### $reset"
    echo -e "$yellow * There must be two blank disks.                                          $reset"
    echo -e "$yellow =>> One as the primary disk, at least 30G of space.                       $reset"
    echo -e "$yellow =>> One as the second disk , must be a USB with at least 8G of space.     $reset"
    echo -e "$yellow #########################################################################\\n $reset"

    echo -e "$green =>> Do you want to continue?$reset$yellow Yes(any)/No(n) $reset"
    read -r YES_NO
    if [ "$YES_NO" == "n" ]; then
        echo -e "$red >>>>> Installation script has quit. $reset"
        exit
    fi
}
Show_Suggestions

Update_System_Clock() {
    echo -e "$red >>>>> Update the system clock. $reset"
    timedatectl set-ntp true
}
Update_System_Clock

Partition_Disk() {
    echo -e "$red >>>>> Partition the disks $reset"
    parted -s --align optimal /dev/"$2" mklabel gpt
    parted -s --align optimal /dev/"$2" mkpart primary 0% 1G # /dev/"$2"1 (1G, EFI)
    parted -s --align optimal /dev/"$2" mkpart primary 1G 2G # /dev/"$2"2 (1G, BOOT)

    echo -e "$red >>>>> Encrypt the second disks $reset$yellow(Follow the prompts to enter the password). $reset"
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
    echo -e "$red >>>>> Format the partitions. $reset"
    mkfs.fat -F 32 /dev/"$2"1
    mkfs.xfs /dev/mapper/BOOT
    mkfs.xfs /dev/mapper/ROOT
}

Mount_Disk(){
    echo -e "$red >>>>> Mount the filesystems. $reset"
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
echo -e "$red >>>>> Please select a disk. $reset"
lsblk -f
# 选择磁盘
echo -e "$green =>> Enter the primary disk device name $reset$yellow(Direct input): $reset"
read -r primary_Disk
echo -e "$green =>> Enter the second disk device name $reset$yellow(Direct input): $reset"
read -r second_Disk
Partition_Disk "$primary_Disk" "$second_Disk"
Format_Disk    "$primary_Disk" "$second_Disk"
Mount_Disk     "$primary_Disk" "$second_Disk"

Installation_System() {
    echo -e "$red >>>>> Select the mirrors. $reset"
    echo -e "$green =>> \"mirrorlist\" file will be edited $reset$yellow(Enter key continues). $reset"
    read -r PAUSE
    vim /etc/pacman.d/mirrorlist

    echo -e "$red >>>>> Install the base group. $reset"
    pacstrap -K /mnt base linux linux-firmware xfsprogs dhcpcd vi
}
Installation_System

Configure_The_System() {
    echo -e "$red >>>>> Generate an fstab file. $reset"
    genfstab -U /mnt >> /mnt/etc/fstab

    # 在 initramfs 解密
    cp -rf /mnt/etc/crypttab /mnt/etc/crypttab.initramfs
    echo -e "  BOOT    UUID=$(lsblk -f | grep "$second_Disk"2  | awk '{print $3}')    /boot/BOOT" >> /mnt/etc/crypttab.initramfs
    echo -e "  ROOT    UUID=$(lsblk -f | grep "$primary_Disk"  | awk '{print $3}')    /boot/ROOT" >> /mnt/etc/crypttab.initramfs
    chmod 600 /mnt/boot/initramfs-linux*

    echo -e "$red >>>>> Change root into the new system. $reset"
    curl -sL "$SECOND_SH" -o /mnt/root/second.sh
    chmod +x /mnt/root/second.sh
    sync
    arch-chroot /mnt /root/second.sh
    rm -rf /mnt/root/second.sh
}
Configure_The_System

echo -e "$red >>>>> Installation completed. $reset"
sync
umount -R /mnt
cryptsetup -v close BOOT
cryptsetup -v close ROOT
exit
