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

# 导出已安装的 base 组的包列表
pacman -Q > /root/base-group.log

set_Time_Zone() {
    echo -e "$red >>>>> Set time zone. $reset"
    echo -e "$green =>> Please select the time zone to set $reset$yellow(Enter key continues). $reset"
    read -r temp_time_zone
    ln -sf /usr/share/zoneinfo/"$(tzselect)" /etc/localtime
    hwclock --systohc
}
set_Time_Zone

set_Localization() {
    echo -e "$red >>>>> Generate the needed locales. $reset"
    echo -e "$green =>> \"locale.gen\" file will be edited $reset$yellow(Enter key continues). $reset"
    read -r temp_localization
    vi /etc/locale.gen
    locale-gen

    echo -e "$red >>>>> Setting the system locale. $reset"
    echo -e "$green =>> Default value is$reset$yellow LANG=en_US.UTF-8 $reset"
    echo -e "LANG=en_US.UTF-8" > /etc/locale.conf

    echo -e "$red >>>>> Set the keyboard layout and font. $reset"
    echo -e "$green =>> Default Value is$reset$yellow KEYMAP=us FONT=sun12x22 $reset"
    echo -e "KEYMAP=us\nFONT=sun12x22" > /etc/vconsole.conf
}
set_Localization

network_Configuration() {
    echo -e "$red >>>>> Set the hostname. $reset"
    echo -e "$green =>> Please enter the hostname $reset$yellow(Direct input): $reset"
    read -r host_Name
    echo -e "$host_Name" > /etc/hostname

    echo -e "$red >>>>> Configure the hosts file. $reset"
    echo -e "127.0.0.1 localhost\\n::1       localhost\\n127.0.1.1 $host_Name.localdomain $host_Name" >> /etc/hosts
}
network_Configuration

configure_Mkinitcpio() {
    echo -e "$red >>>>> Configure mkinitcpio. $reset"
    sed -i "s/^FILES=()$/FILES=(\/boot\/KeyFile4Boot \/boot\/KeyFile4Root)/" /etc/mkinitcpio.conf
    sed -i "s/^HOOKS=(.*$/HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)/" /etc/mkinitcpio.conf
    mkinitcpio -p linux
}
configure_Mkinitcpio

user_Management() {
    echo -e "$red >>>>> Set a password for the Root. $reset"
    echo -e "$green =>> Please set a password for the Root $reset$yellow(Direct input): $reset"
    passwd

    pacman -S --noconfirm zsh
    echo -e "$red >>>>> Create a new user. $reset"
    echo -e "$green =>> Please create a new user name $reset$yellow(Direct input): $reset"
    read -r add_User_Name
    useradd -m -g users -G wheel -s /bin/zsh "$add_User_Name"

    echo -e "$red >>>>> Set a password for the new user. $reset"
    echo -e "$green =>> Please set a password for the new user $reset$yellow(Direct input): $reset"
    passwd "$add_User_Name"

    pacman -S --noconfirm sudo
    echo -e "$red >>>>> Enable sudo for new users. $reset"
    echo -e "$green =>> \"sudoers\" file will be edited $reset$yellow(Enter key continues). $reset"
    read -r temp_sudoers
    EDITOR=vi visudo
}
user_Management

install_Bootloader() {
    echo -e "$red >>>>> Install bootloader. $reset"
    pacman -S --noconfirm grub efibootmgr
    sed -i "s/^.*CMDLINE_LINUX_DEFAULT=\".*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet sysrq_always_enabled=1\"/" /etc/default/grub
    sed -i "s/^.*CMDLINE_LINUX=\"\"$/GRUB_CMDLINE_LINUX=\"root=\/dev\/mapper\/CryptRoot\"/" /etc/default/grub
    sed -i "s/^.*CRYPTODISK=y$/GRUB_ENABLE_CRYPTODISK=y/" /etc/default/grub
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable
    grub-mkconfig -o /boot/grub/grub.cfg
}
install_Bootloader

# 导出基本系统的包列表
pacman -Q > /root/base-system.log

sync
exit
