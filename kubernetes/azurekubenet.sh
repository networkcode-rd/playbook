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
kubectl debug node/aks-agentpool-20806549-vmss000000 -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0
Creating debugging pod node-debugger-aks-agentpool-20806549-vmss000000-k95zk with container debugger on node aks-agentpool-20806549-vmss000000.
If you don't see a command prompt, try pressing enter.
root@aks-agentpool-20806549-vmss000000:/# chroot /host
# 
# apt-get update && apt-get install -i iproute2 net-tools
#==============================================