#!/usr/bin/env bash
#
# second.sh
# @version: v1.0.5

# Defining variables.
#
# This color requires special attention from the user.
green='\033[32m'
# This color is used to display the process of script execution.
red='\033[31m'
# This color is used to display additional information.
yellow='\033[33m'
# Color End Flag.
reset='\033[0m'

# Export the package list of installed base groups
pacman -Q > /root/base-group.log

Set_Time_Zone() {
    echo -e "$red >>>>> Set time zone. $reset"
    echo -e "$green =>> Please select the time zone to set $reset$yellow(Enter key continues). $reset"
    read -r PAUSE
    touch /etc/localtime.bak
    ln -sf /usr/share/zoneinfo/"$(tzselect)" /etc/localtime
    #timedatectl set-ntp true
    hwclock --systohc
}
Set_Time_Zone

Set_Localization() {
    echo -e "$red >>>>> Generate the needed locales. $reset"
    echo -e "$green =>> \"locale.gen\" file will be edited $reset$yellow(Enter key continues). $reset"
    read -r PAUSE
    cp /etc/locale.gen /etc/locale.gen.bak
    vi /etc/locale.gen
    locale-gen

    echo -e "$red >>>>> Setting the system locale. $reset"
    echo -e "$green =>> Default value is$reset$yellow LANG=en_US.UTF-8 $reset"
    touch /etc/locale.conf.bak
    echo -e "LANG=en_US.UTF-8" > /etc/locale.conf

    echo -e "$red >>>>> Set the keyboard layout and font. $reset"
    echo -e "$green =>> Default Value is$reset$yellow KEYMAP=us FONT=sun12x22 $reset"
    touch /etc/vconsole.conf.bak
    echo -e "KEYMAP=us\nFONT=sun12x22" > /etc/vconsole.conf
}
Set_Localization

Network_Configuration() {
    echo -e "$red >>>>> Set the hostname. $reset"
    echo -e "$green =>> Please enter the hostname $reset$yellow(Direct input): $reset"
    read -r HOST_NAME
    touch /etc/hostname.bak
    echo -e "$HOST_NAME" > /etc/hostname

    echo -e "$red >>>>> Configure the hosts file. $reset"
    cp /etc/hosts /etc/hosts.bak
    echo -e "127.0.0.1 localhost\\n::1       localhost\\n127.0.1.1 $host_Name.localdomain $host_Name" >> /etc/hosts
}
Network_Configuration

Config_Mkinitcpio() {
    echo -e "$red >>>>> Configure mkinitcpio. $reset"
    cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
    sed -i "s/^FILES=()$/FILES=(\/boot\/Key4Boot \/boot\/Key4Root)/" /etc/mkinitcpio.conf
    sed -i "s/^HOOKS=(.*$/HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)/" /etc/mkinitcpio.conf
    mkinitcpio -P
}
Config_Mkinitcpio

User_Management() {
    echo -e "$red >>>>> Set a password for the Root. $reset"
    echo -e "$green =>> Please set a password for the Root $reset$yellow(Direct input): $reset"
    passwd

    pacman -S --noconfirm zsh
    echo -e "$red >>>>> Create a new user. $reset"
    echo -e "$green =>> Please create a new user name $reset$yellow(Direct input): $reset"
    read -r ADD_USER_NAME
    useradd -m -g users -G wheel -s /usr/bin/zsh "$ADD_USER_NAME"

    echo -e "$red >>>>> Set a password for the new user. $reset"
    echo -e "$green =>> Please set a password for the new user $reset$yellow(Direct input): $reset"
    passwd "$ADD_USER_NAME"

    pacman -S --noconfirm sudo
    echo -e "$red >>>>> Enable sudo for new users. $reset"
    echo -e "$green =>> \"sudoers\" file will be edited $reset$yellow(Enter key continues). $reset"
    read -r PAUSE
    cp /etc/sudoers /etc/sudoers.bak
    EDITOR=vi visudo
}
User_Management

Install_Bootloader() {
    echo -e "$red >>>>> Install bootloader. $reset"
    pacman -S --noconfirm grub efibootmgr
    cp /etc/default/grub /etc/default/grub.bak
    sed -i "s/^.*CMDLINE_LINUX_DEFAULT=\".*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet sysrq_always_enabled=1\"/" /etc/default/grub
    sed -i "s/^.*CMDLINE_LINUX=\"\"$/GRUB_CMDLINE_LINUX=\"root=\/dev\/mapper\/ROOT\"/" /etc/default/grub
    sed -i "s/^.*CRYPTODISK=y$/GRUB_ENABLE_CRYPTODISK=y/" /etc/default/grub
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --removable
    grub-mkconfig -o /boot/grub/grub.cfg
}
Install_Bootloader

# Export the package list of the base system
pacman -Q > /root/base-system.log

sync
exit
