#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/{lean,lienol,ctcgfw,ntlf9t} package
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/openwrt-passwall/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/openwrt-passwall/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/redsocks2 package/openwrt-passwall/redsocks2
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/openwrt-passwall/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/openwrt-passwall/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/openwrt-passwall/naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/openwrt-passwall/simple-obfs
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/openwrt-passwall/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/openwrt-passwall/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/openwrt-passwall/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocks-rust package/openwrt-passwall/shadowsocks-rust
sed -i '/banner/d' package/lean/default-settings/Makefile
sed -i '/banner/d' package/lean/default-settings/files/zzz-default-settings
git clone https://github.com/tuanqing/install-program package/install-program
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autocore package/lean/autocore
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cpufreq package/lean/luci-app-cpufreq
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/openwrt-fullconenat package/lean/openwrt-fullconenat
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-flowoffload package/lean/luci-app-flowoffload
svn co https://github.com/garypang13/openwrt-packages/trunk/smartdns-le package/smartdns-le
git clone https://github.com/garypang13/luci-app-bypass.git package/luci-app-bypass
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb

#修改bypass的makefile
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

# 添加cpufreq
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
#sed -i 's/services/system/g' package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua
#sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_mvebu||TARGET_sunxi||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile
