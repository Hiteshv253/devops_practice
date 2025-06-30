
To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.190.166:6443 --token r757nf.u0vctw3flbmonce8 \
	--discovery-token-ca-cert-hash sha256:26531eeff4f02d8194a96d08faaefe2c465e07957d23827ae2af8f733f452e7e 


## Token
kubeadm token create --print-join-command
kubeadm join 192.168.190.166:6443 --token j8wsbg.a60d0e5ulmzfvs73 --discovery-token-ca-cert-hash sha256:26531eeff4f02d8194a96d08faaefe2c465e07957d23827ae2af8f733f452e7e  --v=5


## 
kubectl label node worknode-1  node-role.kubernetes.io/worker=worker



================================



mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config


# Network Plugin = calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

kubeadm token create --print-join-command
```

- You will get `kubeadm token`, **Copy it**.
  <img src="https://raw.githubusercontent.com/faizan35/kubernetes_cluster_with_kubeadm/main/Img/kubeadm-token.png" width="75%">

---

## Execute on ALL of your Worker Node's

1. Perform pre-flight checks

   ```bash
   sudo kubeadm reset pre-flight checks
   ```

2. Paste the join command you got from the master node and append `--v=5` at the end.

   ```bash
   sudo your-token --v=5
   ```

   > Use `sudo` before the token.

---

## Verify Cluster Connection

**On Master Node:**

```bash
kubectl get nodes
```

   <img src="https://raw.githubusercontent.com/faizan35/kubernetes_cluster_with_kubeadm/main/Img/nodes-connected.png" width="70%">

---

## Optional: Labeling Nodes

If you want to label worker nodes, you can use the following command:

```bash
kubectl label node <node-name> node-role.kubernetes.io/worker=worker
```

---

## Optional: Test a demo Pod

If you want to test a demo pod, you can use the following command:

```bash
kubectl run hello-world-pod --image=busybox --restart=Never --command -- sh -c "echo 'Hello, World' && sleep 3600"
```

<kbd>![image](https://github.com/paragpallavsingh/kubernetes-kickstarter/assets/40052830/bace1884-bbba-4e2f-8fb2-83bbba819d08)</kbd>
