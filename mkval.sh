#!/bin/bash
 for filename in `ls`
 do
	file=${filename}
	i=0
	cd $file
	for fin in *
	do
		
		let i++
		count=`ls -l  |wc -l`
		mypath="/home/s.li/caffe0719/data/flip/train/$file" 
		if [ ! -d $mypath ];then
			mkdir -p $mypath 
		fi
		myval="/home/s.li/caffe0719/data/flip/val/$file"
		if [ ! -d $myval ];then
			mkdir -p $myval
		fi
		#count=$[$count/5] 
		if [ $i -le $(($count/5*4)) -o $count -le 5 ];then
			cp -r $fin   "/home/s.li/caffe0719/data/flip/train/$file/$fin"    
		else
			cp -r $fin  "/home/s.li/caffe0719/data/flip/val/$file/$fin"   
			#sed  -i “s/[0-9]*\(_MN\)/$f\1/g”  absd.bc     #
		fi
	done
	cd /home/s.li/caffe0719/data/flip/
done
