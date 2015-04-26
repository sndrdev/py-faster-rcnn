#! /bin/bash

set -x

export PYTHONUNBUFFERED="True"

# -----------------------------------------------------------------------------
LOG="experiments/logs/multitask_no_bbox_reg_vgg16.txt.`date +'%Y-%m-%d_%H-%M-%S'`"
exec 3>&1 4>&2 &> >(tee -a "$LOG")
echo Logging output to "$LOG"

time ./tools/test_net.py --gpu $1 \
  --def models/VGG16/test.prototxt \
  --net output/default/voc_2007_trainval/vgg16_fast_rcnn_iter_40000.caffemodel \
  --imdb voc_2007_test \
  --cfg experiments/cfgs/no_bbox_reg.yml

# restore stdout/err
exec 1>&3 2>&4
# -----------------------------------------------------------------------------
