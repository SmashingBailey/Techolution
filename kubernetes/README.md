# Important Documentation

## microk8 docs
https://microk8s.io/

### Microk8s overview
Microk8s helps you manage kubernetes with additional plugins fluentd, gpu, storage, registry, ingress, dns, metrics-server, dashbord, prometheus, and istio

## Kubernetes architecture docs
Read Kubernetes docs here https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/

A kubernetes cluster runs on nodes. A node can have multiple pods (pods are containers with your volume, storage, dns, etc. config specs). And pods are exposed by services. You can configure kubernetes to autoscale and add replicas to your microservices.

## Kubernetes API docs
Configuring Kubernetes yaml files will involve the kubernetes API reference:
https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.10/#-strong-api-overview-strong-

# Basic microk8s commands:

## START A KUBERNETES CLUSTER
microk8s.start

## CHECK YOUR CLUSTER
microk8s.kubectl get clusters

## VIEW ADDITIONAL SERVICES
microk8s.status

## ENABLE/DISABLE ADDITIONAL SERVICES
microk8s.enable [service]

## VIEW ALL RUNNING SERVICES
micork8s.kubectl get --all-namespaces all

# Common kubernetes commands with microk8s:

## RETURN ALL PODS, SERVICES, REPLICA SETS, AND DEPLOYMENT APPS
microk8s.kubectl get all

## RETURN A CERTAIN SERVICE (pods, services, nodes, replicas)
microk8s.kubectl get [service] 

## CREATE YOUR CLUSTER WITH YAML FILES
microk8s.kubectl create -f [file]
