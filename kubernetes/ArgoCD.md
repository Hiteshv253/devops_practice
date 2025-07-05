#Step 1: Create the argocd namespace
kubectl create namespace argocd

#Step 2: Install Argo CD Core Components

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml  #This installs the Argo CD server, controller, repo server, and UI.

#Step 3: Wait for Pods to Be Ready
kubectl get pods -n argocd  #Make sure all pods show STATUS=Running.


#Step 4: Expose Argo CD UI (Option A: Port Forward)
kubectl port-forward svc/argocd-server -n argocd 8080:443 #Now you can access Argo CD at: http://localhost:8080


#Step 5: Login to Argo CD UI
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo


#Step 6: Add an App to Argo CD (Example)
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/examples/guestbook.yaml  #http://localhost:8080

#Optional: Install Argo CD CLI
# Linux
curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x argocd && sudo mv argocd /usr/local/bin/


argocd version
