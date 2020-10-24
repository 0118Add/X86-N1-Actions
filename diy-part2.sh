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

#使用源码自带ShadowSocksR Plus+出国软件
#sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

#sed -i '$a src-git ssrp https://github.com/fw876/helloworld' feeds.conf.default
#sed -i '$a src-git xiaorouji https://github.com/xiaorouji/openwrt-package' feeds.conf.default
#sed -i '$a src-git helloworld https://github.com/jerrykuku/luci-app-vssr' feeds.conf.default
#sed -i '$a src-git hw https://github.com/jerrykuku/lua-maxminddb' feeds.conf.default
#sed -i '$a src-git jd https://github.com/jerrykuku/luci-app-jd-dailybonus' feeds.conf.default

#git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
git clone https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/xiaorouji/openwrt-package.git package/openwrt-package
#git clone https://github.com/8688Add/luci-app-koolproxyR.git package/luci-app-koolproxyR
git clone -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash
#git clone https://github.com/frainzy1477/luci-app-clash.git package/luci-app-clash
git clone https://github.com/8688Add/luci-theme-infinityfreedom.git package/luci-theme-infinityfreedom
#git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
#git clone https://github.com/8688Add/luci-theme-opentomato.git package/luci-theme-opentomato
rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#git clone -b 18.06 https://github.com/garypang13/luci-theme-edge package/luci-theme-edge
#rm -rf package/applications/luci-app-https-dns-proxy
#git clone https://github.com/8688Add/https-dns-proxy.git package/applications/luci-app-https-dns-proxy-whisky
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
#git clone https://github.com/riverscn/openwrt-iptvhelper.git package/luci-app-iptvhelper
