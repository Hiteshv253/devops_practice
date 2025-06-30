## Apply them:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

## Verify
kubectl get pods
kubectl get svc

## Access the app:
http://<NODE-IP>:30080


## Check Deployment status
kubectl get deployments


## Check Pods created by the Deployment:
kubectl get pods -l app=nginx

## Describe the Deployment (for details):
kubectl describe deployment nginx-deployment


## This will run a CPU load test for 5 minutes (--timeout 300s) using 2 threads (--cpu 2).
kubectl apply -f cpu-stress.yaml

If you want replicas to auto-scale based on CPU usage, use HPA:
## kubectl autoscale deployment nginx-deployment --cpu-percent=50 --min=2 --max=5


## Then stress the system and watch scaling with:
kubectl get hpa -w


kubectl delete pod <pod-name>
kubectl delete pods --all

## Scale Deployment to 0 (Stop All Pods from a Deployment)
kubectl scale deployment <deployment-name> --replicas=0
