#!/bin/bash

# @Author:  Cool-Pan
# @Version: v10.5.9
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
sudo pacman -Syyu

echo -e "$red >>>>> Start Install Software (开始安装). $reset"
sudo pacman -S $(echo "

##### Graphical (图形) #####
    # 视频 (显卡)驱动
        # Intel 显卡
        Intel="xf86-video-intel mesa lib32-mesa"
        # NVIDIA 显卡
        Nvidia="nvidia-lts nvidia-utils lib32-nvidia-utils"
        # Vulkan
        Vulkan="vulkan-icd-loader lib32-vulkan-icd-loader vulkan-intel"
    # X Window 系统
        # Xorg 实现
        Xorg_Server="xorg-server xorg-xmodmap xorg-xrdb xorg-xhost numlockx"
        # 触摸版设备
        Input_Devices="libinput xf86-input-libinput xorg-xinput"
        # 屏幕管理
        Screen_Management="xorg-xrandr"
    # 桌面环境
        # 顯示管理器
        Display_Manager="lightdm lightdm-gtk-greeter"
        # 窗口管理器
        Window_Managers="i3-gaps"
        # 程序启动器
        Application_Launchers="rofi"
        # 背光
        Backlight="light"
    # 美化
        # 字体
        Fonts="fontconfig ttf-dejavu wqy-zenhei noto-fonts-emoji"
        # 窗口合成
        X_Compositor="compton compton-conf-git"
        # 壁紙設置工具及壁紙
        Wallpaper_Setters="feh jpegexiforient archlinux-wallpaper"
        # GTK+ 样式主题
        Configuration_GTK="arc-gtk-theme"
        # QT5 样式主题
        Configuration_QT5="qt5ct kvantum-qt5"
        # 图标主题
        Icon_Themes="papirus-icon-theme"
        # 光标主题
        Cursor_Themes="capitaine-cursors"


##### Internet (互联网) #####
    # 网络连接
        # 网络管理                              ⊢--AP--⊣ ⊢-----WiFi-----⊣
        Network_Managers="network-manager-applet dnsmasq wpa_supplicant iw"
    # Web 浏览器
        # 基于 Gecko
        Gecko_Based="firefox firefox-i18n-zh-cn flashplugin libvdpau"
        # 基于 Blink
        Blink_Based="chromium pepper-flash"
        # 控制台中的浏览器
        Console_Based="w3m imlib2"
    # 文件共享
        # 通用的下载工具
        Download_Managers="aria2 axel wget ca-certificates"
        # BitTorrent 客户端
        BitTorrent_Clients="transmission-cli"
    # 沟通
        # E-Mail 客户端
        Email_Clients="neomutt"
        # IRC 客户端
        IRC_Clients="weechat"
        # XMPP 客户端
        XMPP_Clients="profanity"
        # 其它 IM 客户端
        Other_IM_Clients="electronic-wechat"
        # 远程桌面
        Remote_Desktop="teamviewer"
    # 新闻, RSS 和博客
        # 新闻聚合
        News_Aggregators="newsboat quiterss"
        # 博客引擎
        Blog_Engines="hugo pygmentize"


##### Multimedia (多媒体) #####
    # 图像
        # 图像查看
        Image_Viewers="viewnior"
        # 图像处理
        Image_Processing="imagemagick imagemagick-doc"
        # 图像编辑
        Raster_Graphics_Editors="photoflare"
        # 3D 图形
        3D_Computer_Graphics="blender"
        # 截图
        Screenshot="flameshot"
        # 颜色选择器
        Color_Pickers="gcolor3"
    # 音频
        # 声音系统
            # 驱动和接口
            Drivers_And_Interface="alsa-firmware alsa-utils"
            # 声音服务
            Sound_Servers="pulseaudio pulseaudio-alsa pulseaudio-bluetooth pavucontrol-qt pulseeffects"
        # 音频播放
        Audio_Players="cmus flac libmad faad2 libmp4v2"
        # 音频编辑
        Audio_Editors="audacity"
    # 视频
        # 视频播放
        Video_Players="mpv smplayer"
        # 视频转换
        Video_Converters="ffmpeg handbrake"
        # 录屏
        Screencast="obs-studio libxcomposite"
    # 移动设备管理
    Mobile_Device_Managers="android-tools android-file-transfer libmtp"


##### Utilities (实用程序) #####
    # 终端
        # 终端模拟
        Terminal_Emulators="alacritty alacritty-terminfo"
        # 终端多路复用
        Terminal_multiplexers="tmux"
    # 文字输入
        # 输入法
        Input_Methods="fcitx fcitx-rime fcitx-gtk2 fcitx-gtk3 fcitx-qt5 fcitx-configtool"
    # 磁盘
        # 分区工具
        Partitioning_Tools="parted"
        # 格式化工具
        Formatting_Tools="btrfs-progs dosfstools exfat-utils f2fs-tools nilfs-utils ntfs-3g"
        # 挂载工具
        Mount_Tools="udisks2 gptfdisk"
        # 磁盘使用情况显示
        Disk_Usage_Display="ncdu lsof"
        # 磁盘健康分析
        Analyzing_And_Monitoring="smartmontools hdparm"
    # 系统
        # 任务管理
        Task_Managers="htop cronie"
        # 系统监视
        System_Monitors="glances hddtemp python-bottle strace sysstat"
        # 硬件传感器监控
            # 温度
            lm_sensors="lm_sensors psensor"
        # 系统信息查看
        System_Information_Viewers="neofetch"
        # 蓝牙管理
        Bluetooth_Management="bluez bluez-utils blueman"
        # 电源管理
        Power_Management="tlp x86_energy_perf_policy"
        # Pacman 管理工具
        Pacman_Management_Tools="expac pacgraph pacutils lostfiles pacman-contrib archlinuxcn-keyring"
        # Nspawn 相关工具
        Nspawn="debootstrap debian-archive-keyring"
    # 数学
        # 计算器
        Calculator="bc calc"


##### Documents (文件) #####
    # 文件管理器
    File_Managers="ranger atool highlight libcaca python-chardet"
    # 文件同步
    File_Synchronization="rsync"
    # 归档和压缩工具
    Archiving_And_Compression_Tools="lrzip lzip lzop p7zip unrar zip unzip arj par2cmdline sharutils"
    # 比较, 差异, 合并
    Comparison_Diff_Merge="meld"
    # 文件检索
    File_Searching="fd tree"
    # 全文检索
    Full_Text_Searching="ripgrep fzf"
    # 替代 cat, ls, man
    Cat_Ls_Man="bat exa tldr"
    # 文字编辑
        # Emacs 风格的文本编辑器
        Emacs_Style_Text_Editors="emacs"
        # Vi 风格的文本编辑器
        Vi_Style_Text_Editors="gvim neovim python-neovim xsel"
        # 办公套件
        Office_Suites="wps-office ttf-wps-fonts"
    # 文件转换
    Document_Converters="pandoc dos2unix figlet"
    # 阅读和查看
        # PDF 和 DjVu
        PDF_And_DjVu="xreader"
        # 电子书
        E_Book="fbreader"
        # CHM
        CHM="xchm"
    # 笔记
        # Markdown 工具
        Markdown="vnote-git"
        # 思维导图
        Mind_Mapping="vym"
    # 字典和词库
    Dictionary_And_Thesaurus="goldendict"
    # 翻译和本地化
    Translation_And_Localization="poedit translate-shell"


##### Security (安全) #####
    # 内核
    Kernel="linux-lts linux-lts-headers dkms"
    # 硬件安全
        # 微码
        Microcode="intel-ucode"
        # MAC 地址随机化
        MAC_Address_Spoofing="macchanger"
    # 系统管理
        # 权限控制
        Controlling_Privileges="polkit polkit-gnome"
        # 安全 Shell
        Secure_Shell="openssh x11-ssh-askpass xorg-xauth"
    # 网络安全
    Network_Security="nmap wireshark-qt"
    # 防火墙
    Firewall_Management="gufw"
    # 屏幕锁
    Screen_Lockers="i3lock-color"
    # 密码管理
    Password_Managers="keepassxc"
    # 密码学
        # 磁盘加密
        Disk_Encryption="gocryptfs"


##### Programming (编程) #####
    # 数据库及其管理工具
    Database_Tools="mariadb dbeaver"
    # 虚拟化
        # 虛擬機
        Virtualization="virtualbox virtualbox-host-dkms virtualbox-guest-iso"
        # 容器
        Container="docker"
    # 版本控制系统
    Version_Control_Systems="git"
    # 自动化构建工具
    Build_Automation="cmake gradle"
    # 集成开发环境
    IDE="android-studio intellij-idea-ultimate-edition intellij-idea-ultimate-edition-jre pycharm-professional webstorm webstorm-jre"
    # 各语言工具  JSON ⊢----shell----⊣   Tag
    Language_Tools="jq shellcheck shfmt ctags"
    # API 文档浏览
    API_Documentation_Browsers="zeal"
    # 编程语言
        # 作为软件依赖的语言             ⊢------------Python3------------⊣  Haskell
        As_A_System_Dependent_Language="python python-pip python-setuptools ghc"
        # 我的主要语言     ⊢-------C-------⊣    ⊢-----Java-----⊣    ⊢--JS--⊣  TypeScript
        My_Main_Language="base-devel gdb clang jdk8-openjdk kotlin nodejs npm typescript"
        # 其它会用到的语言           C#   ⊢--Go--⊣   Rust  ⊢--Ruby--⊣   Lua   DOT
        Other_Languages_To_Be_Used="mono go go-tools rust ruby rubygems lua graphviz"


##### Programming (编程) #####
    # 数字发行平台
    Digital_Distribution="steam"
    # 游戏模拟器
    Video_Game_Platform_Emulators="ppsspp"
    # 模擬類游戏
    Simulation="hmcl"

" | grep "=" | cut -d"=" -f2 | xargs echo)
sync

# lightdm
sudo systemctl enable lightdm.service

# networkmanager
sudo systemctl enable NetworkManager.service

# alsa-utils
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

# pulseaudio
pactl set-sink-mute 0 false

# tlp
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket

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
