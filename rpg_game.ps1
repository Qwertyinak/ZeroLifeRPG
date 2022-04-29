<#

    |        ///             ///        |
    |        ///  Main Menu  ///        |
    V        ///             ///        V

#>

function rpgmainmenu {
    # mainmenu
    Clear-Host
    write-host "character hp = $script:chp" -ForegroundColor DarkGreen -BackgroundColor Black
    Write-Host "99 - return to game select" -ForegroundColor Green -BackgroundColor Black
    write-host "1 - character sheet" -ForegroundColor Yellow -BackgroundColor Black
    write-host "2 - rpgfight" -ForegroundColor Yellow -BackgroundColor Black
    write-host "3 - sleep" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "4 - rpgtrain" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "5 - check monster stats" -ForegroundColor Yellow -BackgroundColor Black
    $menuoption = read-host "choose option"
    switch ($menuoption) {
        1 {
            rpgcharactersheet
        }
        2 {
            rpgfightyn
        }
        3 {
            rpgsleepz
        }
        4 {
            rpgtrainsub
        }
        5 {
            rpgstatcompare
        }
        42 {
            $answer = read-host "Cheat? y/n" 
            if ($answer -eq "y") {
                $script:chp = 999
                $script:cstrength = 999
                $script:cdefense = 999
                $script:cint = 999
                $script:coins = 999
                write-host "-------------- CHEAT MODE ACTIVATED! --------------" -ForegroundColor Red -BackgroundColor Black
                Pause
            }
            elseif ($answer -eq "n") {

            }
            else {
                write-host "answer the question"
            }
        }
        99 {
            $script:rpg99 = 0
        }
        default {
            write-host "???"
        }
    }
}

<#
    ^                                   ^
   /|\       ///             ///       /|\
    |        ///  Main Menu  ///        |
    |        ///             ///        |

#>

<#

    |        ///                   ///        |
    |        ///  Fight Functions  ///        |
    V        ///                   ///        V

#>

function rpgfight {
    # calculate fight
    # random drop
    rpgrandomdrop
    # animation
    rpgfightanime
    # calculate attack damages
    rpgcalcattack
    # deal damage to character
    rpgdealdamage monster $script:cdmg
    # deal damage to monster
    rpgdealdamage character $script:mdmg
    # show events
    rpgbattlesum
    # fight again?
    rpgfightyn
}

function rpgrandomdrop {
    # chance coin drop
    if ((Get-Random -Minimum 1 -Maximum 3) -eq 1) {
        write-host "you found a coin"
        $script:coins = $script:coins + 1
        write-host "you now have $script:coins coins!"-ForegroundColor Yellow -BackgroundColor Black
        Pause
    }
}

function rpgfightanime {
    # rpgfight animation
    write-host " O       O   "
    Write-Host "/|\---  /|\  "
    Write-Host "/ \     / \  " 
    Start-Sleep -m 500
    write-host " O         O "
    Write-Host "/|\---    /  "
    Write-Host "/ \     / \  " 
    Start-Sleep -m 500
    write-host " O           "
    Write-Host "/|\          "
    Write-Host "/ \     >--o " 
}

function rpgbattlesum {
    # write fight result
    if ($script:mdmg -gt 0) {
        # monster damage positive
        write-host "YOU TOOK $script:mdmg DAMAGE!" -ForegroundColor DarkRed -BackgroundColor Black
    }
    else {
        # monster dealt 0 or less damage
        write-host "you blocked the damage" -ForegroundColor Blue -BackgroundColor Black
    }
    if ($script:chp -le 0) {
        # character hp 0 or less (DEAD!)
        write-host "lose!" -ForegroundColor Red -BackgroundColor Black
        write-host $script:chp"hp" -ForegroundColor Red -BackgroundColor Black
        $script:dead = 1
    }
    else {
        if ($script:cdmg -gt 0) {
            # character dealt damage
            if ($script:mhp -gt 0) {
                # character dealt damage, no kill
                write-host "you dealt $script:cdmg damage" -ForegroundColor DarkCyan -BackgroundColor Black
                write-host "the monster survived with $script:mhp health"
                Pause
            }
            else {
                # monster dies, gen new monster
                write-host "you dealt $script:cdmg damage" -ForegroundColor DarkCyan -BackgroundColor Black
                write-host "monster died" -ForegroundColor Magenta -BackgroundColor Black
                write-host "you gained 5 coins!" -ForegroundColor Yellow -BackgroundColor Black
                rpggenmhp
                $script:kills = $script:kills + 1
                $script:coins = $script:coins + 5
                Pause
            }
        }
        else {
            # monster blocked
            write-host "monster blocked" -ForegroundColor Blue -BackgroundColor Black
        }
    }
}

function rpgfightyn {
    # ask to rpgfight or not
    Clear-Host
    write-host $script:chp -NoNewLine -ForegroundColor DarkGreen -BackgroundColor Black
    write-host " v.s. " -NoNewLine 
    write-host $script:mhp -ForegroundColor Red -BackgroundColor Black
    Write-Host "fight?" -ForegroundColor Yellow -BackgroundColor Black
    $answer = read-host "y/n" 
    if ($answer -eq "y") {
        rpgfight
    }
    elseif ($answer -eq "n") {

    }
    else {
        write-host "answer the question"
        rpgfightyn
    }
}

function rpgcalcattack {
    # calculate attack values from stats 
    $script:cdmg = $script:cstrength - $script:mdefense 
    $script:mdmg = $script:mstrength - $script:cdefense 
}

function rpgdealdamage {
    # deal damage to target
    param (
        [Parameter(Mandatory, Position = 0)]
        $target,
        [Parameter(Mandatory, Position = 1)]
        $dmg
    )
    if ($dmg -gt 0) {
        switch ($target) {
            "character" {
                $script:chp = $script:chp - $dmg
            }
            "monster" {
                $script:mhp = $script:mhp - $dmg
            }
            default {
                Write-Error "ERROR: target error in function rpgdealdamage!"
            }
        } 
    }
}

<#
    ^                                         ^
   /|\       ///                   ///       /|\
    |        ///  Fight Functions  ///        |
    |        ///                   ///        |

#>

<#

    |        ///                ///        |
    |        ///  Stat Windows  ///        |
    V        ///                ///        V

#>

function rpgstatcompare {
    # use int for stat check
    param (
    )
    if ($script:cint -gt 5) {   
        Clear-Host   
        # header
        write-host "------------------------------------" -ForegroundColor Magenta -BackgroundColor Black
        write-host "|   Character    v.s.    Monster" -ForegroundColor Magenta -BackgroundColor Black
        
        # health
        write-host "| Health:      " -NoNewLine -ForegroundColor DarkGreen -BackgroundColor Black
        write-host $script:chp -NoNewLine -ForegroundColor DarkGreen -BackgroundColor Black
        write-host " v.s. " -NoNewLine -BackgroundColor Black
        write-host $script:mhp -ForegroundColor Red -BackgroundColor Black

        # strength
        write-host "| Strength:   " -NoNewLine -ForegroundColor Red -BackgroundColor Black
        write-host $script:cstrength -NoNewLine -ForegroundColor DarkGreen -BackgroundColor Black
        write-host " v.s. " -NoNewLine -BackgroundColor Black
        write-host $script:mstrength -ForegroundColor Red -BackgroundColor Black

        # denfese
        write-host "| Defense:     " -NoNewLine -ForegroundColor Blue -BackgroundColor Black
        write-host $script:cdefense -NoNewLine -ForegroundColor DarkGreen -BackgroundColor Black
        write-host " v.s. " -NoNewLine -BackgroundColor Black
        write-host $script:mdefense -ForegroundColor Red -BackgroundColor Black
        
        # damage
        rpgcalcattack
        write-host "| Damage:      " -NoNewLine -ForegroundColor Yellow -BackgroundColor Black
        write-host $script:cdmg -NoNewLine -ForegroundColor DarkGreen -BackgroundColor Black
        write-host " v.s. " -NoNewLine -BackgroundColor Black
        write-host $script:mdmg -ForegroundColor Red -BackgroundColor Black
        
        # footer
        write-host "------------------------------------" -ForegroundColor Magenta -BackgroundColor Black
        Pause
    }
    else {
        Write-Host "BAKA! ur too baka to judge the enemy!" -ForegroundColor Red -BackgroundColor Black
        Pause
    }
}

function rpgcharactersheet {
    Clear-Host
    write-host "health:"$script:chp -ForegroundColor DarkGreen -BackgroundColor Black
    write-host "strength:"$script:cstrength -ForegroundColor Red -BackgroundColor Black
    Write-Host "defense:"$script:cdefense -ForegroundColor Blue -BackgroundColor Black
    Write-Host "int:"$script:cint -ForegroundColor Cyan -BackgroundColor Black
    Write-Host "coins:"$script:coins -ForegroundColor Yellow  -BackgroundColor Black
    Write-Host "kills:"$script:kills -ForegroundColor Gray  -BackgroundColor Black
    Pause
}

<#
    ^                                      ^
   /|\       ///                ///       /|\
    |        ///  Stat Windows  ///        |
    |        ///                ///        |

#>

<#

    |        ///                    ///        |
    |        ///  Training section  ///        |
    V        ///                    ///        V

#>

function rpgsleepz {
    # sleep to gain health
    Clear-Host
    $script:chp = $script:chp + 2
    write-host "+2 hp gained" -ForegroundColor DarkGreen -BackgroundColor Black
}

function rpgtrainsub {
    # sub menu for training stats
    param (

    )
    $rpgtrainmenu = 1
    while ($rpgtrainmenu -eq 1) {
        Clear-Host
        Write-Host "training menu" -ForegroundColor Green -BackgroundColor Black
        Write-Host "1 - return to rpgmainmenu" -ForegroundColor Blue -BackgroundColor Black
        Write-Host "2 - rpgtrain strength by $script:rpgtrainamount" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "3 - rpgtrain defense by $script:rpgtrainamount" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "4 - rpgtrain int by $script:rpgtrainamount" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "5 - cycle amount" -ForegroundColor Blue
        $menuoption = read-host "choose stat to rpgtrain"
        switch ($menuoption) {
            1 {
                $rpgtrainmenu = 0
            }
            2 {
                rpgtrain strength $script:rpgtrainamount
            }
            3 {
                rpgtrain defense $script:rpgtrainamount
            }
            4 {
                rpgtrain int $script:rpgtrainamount
            }
            5 {
                switch ($script:rpgtrainamount) {
                    1 {
                        $script:rpgtrainamount = 5
                    }
                    5 {
                        $script:rpgtrainamount = 10
                    }
                    10 {
                        $script:rpgtrainamount = 1
                    }
                    #25 {
                    #    $script:rpgtrainamount = 100
                    #}
                    #100 {
                    #    $script:rpgtrainamount = 'max'
                    #}
                    #'max' {
                    #    $script:rpgtrainamount = 1
                    #}
                }
            }
        }
    }
}

function rpgtrain {
    # train selected stat
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$stat,
        [Parameter(Position = 1)]
        $amount
    )
    #Write-Host "TRAINING GROUNDS" -ForegroundColor Magenta -BackgroundColor Black
    #$answer = read-host "train $stat by"$amount"? y/n"
    #if ($answer -eq "y") {
    if ($amount -le 0) {
        $amount = 1
    }
    switch ($stat) {
        "strength" {
            $script:cstrength = $script:cstrength + $amount
            Write-Host "strength is now:"$script:cstrength -ForegroundColor Red -BackgroundColor Black
            Pause
        }
        "defense" {
            $script:cdefense = $script:cdefense + $amount
            Write-Host "defense is now:"$script:cdefense -ForegroundColor Blue -BackgroundColor Black
            Pause
        }
        "int" {
            $script:cint = $script:cint + $amount
            Write-Host "int is now:"$script:cint -ForegroundColor Cyan -BackgroundColor Black
            Pause
        }
        default {
            Write-Error "incorrect training! error: |$stat||$amount|" -Category InvalidArgument
        }
    }
}

<#
    ^                                          ^
   /|\       ///                    ///       /|\
    |        ///  Training section  ///        |
    |        ///                    ///        |

#>

<#

    |        ///                           ///        |
    |        ///  INIT and main game loop  ///        |
    V        ///                           ///        V

#>

function rpggameover {
    #end game
    $script:rpgfirsttime = 0
    $script:rpg99 = 0
    Write-Host "You Died!" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Game Over!" -ForegroundColor Red -BackgroundColor Black
    Pause
}

function rpginit {
    rpggenchar
    rpggenmhp
    $script:rpgtrainamount = 1
}

function rpggenchar {
    # init character
    $script:chp = Get-Random -Minimum 5 -Maximum 10
    $script:cstrength = Get-Random -Minimum 1 -Maximum 10
    $script:cdefense = Get-Random -Minimum 1 -Maximum 10
    $script:cint = 6#Get-Random -Minimum 1 -Maximum 10
    $script:kills = 0
    $script:coins = 1
    $script:dead = 0
}

function rpggenmhp {
    # generate a new monster
    $script:mhp = Get-Random -Minimum 1 -Maximum 10
    $script:mdefense = Get-Random -Minimum 1 -Maximum 10
    $script:mstrength = Get-Random -Minimum 1 -Maximum 10
}

function rpgmain {
    if ($script:rpgfirsttime -eq 1) {
        $script:rpg99 = 1
    }
    else {
        rpginit
        $script:rpgfirsttime = 1
        $script:rpg99 = 1
    }
    while ($script:rpg99 -eq 1) {
        if ($script:dead -eq 0) {
            rpgmainmenu
        }
        elseif ($script:dead -eq 1) {
            rpggameover
        }
    }
}

<#
    ^                                                 ^
   /|\       ///                           ///       /|\
    |        ///  INIT and main game loop  ///        |
    |        ///                           ///        |

#>

# launch
#main

