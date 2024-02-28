---
abstract: The process for bringing up a bare-metal k8s cluster with kubeadm.
authors: Xander Harris
date: 2024-03-01
title: Kubeadm Setup
---

[kubeadm init issue](https://forum.linuxfoundation.org/discussion/862809/lab-3-1-kubeadm-init-error-creating-kube-proxy-service-account)

## First Control Plane

```{code-block} shell
cert_key="$(kubeadm certs certificate-key)"
node_token="$(kubeadm token generate)"

kubeadm init --apiserver-advertise-address 192.168.1.50 \
    --apiserver-bind-port 6443 \
    --apiserver-cert-extra-sans '192.168.1.50,192.168.1.51,kcp01.socal.rr.com,kubernetes.default.svc.local,kubernetes' \
    --certificate-key "${cert_key}" \
    --control-plane-endpoint 'kcp01.socal.rr.com' --node-name 'kcp01' \
    --token "${node_token}" \
    --upload-certs
```

````{card} kubeadm init output
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

```{code-block} shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Alternatively, if you are the root user, you can run:

```{code-block} shell
export KUBECONFIG=/etc/kubernetes/admin.conf
```

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

```{code-block} shell
kubeadm join kcp01.socal.rr.com:6443 --token "${node_token}" \
    --discovery-token-ca-cert-hash ${ca_cert_hash} \
    --control-plane --certificate-key "${cert_key}"
```

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join kcp01.socal.rr.com:6443 --token ${node_token} \
    --discovery-token-ca-cert-hash ${ca_cert_hash}
````

## Second Control Plane

```{code-block} shell
kubeadm join kcp01.socal.rr.com:6443 --token ${node_token} \
    --discovery-token-ca-cert-hash ${ca_cert_hash} \
    --control-plane --certificate-key ${cert_key}
```
