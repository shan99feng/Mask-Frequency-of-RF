
export OMP_NUM_THREADS=4
export MKL_NUM_THREADS=4

export CUDA_VISIBLE_DEVICES=0,1,2,3
NGPUS=4
LR=0.0006
# export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
# NGPUS=8
# LR=0.0012

# rm ./res_pretrain/model_300.pth

## bs=2048, lr=1.2e-3

# mfm pretraining
torchrun --nproc_per_node=$NGPUS train_mfm.py \
    --data-path ./imagenet/ \
    --model resnet50 \
    --epochs 300 \
    --opt adamw \
    --batch-size 256 \
    --lr $LR \
    --wd 0.05 \
    --lr-scheduler cosineannealinglr \
    --lr-warmup-epochs 20 \
    --clip-grad-norm 3.0 \
    --lr-warmup-method linear \
    --output-dir ./res_pretrain \
    --amp \
    --use-dali \
    --train-crop-size 224

    # --lr 0.0009 \
    # --lr 0.0012 \
    # --resume res_pretrain/model_80.pth \


sleep 10

# finetune 100ep
export CUDA_VISIBLE_DEVICES=0,1,2,3
NGPUS=4
LR=0.006
# export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
# NGPUS=8
# LR=0.012

## bs=2048, lr=1.2e-2

torchrun --nproc_per_node=$NGPUS train_finetune.py \
    --data-path ./imagenet/ \
    --model resnet50 \
    --batch-size 256 \
    --epochs 100 \
    --opt adamw \
    --lr $LR \
    --wd 0.02 \
    --label-smoothing 0.1 \
    --mixup-alpha 0.1 \
    --cutmix-alpha 1.0 \
    --lr-scheduler cosineannealinglr \
    --lr-warmup-epochs 5 \
    --lr-warmup-method linear \
    --output-dir ./res_finetune \
    --auto-augment ra_6_10 \
    --weights ./res_pretrain/model_300.pth \
    --amp \
    --val-resize-size 236 \
    --train-crop-size 160


    # --lr 0.009 \
    # --lr 0.012 \
