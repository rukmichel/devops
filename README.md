# devops
## Authenticate Terraform to Azure

```powershell
az login `
az account set --subscription {subscription_id} `

```
Create a Service Principal for Terraform

```powershell
$sp = (az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/{subscription_id} --display-name "Terraform-michel") | ConvertFrom-Json `

 $env:ARM_CLIENT_ID = $sp.appId 
 $env:ARM_CLIENT_SECRET = $sp.password 
 $env:ARM_SUBSCRIPTION_ID = {subscription_id} 
 $env:ARM_TENANT_ID = $sp.tenant 

gci env:ARM_*
```

