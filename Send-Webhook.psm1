<#Functie Send-Webhook
.FUNCTIONALITY
Functie voor logging webhooken naar Teams SysOps:  NS | ICT > SysOps - Intune Logs
Door simpelweg Send-Webhook aan het einde toe te voegen aan een catch die errors opvangt en relevante zaken aan de log toevoegt
#>

function Send-Webhook
{
    $LogFile = "C:\Automation\Logs\$TypeInstall $appname.log"
	$WebHookURL = "https://nieuwestroom.webhook.office.com/webhookb2/b6320b89-4fb3-4fff-ad4d-6f1d14f6771d@b65f2e69-e0ed-4835-896a-2e51e05f5da2/IncomingWebhook/d2cb2155bc804b629fb1653476b66098/b219c53d-7e09-4b13-b39a-44012d1157f3"
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