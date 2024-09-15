## Connect to the right tenant and right subscription (if you have more than one tenant or more than one subscription, if not follow the last method in this category)
az login --tenant <myTenantID>
#or
az login
# Once you logged in the right Tenant make sure the Subscription you are connected to is the right one before making any changes, use:
az account show --output table
#or
az account set --subscription "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # to change the active subscription to some other
#or
az account list --query "[?isDefault]"

# use this to clear cache:
az account clear

## Step-1: Create a resource group to contain all the resources for this exercise.

RGROUP=$(az group create --name GSN3RG --location centralindia --output tsv --query name)


#Step-2: Use Cloud Shell to create the gns3internalvnet virtual network and the gns3internalsub-1 subnet.

az network vnet create --resource-group $RGROUP --name gns3internalvnet --address-prefixes 172.29.0.0/16 --subnet-name gns3internalsub-1 --subnet-prefixes 172.29.0.0/24


#Step-3: Create a Windows virtual machine by using the Azure CLI

az vm create --resource-group $RGROUP --name GSN3-client --size Standard_DS1_v2 --public-ip-sku Standard --vnet-name gns3internalvnetl --subnet gns3internalsub-1 --image Win2022Datacenter --admin-username <username> --no-wait --admin-password <password>

# To get the list of VM Images along with Publisher name:
az vm image list --all --output table

#Create a Linux virtual machine by using the Azure CLI


az vm create --resource-group $RGROUP --name GNS3-server --size Standard_DS1_v2 --image Ubuntu24:latest  --vnet-name gns3internalvnet --subnet gns3internalsub-1 --admin-username <username> --no-wait --admin-password <password>




--authentication-type ssh --generate-ssh-keys


Step-4: Backup it up using Azure CLI.

az backup vault create --resource-group GSN3RG --location centralindia --name azure-backup


Step:5: Using Cloud Shell, enable a backup.

az backup protection enable-for-vm --resource-group GSN3RG --vault-name azure-backup --vm GSN3-client --policy-name StandardPolicy


Step-6: Monitor the progress of the setup using the Azure CLI.

az backup job list --resource-group GSN3RG --vault-name azure-backup --output table


Step=7: Do an initial backup of the virtual machine, instead of waiting for the schedule to run it.


az backup protection backup-now --resource-group GSN3RG --vault-name azure-backup --container-name GSN3-client --item-name GSN3-client --retain-until 18-10-2030 --backup-management-type AzureIaasVM