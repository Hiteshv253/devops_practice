Build and push your Docker image:
 
docker build -t your-registry/lions-app:latest .
docker push your-registry/lions-app:latest


Deploy to your cluster:

kubectl apply -f k8s-deployment.yaml
kubectl apply -f k8s-db.yaml


Verify everything is running:
kubectl get pods -n lions
kubectl get svc -n lions
