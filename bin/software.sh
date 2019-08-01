#!/bin/bash

# @Author:  Cool-Pan
# @Version: v11.1.2
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
read -r temp_Edit_Mirrorlist
sudo vi /etc/pacman.conf
sudo pacman -Syyuu

echo -e "$red >>>>> Start Install Software (开始安装). $reset"
# 移除基本系统中的包：
# + vi
# + nano
sudo pacman -S $(echo "

##### Graphical (图形) #####
    # 视频 (显卡)驱动
        # Intel 显卡
        Intel="xf86-video-intel mesa lib32-mesa"
        # NVIDIA 显卡
        Nvidia="nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings"
        # Vulkan
        Vulkan="vulkan-icd-loader lib32-vulkan-icd-loader vulkan-intel"
    # X Window 系统
        # Xorg 实现
        Xorg_Server="xorg-server xorg-xinit xorg-xset xorg-xhost"
        # 触摸版设备
        Input_Devices="libinput xf86-input-libinput xorg-xinput"
        # 屏幕管理
        Screen_Management="xorg-xrandr arandr"
        # 背光
        Backlight="light"
    # 桌面环境
        # KDE 桌面
        KDE_Plasma_Desktop="plasma-desktop"
        # 显示管理器
        Display_Manager="sddm sddm-kcm"
        # 窗口管理器
        Window_Managers="i3-gaps"
        # 程序启动器
        Application_Launchers="krunner"
    # 美化
        # 字体
        Fonts="fontconfig ttf-dejavu noto-fonts wqy-zenhei noto-fonts-cjk noto-fonts-emoji"
        # 窗口合成
        X_Compositor="compton"
        # 壁纸设置及壁纸
        Wallpaper_Setters="feh jpegexiforient archlinux-wallpaper"
        # GTK+ 样式主题
        Configuration_GTK="breeze-gtk kde-gtk-config"
        # QT5 样式主题
        Configuration_QT5="breeze"
        # 图标主题
        Icon_Themes="breeze-icons papirus-icon-theme"


##### Internet (互联网) #####
    # 网络连接
        # 网络管理                       ⊢-AP--⊣ ⊢-----WiFi------⊣
        Network_Managers="networkmanager dnsmasq wpa_supplicant iw plasma-nm"
    # Web 浏览器
        # 基于 Gecko
        Gecko_Based="firefox-developer-edition firefox-developer-edition-i18n-zh-tw firefox-developer-edition-i18n-ja firefox-developer-edition-i18n-de firefox-developer-edition-i18n-zh-cn flashplugin libvdpau xdg-desktop-portal xdg-desktop-portal-kde"
        # 基于 Blink
        Blink_Based="chromium pepper-flash kdialog"
        # 控制台中的浏览器
        Console_Based="w3m imlib2"
    # 文件共享
        # 通用的下载工具
        Download_Managers="aria2 axel wget ca-certificates"
        # BitTorrent 客户端
        BitTorrent_Clients="qbittorrent"
    # 沟通
        # 邮件, IRC, XMPP客服端
        Email_IRC_XMPP_Clients="thunderbird thunderbird-i18n-zh-tw thunderbird-i18n-ja thunderbird-i18n-de thunderbird-i18n-zh-cn"
    # 新闻, RSS 和博客
        # 新闻聚合
        News_Aggregators="quiterss"
        # 博客引擎
        Blog_Engines="hugo pygmentize"


##### Multimedia (多媒体) #####
    # 图像
        # 图像查看
        Image_Viewers="gwenview"
        # 图像处理
        Image_Processing="imagemagick"
        # 图像编辑
        Raster_Graphics_Editors="krita kolourpaint"
        # 矢量图形编辑器
        Vector_Graphics_Editors="inkscape"
        # 3D 图形
        3D_Computer_Graphics="blender"
        # 颜色选择器
        Color_Pickers="gcolor3"
        # 截图
        Screenshot="flameshot"
    # 音频
        # 声音系统
            # 驱动和接口
            Drivers_And_Interface="alsa-firmware alsa-utils"
            # 声音服务
            Sound_Servers="pulseaudio pulseaudio-alsa pulseaudio-bluetooth plasma-pa"
        # 音频播放
        Audio_Players="cmus faad2 wavpack flac libmad"
        # 音频编辑
        Audio_Editors="audacity"
    # 视频
        # 视频播放
        Video_Players="mpv"
        # 音视频转换
        Video_Converters="ffmpeg ciano"
        # 录屏
        Screencast="obs-studio libxcomposite"
    # 移动设备管理
    Mobile_Device_Managers="android-tools android-file-transfer libmtp kdeconnect sshfs"


##### Utilities (实用程序) #####
    # 终端
        # 终端模拟
        Terminal_Emulators="konsole"
        # 终端多路复用
        Terminal_multiplexers="tmux"
    # 文字输入
        # 输入法
        Input_Methods="fcitx fcitx-rime fcitx-gtk2 fcitx-gtk3 fcitx-qt5 kcm-fcitx"
    # 磁盘
        # 分区工具
        Partitioning_Tools="parted partitionmanager"
        # 格式化工具
        Formatting_Tools="btrfs-progs dosfstools exfat-utils f2fs-tools nilfs-utils ntfs-3g"
        # 挂载工具
        Mount_Tools="udisks2 gptfdisk"
        # 磁盘使用情况显示
        Disk_Usage_Display="ncdu filelight lsof"
        # 磁盘健康分析
        Analyzing_And_Monitoring="smartmontools hdparm"
    # 系统
        # 任务管理
        Task_Managers="htop strace ksysguard cronie"
        # 系统监视
        System_Monitors="glances hddtemp python-bottle sysstat conky conky-manager"
        # 系统信息查看
        System_Information_Viewers="neofetch kinfocenter"
        # 蓝牙管理
        Bluetooth_Management="bluez bluez-utils bluedevil"
        # 电源管理
        Power_Management="powerdevil"
        # Pacman 管理工具
        Pacman_Management_Tools="expac pacgraph pacutils lostfiles pacman-contrib"
    # 数学
        # 计算器
        Calculator="bc calc kcalc"


##### Documents (文件) #####
    # 文件管理器
    File_Managers="ranger atool highlight libcaca python-chardet dolphin dolphin-plugins"
    # 文件同步
    File_Synchronization="rsync"
    # 归档和压缩工具
    Archiving_And_Compression_Tools="lrzip lzip lzop p7zip unrar zip unzip arj par2cmdline sharutils ark"
    # 比较, 差异, 合并
    Comparison_Diff_Merge="meld"
    # 文件检索
    File_Searching="fd tree baloo"
    # 全文检索
    Full_Text_Searching="ripgrep fzf"
    # 替代 cat, ls, man
    CAT_LS_MAN="bat exa tldr"
    # 文字编辑
        # Emacs 风格的文本编辑器
        Emacs_Style_Text_Editors="emacs"
        # Vi 风格的文本编辑器
        Vi_Style_Text_Editors="gvim"
    # 办公
        # 办公套件
        Office_Suites="libreoffice-fresh libreoffice-fresh-zh-tw libreoffice-fresh-ja libreoffice-fresh-de libreoffice-fresh-zh-cn"
    # 文件转换
    Document_Converters="pandoc dos2unix figlet"
    # 阅读和查看
        # 查看 PDF, DjVu, CHM 文档
        PDF_DjVu_CHM="okular"
        # 电子书
        E_Book="calibre"
    # 笔记
        # 思维导图
        Mind_Mapping="vym"
    # 字典和词库
    Dictionary_And_Thesaurus="goldendict"
    # 翻译和本地化
    Translation_And_Localization="poedit"


##### Security (安全) #####
    # 内核
    Kernel="linux-zen linux-zen-headers dkms"
    # 硬件安全
        # 微码
        Microcode="intel-ucode"
        # MAC 地址随机化
        MAC_Address_Spoofing="macchanger"
    # 系统管理
        # 权限控制
        Controlling_Privileges="polkit polkit-kde-agent"
        # 安全 Shell
        Secure_Shell="openssh x11-ssh-askpass xorg-xauth"
    # 网络安全
    Network_Security="nmap ntop tcpdump wireshark-qt bind-tools"
    # 防火墙
    Firewall_Management="ufw gufw"
    # 屏幕锁
    Screen_Lockers="i3lock"
    # 密码管理
    Password_Managers="keepassxc kwalletmanager"
    # 隐写术
    Encryption_Steganography="kgpg kleopatra"
    # 密码学
        # 磁盘加密
        Disk_Encryption="gocryptfs"


##### Programming (编程) #####
    # 虚拟化
        # 虚拟机管理程序
        Hypervisors="virtualbox virtualbox-host-dkms virtualbox-guest-iso"
        # Nspawn 相关工具
        Nspawn="debootstrap debian-archive-keyring"
        # 容器
        Container="docker"
    # 数据库及其管理工具
    Database_Tools="mariadb dbeaver"
    # 版本控制系统
    Version_Control_Systems="git"
    # 自动化构建工具
    Build_Automation="cmake gradle maven"
    # 各语言工具  JSON ⊢----shell----⊣   Tag
    Language_Tools="jq shellcheck shfmt ctags"
    # API 文档浏览
    API_Documentation_Browsers="zeal"
    # 编程语言
        # 作为软件依赖的语言             ⊢------------Python3------------⊣    ⊢------------Python3------------⊣   Haskell
        As_A_System_Dependent_Language="python python-pip python-setuptools python2 python2-pip python2-setuptools ghc"
        # 我的主要语言     ⊢------------C-------------⊣  ⊢-----Java-----⊣   ⊢--JS--⊣  TypeScript
        My_Main_Language="base-devel gdb clang lld lldb jdk-openjdk kotlin nodejs npm typescript"
        # 其它会用到的语言           C#   ⊢--Go--⊣   Rust  ⊢--Ruby--⊣   Lua   DOT
        Other_Languages_To_Be_Used="mono go go-tools rust ruby rubygems lua graphviz"


##### Programming (编程) #####
    # 数字发行平台
    Digital_Distribution="steam"
    # 游戏模拟器
    Video_Game_Platform_Emulators="ppsspp"


##### 处理软件缺失的依赖 #####
    # Warframe / 星际战甲 (需手动从 AUR 中安装 xboxdrv 包)
    # 修复: 运行 5min 后卡死的问题
    Handle_Warframe="python-dbus-common python2-dbus"


" | grep "=" | cut -d"=" -f2 | xargs echo)
sync

# sddm
sudo systemctl enable sddm.service

# networkmanager
sudo systemctl enable NetworkManager.service

# alsa-utils
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

# pulseaudio
pactl set-sink-mute 0 false

# intel-ucode
sudo grub-mkconfig -o /boot/grub/grub.cfg

# ufw
sudo systemctl enable ufw.service

# mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb.service
mysql_secure_installation
sudo systemctl stop mariadb.service

sync
echo -e "$red >>>>> Software installation script has been quit. $reset"
exit
