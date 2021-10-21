Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
Install-Module PSReadLine -RequiredVersion 2.2.0-beta3 -AllowPrerelease -Scope CurrentUser 
Install-Module z -AllowClobber -Scope CurrentUser

$profileFile = '' + $PROFILE.CurrentUserCurrentHost
$profilePath = $profileFile.Replace('Microsoft.PowerShell_profile.ps1', '')

$themeFile = $profilePath + 'minimal.json'


#echo $themeFile
Copy-Item .\themes\minimal.json -Destination $themeFile
Copy-Item .\profile\profile.ps1 -Destination $profileFile