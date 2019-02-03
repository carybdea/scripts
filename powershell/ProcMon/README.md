# About ProcMon

[Process Monitor](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon) is an advanced monitoring tool for Windows that shows real-time file system, Registry and process/thread activity. It combines the features of two legacy Sysinternals utilities, Filemon and Regmon, and adds an extensive list of enhancements including rich and non-destructive filtering, comprehensive event properties such session IDs and user names, reliable process information, full thread stacks with integrated symbol support for each operation, simultaneous logging to a file, and much more. Its uniquely powerful features will make Process Monitor a core utility in your system troubleshooting and malware hunting toolkit.

# About this tool

This Script gives you the possibility to run ProcMon on a remote computer.
It will copy Procmon in a remote system and run it quietly using PsExec, then generates a log file that will be copied into your local machine for troubleshooting and analysis.

# Getting Started

## Prerequisites

* [Procmon](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon)
* [PsExec](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec)
* Access to remote machine.
* 500MB free disk space on both remote and local machines,

## Parameters

* -ComputerName HOSTNAME, Hostname or IP address of the remote machine.
* -Duration TIMEINSECONDS, duration of data collet, default duration is 20 seconds.
* -ProcmonPath PROCMONPATH, path To Procmon.exe on local machine, default path :  ```C:\Tools\ProcessMonitor\Procmon.exe```
* -PsExecPath PSEXECPATH, path to PsExec.exe on your local machine, default path :  ```C:\Tools\PSTools\PsExec.exe ```
* -SaveDataPath SAVEPATH, path to save the generated log file on your local machine, default path :  ```C:\Tools\ProcmonData```

# Contributions
You are welcome to contribute and suggest any improvements. If you want to point to an issue, Please file an issue.

# Disclaimer
This tool can be only used in legitimate actions.
Author does not take any responsibility for any actions taken by its users.
