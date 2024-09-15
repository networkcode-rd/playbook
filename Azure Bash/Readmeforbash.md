Playbook for Bash commands used for Azure Troubleshooting

But if you wish to learn more, refer the Microsoft Azure CLI documentation: https://learn.microsoft.com/en-us/cli/azure/

Add-on
------------------------------
[Windows only] Azure CLI is collecting feedback on using the Web Account Manager (WAM) broker for the login experience.

You may opt-in to use WAM by running the following commands:

az config set core.allow_broker=true
az account clear
az login

Web Account Manager (WAM) is an authentication broker that is the default authentication method for Azure CLI on Windows.

Author - Ratnavo Dutta