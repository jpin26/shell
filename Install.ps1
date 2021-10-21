$profilePath = '' + $PROFILE.CurrentUserCurrentHost
#$profilePath = $profilePath.Replace('profile.ps1', '')
echo 'Copying awesome profile to : ' $profilePath

Copy-Item .\profile\profile.ps1 -Destination $profilePath