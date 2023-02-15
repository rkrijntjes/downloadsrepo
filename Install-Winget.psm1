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
	
	$repo = "microsoft/winget-cli"
	$releases = "https://api.github.com/repos/$repo/releases"
	
	Write-Host "Laatste versie detecteren"
	$json = Invoke-WebRequest $releases
	$tag = ($json | ConvertFrom-Json)[0].tag_name
	$file = ($json | ConvertFrom-Json)[0].assets[0].name
	
	$download = "https://github.com/$repo/releases/download/$tag/$file"
	$output = $PSScriptRoot + "\winget-latest.appxbundle"
	Write-Host "Downloaden laatste versie"
	Invoke-WebRequest -Uri $download -OutFile $output
	
	Write-Host "Installeren WinGet"
	Add-AppxPackage -Path $output
}