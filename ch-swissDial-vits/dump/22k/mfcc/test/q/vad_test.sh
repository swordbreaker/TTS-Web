#!/bin/bash
cd /scicore/home/graber0001/perity98/IP922/espnet/egs2/ch_swissDial_vits/tts
. ./path.sh
( echo '#' Running on `hostname`
  echo '#' Started at `date`
  set | grep SLURM | while read line; do echo "# $line"; done
  echo -n '# '; cat <<EOF
compute-vad --config=conf/vad.conf scp:dump/22k/mfcc/test/split8/${SLURM_ARRAY_TASK_ID}/feats.scp ark,scp:/scicore/home/graber0001/perity98/IP922/espnet/egs2/ch_swissDial_vits/tts/dump/22k/mfcc/test/data/vad_test.${SLURM_ARRAY_TASK_ID}.ark,/scicore/home/graber0001/perity98/IP922/espnet/egs2/ch_swissDial_vits/tts/dump/22k/mfcc/test/data/vad_test.${SLURM_ARRAY_TASK_ID}.scp 
EOF
) >dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
if [ "$CUDA_VISIBLE_DEVICES" == "NoDevFiles" ]; then
  ( echo CUDA_VISIBLE_DEVICES set to NoDevFiles, unsetting it... 
  )>>dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
  unset CUDA_VISIBLE_DEVICES
fi
time1=`date +"%s"`
 ( compute-vad --config=conf/vad.conf scp:dump/22k/mfcc/test/split8/${SLURM_ARRAY_TASK_ID}/feats.scp ark,scp:/scicore/home/graber0001/perity98/IP922/espnet/egs2/ch_swissDial_vits/tts/dump/22k/mfcc/test/data/vad_test.${SLURM_ARRAY_TASK_ID}.ark,/scicore/home/graber0001/perity98/IP922/espnet/egs2/ch_swissDial_vits/tts/dump/22k/mfcc/test/data/vad_test.${SLURM_ARRAY_TASK_ID}.scp  ) &>>dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
ret=$?
sync || true
time2=`date +"%s"`
echo '#' Accounting: begin_time=$time1 >>dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
echo '#' Accounting: end_time=$time2 >>dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
echo '#' Accounting: time=$(($time2-$time1)) threads=1 >>dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
echo '#' Finished at `date` with status $ret >>dump/22k/mfcc/test/log/vad_test.$SLURM_ARRAY_TASK_ID.log
[ $ret -eq 137 ] && exit 100;
touch dump/22k/mfcc/test/q/done.121980.$SLURM_ARRAY_TASK_ID
exit $[$ret ? 1 : 0]
## submitted with:
# sbatch --export=PATH  -p gpu --gres=gpu:4 -c 4 --cpus-per-task 8 --time 24:00:00 --qos 1day --mem-per-cpu 32G --partition a100  --open-mode=append -e dump/22k/mfcc/test/q/vad_test.log -o dump/22k/mfcc/test/q/vad_test.log --array 1-8 /scicore/home/graber0001/perity98/IP922/espnet/egs2/ch_swissDial_vits/tts/dump/22k/mfcc/test/q/vad_test.sh >>dump/22k/mfcc/test/q/vad_test.log 2>&1
