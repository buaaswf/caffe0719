#!/usr/bin/env sh
    if [ -d /home/s.li/caffe0719/data/patch/align_casia_web ];
    then
        echo "start..."
        cp models/idface/casia_swf.prototxt models/idface/patch_train_$1.prototxt &&
        sed -i 's/patch_mean.binaryproto/'$1'\/patch'$1'_mean.binaryproto/g' models/idface/patch_train_$1.prototxt&&

        sed -i 's/patch_train_lmdb/patch'$1'_train_lmdb/g' models/idface/patch_train_$1.prototxt&&
        echo "train"
        sed -i 's/patch_val_lmdb/patch'$1'_val_lmdb/g' models/idface/patch_train_$1.prototxt &&
        cp models/idface/solver_0915_1w_align.prototxt  models/idface/patch_solver_$1.prototxt&&
        sed -i 's/deepid.prototxt/patch_train_'$1'.prototxt/g' models/idface/patch_solver_$1.prototxt&& 
        sed -i 's/deepid_28_0_train/deepid_'$1'/g' models/idface/patch_solver_$1.prototxt&& 
    
        echo "ready!"
    ./build/tools/caffe train \
        --solver=models/idface/patch_solver_$1.prototxt -gpu 0
    fi
