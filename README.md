# MFM
Unofficial code for paper "Masked Feature Prediction for Self-Supervised Visual Pre-Training" (https://arxiv.org/pdf/2206.07706.pdf)


## Platform

* pytorch 1.11.0
* torchvision 0.12.0
* dali 1.16.0
* V100 GPU(32G) x 8


## Dataset
Prepare imagenet val set in same method as pytorch official classification [example](https://github.com/pytorch/examples/tree/main/imagenet), and then link them to the folder of this repo:
```
    $ mkdir -p imagenet
    $ ln -s /path/to/imagenet/train ./imagenet/train
    $ ln -s /path/to/imagenet/val ./imagenet/val
```

Pretraining and finetuning Command is [here](./dist_train.sh)



