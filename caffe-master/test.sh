 cp -r ~/caffe0719/data/patch/$1/train ./data/face/patch/$1/ &&
./examples/patches17/autocreate.sh $1 && 
./examples/patches17/automake.sh $1
