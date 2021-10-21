if (-not (Get-Module oh-my-posh)) {
    echo "Installing oh-my-posh module"
    Install-Module oh-my-posh -Scope CurrentUser
}

if (-not (Get-Module -Name Terminal-Icons)) {
    echo "Installing Terminal-icons module"
    Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser
}

if (-not (Get-Module PSReadLine)) {
    echo "Installing PSReadLine beta version module"
    Install-Module PSReadLine -RequiredVersion 2.2.0-beta3 -AllowPrerelease -Scope CurrentUser 
}

if (-not (Get-Module z)) {
    echo "Installing z module"
    Install-Module z -AllowClobber -Scope CurrentUser
}

$profileTargetFile = '' + $PROFILE.CurrentUserCurrentHost
$profileTargetPath = $profileTargetFile.Replace('Microsoft.PowerShell_profile.ps1', '')
$themeFile = $profileTargetPath + 'minimal.json'
$fontSource = gci -Path .\files\CascadiaCode

echo "Installing fonts"
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in gci -Path .\files\CascadiaCode\*.ttf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        echo $fileName
        dir $file | %{ $fonts.CopyHere($_.fullname) }
    }
}
#cp .\files\CascadiaCode\*.ttf c:\windows\fonts\

echo "Installing theme CurrentUserCurrentHost Profile"
Copy-Item .\themes\minimal.json -Destination $themeFile

echo "Updating CurrentUserCurrentHost Profile"
Copy-Item .\profile\profile.ps1 -Destination $profileTargetFile