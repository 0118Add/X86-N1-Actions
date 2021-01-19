#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: ARMv8-S.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/xiaorouji/openwrt-package' feeds.conf.default

#使用源码自带ShadowSocksR Plus+出国软件
sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#添加额外软件包
rm -rf package/lean/luci-app-dockerman
git clone https://github.com/lisaac/luci-app-dockerman.git package/lean/luci-app-dockerman
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package/brook package/brook
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package/chinadns-ng package/chinadns-ng
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package/trojan-go package/trojan-go
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package/trojan-plus package/trojan-plus
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package/ssocks package/ssocks
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package/tcping package/tcping
#svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/luci-app-passwall
#svn co https://github.com/siropboy/mypackages/trunk/luci-app-autopoweroff package/openwrt-packages/luci-app-autopoweroff
#svn co https://github.com/siropboy/mypackages/trunk/luci-app-control-timewol package/openwrt-packages/luci-app-control-timewol
#git clone https://github.com/tty228/luci-app-serverchan.git package/openwrt-packages/luci-app-serverchan
#git clone https://github.com/8688Add/luci-app-adbyby-plus-special.git package/luci-app-adbyby-plus-ram_edition-special
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#git clone https://github.com/8688Add/luci-app-vssr-plus.git package/luci-app-vssr-plus
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone https://github.com/Lienol/openwrt-package.git package/openwrt-package
#git clone https://github.com/Mattraks/helloworld.git package/luci-app-ssr-plus
#git clone https://github.com/bin20088/luci-theme-argon-mc.git package/openwrt-packages/luci-theme-argon-mc
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/openwrt-packages/luci-theme-opentomcat
#git clone https://github.com/bin20088/luci-theme-butongwifi.git package/openwrt-packages/luci-theme-butongwifi
#git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/openwrt-packages/luci-theme-atmaterial
#git clone https://github.com/bin20088/luci-app-koolproxy.git package/openwrt-packages/luci-app-koolproxy
#git clone https://github.com/bin20088/luci-app-koolddns.git package/luci-app-koolddns
git clone https://github.com/tuanqing/install-program package/install-program
git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
#svn co https://github.com/8688Add/sirpdboy-package/trunk/luci-app-ddnsto package/luci-app-ddnsto
#rm -rf package/lean/v2ray
#svn co https://github.com/8688Add/Lienol-openwrt-package/trunk/package/v2ray package/v2ray
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/lean/luci-app-gost
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/lean/gost
svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/diy/luci-app-ssr-plus
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/diy/redsocks2
#svn co https://github.com/xiaorouji/openwrt-package/trunk/lienol/luci-app-passwall package/lean/luci-app-passwall
#svn co https://github.com/xiaorouji/openwrt-package/trunk/package package/lean/package

#赋予koolddns权限
#chmod 0755 package/luci-app-koolddns/root/etc/init.d/koolddns
#chmod 0755 package/luci-app-koolddns/root/usr/share/koolddns/aliddns

./scripts/feeds update -a
./scripts/feeds install -a
