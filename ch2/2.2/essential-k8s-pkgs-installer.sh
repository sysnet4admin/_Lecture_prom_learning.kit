#!/usr/bin/env bash

# main scripfiles dir 
SCRIPTSDIR=$HOME/_Lecture_prometheus_learning.kit/ch2/2.2/essential-k8s-pkgs

# helm 3.9.1 installer
sh $SCRIPTSDIR/get-helm-3.9.1.sh

# metallb v0.13.3
kubectl apply -f $SCRIPTSDIR/metallb-native-v0.13.3.yaml

# metrics server v0.6.1 - insecure mode 
kubectl apply -f  $SCRIPTSDIR/metrics-server-0.6.1.yaml

# NFS dir configuration
sh $SCRIPTSDIR/nfs-exporter.sh dynamic-vol

# nfs-provsioner installer 
kubectl apply -f  $SCRIPTSDIR/nfs-provisioner.yaml

# storageclass installer & set default storageclass
kubectl apply -f $SCRIPTSDIR/storageclass.yaml 

# setup default storage class due to no mention later on
kubectl annotate storageclass managed-nfs-storage storageclass.kubernetes.io/is-default-class=true

# config metallb ip range and it cannot deploy with metallb due to CRD cannot create yet 
(sleep 300 && kubectl apply -f $SCRIPTSDIR/metallb-iprange.yaml)&
