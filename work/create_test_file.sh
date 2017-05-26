#!/bin/bash
case "$1" in
	-h) echo "-c filename to create format file"
	    echo "-m filename(program source file) to make to man file"         
	    echo "example create_test_file -m file.c file ";;
	-c) touch $2
		#declare
		echo "/*---------@.TH  1 "`date` author:ksx"@------*/">>$2
		#name
		echo "/*------@.SH NAME@-----*/">>$2
		#option/introduce
		echo "/*---------@.SH SYNOPSIS@-------*/">>$2
		echo "/*--------@.SH NOTE@----------*/">>$2
		#example
                echo "/*--------@.SH EXAMPLE@-------*/">>$2
		echo "/*--------@.EX@----------*/">>$2
		echo "/*-------@this is a test\&@----*/">>$2
		echo "/*--------@.TP@-------------*/">>$2
		echo "/*-------@helplink:some url@------*/">>$2
		echo "/*-------@.EE@-------*/">>$2
		echo "/*-------@the standard the include file path in the system@----*/">>$2;;
	-m)     ./$3 >> $2
	       #	gawk 'BEGIN{FS="@"}{ if($2==""){print $1} else{print $2}}'  $2>>$2.1
		gawk 'BEGIN{FS="@"; RS="\n"}{ if($2==""){print $1} else{print $2}}' $2 >> $2.1
		gzip -c $2.1> $3.1.gz
		mv $3.1.gz /usr/share/man/man1 ;;
        *)echo "input -h to get help";;
esac

