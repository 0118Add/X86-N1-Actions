#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# By: BGG
#===============================================

echo "开始配置……"
echo "========================="

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 修改主机名字（不能纯数字或者使用中文）
#sed -i "s/hostname='.*'/hostname='X86'/g" package/base-files/files/bin/config_generate
#sed -i "s/OpenWrt /OPWRT/g" package/lean/default-settings/files/zzz-default-settings

# 加入作者信息
#sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt-X86-$(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings   
#sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION=' BGG'/g" package/lean/default-settings/files/zzz-default-settings

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改autocore
#sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# 修改版本为编译日期
#date_version=$(date +"%y.%m.%d")
#orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
#sed -i "s/${orig_version}/R${date_version}/g" package/lean/default-settings/files/zzz-default-settings

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 替换内核
#sed -i 's/KERNEL_PATCHVER:=6.1/KERNEL_PATCHVER:=6.6/g' target/linux/x86/Makefile

# 内核替换 kernel xxx
#sed -i 's/LINUX_KERNEL_HASH-6.6.69 = 9c6305567b75d99514cde6eb9de39973f3d5c857a75bd9dcdfca57041f8d4f34/LINUX_KERNEL_HASH-6.6.66 = 9d757937c4661c2f512c62641b74ef74eff9bb13dc5dbcbaaa108c21152f1e52/g' ./include/kernel-6.6
#sed -i 's/LINUX_VERSION-6.6 = .69/LINUX_VERSION-6.6 = .66/g' ./include/kernel-6.6

# 替换文件
#wget -O ./package/kernel/linux/modules/netsupport.mk https://raw.githubusercontent.com/0118Add/X86-N1-Actions/main/general/netsupport.mk
#wget -O ./package/lean/autocore/files/x86/index.htm https://raw.githubusercontent.com/0118Add/OpenWrt/main/images/index.htm

# 去除主页一串的LUCI版本号显示
#sed -i 's/distversion)%>/distversion)%><!--/g' package/lean/autocore/files/*/index.htm
#sed -i 's/luciversion)%>)/luciversion)%>)-->/g' package/lean/autocore/files/*/index.htm

# 修改概览里时间显示为中文数字
#sed -i 's/os.date()/os.date("%Y-%m-%d") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm

# x86 型号只显示 CPU 型号
#sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore

# 添加温度显示
#sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

# 替换banner
wget -O ./package/base-files/files/etc/banner https://raw.githubusercontent.com/0118Add/X86_64-Test/main/general/banner

# 修改默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/g' feeds/luci/collections/luci/Makefile

# 删除主题强制默认
#find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

# 修改连接数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# golang 1.24
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

# 移除重复软件包
rm -rf feeds/other/lean/autocore
rm -rf package/public/autosamba
rm -rf package/kernel/r8152
rm -rf feeds/packages/net/{sing-box,xray-core}
rm -rf feeds/other/luci-app-diskman
rm -rf feeds/other/luci-app-dockerman
rm -rf feeds/other/lean/luci-app-autoreboot
rm -rf feeds/other/lean/luci-app-turboacc
rm -rf feeds/other/lean/luci-app-zerotier
rm -rf feeds/luci/applications/luci-app-alist
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/lienol/luci-app-ramfree
rm -rf target/linux/generic/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch
rm -rf target/linux/generic/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
rm -rf target/linux/generic/hack-6.1/952-add-net-conntrack-events-support-multiple-registrant.patch
rm -rf target/linux/generic/hack-6.1/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
rm -rf target/linux/generic/hack-6.6/952-add-net-conntrack-events-support-multiple-registrant.patch

# 添加额外软件包
git clone https://github.com/0118Add/X86-N1-Actions package/autocore
#git clone https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
#git clone https://github.com/0118Add/luci-app-vssr package/luci-app-vssr
#git clone https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone -b main --single-branch https://github.com/xiaorouji/openwrt-passwall package/passwall-luci
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
#git clone https://github.com/fw876/helloworld.git package/helloworld
#git_sparse_clone main https://github.com/kiddin9/kwrt-packages luci-app-autoreboot luci-app-diskman luci-app-ramfree
#git clone https://github.com/xiaorouji/openwrt-passwall2 package/passwall2
#git clone https://github.com/sbwml/luci-app-alist.git package/alist
#git clone https://github.com/QiuSimons/luci-app-daed-next package/luci-app-daed-next
#git clone -b lede --single-branch https://github.com/lwb1978/luci-app-smartdns package/luci-app-smartdns
#git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
#git clone https://github.com/8688Add/luci-theme-argon-dark-mod.git package/luci-theme-argon-dark-mod
#git clone https://github.com/justice2001/luci-app-multi-frpc package/luci-app-multi-frpc
#git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
#git clone -b dev --depth 1 https://github.com/vernesong/OpenClash package/luci-app-openclash
#git clone -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush package/luci-app-wechatpush
git clone https://github.com/8688Add/luci-app-zerotier package/luci-app-zerotier
git clone https://github.com/sbwml/luci-app-filemanager package/luci-app-filemanager
git clone https://github.com/sirpdboy/luci-app-partexp package/luci-app-partexp
#git clone https://github.com/sirpdboy/luci-app-ddns-go package/luci-app-ddns-go
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#git clone -b nekobox --depth 1 https://github.com/Thaolga/openwrt-nekobox package/nekobox
#git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-design
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/gngpp/luci-theme-design package/luci-theme-design
#rm -rf feeds/packages/net/smartdns
#cp -rf ${GITHUB_WORKSPACE}/general/smartdns feeds/packages/net

git clone --depth 1 -b dev https://github.com/immortalwrt/homeproxy package/homeproxy
sed -i "s/ImmortalWrt/OpenWrt/g" package/homeproxy/po/zh_Hans/homeproxy.po
sed -i "s/ImmortalWrt proxy/OpenWrt proxy/g" package/homeproxy/htdocs/luci-static/resources/view/homeproxy/{client.js,server.js}

# mihomo
git clone https://github.com/nikkinikki-org/OpenWrt-nikki  package/OpenWrt-nikki
#sed -i 's/MihomoTProxy/Mihomo/g' package/openwrt-mihomo/luci-app-mihomo/po/zh_Hans/mihomo.po
#sed -i 's/MihomoTProxy/Mihomo/g' package/openwrt-mihomo/luci-app-mihomo/root/usr/share/luci/menu.d/luci-app-mihomo.json

# turboacc
#git clone https://github.com/chenmozhijin/turboacc package/new/luci-app-turboacc
curl -sSL https://raw.githubusercontent.com/chenmozhijin/turboacc/luci/add_turboacc.sh -o add_turboacc.sh && bash add_turboacc.sh
sed -i 's/Turbo ACC 网络加速/网络加速/g' package/turboacc/luci-app-turboacc/po/zh-cn/turboacc.po

# 克隆immortalwrt-luci仓库
#git clone --depth=1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git immortalwrt-luci
#cp -rf immortalwrt-luci/applications/luci-app-dockerman feeds/luci/applications/luci-app-dockerman
#ln -sf ../../../feeds/luci/applications/luci-app-dockerman ./package/feeds/luci/luci-app-dockerman

# 修改系统文件
curl -fsSL https://raw.githubusercontent.com/0118Add/X86-N1-Actions/main/general/25_storage.js > ./feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/25_storage.js
curl -fsSL https://raw.githubusercontent.com/0118Add/X86-N1-Actions/main/general/os-release > package/base-files/files/etc/os-release

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/Argon 主题设置/Argon设置/g' feeds/luci/applications/luci-app-argon-config/po/zh-cn/argon-config.po
#sed -i 's/Design 主题设置/Design设置/g' feeds/luci/applications/luci-app-design-config/po/zh-cn/design-config.po
#sed -i 's/CPU 性能优化调节/性能优化/g' feeds/luci/applications/luci-app-cpufreq/po/zh-cn/cpufreq.po
#sed -i 's/一键分区扩容/分区扩容/g' package/luci-app-partexp/po/zh-cn/partexp.po
#sed -i 's/"管理权"/"改密码"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i 's/TTYD 终端/命令行/g' feeds/luci/applications/luci-app-ttyd/po/zh-cn/terminal.po
#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/msgstr "KMS 服务器"/msgstr "KMS激活"/g' feeds/luci/applications/luci-app-vlmcsd/po/zh-cn/vlmcsd.po
#sed -i 's/msgstr "UPnP"/msgstr "UPnP设置"/g' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po
#sed -i 's/Frp 内网穿透/内网穿透/g' feeds/luci/applications/luci-app-frpc/po/zh-cn/frp.po
#sed -i 's/Frpc内网穿透/内网穿透/g' package/luci-app-multi-frpc/po/zh-cn/frp.po
#sed -i 's/NekoClash/Clash/g' package/nekoclash/luci-app-nekoclash/luasrc/controller/neko.lua
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/root/usr/share/luci/menu.d/luci-app-unblockneteasemusic.json
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
#sed -i 's/V2ray 服务器/V2ray服务/g' feeds/luci/applications/luci-app-v2ray-server/po/zh-cn/v2ray_server.po
#sed -i 's/SoftEther VPN 服务器/SoftEther/g' feeds/luci/applications/luci-app-softethervpn/po/zh-cn/softethervpn.po
#sed -i 's/firstchild(), "VPN"/firstchild(), "GFW"/g' feeds/luci/applications/luci-app-softethervpn/luasrc/controller/softethervpn.lua
#sed -i 's/IPSec VPN 服务器/IPSec VPN/g' feeds/luci/applications/luci-app-ipsec-vpnd/po/zh-cn/ipsec.po
#sed -i 's/WireGuard 状态/WiGd状态/g' feeds/luci/applications/luci-app-wireguard/po/zh-cn/wireguard.po
#sed -i 's/Turbo ACC 网络加速/网络加速/g' package/luci-app-turboacc/po/zh-cn/turboacc.po

# 去掉ssr+中shadowsocksr-libev的libopenssl-legacy依赖支持
#sed -i 's/ +libopenssl-legacy//g' package/helloworld/shadowsocksr-libev/Makefile

# 固定shadowsocks-rust版本以免编译失败
#rm -rf package/helloworld/shadowsocks-rust
#wget -P package/helloworld/shadowsocks-rust https://github.com/wekingchen/my-file/raw/master/shadowsocks-rust/Makefile
#rm -rf package/openwrt-passwall/shadowsocks-rust
#wget -P package/openwrt-passwall/shadowsocks-rust https://github.com/wekingchen/my-file/raw/master/shadowsocks-rust/Makefile

# 调整 Dockerman 到 服务 菜单
sed -i 's/"admin",/"admin","services",/g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/model/*.lua
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
sed -i 's/"admin/"admin\/services/g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# 调整 Zerotier 到 服务 菜单
#sed -i 's/vpn/services/g' feeds/other/lean/luci-app-zerotier/luasrc/controller/*.lua
#sed -i 's/vpn/services/g' feeds/other/lean/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua
#sed -i 's/vpn/services/g' feeds/other/lean/luci-app-zerotier/luasrc/view/zerotier/*.htm
sed -i 's/vpn/services/g' package/luci-app-zerotier/root/usr/share/luci/menu.d/luci-app-zerotier.json

# 调整 bypass 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
#sed -i 's/services/vpn/g' package/luci-app-bypass/luasrc/view/bypass/*.htm

# 调整 SSRP 到 GFW 菜单
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/*.lua
#sed -i 's/services/vpn/g' package/helloworld/luci-app-ssr-plus/luasrc/view/shadowsocksr/*.htm

# 调整 Pass Wall 到 GFW 菜单
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/passwall/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/socks_auto_switch/*.htm

# 调整 Pass Wall 2 到 GFW 菜单
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/model/cbi/passwall2/client/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/model/cbi/passwall2/server/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/passwall2/*.lua
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/app_update/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/global/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/haproxy/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/log/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/node_list/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/rule/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/server/*.htm
#sed -i 's/services/vpn/g' package/passwall2/luci-app-passwall2/luasrc/view/passwall2/socks_auto_switch/*.htm

# 调整 Hello World 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/view/vssr/*.htm

# 调整 Open Clash 到 GFW 菜单
#sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luci-app-openclash/luasrc/view/openclash/*.htm

# 修正部分从第三方仓库拉取的软件 Makefile 路径问题
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/rust\/rust-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/rust\/rust-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}

./scripts/feeds update -i
./scripts/feeds install -a
