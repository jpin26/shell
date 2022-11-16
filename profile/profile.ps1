using namespace System.Management.Automation
using namespace System.Management.Automation.Language

$git = "d:\git"
$profileFile = '' + $PROFILE.CurrentUserCurrentHost
$profilePath = $profileFile.Replace('Microsoft.PowerShell_profile.ps1', '')
$themeFile = $profilePath + 'minimal.json'

function kubernetesApplyFile([string]$filePath=".")
{
    kubectl apply -f $filePath
}

function kubernetesDeleteFile([string]$filePath=".")
{
    kubectl delete -f $filePath
}

function kubernetesDeleteFile([string]$filePath=".")
{
    kubectl delete -f $filePath
}

function kubernetesDeleteFile([string]$filePath=".")
{
    kubectl delete -f $filePath
}

function kubernetesUseContext([string]$context=".")
{
    kubectl config use-context $context
}

function kubernetesSetNameSpace([string]$nameSpace=".")
{
    kubectl config set-context --current --namespace=$nameSpace
}

function kubernetesSetContextAndNameSpace([string]$context=".", [string]$nameSpace=".")
{
    kubectl config use-context $context --namespace=$nameSpace
}

function dockerImages()
{
    docker images
}

function dockerImagesRemoveByName([string]$imagName=".")
{
    docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}"|findstr $imagName) --force
}

function edge([string]$url=".")
{
    start msedge $url
}

function githome()
{
    cd $git
}

Set-Alias -Name d -Value docker
Set-Alias -Name di -Value dockerImages
Set-Alias -Name remove-images -Value dockerImagesRemoveByName

Set-Alias -Name k -Value kubectl
Set-Alias -Name kaf -Value kubernetesApplyFile
Set-Alias -Name kdf -Value kubernetesDeleteFile
Set-Alias -Name kc -Value kubernetesUseContext
Set-Alias -Name kn -Value kubernetesSetNameSpace
Set-Alias -Name kcn -Value kubernetesSetContextAndNameSpace

Set-Alias -Name ie -Value startEdge
 
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}

#Import-Module -Name Terminal-Icons
#Import-Module oh-my-posh
#Import-Module z

Set-PoshPrompt -Theme $themeFile

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param($commandName, $wordToComplete, $cursorPosition)
         dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
         }
 }

# ---


# This is an example profile for PSReadLine.
#
# This is roughly what I use so there is some emphasis on emacs bindings,
# but most of these bindings make sense in Windows mode as well.

# Searching for commands with up/down arrow is really handy.  The
# option "moves to end" is useful if you want the cursor at the end
# of the line while cycling through history like it does w/o searching,
# without that option, the cursor will remain at the position it was
# when you used up arrow, which can be useful if you forget the exact
# string you started the search on.
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

#
$global:PSReadLineMarks = @{}


Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows


# This is an example of a macro that you might use to execute a command.
# This will add the command to history.
Set-PSReadLineKeyHandler -Key Ctrl+Shift+b `
                         -BriefDescription BuildCurrentDirectory `
                         -LongDescription "dotnet: build the current directory" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet build")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key Ctrl+Shift+t `
                         -BriefDescription BuildCurrentDirectory `
                         -LongDescription "dotnet: test the current directory" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet test")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key Ctrl+w `
                         -BriefDescription BuildCurrentDirectory `
                         -LongDescription "dotnet: watch the current directory" `
                         -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("dotnet watch")
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
