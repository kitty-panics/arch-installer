#!/bin/bash

# @Author:  Cool-Pan
# @Version: v9.0.0
# @Mail:    ivlioioilvi@gmail.com

# This color requires special attention from the user (显示此颜色需要特别注意).
green='\033[32m'
# This color is used to display the process of script execution (用于标示执行过程).
red='\033[31m'
# This color is used to display additional information. (备用颜色)
yellow='\033[33m'
# Color End Flag (结束标志).
reset='\033[0m'

echo -e "$green >>>>> Please enable Multilib and Testing repo. $reset"
echo -e "$green >>>>> \"mirrorlist\" file will be edited.(Enter key continues) $reset"
#echo -e "$green >>>>> 请启用 Multilib 和 Testing 仓库. $reset"
#echo -e "$green >>>>> 将要开始编辑 \"mirrorlist\" 文件.(按下 Enter 键) $reset"
read -r temp_Edit_Mirrorlist
sudo vi /etc/pacman.conf
sudo pacman -Syyuu

echo -e "$red >>>>> Start Install Software (开始安装). $reset"
sudo pacman -S $(echo "

##### Graphical (图形) #####
    # 视频 (显卡)驱动
        # Intel 显卡
        Intel="xf86-video-intel mesa lib32-mesa"
        # NVIDIA 显卡
        Nvidia="nvidia nvidia-utils lib32-nvidia-utils nvidia-settings"
        # Vulkan 3D 图形和计算 API
        Vulkan="vulkan-icd-loader lib32-vulkan-icd-loader vulkan-intel"
    # X Window 系统
        # Xorg 实现
        Xorg_Server="xorg-server xorg-xinit xorg-xhost"
        # 输入设备
        Input_Devices="libinput xf86-input-libinput xorg-xinput"
        # 屏幕管理
        Screen_Management="xorg-xrandr arandr"
        # 背光
        Backlight="light redshift"
    # 桌面环境
        # 桌面
        Desktop_Environment="plasma-desktop"
        # 窗口管理器
        Window_Managers="i3-gaps"
        # 任务栏
        Taskbars="i3blocks"
        # 程序启动器
        Application_Launchers="rofi"
    # 美化
        # 字体
        Fonts="fontconfig ttf-dejavu wqy-zenhei noto-fonts-emoji"
        # 壁纸设置
        Wallpaper_Setters="feh archlinux-wallpaper"
        # 配置 GTK+
        Configuration_GTK="dconf dconf-editor breeze-gtk"
        # 配置 QT5
        Configuration_QT5="qt5ct breeze breeze-icons"
        # 窗口合成
        X_Compositor="compton"


##### Internet (互联网) #####
    # 网络连接
        # 网络管理            ⊢----管理器----⊣      ⊢----无线----⊣   ⊢无线AP⊣
        Network_Managers="networkmanager plasma-nm iw wpa_supplicant hostapd proxychains-ng"
    # Web 浏览器
        # 基于 Gecko
        Gecko_Based="firefox-developer-edition firefox-developer-edition-i18n-zh-cn"
        # 基于 Blink
        Blink_Based="chromium"
        # 浏览器插件
        Browser_Plugins="pepper-flash"
        # 控制台中的浏览器
        Console_Based="w3m imlib2"
    # 文件共享
        # 下载工具
        Download_Managers="aria2 axel wget"
        # BitTorrent 客户端
        BitTorrent_Clients="qbittorrent"
    # 沟通
        # 电子邮件客户端
        Email_Clients="kube kmail"
        # 即时消息客户端
            # IRC 客户端
            IRC_Clients="quassel-monolithic"
    # 新闻, RSS 和博客
        # 新闻聚合
        News_Aggregators="quiterss"
        # 博客引擎
        Blog_Engines="hugo"


##### Multimedia (多媒体) #####
    # 图像
        # 图像查看
        Image_Viewers="vimiv"
        # 图像处理
        Image_Processing="imagemagick"
        # 图像编辑
        Raster_Graphics_Editors="krita"
        # 3D 图形
        3D_Computer_Graphics="blender"
        # 截图
        Screenshot="flameshot"
        # 颜色选择器
        Color_Pickers="kcolorchooser"
    # 音频
        # 声音系统
            # 驱动和接口
            Drivers_And_Interface="alsa-firmware alsa-utils"
            # 声音服务
            Sound_Servers="pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol-qt"
        # 音频播放
        Audio_Players="cmus flac libmad"
        # 音频转换
        Audio_Converters="sox"
        # 音频编辑
        Audio_Editors="audacity"
    # 视频
        # 视频播放
        Video_Players="mpv"
        # 视频转换
        Video_Converters="ffmpeg"
        # 录屏
        Screencast="simplescreenrecorder"
    # 移动设备管理
    Mobile_Device_Managers="android-tools libmtp android-file-transfer kdeconnect"
    # 数字发行平台
    Digital_Distribution="steam"


##### Utilities (实用程序) #####
    # 终端
        # Shell
        Command_Shells="fish"
        # 终端模拟
        Terminal_Emulators="rxvt-unicode urxvt-perls konsole"
        # 终端多路复用
        Terminal_multiplexers="tmux"
    # 文字输入
        # 输入法
        Input_Methods="fcitx fcitx-rime fcitx-gtk3 fcitx-qt5 fcitx-configtool"
    # 磁盘
        # 分区工具
        Partitioning_Tools="parted"
        # 格式化工具
        Formatting_Tools="btrfs-progs dosfstools exfat-utils f2fs-tools nilfs-utils ntfs-3g"
        # 挂载工具
        Mount_Tools="udisks2"
        # 磁盘使用情况显示
        Disk_Usage_Display="ncdu"
        # 磁盘状态分析
        Analyzing_And_Monitoring="hdparm smartmontools gsmartcontrol"
    # 系统
        # 任务管理
        Task_Managers="htop ksystemlog"
        # 系统监视
        System_Monitors="glances conky"
        # 系统信息查看
        System_Information_Viewers="neofetch"
        # 蓝牙管理
        Bluetooth_Management="bluez blueman"
        # 电源管理
        Power_Management="tlp powerdevil"
        # 虚拟化
        Virtualization="virtualbox virtualbox-host-modules-arch virtualbox-guest-iso"
        # Pacman 相关工具
        Pacman_Tools="expac pacutils"
        # 备份工具
        Full_System_Backup="squashfs-tools"
        # 其它
        Others="debootstrap debian-archive-keyring"
    # 数学
        # 计算器
        Calculator="bc calc"


##### Documents (文件) #####
    # 文件管理器
    File_Managers="ranger dolphin"
    # 文件同步
    File_Synchronization="rsync grsync"
    # 归档和压缩工具
    Archiving_And_Compression_Tools="lrzip lzip lzop p7zip unrar zip unzip arj par2cmdline sharutils"
    # 比较, 差异, 合并
    Comparison_Diff_Merge="meld"
    # 文件检索
    File_Searching="fd tree"
    # 全文检索
    Full_Text_Searching="ripgrep fzf"
    # 替代 cat
    Cat_Replacement="bat"
    # 替代 ls
    Ls_Replacement="exa"
    # 替代 man
    Man_Replacement="tldr"
    # 文字编辑
        # Emacs 风格的文本编辑器
        Emacs_Style_Text_Editors="emacs"
        # Vi 风格的文本编辑器
        Vi_Style_Text_Editors="neovim python-neovim"
    # 办公
        # 办公套件
        Office_Suites="libreoffice-fresh libreoffice-fresh-zh-cn"
        # 数据库及其管理工具
        Database_Tools="mariadb"
    # 文件转换
    Document_Converters="pandoc dos2unix figlet"
    # 阅读和查看
        # PDF 和 DjVu
        PDF_And_DjVu="evince"
        # CHM
        CHM="xchm"
    # 笔记
        # 思维导图
        Mind_Mapping="vym"
    # 字典和词库
    Dictionary_And_Thesaurus="goldendict sdcv"
    # 翻译和本地化
    Translation_And_Localization="poedit translate-shell"


##### Security (安全) #####
    # 硬件安全
        # 微码
        Microcode="intel-ucode"
        # MAC 地址欺骗
        MAC_Address_Spoofing="macchanger"
    # 系统管理
        # 权限控制
        Controlling_Privileges="polkit polkit-gnome"
        # 安全 Shell
        Secure_Shell="openssh"
    # 网络安全
    Network_Security="wireshark-qt nmap"
    # 屏幕锁
    Screen_Lockers="i3lock"
    # 密码管理
    Password_Managers="keepassxc kgpg"
    # 密码学
        # 磁盘加密
        Disk_Encryption="gocryptfs"
    # 垃圾管理 (安全删除)
    Trash_Management="trash-cli"


##### Programming (编程) #####
    # 版本控制系统
    Version_Control_Systems="git"
    # 自动化构建工具
    Build_Automation="cmake gradle"
    # API 文档浏览
    API_Documentation_Browsers="zeal"
    # 各语言工具     ⊢---shell---⊣   JSON
    Language_Tools="shellcheck shfmt jq"
    # 编程语言
        # 作为软件依赖的语言             ⊢------------Python3------------⊣  Haskell
        As_A_System_Dependent_Language="python python-pip python-setuptools ghc"
        # 我的主要语言     ⊢-------C-------⊣    ⊢-----Java-----⊣   ⊢--JS--⊣
        My_Main_Language="base-devel gdb clang jdk-openjdk kotlin nodejs npm"
        # 其它会用到的语言           ⊢--Go--⊣   Rust  ⊢--Ruby--⊣   Lua   DOT
        Other_Languages_To_Be_Used="go go-tools rust ruby rubygems lua graphviz"

" | grep "=" | cut -d"=" -f2 | xargs echo)
sync

# Advanced Linux Sound Architecture
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute
# PulseAudio
pactl set-sink-mute 0 false
# Tlp
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
# MariaDB
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mariadb.service
mysql_secure_installation
systemctl stop mariadb.service
# Microcode
sudo grub-mkconfig -o /boot/grub/grub.cfg

sync
echo -e "$red >>>>> Software installation script has been quit. $reset"
exit
