Playbook for Bash commands used for Azure Troubleshooting

But if you wish to learn more, refer the Microsoft Azure CLI documentation: https://learn.microsoft.com/en-us/cli/azure/

Add-on
------------------------------
[Notification for Windows only] Azure CLI has introduced Web Account Manager (WAM) broker for the login experience. Web Account Manager (WAM) is an authentication broker that is the default authentication method for Azure CLI on Windows.

You may opt-in to use WAM by running the following commands:

az config set core.allow_broker=true
<br>
az account clear
<br>
az login
<br>



Author - Ratnavo Dutta
Networkcode