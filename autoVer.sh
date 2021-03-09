#!/bin/bash

OpVersion=$(echo "$(cat /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings)" | grep -Po "DISTRIB_REVISION=\'\K[^\']*")

echo $OpVersion

sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/mk_s905x3_multi.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/mk_s905d_n1.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/OLD_mk_n1_opimg.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/mk_s912_zyxq.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/mk_s922x_gtking.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/mk_rk3328_beikeyun.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/mk_rk3328_l1pro.sh
sed -i "s/OPENWRT_VER=.*/OPENWRT_VER=\"$OpVersion\"/" /opt/openwrt/n1-to-vplus.sh
