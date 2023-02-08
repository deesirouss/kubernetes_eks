#!/bin/bash
/etc/eks/bootstrap.sh prod-eks-test-vyaguta \
 --use-max-pods false \
  --kubelet-extra-args '--max-pods=40'