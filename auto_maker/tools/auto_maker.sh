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
	echo ">>> Init Environment ...    "
	cd ../..
	source build/envsetup.sh >/dev/null
	echo "<<< Init Environment Done!  "
	cd -
}

function clean(){
	echo ">>> Sure Cleaning WorkSpace? (y/n) <<<"
	read c
	if [ "$c" == "y" ]; then
		echo ">>> Cleaning WorkSpace ...  "
		make cleanall
		echo "<<< Clean WorkSpace Done!   "
	else
		echo ">>> Without Cleaning WorkSpace! "
	fi
}

function fullota(){
	echo ">>>  Making Fullota ... "
	make fullota -j4 SHOW_COMMANDS=true
	if [ "$?" == "0" ]; then
		echo ">>>  Fullota  Done! "
	else
		echo "[GaHoKwan CUST] OTA: Fullota  Fail Pleace Check Logreport! "
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
	echo "Diffota USAGE:"
	echo "=========================================================================="
	echo "   Preparing target_files.zip of previous version in current directory,   "
	echo "   make otadiff => build an Incremental OTA Package.                      "
	echo "   make otadiff PRE=xx/xx/target_files_xx.zip => specify previous package."
	echo "   make otadiff PRE=xx/xx/ota_xx.zip => specify previous ota package.     "
	echo "=========================================================================="
	echo "[GaHoKwan CUST] OTA: All Done For Fullota"
fi

echo "[GaHoKwan CUST] OTA: Thank For Using Auto Maker Script"
echo "[GaHoKwan CUST] OTA: All Rights Reserved by luo2888"
# Script End
