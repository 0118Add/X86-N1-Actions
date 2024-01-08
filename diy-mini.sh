#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# By: BGG
#===============================================

# 修改主机名字（不能纯数字或者使用中文）
#sed -i "s/hostname='.*'/hostname='X86'/g" package/base-files/files/bin/config_generate
#sed -i "s/OpenWrt /OPWRT/g" package/lean/default-settings/files/zzz-default-settings

# 加入作者信息
#sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt-X86-$(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings   
#sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' BGG'/g" package/lean/default-settings/files/zzz-default-settings

# 使用源码自带ShadowSocksR Plus+出国软件
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# 修改版本为编译日期
#date_version=$(date +"%y.%m.%d")
#orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
#sed -i "s/${orig_version}/R${date_version}/g" package/lean/default-settings/files/zzz-default-settings

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 替换内核
#sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g' target/linux/armvirt/Makefile

# 修改概览里时间显示为中文数字
#sed -i 's/os.date()/os.date("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm

# 添加温度显示
#sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 修改系统文件
#curl -fsSL https://raw.githubusercontent.com/0118Add/patch/main/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
curl -fsSL https://raw.githubusercontent.com/0118Add/N1-Actions-Dabao49/main/flippyn1_index.htm > ./package/lean/autocore/files/arm/index.htm
#curl -fsSL https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/diy/x86_lede/cpuinfo > ./package/myautocore/autocore/files/generic/cpuinfo

# 替换index.htm文件
#wget -O ./package/lean/autocore/files/x86/index.htm https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/index_x86.htm

# 替换banner
wget -O ./package/base-files/files/etc/banner https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/diy/x86_lede/banner

# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/g' feeds/luci/collections/luci/Makefile

# 删除主题强制默认
#find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

# 修改连接数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# 添加旁路由防火墙
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user
#echo "iptables -t nat -I POSTROUTING -j FULLCONENAT" >> package/network/config/firewall/files/firewall.user

# node - prebuilt
rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node-prebuilt feeds/packages/lang/node

# 移除重复软件包
#rm -rf package/helloworld/{hysteria,xray-core}
#rm -rf package/lean/autocore
#rm -rf feeds/packages/lang/golang
rm -rf feeds/luci/collections/luci-lib-docker
rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/luci/applications/luci-app-netdata
#rm -rf feeds/luci/applications/luci-app-aliyundrive-webdav
#rm -rf feeds/packages/multimedia/aliyundrive-webdav

# 添加额外软件包
#rm -rf package/lean/autocore
#git clone https://github.com/0118Add/X86_64-TEST.git package/myautocore
rm -rf feeds/luci/collections/luci-lib-docker
rm -rf feeds/luci/applications/luci-app-dockerman
#rm -rf feeds/packages/lang/golang
#svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang
#rm -rf feeds/luci/applications/luci-app-netdata
#rm -rf feeds/luci/applications/luci-app-aliyundrive-webdav
#rm -rf feeds/packages/multimedia/aliyundrive-webdav
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-serverchan
#svn co https://github.com/sirpdboy/diy/trunk/samba4 feeds/packages/net/samba4
git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata
git clone https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
#svn co https://github.com/0118Add/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone https://github.com/sbwml/luci-app-mosdns package/mosdns
#git clone https://github.com/sbwml/openwrt_helloworld package/helloworld
#svn export -q https://github.com/fw876/helloworld package/helloworld
git clone https://github.com/fw876/helloworld package/helloworld
git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2
git clone https://github.com/justice2001/luci-app-multi-frpc package/luci-app-multi-frpc
git clone https://github.com/sbwml/luci-app-alist.git package/alist
#git clone https://github.com/messense/aliyundrive-webdav.git package/aliyundrive-webdav
#git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
#git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
git clone https://github.com/sirpdboy/luci-app-ddns-go package/ddns-go
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-design
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/gngpp/luci-theme-design package/luci-theme-design
git clone https://github.com/0118Add/openwrt_packages package/luci-theme-atmaterial_new
#git clone --depth=1 -b main https://github.com/fw876/helloworld package/helloworld
git clone https://github.com/0118Add/luci-app-vssr package/luci-app-vssr
git clone -b dev --depth 1 https://github.com/vernesong/OpenClash package/luci-app-openclash
git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-wechatpush
git clone https://github.com/ophub/luci-app-amlogic.git package/amlogic
#svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' feeds/luci/applications/luci-app-adbyby-plus/po/zh-cn/adbyby.po
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
#sed -i 's/Hello World/Hi World/g' package/luci-app-vssr/luasrc/controller/vssr.lua
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/Argon 主题设置/主题设置/g' feeds/luci/applications/luci-app-argon-config/po/zh-cn/argon-config.po
#sed -i 's/Frp 内网穿透/内网穿透/g' feeds/luci/applications/luci-app-frpc/po/zh-cn/frp.po
sed -i 's/Frpc内网穿透/内网穿透/g' package/luci-app-multi-frpc/po/zh-cn/frp.po
#sed -i 's/Docker CE 容器/Docker 容器/g' feeds/luci/applications/luci-app-docker/po/zh-cn/docker.po
#sed -i 's/V2ray 服务器/V2ray服务/g' feeds/luci/applications/luci-app-v2ray-server/po/zh-cn/v2ray_server.po
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
sed -i 's/WireGuard 状态/WiGd状态/g' feeds/luci/applications/luci-app-wireguard/po/zh-cn/wireguard.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

#luci-app-amlogic 晶晨宝盒
sed -i "s|https.*/s9xxx-openwrt|https://github.com/0118Add/s9xxx-actions|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/breakings/OpenWrt/opt/kernel|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|s9xxx_lede|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic

# 调整 Dockerman 到 服务 菜单
sed -i 's/"admin",/"admin","services",/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/model/*.lua
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# 调整 Zerotier 到 服务 菜单
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/controller/*.lua
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua
sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/*.htm

# 调整 V2ray服务 到 VPN 菜单
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

# 调整 bypass 到 GFW 菜单
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/view/bypass/*.htm

# 调整 SSRP 到 GFW 菜单
sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# 调整 Pass Wall 到 GFW 菜单
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/passwall/*.lua
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm
sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm

# 调整 Pass Wall 2 到 GFW 菜单
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/model/cbi/passwall2/client/*.lua
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/model/cbi/passwall2/server/*.lua
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/passwall2/*.lua
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/app_update/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/global/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/haproxy/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/log/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/node_list/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/rule/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/server/*.htm
sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/socks_auto_switch/*.htm

# 调整 Hello World 到 GFW 菜单
sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/view/vssr/*.htm

# 调整 Open Clash 到 GFW 菜单
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/controller/*.lua
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/*.lua
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/view/openclash/*.htm

# 修复 hostapd 报错
cp -f $GITHUB_WORKSPACE/scripts/011-fix-mbo-modules-build.patch package/network/services/hostapd/patches/011-fix-mbo-modules-build.patch

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHREPO/PKG_SOURCE_URL:=https:\/\/github\.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload\.github\.com/g' {}

./scripts/feeds update -i
./scripts/feeds install -a
