# Remote Desktop

A PowerShell tool to manage Remote Desktop Access on a remote or a local Windows Machine.

# Introduction

In order to set a Remote Desktop Connection on Windows :
* Remote Desktop must be enabled
* You must have permission to connect, so you must be on the list of users allowed to connect.
* You must have network access to the remote machine (You may need to allow Remote Desktop connections through the firewall.)

The main purpose of this tool is to provide a quick way to check the first two conditions.
This tool can also be used to check who can use Remote Desktop on your network as part of a security audit.
Note that some [ransomwares](https://nakedsecurity.sophos.com/2018/12/18/after-samsam-ryuk-shows-targeted-ransomware-is-still-evolving/) use RDP in order to spread on the network

## Getting Started

### Prerequisites

You will need RW access to registry key ```HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server``` to enable/disable RDP on your remote/local machine.

### Installing

In order to use this tool, you need to import the module into PowerShell.

```
Import-Module C:\PATHtoModule\RemoteDesktop.psm1
```


## Use the tool on a remote machine

To use this tool on a remote machine, just add the following parameter : ```-ComputerName HOSTNAME```
Otherwise, the script will be executed on your local machine.

## Check Remote Desktop Status

This command checks the remote Desktop status based on registry key : ```HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server```

```
Get-RDPstatus -ComputerName HOSTNAME
```


### Enable Remote Desktop

```
Enable-RDP -ComputerName HOSTNAME
```

### Disable Remote Desktop

```
Disable-RDP -ComputerName HOSTNAME
```

### Get the list of users allowed to connect to a remote machine

This command lists the members of "Remote Desktop Users" local group who are allowed to use remote desktop on this machine.

```
Get-RDPUsers -ComputerName HOSTNAME
```

### Give a user Remote Desktop Access

This command adds USER to "Remote Desktop Users" local group on HOSTNAME.

```
add-RDPUser -Computername HOSTNAME -UserName USER
```

### Remove a user from "Remote Desktop Users" local group

This command removes USER from "Remote Desktop Users" local group on HOSTNAME.

```
Remove-RDPUser -Computername HOSTNAME -UserName USER
```
