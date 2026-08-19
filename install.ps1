Write-Output "Starting Windows VM configuration..."

Install-WindowsFeature -Name Web-Server -IncludeManagementTools

Set-Content `
    -Path "C:\inetpub\wwwroot\index.html" `
    -Value "<h1>Hello from Gopal's Terraform Windows VM</h1>"

New-Item `
    -Path "C:\Terraform" `
    -ItemType Directory `
    -Force

Set-Content `
    -Path "C:\Terraform\deployment.txt" `
    -Value "This Windows VM was configured using Terraform and PowerShell."

Write-Output "IIS installation completed."
