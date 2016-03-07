#!/bin/bash

tt=1
while ((tt=1)) 
do
	echo -e "<<\c"
	read order
	
	if [ $order = "load" ]; then
		echo "请输入文件名(无后缀名)："
		read filename
		echo $filename > "file.ran"
	fi
	if [ $order = "fpc" ]; then
		if [ -f "file.ran" ]; then
			read filename < "file.ran"
		else
			echo "请载入要操作文件名（无后缀名）"
			read filename
			echo $filename > "file.ran"
		fi
		fpc $filename
	fi
	if [ $order = "run" ]; then
		if [ -f "file.ran" ]; then
			read filename < "file.ran"
		else
			echo "请载入要操作文件名（无后缀名）"
			read filename
			fpc $filename
			echo $filename > "file.ran"
		fi
		
		if [ -f $filename ]; then
			echo "已找到程序"
		else
			fpc $filename
		fi
		echo "程序正在运行"
		./$filename
	fi
	if [ $order = "print" ]; then
		if [ -f "file.ran" ]; then
			read filename < "file.ran"
		else
			echo "请载入要操作文件名（无后缀名）"
			read filename
			echo $filename > "file.ran"
		fi
		echo $filename"(.pas)"
	fi
	if [ $order = "exit" ];  then
		exit
	fi

	if [ $order = "cal" ]; then
		echo "请输入运算表达式"
		read string
		echo "begin writeln(" $string "); end." >"cal.ran"
		fpc cal.ran >& "wuyong.out"
		if [ -f "cal" ]; then 
			./cal
		else
			echo "输入不合法"
		fi
		rm -f cal.ran
		rm -f cal
		rm -f cal.o
		rm -f wuyong.out
	fi
done
