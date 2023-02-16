<#Functie Send-Webhook
.FUNCTIONALITY
Functie voor logging webhooken naar Teams 
Door simpelweg Send-Webhook aan het einde toe te voegen aan een catch die errors opvangt en relevante zaken aan de log toevoegt
#>

function Send-Webhook
{
    $LogFile = "C:\Automation\Logs\$TypeInstall $appname.log"
	$WebHookURL = "$WHURL"
	$Message_Json = [PSCustomObject][Ordered]@{
		"@type" = "MessageCard"
		"@context" = "<http://schema.org/extensions>"
		"themeColor" = "0078D7"
		"title" = "Transcript - $appname"
		"text" = "Computer: $env:computername <br> Gebruiker: $env:UserName <br><br><br> $($(Get-Content $LogFile) -join '<br>')"
	} | ConvertTo-Json
	
	$parameters = @{
		"URI" = $WebHookURL
		"Method" = 'POST'
		"Body" = $Message_Json
		"ContentType" = 'application/json'
	}
	
	Invoke-RestMethod @parameters
	}