# K8s deployment

For the first time: 

```kubectl apply -f ./k8s-mamaka-depl.yaml && kubectl apply -f ./k8s-mamaka-lb-service.yaml```

For updates

```kubectl rollout restart deployment mamaka-depl```