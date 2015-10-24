#!/usr/bin/env sh
    if [ -d /home/s.li/caffe0719/data/patch/$1 ];
    then
        echo "sh patchdata srcprototxt "
        cp models/idface/$2 models/idface/patch_train_$1.prototxt &&
        sed -i 's/align_casia1000\/patchalign_casia1000_mean.binaryproto/'$1'\/patch'$1'_mean.binaryproto/g' models/idface/patch_train_$1.prototxt&&
        sed -i 's/num_output: 1000/num_output: '$4'/g' models/idface/patch_train_$1.prototxt&&
        sed -i 's/patchalign_casia1000_train_lmdb/patch'$1'_train_lmdb/g' models/idface/patch_train_$1.prototxt&&
        echo "train"
        sed -i 's/patchalign_casia1000_val_lmdb/patch'$1'_val_lmdb/g' models/idface/patch_train_$1.prototxt &&
        cp models/idface/$3  models/idface/patch_solver_$1.prototxt&&
        sed -i 's/casia_1k_aligned.prototxt/patch_train_'$1'.prototxt/g' models/idface/patch_solver_$1.prototxt&& 
        sed -i 's/casia_1k_align/'$1'/g' models/idface/patch_solver_$1.prototxt&& 
    
        echo "ready!"
    ./build/tools/caffe train \
        --solver=models/idface/patch_solver_$1.prototxt -gpu 0
    fi
