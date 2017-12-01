#!/bin/bash
#
whiptail --title "语言(Language)" --yes-button "中文" --no-button "English" --yesno "请选择语言.（Please choose Language）" 10 80
	if [ "$?" == "0" ]; then
		script -f Compile.log -c 'source tools/auto_maker_cn.sh'
	else
		export LANG=C
		script -f Compile.log -c 'source tools/auto_maker.sh'
	fi
read anykey
