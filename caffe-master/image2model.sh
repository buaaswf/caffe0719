#!/usr/bin/env sh
# examples 
# ./image2model.sh datadir
cd /home/s.li/hj/src/face_align/
./autoalign.sh $1
name=`pwd | rev | awk -F \/ '{print $1}' | rev`
cd ..
var=`pwd`\/align${name}
if [ -d var ];
    then
        echo "start..."
        echo "start making lmdb"
        cd ~/caffe0719/data/patch
        cp -r $var ./ &&
        ./fuustep.sh &&
        echo "mklmdb done"
        mv align${name} ../ &&
        cd /home/s.li/caffe0719/caffe-master/
        cp models/idface/casia_swf.prototxt models/idface/patch_train_${name}.prototxt &&
        sed -i 's/patch_mean.binaryproto/'${name}'\/patch'${name}'_mean.binaryproto/g' models/idface/patch_train_${name}.prototxt&&
        sed -i 's/patch_train_lmdb/patch'${name}'_train_lmdb/g' models/idface/patch_train_${name}.prototxt&&
        echo "training,please have a rest,or do another thing"
        sed -i 's/patch_val_lmdb/patch'${name}'_val_lmdb/g' models/idface/patch_train_${name}.prototxt &&
        cp models/idface/solver_0915_1w_align.prototxt  models/idface/patch_solver_${name}.prototxt&&
        sed -i 's/deepid.prototxt/patch_train_'${name}'.prototxt/g' models/idface/patch_solver_${name}.prototxt&& 
        sed -i 's/deepid_28_0_train/deepid_'${name}'/g' models/idface/patch_solver_${name}.prototxt&& 
        echo "ready!"
        ./build/tools/caffe train \
            --solver=models/idface/patch_solver_$1.prototxt -gpu 0
    fi
