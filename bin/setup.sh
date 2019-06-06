#!/bin/bash

# @Author:  Cool-Pan
# @Version: v6.6.1
# @Mail:    ivlioioilvi@gmail.com


# Defining variables.

# This color requires special attention from the user.
green='\033[32m'
# This color is used to display the process of script execution.
red='\033[31m'
# This color is used to display additional information.
yellow='\033[33m'
# Color End Flag.
reset='\033[0m'

set_Console_Fonts() {
    echo -e "$red >>>>> Set temporary console fonts. $reset"
    setfont sun12x22
}
set_Console_Fonts

show_Suggestions() {
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
    read -r my_Choose
    if [ "$my_Choose" = n ]; then
        echo -e "$red >>>>> Installation script has quit. $reset"
        exit
    fi
}
show_Suggestions

update_System_Clock() {
    echo -e "$red >>>>> Update the system clock. $reset"
    timedatectl set-ntp true
}
update_System_Clock

partition_Disk() {
    echo -e "$red >>>>> Partition the disks $reset"
    parted -s --align optimal /dev/"$2" mklabel gpt
    parted -s --align optimal /dev/"$2" mkpart primary 0% 2G
    parted -s --align optimal /dev/"$2" mkpart primary 2G 5G

    echo -e "$red >>>>> Encrypt the second disks $reset$yellow(Follow the prompts to enter the password). $reset"
    # 创建密钥
    dd if=/dev/random of=KeyFile4Boot bs=8192 count=1 status=progress
    dd if=/dev/random of=KeyFile4Root bs=8192 count=1 status=progress
    # 加密磁盘
    cryptsetup -v luksFormat /dev/"$2"2
    cryptsetup -v luksAddKey /dev/"$2"2 KeyFile4Boot
    cryptsetup -v --type luks2 --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 --use-random --verify-passphrase --key-file KeyFile4Root luksFormat /dev/"$1"
    # 打开加密磁盘
    cryptsetup -v --key-file=KeyFile4Boot open /dev/"$2"2 CryptBoot
    cryptsetup -v --key-file=KeyFile4Root open /dev/"$1"  CryptRoot
}

format_Disk() {
    echo -e "$red >>>>> Format the partitions. $reset"
    mkfs.fat -F 32 /dev/"$2"1
    mkfs.xfs /dev/mapper/CryptBoot
    mkfs.xfs /dev/mapper/CryptRoot
}

mount_Disk(){
    echo -e "$red >>>>> Mount the filesystems. $reset"
    # "/" 分区
    mount /dev/mapper/CryptRoot /mnt
    # "/boot" 分区
    mkdir -p /mnt/boot
    mount /dev/mapper/CryptBoot /mnt/boot
    # "/boot/efi" 分区
    mkdir -p /mnt/boot/efi
    mount /dev/"$2"1 /mnt/boot/efi

    # 复制密钥
    cp -rf KeyFile4* /mnt/boot/
    chmod 000 /mnt/boot/KeyFile4*
}

# 磁盘信息
echo -e "$red >>>>> Please select a disk. $reset"
lsblk -f
# 选择磁盘
echo -e "$green =>> Enter the primary disk device name $reset$yellow(Direct input): $reset"
read -r primary_Disk
echo -e "$green =>> Enter the second disk device name $reset$yellow(Direct input): $reset"
read -r second_Disk
partition_Disk "$primary_Disk" "$second_Disk"
format_Disk    "$primary_Disk" "$second_Disk"
mount_Disk     "$primary_Disk" "$second_Disk"

installation_System() {
    echo -e "$red >>>>> Select the mirrors. $reset"
    echo -e "$green =>> \"mirrorlist\" file will be edited $reset$yellow(Enter key continues). $reset"
    read -r temp_mirrorlist
    vim /etc/pacman.d/mirrorlist

    echo -e "$red >>>>> Install the base group. $reset"
    pacstrap /mnt base
}
installation_System

configure_The_System() {
    echo -e "$red >>>>> Generate an fstab file. $reset"
    genfstab -U /mnt >> /mnt/etc/fstab

    # 在 initramfs 解密
    cp -rf /mnt/etc/crypttab /mnt/etc/crypttab.initramfs
    echo -e "  CryptBoot    UUID=$(lsblk -f | grep "$second_Disk"2  | awk '{print $3}')    /boot/KeyFile4Boot" >> /mnt/etc/crypttab.initramfs
    echo -e "  CryptRoot    UUID=$(lsblk -f | grep "$primary_Disk"  | awk '{print $3}')    /boot/KeyFile4Root" >> /mnt/etc/crypttab.initramfs
    chmod 600 /mnt/boot/initramfs-linux*

    echo -e "$red >>>>> Change root into the new system. $reset"
    curl -sL "https://raw.githubusercontent.com/Cool-Pan/arch-installer/master/bin/second.sh" -o /mnt/root/second.sh
    chmod +x /mnt/root/second.sh
    sync
    arch-chroot /mnt /root/second.sh
    rm -rf /mnt/root/second.sh
}
configure_The_System

echo -e "$red >>>>> Installation completed. $reset"
sync
umount -R /mnt
cryptsetup close CryptBoot
cryptsetup close CryptRoot
exit
