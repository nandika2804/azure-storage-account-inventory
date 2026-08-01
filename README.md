# azure-storage-account-inventory
PowerShell-based inventory and reporting tool for Azure Storage Accounts.

## Overview

This tool automates the discovery and reporting of Azure Storage Accounts across multiple Azure subscriptions.

The script accepts a list of Storage Account names and Resource Groups from an Excel file, searches across all enabled Azure subscriptions, and exports inventory information into an Excel report.


## Features
- Bulk Storage Account discovery
- Cross-subscription lookup
- Excel input support
- Excel output generation
- Resource Group validation
- Azure PowerShell integration
- Large-scale reporting support

## Output
Generated file: SAnames_Output.xlsx

Output contains:
- Storage Account
- Environment
- Private Endpoint Enabled
- Subscription
- Resource Group
- Content Details

## Example Use Cases
- Cloud inventory audits
- Migration assessments
- Storage governance reviews
- Subscription cleanup activities
- Azure operations reporting

## Prerequisites

### Azure PowerShell

```powershell

Install-Module Az -Scope CurrentUser
Install-Module ImportExcel -Scope CurrentUser
 
./Get-StorageAccountInventory.ps1
