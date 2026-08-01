# azure-storage-account-inventory
PowerShell-based inventory and reporting tool for Azure Storage Accounts.

## Overview

This tool automates the discovery and reporting of Azure Storage Accounts across multiple Azure subscriptions.

The script accepts a list of Storage Account names and Resource Groups from an Excel file, searches across all enabled Azure subscriptions, and exports inventory information into an Excel report.


## What this script is useful for
This is actually a strong Azure Operations/SRE inventory tool because it helps answer:
- Which subscription contains the storage account?
- Which resource group hosts it?
- Is a private endpoint configured?
- What blob containers exist?
- What file shares exist?
- What tables exist?
- What queues exist?
- Which environment owns the storage account?
  
## Typical use cases:
- Cloud inventory audits
- Migration assessments
- Storage governance reviews
- Security reviews
- Private endpoint validation
- Production environment documentation
- Application dependency discovery

## Output
Generated file: SAnames_Output.xlsx

Output contains:
- Storage Account
- Environment
- Private Endpoint Enabled
- Subscription
- Resource Group
- Content Details


## Prerequisites

### Azure PowerShell

```powershell

Install-Module Az -Scope CurrentUser
Install-Module ImportExcel -Scope CurrentUser
 
./Get-StorageAccountInventory.ps1
