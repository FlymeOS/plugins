#!/bin/bash
#
# The MIT License (MIT)
#
# All rights reserved by luo2888
#
# Weibo : www.weibo.com/kwangaho
#  QQ   : 625336209
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Auto maker Script for flyme patchrom
# Script Start

function init(){
	echo ">>> 正在初始化环境 ...    "
	cd ../..
	source build/envsetup.sh >/dev/null
	echo "<<< 环境初始化完成！     "
	cd -
}

function clean(){
	echo ">>> 确定清理缓存文件吗? (y/n) <<<"
	read c
	if [ "$c" == "y" ]; then
		echo ">>> 正在清理缓存文件 ...  "
		make cleanall
		echo "<<< 缓存文件清理完成！   "
	else
		echo ">>> 跳过缓存文件清理！   "
	fi
}

function fullota(){
	echo ">>>  开始制作完整刷机包  ...     "
	make fullota -j4 SHOW_COMMANDS=true
	if [ "$?" == "0" ]; then
		echo ">>>  完整刷机包制作完成！ "
	else
		echo "[GaHoKwan CUST] OTA: 刷机包生成失败，请检查编译日志！ "
	fi
}

OUTDIR=`pwd`/out

# Function Start
init
clean
fullota
# Function End

ls $OUTDIR/ota*.zip
if [ "$?" == "0" ]; then
	export status="done"
fi

if [ "$status" == "done" ]; then
	echo "差分升级包制作:"
	echo "================================================================================"
	echo "   make otadiff => 把上一版本的target_files.zip移动到当前目录,制作差分升级包。  "
	echo "   make otadiff PRE=xx/target_files_xx.zip => 指定版本的target_files_xx.zip 。 "
	echo "   make otadiff PRE=xx/ota_xx.zip => 指定上一个版本的ota_xx.zip。 "
	echo "================================================================================"
	echo "[GaHoKwan CUST] OTA: 刷机包制作完成"
fi

echo "[GaHoKwan CUST] OTA: 感谢您使用刷机包自动编译脚本"
echo "[GaHoKwan CUST] OTA: 一切版权属于luo2888"
# Script End
