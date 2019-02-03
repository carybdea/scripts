
###### Get-ProcmonData ######

### Created : 14/03/2018
### Updated : 28/03/2018
### Version : 1.1


    Param(
         [Parameter()][string]$ComputerName = $env:COMPUTERNAME,
         [Parameter()][ValidateRange(10,60)][int]$Duration = 20, #Time of collect in Seconds
         [Parameter()][string]$ProcmonPath = 'C:\Tools\ProcessMonitor\Procmon.exe', #Path To Procmon.exe on local machine
         [Parameter()][string]$PsExecPath = 'C:\Tools\PSTools\PsExec.exe', #Path to PsExec.exe
         [Parameter()][string]$SaveDataPath = 'C:\Tools\ProcmonData' #Path to save generated file
         )

    $remote = 'C$'
    $local = 'C:'
    $TempFolder = 'Windows\Temp'

    if (!(Test-Connection $ComputerName)) { Write-Warning "$ComputerName is unreachable. Aborting..." }
    else{
        if (!(Test-Path $PsExecPath)) { Write-Warning "$PsExec not found, please verify path or use -PsExecPath." }
        else{
            if (!(Test-Path $ProcmonPath)) {Write-Warning "$ProcMon not found, please verify path or use -ProcmonPath." }
            else{
                if (!(Get-WmiObject Win32_Volume | Where-Object {$_.Capacity/1mb -gt 500  })) { Write-Warning "Not Enough Free Space on local machine."}
                    #Improvement : Add verification on remote machine.
                        #Get-WmiObject Win32_Volume -ComputerName $ComputerName | Where-Object {$_.Capacity/1mb -gt 500  }))
                        #Error: Get-WmiObject : The RPC server is unavailable (Exception de HRESULT : 0x800706BA)
                else {
                    ### Copy Procmon on remote machine.
                    Write-Host "Copying Procmon on $ComputerName..."
                    try { Copy-Item $ProcmonPath "\\$ComputerName\$remote\$TempFolder" -Force -Verbose -ErrorAction Stop } catch { Write-Warning $_.Exception; break }

                    ### Command to run Procmon via PsExec :
                    # -accepteula : Accept End User Licence Agreement for PsExec
                    # -s : Run with SYSTEM privileges
                    # -d : Don't wait for process to terminate, important so that the next commands can be executed.
                    # /accepteula : Accept End User Licence Agreement for Procomon.
                    # /BackingFile C:\Path\Save\data.pml : Specifies path to save log file.
                    # /Quiet : So that the user does not notice the presence of procmon.

                    Write-Host "Running Procmon on $ComputerName..."
                    Start-Process -FilePath $PsExecPath -ArgumentList "-accepteula -s -d \\$ComputerName $local\$TempFolder\Procmon.exe /accepteula /BackingFile $local\$TempFolder\$ComputerName.pml /Quiet"
                    Write-Host "Collecting Data... Please wait $duration seconds."
                    Start-Sleep -s $Duration
                    ### End PsExec process, PsExec must be terminated this way, otherwise the backing file won't work.
                    Write-Host "Terminating Process..."
                    $Terminate = & $PsExecPath -accepteula -s \\$ComputerName $local\$TempFolder\Procmon.exe /accepteula /Terminate 2>&1;

                    ### Copy file to local machine and clean up
                    Write-Host "Copying data to local machine..."
                    if (!(Test-Path -path $SaveDataPath)) { New-Item $SaveDataPath -Type Directory }
                    try { Copy-Item "\\$ComputerName\$remote\$TempFolder\$ComputerName.pml" $SaveDataPath -Force -Verbose -ErrorAction Stop } catch { Write-Warning $_.Exception }

                    Write-Host "Cleaning up..."
                    Remove-Item "\\$ComputerName\$remote\$TempFolder\$ComputerName.pml" -Verbose -Force
                    Remove-Item "\\$ComputerName\$remote\$TempFolder\Procmon.exe" -Verbose -Force
                }
            }
        }

        if(get-process -ComputerName $ComputerName -Name "*procmon*"){
        Write-Warning "Procmon is still running..."
    }

    }
