#Start a VM	
az vm start --resource-group myResourceGroup --name myVM

#Stop a VM	
az vm stop --resource-group myResourceGroup --name myVM

#Deallocate a VM	
az vm deallocate --resource-group myResourceGroup --name myVM

#Restart a VM	
az vm restart --resource-group myResourceGroup --name myVM

#Redeploy a VM	
az vm redeploy --resource-group myResourceGroup --name myVM

#Delete a VM	
az vm delete --resource-group myResourceGroup --name myVM