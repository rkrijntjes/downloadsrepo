<#Functie Write-LogEntry
.FUNCTIONALITY
Functie die makkelijk entries toevoegd aan logfile doormiddel van Write-LogEntry -Stamp -Value
Voor mooimakerij hoeft de parameter -Stamp niet toegevoegd te worden, alleen met errors of relevantie informatie
#>
function Write-LogEntry {
    param (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Value,
        [parameter(Mandatory = $false)]
        [switch]$Stamp
    )

    #Aanmaken logfile

    $LogFile = "C:\Automation\Logs\$TypeInstall $appname.log"
    $Time = -join @((Get-Date -Format "HH:mm:"), " ", (Get-WmiObject -Class Win32_TimeZone | Select-Object -ExpandProperty Bias))
    $Date = (Get-Date -Format "dd-MM-yyyy")


    If ($Stamp) {
        $LogText = "<<time=""$($Time)>"" date=""$($Date)""> $($Value)"
    }
    else {
        $LogText = "$($Value)"
    }
	
    Try {
        Out-File -InputObject $LogText -Append -NoClobber -Encoding Default -FilePath $LogFile -ErrorAction Stop
    }
    Catch [System.Exception] {
        Write-Warning -Message "kan geen lijn toevoegen aan $LogFile.log bestand. Error op lijn  $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    }
}