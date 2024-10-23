#! /bin/sh

# 从GitHub上下载安装包
OPVPN_URL="https://github.com/OpenWrt01/MT7621/blob/main/package/202410_openvpn.tar.gz"
PASSWALL_URL="https://github.com/OpenWrt01/MT7621/blob/main/package/202410_passwall.tar.gz"
PASSWALL2_URL="https://github.com/OpenWrt01/MT7621/blob/main/package/202410_passwall2.tar.gz"
SSR_URL="https://github.com/OpenWrt01/MT7621/blob/main/package/202410_ssr%2B.tar.gz"

# 让用户选择
echo "请选择要安装的插件："
echo "1. PASSWALL"
echo "2. PASSWALL2"
echo "3. SSR+"
echo "4. OpenVPN"

read -p "请输入数字:" num

# 执行安装命令
if [ $num -eq 1 ]
then
    PACKAGE_URL=$PASSWALL_URL
    echo "正在安装PASSWALL>>>..."
elif [ $num -eq 2 ]
then
    PACKAGE_URL=$PASSWALL2_URL
    echo "正在安装PASSWALL2>>>..."
elif [ $num -eq 3 ]
then
    PACKAGE_URL=$SSR_URL
    echo "正在安装SSR+>>>..."
elif [ $num -eq 4 ]
then
    PACKAGE_URL=$OPVPN_URL
    echo "正在安装Openvpn>>>..."
else
    echo "无效选择"
    exit 1
fi

# 下载插件包
FILENAME=$(basename $PACKAGE_URL)
wget -O $FILENAME $PACKAGE_URL

# 检查下载是否成功
if [ ! -f $FILENAME ]
then
    echo "从链接 $PACKAGE_URL 下载失败,请检查网络或稍后再试!"
    exit 1
fi

# 创建目录解压缩
DIR_NAME="${FILENAME%.tar.gz}"
mkdir $DIR_NAME
tar -zxvf $FILENAME -C $DIR_NAME

# 安装所有ipk文件
cd $DIR_NAME
opkg install --force-overwrite ./*.ipk

# 清理下载和解压的文件和目录
cd ..
rm -rf $FILENAME $DIR_NAME

echo "已安装 $num"

