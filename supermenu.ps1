Import-Module -Name ./rpg_game.ps1
Import-Module -Name ./store.ps1
Import-Module -Name ./zlidle.ps1
Import-Module -Name ./guild.ps1

function supermenu {
    Clear-Host
    Write-Host "---SUPERMENU---"
    Write-Host "99 - EXIT" -ForegroundColor Green
    Write-Host "1 - RPG"
    Write-Host "2 - Store"
    Write-Host "3 - ZEROLIFE"
    Write-Host "4 - Guild"
    $answer = Read-Host "Select Game"
    switch ($answer) {
        1 {
            rpgmain
        }
        2 {
            storemain
        }
        3 {
            zlmain
        }
        4 {
            gldGuildMain
        }
        99 {
            Exit
        }
        default {
            Write-Host "???"
        }
    }
}

function supermain {
    while (1 -eq 1) {
        supermenu
    }
}

# launch
supermain