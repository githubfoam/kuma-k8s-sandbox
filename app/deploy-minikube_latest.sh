#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

#Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

#https://minikube.sigs.k8s.io/docs/start/
#https://github.com/kubernetes/minikube
# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.2.0/minikube-linux-amd64
chmod +x minikube
cp minikube /usr/local/bin/ && rm minikube
#starts Minikube with 6 CPUs, 12288 memory, 120G disk size
minikube start --vm-driver=none \
                --cpus 6 \
                --memory 12288 \
                --disk-size=120g \
                --extra-config=apiserver.authorization-mode=RBAC \
                --extra-config=kubelet.resolv-conf=/run/systemd/resolve/resolv.conf \
                --extra-config kubeadm.ignore-preflight-errors=SystemVerification

# Set docker environment to minikube
eval "$(minikube docker-env --profile=minikube)" && export DOCKER_CLI='docker'

echo "=========================================================================================="
kubectl version --client #ensure the version
kubectl cluster-info
minikube status
echo "=========================================================================================="
echo "Waiting for kubernetes to be ready ..."
  for i in {1..150}; do # Timeout after 5 minutes, 150x2=300 secs
    if kubectl get pods --namespace=kube-system -lk8s-app=kube-dns|grep Running ; then
      break
    fi
    sleep 2
  done
echo "============================status check=============================================================="
minikube status
kubectl cluster-info
kubectl get pods --all-namespaces
kubectl get pods -n default
kubectl get pod -o wide #The IP column will contain the internal cluster IP address for each pod.
kubectl get service --all-namespaces # find a Service IP,list all services in all namespaces
