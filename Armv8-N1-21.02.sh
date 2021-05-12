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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
#sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
#sed -i '$a src-git packages https://github.com/garypang13/openwrt-packages' feeds.conf.default

#添加额外软件包
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean package/lean
#rm -rf package/openwrt-packages/luci-app-unblockmusic
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/UnblockNeteaseMusic package/UnblockNeteaseMusic
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/UnblockNeteaseMusicGo package/UnblockNeteaseMusicGo
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/luci-app-unblockmusic package/luci-app-unblockmusic
#git clone https://github.com/garypang13/openwrt-packages.git package/openwrt-packages
#git clone https://github.com/fw876/helloworld.git package/helloworld
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/lean/luci-app-jd-dailybonus
rm -rf luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
svn co https://github.com/ophub/amlogic-s9xxx-openwrt/trunk/amlogic-s9xxx/install-program package/install-program
#git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/luci-app-cpufreq package/lean/luci-app-cpufreq
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/lean/redsocks2

# 添加cpufreq
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
#sed -i 's/services/system/g' package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua
#sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_mvebu||TARGET_sunxi||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-vssr/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-alt/shadowsocksr-libev-ssr-redir/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-vssr/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-server/shadowsocksr-libev-ssr-server/g' {}
