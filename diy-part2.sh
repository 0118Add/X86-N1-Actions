#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# 修改默认IP
sed -i 's/192.168.1.1/192.168.2.10/g' package/base-files/files/bin/config_generate

#使用源码自带ShadowSocksR Plus+出国软件
#sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#添加额外软件包
rm -rf feeds/luci/collections/luci-lib-docker
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf /feeds/packages/net/samba4
svn co https://github.com/sirpdboy/diy/trunk/samba4 feeds/packages/net/samba4
git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata

#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy

#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
#svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/shadowsocks-rust
#svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
#svn co https://github.com/fw876/helloworld/trunk/v2ray-core package/v2ray-core
#svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/v2ray-plugin
#svn co https://github.com/fw876/helloworld/trunk/tcping package/tcping
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
#svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
git clone https://github.com/kiddin9/openwrt-bypass.git package/bypass
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/passwall
#git clone https://github.com/0118Add/luci-theme-neobird.git package/luci-theme-neobird
#git clone https://github.com/leshanydy2022/luci-theme-bootstrap-mod.git package/luci-theme-bootstrap-mod
git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#git clone https://github.com/bin20088/luci-app-koolddns.git package/luci-app-koolddns
#git clone https://github.com/QiuSimons/openwrt-mos package/luci-app-mosdns
svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
#rm -rf package/lean/luci-app-frpc
#git clone https://github.com/8688Add/luci-app-frpc-mod.git package/lean/luci-app-frpc
#chmod 0755 package/lean/luci-app-frpc/root/etc/init.d/frp
#git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
git clone https://github.com/8688Add/install-program.git package/install-program
#svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
#sed -i 's/Docker CE 容器/Docker 容器/g' feeds/luci/applications/luci-app-docker/po/zh-cn/docker.po
sed -i 's/V2ray 服务器/V2ray 服务/g' feeds/luci/applications/luci-app-v2ray-server/po/zh-cn/v2ray_server.po
#sed -i 's/Frp 内网穿透/Frp内网穿透/g' feeds/luci/applications/luci-app-frpc/po/zh-cn/frp.po


#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
#sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
#sed -i 's/"解锁网易云灰色歌曲"/"网易云音乐"/g' package/lean/luci-app-unblockmusic/po/zh-cn/unblockmusic.po

#readd cpufreq for aarch64
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/feeds/luci/collections/luci-app-cpufreq/Makefile
#sed -i 's/services/system/g' package/feeds/luci/collections/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# Add autocore support for armvirt
#sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# 替换index.htm文件
wget -O ./package/lean/autocore/files/arm/index.htm https://raw.githubusercontent.com/0118Add/Actions-Shangyou/main/n1_index.htm

# 替换banner
wget -O ./package/base-files/files/etc/banner https://raw.githubusercontent.com/0118Add/Armbian/main/router/Openwrt_N1/diy/n1_lede/banner

# 添加旁路由防火墙
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

#sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile
#sed -i '175i\  --with-sandbox=rlimit \\' feeds/packages/net/openssh//Makefile

#replace coremark.sh with the new one
#rm package/lean/coremark/coremark.sh
#cp $GITHUB_WORKSPACE/general/coremark.sh package/lean/coremark/

#赋予koolddns权限
#chmod 0755 package/openwrt-packages/luci-app-koolddns/root/etc/init.d/koolddns
#chmod 0755 package/openwrt-packages/luci-app-koolddns/root/usr/share/koolddns/aliddns

#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-vssr/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-alt/shadowsocksr-libev-ssr-redir/g' {}
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-vssr/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-server/shadowsocksr-libev-ssr-server/g' {}

#修改bypass的makefile
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

./scripts/feeds update -a
./scripts/feeds install -a
