# Git cmds
function g { git $args }
function gs { git status $args }
function gd { git diff $args }
function gb { git branch $args }
function ga { git add $args }
function gic { git commit $args }
function go { git checkout $args }
function gf { git fetch $args }
function gip { git pull $args }
function gpu { git push }
function gr { git restore $args }
function grs { git restore --staged $args }
# Docker/Compose cmds
function dk { docker $args }
function dkr { docker run -ti --rm --entrypoint powershell $args }
function dki { docker images $args }
function dc { docker-compose $args }
function dcr { docker-compose run --rm --entrypoint powershell $args }
function dcb { docker-compose build $args }
function dkspf { docker system prune -f $args }

Function Prompt {
  $curPath = Get-Location
  $pathUri = ([uri] $curPath.ToString())
  $timeStamp = $(Get-Date -Format 'yyyy-MM-dd HH:mm')
  if ($pathUri.Segments.Count -le 2) {
    "PS $timeStamp {0} >" -f $curPath
  } else {
    $pathFromGit = $pathUri.Segments[-3..-1] -join ""
    "PS $timeStamp - $pathFromGit >"
  }
}

function Show-Colors( ) {
  $colors = [Enum]::GetValues( [ConsoleColor] )
  $max = ($colors | foreach { "$_ ".Length } | Measure-Object -Maximum).Maximum
  foreach( $color in $colors ) {
    Write-Host (" {0,2} {1,$max} " -f [int]$color,$color) -NoNewline
    Write-Host "$color" -Foreground $color
  }
}
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }
