#!/bin/bash

# guide to install https://gist.github.com/linderd/71ec30048e78813115ba3f634e1b0817
TARGET=~/dot-files
OPT_PATH=/opt
export USER=yoser
export HOST=yoserlaptop
export TZ="America/Bogota" # Replace Europe/London with your Region/City

install_zsh(){
  echo "Starting the installation oh my zsh"
  # sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  sed -i "\$a source $1/ext_zshrc" ~/.zshrc
}
#install_zsh $TARGET
install_asdf(){
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
  asdf=~/.asdf/bin/asdf
  $asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  $asdf install nodejs latest
  $asdf global nodejs latest
  $asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  # $asdf install elixir ref:a64d42f5d3cb6c32752af9d3312897e8cd5bb7ec
  # $asdf global elixir ref:a64d42f5d3cb6c32752af9d3312897e8cd5bb7ec
  $asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  # $asdf install erlang 24.1.2
  # $asdf global erlang 24.1.2
}

dvp_it_ins(){
  ln -s ${TARGET}/dot-files/dvp-it/dvp-it /usr/share/X11/xkb/symbols/.
}

install_python(){
  pyenv install 3.10.7
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
  pyenv virtualenv 3.10.7 neovim3
  pyenv activate neovim3
  pyenv install 2.7.18 
  pyenv activate neovim2
  pyenv virtualenv 2.7.18 neovim2
  python -m pip install --user --upgrade pynvim
}

install_wifi(){
  yay -S linux5.15.10.arch1-1-headers-bin
  git clone https://github.com/lwfinger/rtw89.git
  cd rtw89
  make
  sudo make install
  sudo modprobe rtw89pci
  sudo rfkill unblock all
  sudo ip link set wlp3s0 up
}
#install_asdf 
build_git(){
  ln -s ~/dot-files/git/gitignore_general .gitignore
}

build_src(){
  mkdir ~/scr
}
build_sound(){
 # sudo modprobe snd_seq_oss snd_pcm_oss snd_mixer_oss
  #sudo alsactl init
  sed -i 's/load-module module-suspend-on-idle/#load-module module-suspend-on-idle/' /etc/pulse/default.pa
}

build_docker(){
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo groupadd docker
  newgrp docker
  sudo chown root:docker /var/run/docker.sock
  sudo usermod -aG docker yoser
  docker pull postgres:alpine
  # docker run -d -p 5432:5432 --name psqlcont-liftit-local-tms -e POSTGRES_PASSWORD=postgres -v $HOME/liftit/backup/LIFTIT_DB_TMS:/var/lib/postgresql/data postgis/postgis:11-3.0-alpine
  docker run -d -p 5432:5432 --name postgresql -e POSTGRES_PASSWORD=postgres
}

set_timedatectl(){
 timedatectl set-ntp true
}

install_grloud(){
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-367.0.0-linux-x86_64.tar.gz
  ./google-cloud-sdk/install.sh
  ./google-cloud-sdk/bin/gcloud init
}

install_bluethooth(){
  sudo systemctl enable bluetooth
}

settings(){
  ln -sf /usr/share/zoneinfo/$TZ /etc/localtime  && \ 
    hwclock -uw # or hwclock --systohc --utc
  echo $HOST > /etc/hostname
  cat << EOF >> /etc/hosts
# <ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	localhost
::1		localhost
127.0.1.1	$HOST.localdomain	$HOST
EOF
  sed -i 's/BINARIES=()/BINARIES=("\/usr\/bin\/btrfs")/' /etc/mkinitcpio.conf && \
  sed -i 's/MODULES=()/MODULES=(amdgpu)/' /etc/mkinitcpio.conf && \
  sed -i 's/#COMPRESSION="lz4"/COMPRESSION="lz4"/' /etc/mkinitcpio.conf && \
  sed -i 's/#COMPRESSION_OPTIONS=()/COMPRESSION_OPTIONS=(-9)/' /etc/mkinitcpio.conf && \
  sed -i 's/^HOOKS.*/HOOKS=(base systemd autodetect modconf block sd-encrypt filesystems keyboard fsck)/' /etc/mkinitcpio.conf
# if you have more than 1 btrfs drive
# sed -i 's/^HOOKS.*/HOOKS=(base systemd autodetect modconf block sd-encrypt resume btrfs filesystems keyboard fsck)/' mkinitcpio.conf

  mkinitcpio -p linux
}
#settings

create_zram(){
cat << EOF > /etc/systemd/swap.conf
#  This file is part of systemd-swap.
#
# Entries in this file show the systemd-swap defaults as
# specified in /usr/share/systemd-swap/swap-default.conf
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See swap.conf(5) and /usr/share/systemd-swap/swap-default.conf for details.
zram_enabled=1
zswap_enabled=0
swapfc_enabled=0
zram_size=\$(( RAM_SIZE / 4 ))
EOF
}
optimize_makepkg(){
  sed -i 's/^CFLAGS.*/CFLAGS="-march=native -mtune=native -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt"/' /etc/makepkg.conf && \
  sed -i 's/^CXXFLAGS.*/CXXFLAGS="-march=native -mtune=native -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt"/' /etc/makepkg.conf && \
  sed -i 's/^#RUSTFLAGS.*/RUSTFLAGS="-C opt-level=2 -C target-cpu=native"/' /etc/makepkg.conf && \
  sed -i 's/^#BUILDDIR.*/BUILDDIR=\/tmp\/makepkg/' /etc/makepkg.conf && \
  sed -i 's/^#MAKEFLAGS.*/MAKEFLAGS="-j$(getconf _NPROCESSORS_ONLN) --quiet"/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSGZ.*/COMPRESSGZ=(pigz -c -f -n)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSBZ2.*/COMPRESSBZ2=(pbzip2 -c -f)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSXZ.*/COMPRESSXZ=(xz -T "$(getconf _NPROCESSORS_ONLN)" -c -z --best -)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSZST.*/COMPRESSZST=(zstd -c -z -q --ultra -T0 -22 -)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSLZ.*/COMPRESSLZ=(lzip -c -f)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSLRZ.*/COMPRESSLRZ=(lrzip -9 -q)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSLZO.*/COMPRESSLZO=(lzop -q --best)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSZ.*/COMPRESSZ=(compress -c -f)/' /etc/makepkg.conf && \
  sed -i 's/^COMPRESSLZ4.*/COMPRESSLZ4=(lz4 -q --best)/' /etc/makepkg.conf
}

configure_pacman(){
  sed -i 's/#UseSyslog/UseSyslog/' /etc/pacman.conf && \
  sed -i 's/#Color/Color\\\nILoveCandy/' /etc/pacman.conf && \
  sed -i 's/Color\\/Color/' /etc/pacman.conf && \
  sed -i 's/#TotalDownload/TotalDownload/' /etc/pacman.conf && \
  sed -i 's/#CheckSpace/CheckSpace/' /etc/pacman.conf
  echo 'ParallelDownloads = 5' >> /etc/pacman.conf
}

security_and_performance() {
  sed -i 's/^umask.*/umask\ 077/' /etc/profile && \
  chmod 700 /etc/{iptables,arptables,nftables.conf} && \
  echo "auth optional pam_faildelay.so delay=4000000" >> /etc/pam.d/system-login && \
  echo "tcp_bbr" > /etc/modules-load.d/bbr.conf && \
  echo "write-cache" > /etc/apparmor/parser.conf
  cat << EOF >/etc/sysctl.d/99-sysctl-performance-tweaks.conf
# The swappiness sysctl parameter represents the kernel's preference (or avoidance) of swap space. Swappiness can have a value between 0 and 100, the default value is 60. 
# A low value causes the kernel to avoid swapping, a higher value causes the kernel to try to use swap space. Using a low value on sufficient memory is known to improve responsiveness on many systems.
vm.swappiness=10

# The value controls the tendency of the kernel to reclaim the memory which is used for caching of directory and inode objects (VFS cache). 
# Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache (do not set it to 0, this may produce out-of-memory conditions)
vm.vfs_cache_pressure=50

# This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
# Disable NMI watchdog
#kernel.nmi_watchdog = 0

# Contains, as a percentage of total available memory that contains free pages and reclaimable
# pages, the number of pages at which a process which is generating disk writes will itself start
# writing out dirty data (Default is 20).
vm.dirty_ratio = 5

# Contains, as a percentage of total available memory that contains free pages and reclaimable
# pages, the number of pages at which the background kernel flusher threads will start writing out
# dirty data (Default is 10).
vm.dirty_background_ratio = 5

# This tunable is used to define when dirty data is old enough to be eligible for writeout by the
# kernel flusher threads.  It is expressed in 100'ths of a second.  Data which has been dirty
# in-memory for longer than this interval will be written out next time a flusher thread wakes up
# (Default is 3000).
#vm.dirty_expire_centisecs = 3000

# The kernel flusher threads will periodically wake up and write old data out to disk.  This
# tunable expresses the interval between those wakeups, in 100'ths of a second (Default is 500).
vm.dirty_writeback_centisecs = 1500

# Enable the sysctl setting kernel.unprivileged_userns_clone to allow normal users to run unprivileged containers.
kernel.unprivileged_userns_clone=1

# To hide any kernel messages from the console
kernel.printk = 3 3 3 3

# Restricting access to kernel logs
kernel.dmesg_restrict = 1

# Restricting access to kernel pointers in the proc filesystem
kernel.kptr_restrict = 2

# Disable Kexec, which allows replacing the current running kernel. 
kernel.kexec_load_disabled = 1

# Increasing the size of the receive queue.
# The received frames will be stored in this queue after taking them from the ring buffer on the network card.
# Increasing this value for high speed cards may help prevent losing packets: 
net.core.netdev_max_backlog = 16384

# Increase the maximum connections
#The upper limit on how many connections the kernel will accept (default 128): 
net.core.somaxconn = 8192

# Increase the memory dedicated to the network interfaces
# The default the Linux network stack is not configured for high speed large file transfer across WAN links (i.e. handle more network packets) and setting the correct values may save memory resources: 
net.core.rmem_default = 1048576
net.core.rmem_max = 16777216
net.core.wmem_default = 1048576
net.core.wmem_max = 16777216
net.core.optmem_max = 65536
net.ipv4.tcp_rmem = 4096 1048576 2097152
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.udp_rmem_min = 8192
net.ipv4.udp_wmem_min = 8192

# Enable TCP Fast Open
# TCP Fast Open is an extension to the transmission control protocol (TCP) that helps reduce network latency
# by enabling data to be exchanged during the sender’s initial TCP SYN [3]. 
# Using the value 3 instead of the default 1 allows TCP Fast Open for both incoming and outgoing connections: 
net.ipv4.tcp_fastopen = 3

# Enable BBR
# The BBR congestion control algorithm can help achieve higher bandwidths and lower latencies for internet traffic
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr

# TCP SYN cookie protection
# Helps protect against SYN flood attacks. Only kicks in when net.ipv4.tcp_max_syn_backlog is reached: 
net.ipv4.tcp_syncookies = 1

# Protect against tcp time-wait assassination hazards, drop RST packets for sockets in the time-wait state. Not widely supported outside of Linux, but conforms to RFC: 
net.ipv4.tcp_rfc1337 = 1

# By enabling reverse path filtering, the kernel will do source validation of the packets received from all the interfaces on the machine. This can protect from attackers that are using IP spoofing methods to do harm. 
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1

# Disable ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

# To use the new FQ-PIE Queue Discipline (>= Linux 5.6) in systems with systemd (>= 217), will need to replace the default fq_codel. 
net.core.default_qdisc = fq_pie
EOF
}
nftables_firewall(){
cat << EOF > /etc/nftables.conf
flush ruleset

table ip filter {
  chain DOCKER-USER {
    mark set 1
  }
}

table inet my_table {
	chain my_input {
		type filter hook input priority 0; policy drop;

		iif lo accept comment "Accept any localhost traffic"
		ct state invalid drop comment "Drop invalid connections"
		
		meta l4proto icmp icmp type echo-request limit rate over 10/second burst 4 packets drop comment "No ping floods"
		meta l4proto ipv6-icmp icmpv6 type echo-request limit rate over 10/second burst 4 packets drop comment "No ping floods"

		ct state established,related accept comment "Accept traffic originated from us"

		meta l4proto ipv6-icmp icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, mld-listener-query, mld-listener-report, mld-listener-reduction, nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, ind-neighbor-solicit, ind-neighbor-advert, mld2-listener-report } accept comment "Accept ICMPv6"
		meta l4proto ipv6-icmp icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, mld-listener-query, mld-listener-report, mld-listener-reduction, nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, ind-neighbor-solicit, ind-neighbor-advert, mld2-listener-report } accept comment "Accept ICMPv6"
		meta l4proto icmp icmp type { destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem } accept comment "Accept ICMP"
		ip protocol igmp accept comment "Accept IGMP"

		tcp dport ssh ct state new limit rate 15/minute accept comment "Avoid brute force on SSH"

		udp dport mdns ip6 daddr ff02::fb accept comment "Accept mDNS"
		udp dport mdns ip daddr 224.0.0.251 accept comment "Accept mDNS"

		udp sport 1900 udp dport >= 1024 ip6 saddr { fd00::/8, fe80::/10 } meta pkttype unicast limit rate 4/second burst 20 packets accept comment "Accept UPnP IGD port mapping reply"
		udp sport 1900 udp dport >= 1024 ip saddr { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 169.254.0.0/16 } meta pkttype unicast limit rate 4/second burst 20 packets accept comment "Accept UPnP IGD port mapping reply"

		udp sport netbios-ns udp dport >= 1024 meta pkttype unicast ip6 saddr { fd00::/8, fe80::/10 } accept comment "Accept Samba Workgroup browsing replies"
		udp sport netbios-ns udp dport >= 1024 meta pkttype unicast ip saddr { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 169.254.0.0/16 } accept comment "Accept Samba Workgroup browsing replies"

		counter comment "Count any other traffic"
	}

	chain my_forward {
		type filter hook forward priority security; policy drop;
  		mark 1 accept
		# Drop everything forwarded to that's not from docker us. We do not forward. That is routers job.
	}

	chain my_output {
		type filter hook output priority 0; policy accept;
		# Accept every outbound connection
	}

}

table inet dev {
    set blackhole {
        type ipv4_addr;
        flags dynamic, timeout;
        size 65536;
    }

    chain input {
        ct state new tcp dport 443 \
                meter flood size 128000 { ip saddr timeout 10s limit rate over 10/second } \
                add @blackhole { ip saddr timeout 1m }

        ip saddr @blackhole counter drop
    }
}
EOF
}

gen_locale(){
  echo "es_CO.UTF-8 UTF-8" > /etc/locale.gen && \
        locale-gen && \
  echo "LANG=\"es_CO.UTF-8\"" > /etc/locale.conf && \
  echo "KEYMAP=us" > /etc/vconsole.conf && \
  export LANG="es_CO.UTF-8" && \
  export LC_COLLATE="C"
  ln -sf /usr/share/zoneinfo/$TZ /etc/localtime  && \
         hwclock --systohc --utc
}

default_firefox(){
  xdg-settings get default-web-browser
  xdg-settings set default-web-browser firefox.desktop
}

<<<<<<< Updated upstream
chromium_with_wayland(){
  
}

gparted_with_wayland(){
  xhost +SI:localuser:root
}
=======

install_asdf()
>>>>>>> Stashed changes
