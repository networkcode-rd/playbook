az login --use-device-code
az upgrade
az version
az account tenant list
az login --tenant "replaceWithTenantID"
az account set --subscription "replaceWithSubscriptionID"

#kubernetes---------Using Kubenet setup-------------------------

az aks get-credentials --resource-group Application-testing --name aks-testing-deployment --overwrite-existing
#checkpath: /home/adhoc/.kube/config

#To install kubectl for the first time use:
sudo snap install kubectl --classic

#if not installed kubectl, for the first time, error pops-up:
"Command 'kubectl' not found, but can be installed with:
sudo snap install kubectl"

#fetching cluster information:
kubectl cluster-info

#Getting information on nodes:
kubectl get nodes -o wide

#Getting information on PoDs:
kubectl get pod -o wide


#To get namespace
kubectl get ns


#To create new namespace
kubectl create ns customnamespacerd

#To create a new container for the namespace.
kubectl run superman -n customnamespacerd --image=nginx

#Listing PoD information in specific namespace:
kubectl get pod -n customnamespacerd  -o wide

#To get into a NODE from a POD:
#==============================================
#kubectl debug node/aks-agentpool-20806549-vmss000000 -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0
#Creating debugging pod node-debugger-aks-agentpool-20806549-vmss000000-k95zk with container debugger on node aks-agentpool-20806549-vmss000000.
#If you don't see a command prompt, try pressing enter.
#root@aks-agentpool-20806549-vmss000000:/# chroot /host
# 
# apt-get update && apt-get install -i iproute2 net-tools
#==============================================

#To check the status of an existing/newly created PoD on a specific namespace:
kubectl get all -n customnamespacerd
kubectl get all -n customnamespacerd -o wide

# Deleting a specific PoD from namespace:
kubectl delete pod superman -n customnamespacerd


# To recreate the PoD but with specific service or running a specific port and deployment service:
kubectl create deployment supermanpod -n customnamespacerd --image=nginx --port=80 

#check status:
kubectl get all -n customnamespacerd

# Creating replicas
kubectl scale deployment supermanpod -n customnamespacerd --replicas=2


#Using Declarative approach of reading data in yaml format, use:
kubectl get pod -n customnamespacerd -o yaml

# Internal Cluster Service:
kubectl expose deployment.apps/supermanpod -n customnamespacerd

#Check status: 
kubectl get all -n customnamespacerd

# Getting more information of the service use "describe":
kubectl describe service/supermanpod -n customnamespacerd


#Creating another LB service public facing and then check status:
kubectl expose deployment.apps/supermanpod --name batman -n customnamespacerd --type=LoadBalance

#Check status: 
kubectl get all -n customnamespacerd


#Get all Kube system information:
kubectl get all -n kube-system

#Getting information on namespace and its respective service in a nutshell:
kubectl describe svc -n customnamespacerd
kubectl describe svc "podname" -n customnamespacerd