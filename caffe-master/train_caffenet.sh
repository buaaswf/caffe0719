#!/usr/bin/env sh

gpunum=0
for file in `ls /home/s.li/caffe0719/data/patch`
do
    echo $file
    if [ -d /home/s.li/caffe0719/data/patch/$file -a  "$gpunum" -lt 8 ];
    then
        echo "start..."
        cp models/idface/patch_train.prototxt  models/idface/patch_train_$file.prototxt
        sed -i 's/patch_mean.binaryproto/'$file'\/patch'$file'_mean.binaryproto/g' models/idface/patch_train_$file.prototxt 
        sed -i 's/patch_train_lmdb/patch'$file'_train_lmdb/g' models/idface/patch_train_$file.prototxt 
        sed -i 's/patch_val_lmdb/patch'$file'_val_lmdb/g' models/idface/patch_train_$file.prototxt 
        cp models/idface/patch_solver.prototxt  models/idface/patch_solver_$file.prototxt
        sed -i 's/deepid.prototxt/patch_train_'$file'.prototxt/g' models/idface/patch_solver_$file.prototxt 
        echo "ready!"
#:<<_a_ 
    ./build/tools/caffe train \
        --solver=models/idface/patch_solver_$file.prototxt -gpu $gpunum
        $gpunum = $gpunum +1
        echo $file
#_a_
    fi
done &

