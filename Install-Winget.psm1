function Install-Winget
{
#Installeren WinGet
Write-Host "Installeren WinGet"

Try{
	# Controle of Winget al is geinstalleerd
	$er = (invoke-expression "winget -v") 2>&1
	if ($lastexitcode) {throw $er}
	Write-Host "WinGet is al geinstalleerd"
}
Catch{
	# WinGet is nog niet geinstalleerd, downloaden en installeren via MS GitHub Repo
	Write-Host "WinGet is niet geinstalleerd, installeren WinGet"
	
	$ProgressPreference='Silent'
	Invoke-WebRequest -Uri https://github.com/microsoft/winget-cli/releases/download/v1.3.2691/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -OutFile .\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -UseBasicParsing
	Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx -UseBasicParsing

	Write-Host "Installeren WinGet"
	Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
	Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}
}