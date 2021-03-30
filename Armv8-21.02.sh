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

git clone https://github.com/tuanqing/install-program package/install-program
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lean/luci-app-arpbind package/luci-app-arpbind
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lean/luci-app-autoreboot package/luci-app-autoreboot
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lean/luci-app-filetransfer package/luci-app-filetransfer
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lean/luci-app-ramfree package/luci-app-ramfree
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lienol/luci-app-ssr-mudb-server package/luci-app-ssr-mudb-server
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lienol/luci-app-ipsec-vpnserver-manyusers package/luci-app-ipsec-vpnserver-manyusers
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/lean/luci-lib-fs package/luci-lib-fs
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autocore package/lean/autocore
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cpufreq package/lean/luci-app-cpufreq
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/lean/redsocks2
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/pdnsd-alt package/lean/pdnsd-alt
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/openwrt-fullconenat package/lean/openwrt-fullconenat
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-flowoffload package/lean/luci-app-flowoffload
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusic package/lean/UnblockNeteaseMusic
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/UnblockNeteaseMusicGo package/lean/UnblockNeteaseMusicGo
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-unblockmusic package/lean/luci-app-unblockmusic
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-jd-dailybonus package/lean/luci-app-jd-dailybonus
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/adbyby package/lean/adbyby
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-adbyby-plus package/lean/luci-app-adbyby-plus
svn co https://github.com/garypang13/openwrt-packages/trunk/smartdns-le package/smartdns-le
git clone https://github.com/garypang13/luci-app-bypass.git package/luci-app-bypass
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb

#修改bypass的makefile
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

# 添加cpufreq
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g' package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_mvebu||TARGET_sunxi||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile
