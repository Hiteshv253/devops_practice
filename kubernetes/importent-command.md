
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

ie result:  kubeadm join 192.168.190.166:6443 --token j8wsbg.a60d0e5ulmzfvs73 --discovery-token-ca-cert-hash sha256:26531eeff4f02d8194a96d08faaefe2c465e07957d23827ae2af8f733f452e7e  --v=5

## To Check if kubectl Is Installed and Working
kubectl version --client

## To check cluster connection:
kubectl cluster-info
kubectl get nodes

## If You Want to Check Kubernetes Services
sudo systemctl status kubelet
sudo systemctl status docker

## or if you're using containerd:
sudo systemctl status containerd
sudo systemctl start containerd
sudo systemctl enable containerd

sudo kubeadm reset
sudo kubeadm init


sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart kubelet



## 
kubectl label node worknode-1  node-role.kubernetes.io/worker=worker


sudo systemctl status kubelet

## Check logs for Kubelet
sudo journalctl -u kubelet -f


## check application runing port

## argocd
sudo argocd app list
argocd app get <APP_NAME>
kubectl get svc -n <app-namespace>



## GET all nodes
kubectl get nodes
kubectl get pods

kubectl get nodes -n <node name>

## check wokernode details
sudo kubectl describe node "<worker name> "worker-node-1""

## check pode node details
sudo kubectl describe <pod name> ""tetris-deployment-6649dcb877-xtjsl""

================================

# Network Plugin = calico
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

## list of token
kubeadm token list

## create new token
kubeadm token create
  get key like "k8oz1a.d9k5o7b1a8fp7wnu"

## 🔐 Get the CA Certificate Hash (Required for Join)
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | \
openssl rsa -pubin -outform der 2>/dev/null | \
sha256sum | awk '{print $1}'

## Final kubeadm join Command (Worker Node)
sudo kubeadm join <MASTER_IP>:6443 \
  --token <NEW_TOKEN> \
  --discovery-token-ca-cert-hash sha256:<HASH>

## ============================================================================


kubeadm token create --print-join-command

## Execute on ALL of your Worker Node's

1. Perform pre-flight checks
   sudo kubeadm reset pre-flight checks

2. Paste the join command you got from the master node and append `--v=5` at the end.
   sudo your-token --v=5
   ---

## Optional: Labeling Nodes

  ## If you want to label worker nodes, you can use the following command:


kubectl label node <node-name> node-role.kubernetes.io/worker=worker


---

## Optional: Test a demo Pod

If you want to test a demo pod, you can use the following command:

kubectl run hello-world-pod --image=busybox --restart=Never --command -- sh -c "echo 'Hello, World' && sleep 3600"


<kbd>![image](https://github.com/paragpallavsingh/kubernetes-kickstarter/assets/40052830/bace1884-bbba-4e2f-8fb2-83bbba819d08)</kbd>