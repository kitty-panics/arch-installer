#!/usr/bin/env bash

#
# second.sh
#

# Export the package list of installed base groups
pacman -Q > /root/base-group.log

Set_Time_Zone() {
    PInfo "r" "=> Set time zone."
    PInfo "g" "=> Please select the time zone to set (Enter key continues)."
    read -r PAUSE
    touch /etc/localtime.bak
    ln -sf /usr/share/zoneinfo/"$(tzselect)" /etc/localtime
    #timedatectl set-ntp true
    hwclock --systohc
}
Set_Time_Zone

Set_Localization() {
    PInfo "r" "=> Generate the needed locales."
    PInfo "g" "=> \"locale.gen\" file will be edited (Enter key continues)."
    read -r PAUSE
    cp /etc/locale.gen /etc/locale.gen.bak
    vi /etc/locale.gen
    locale-gen

    PInfo "r" "=> Setting the system locale."
    PInfo "g" "=> Default value is LANG=en_US.UTF-8"
    touch /etc/locale.conf.bak
    echo -e "LANG=en_US.UTF-8" > /etc/locale.conf

    PInfo "r" "=> Set the keyboard layout and font."
    PInfo "g" "=> Default Value is KEYMAP=us FONT=sun12x22"
    touch /etc/vconsole.conf.bak
    echo -e "KEYMAP=us\nFONT=sun12x22" > /etc/vconsole.conf
}
Set_Localization

Network_Configuration() {
    PInfo "r" "=> Set the hostname."
    PInfo "g" "=> Please enter the hostname (Direct input):"
    read -r HOST_NAME
    touch /etc/hostname.bak
    echo -e "$HOST_NAME" > /etc/hostname

    PInfo "r" "=> Configure the hosts file."
    cp /etc/hosts /etc/hosts.bak
    echo -e "127.0.0.1 localhost\\n::1       localhost\\n127.0.1.1 $host_Name.localdomain $host_Name" >> /etc/hosts
}
Network_Configuration

Config_Mkinitcpio() {
    PInfo "r" "=> Configure mkinitcpio."
    cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
    sed -i "s/^FILES=()$/FILES=(\/boot\/Key4Boot \/boot\/Key4Root)/" /etc/mkinitcpio.conf
    sed -i "s/^HOOKS=(.*$/HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)/" /etc/mkinitcpio.conf
    mkinitcpio -P
}
Config_Mkinitcpio

User_Management() {
    PInfo "r" "=> Set a password for the Root."
    PInfo "g" "=> Please set a password for the Root (Direct input):"
    passwd

    pacman -S --noconfirm zsh
    PInfo "r" "=> Create a new user."
    PInfo "g" "=> Please create a new user name (Direct input):"
    read -r ADD_USER_NAME
    useradd -m -g users -G wheel -s /usr/bin/zsh "$ADD_USER_NAME"

    PInfo "r" "=> Set a password for the new user."
    PInfo "g" "=> Please set a password for the new user (Direct input):"
    passwd "$ADD_USER_NAME"

    pacman -S --noconfirm sudo
    PInfo "r" "=> Enable sudo for new users."
    PInfo "g" "=> \"sudoers\" file will be edited (Enter key continues)."
    read -r PAUSE
    cp /etc/sudoers /etc/sudoers.bak
    EDITOR=vi visudo
}
User_Management

Install_Bootloader() {
    PInfo "r" "=> Install bootloader."
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
