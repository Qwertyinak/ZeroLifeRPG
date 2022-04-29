<#

    //yes, i know there is an error in the beggining but everything still works fine
    //ERROR FIXED -B.T.

    //write at all menus to calculate latest zl points and update $data1//
    ---> zlupdatetime <---

    //reset multi calculated corectly just need to have the visuals match 

    //need to balance

#>

<#
    basically
        u have fucntion {zlupdatetime} witch runs fucntion {zlafkpro} witch runs function {zltimecount}
            function {zltimecount}
                gets $zldate2
                compares $zldate1 and $zldate2
                finds the difference
                converts it to seconds as a singe number instead of (00:00:05 ---> 5)
                assigns the seconds to $script:Seconds
            function {zlafkpro} then continues
                for each $script:Seconds
                    makes $script:afkzerofile = (all units production)*game resets
                    then $script:zlearnafk = $script:afkzerolife * $script:Seconds
            function {zlupdatetime} continues
                makes zl points equal zl points * $script:zlearnedafk
                sets $zldate1
                ---> error on start up because function {zltimecount} doesnt yet have a $zldate1 to compare <---


#>

#$script:zerolife = 0
#$script:zlgamereset = 1


<#

    |        ///                  ///        |
    |        ///    MAIN MENUS    ///        |
    V        ///                  ///        V

#>

function zlmenu {
    zlupdatetime
    Clear-Host
    zerolifeheader
    Write-Host "----MENU----" -ForegroundColor Yellow
    Write-Host "99 - return to game select" -ForegroundColor Green
    Write-Host "0 - stats" -ForegroundColor Yellow
    Write-Host "1 - click" -ForegroundColor Yellow
    Write-Host "2 - buy upgrades" -ForegroundColor Yellow
    Write-Host "3 - afk page" -ForegroundColor Yellow
    Write-Host "------------" -ForegroundColor Yellow
    $answer = Read-Host "choose option"
    if ($answer -eq '0') {
        zlstatsmenu
    }
    if ($answer -eq '1') {
        zlclick
    }
    if ($answer -eq '2') {
        zlupmenu
    }
    if ($answer -eq '3') {
        #zlafkpage
    }
    if ($answer -eq '42') {
        zlreset
    }
    if ($answer -eq '99') {
        $script:zl99 = 0
    }
}

function zlafkpage {
    Clear-Host
    zerolifeheader
    
}

function zerolifeheader {
    Write-Host "$script:afkzerolife zl/s X $script:Seconds seconds = +$script:zlearnedafk" -ForegroundColor Yellow
    Write-Host "$script:zerolife zl points" -ForegroundColor Magenta
}

function zlstatsmenu {
    Clear-Host
    zlupdatetime
    Write-Host "----STATS----" -ForegroundColor Green
    Write-Host "unit1: $($script:zlunit1obj.amount) making $($script:zlunit1obj.production*$script:zlunit1obj.amount) zl/s" -ForegroundColor Green
    Write-Host "unit2: $($script:zlunit2obj.amount) making $($script:zlunit2obj.production*$script:zlunit2obj.amount) zl/s" -ForegroundColor Green
    Write-Host "unit3: $($script:zlunit3obj.amount) making $($script:zlunit3obj.production*$script:zlunit3obj.amount) zl/s" -ForegroundColor Green
    Write-Host "total zl/s = $script:afkzerolife" -ForegroundColor Magenta
    Write-Host "game resets: $script:zldisplaygamereset" -ForegroundColor Red
    Write-Host "------------" -ForegroundColor Green
    Pause
}

<#
    ^                                        ^
   /|\       ///                  ///       /|\
    |        ///    MAIN MENUS    ///        |
    |        ///                  ///        |

#>

<#

    |        ///                      ///        |
    |        ///    BUY UNIT STORE    ///        |
    V        ///                      ///        V

#>

function zlupmenu {
    $zlupmenu = 1
    while ($zlupmenu -eq 1) {
        Clear-Host
        zlupdatetime
        #Write-Host "$script:seconds seconds have passed"
        #Write-Host "$script:zerolife zl points" -ForegroundColor Magenta
        zerolifeheader
        Write-Host "---UPMENU---" -ForegroundColor Blue
        Write-Host "0 - main menu" -ForegroundColor Yellow
        Write-Host "1 - unit1 x$script:zlbuyamount" -ForegroundColor Blue
        Write-Host "2 - unit2 x$script:zlbuyamount" -ForegroundColor Blue
        Write-Host "3 - unit3 x$script:zlbuyamount" -ForegroundColor Blue
        Write-Host "4 - cycle amount" -ForegroundColor Blue
        Write-Host "------------" -ForegroundColor Blue
        $answer = Read-Host "choose option"
        switch ($answer) {
            0 {
                $zlupmenu = 0
            }
            1 {
                zlunitbuy -unit 1
            }
            2 {
                zlunitbuy -unit 2
            }
            3 {
                zlunitbuy -unit 3
            }
            4 {
                switch ($script:zlbuyamount) {
                    1 {
                        $script:zlbuyamount = 5
                    }
                    5 {
                        $script:zlbuyamount = 10
                    }
                    10 {
                        $script:zlbuyamount = 25
                    }
                    25 {
                        $script:zlbuyamount = 100
                    }
                    100 {
                        $script:zlbuyamount = 'MAX'
                    }
                    'MAX' {
                        $script:zlbuyamount = 1
                    }
                }
            }
        }
    }
}

function zlunitbuy {
    param (
        $unit
    )
    switch ($unit) {
        1 {
            $zlunitobj = $script:zlunit1obj
        }
        2 {
            $zlunitobj = $script:zlunit2obj
        }
        3 {
            $zlunitobj = $script:zlunit3obj
        }
    }
    $zltobuy = $script:zlbuyamount
    if ($script:zlbuyamount -eq 'MAX') {
        $zlmaxamount = [System.Math]::Floor($($script:zerolife / $zlunitobj.cost))
        $zlbuycost = $zlunitobj.cost * $zlmaxamount
        $zltobuy = $zlmaxamount
    }
    else {
        $zlbuycost = $zlunitobj.cost * $zltobuy
    }
    Write-Host "$($zlunitobj.name) makes $($zlunitobj.production) zl/s" -ForegroundColor Blue
    Write-host "$($zlunitobj.name) costs $($zlunitobj.cost) zl points" -ForegroundColor Blue
    Write-Host "buy $zltobuy $($zlunitobj.name) for $zlbuycost zl points? " -ForegroundColor Yellow -NoNewline
    $answer = Read-Host "y/n"
    if ($answer -eq 'y') {
        if ($script:zerolife -ge $zlbuycost) {
            $zlunitobj.amount = $zlunitobj.amount + $zltobuy
            $script:zerolife = $script:zerolife - $zlbuycost
            Write-Host "-$zlbuycost zl points" -ForegroundColor Blue
            Write-Host "+$zltobuy $($zlunitobj.name)" -ForegroundColor Blue
            Write-Host "you now have $($zlunitobj.amount) $($zlunitobj.name)" -ForegroundColor Blue
            pause
        }
        else {
            Write-Host "you dont have enougth zl points for $zltobuy $($zlunitobj.name)" -ForegroundColor Red
            Write-Host "you need $($zlbuycost-$script:zerolife) more zl points!" -ForegroundColor Red
            Pause
        }
    }
}

<#
    ^                                            ^
   /|\       ///                      ///       /|\
    |        ///    BUY UNIT STORE    ///        |
    |        ///                      ///        |

#>

#Start-Job -FilePath "C:\Users\MDT\Desktop\clickerstuff\afkcount.ps1"

#Start-Job -ScriptBlock { afkcount }

<#

    |        ///                    ///        |
    |        ///    AFK COUNTING    ///        |
    V        ///                    ///        V

#>

function zlupdatetime {
    #//write at all menus to calculate latest zl points and update $data1//
    Clear-Host
    zlafkpro
    $script:zerolife = $script:zerolife + $script:zlearnedafk
    if ($script:Seconds -gt 0) {
        $script:zldate1 = Get-Date
    }
}

function zlafkpro {
    #$script:zldate1 = Get-Date
    zltimecount
    #calculate amount of zl earned
    $script:afkzerolife = (($script:zlunit1obj.production * $script:zlunit1obj.amount) + ($script:zlunit2obj.production * $script:zlunit2obj.amount) + ($script:zlunit3obj.production * $script:zlunit3obj.amount)) * $script:zlgamereset
    $script:zlearnedafk = $script:afkzerolife * $script:Seconds
}

function zltimecount {
    #count the time passed and converts it to a integer
    $script:zldate2 = Get-Date #get a date
    $timepassed = New-TimeSpan -Start $script:zldate1 -End $script:zldate2 #compare it to the first date
    #Write-Host $timepassed
    $TimeString = $timepassed #just randomly reasing the variable
    $TimeSpan = [System.TimeSpan]::Parse($TimeString) #stuff of google that works
    $script:Seconds = [System.Math]::Round($TimeSpan.TotalSeconds, 0) #stuff of google that works
    #return ($script:Seconds.ToString() ) #stuff of google that works
    #Write-Host $script:Seconds -ForegroundColor Magenta
}

<#
    ^                                          ^
   /|\       ///                    ///       /|\
    |        ///    AFK COUNTING    ///        |
    |        ///                    ///        |

#>

<#

    |        ///             ///        |
    |        ///    CLICK    ///        |
    V        ///             ///        V

#>

function zlclick {
    #click adds one zl point
    $zlclick = 1
    while ($zlclick -eq 1) {
        Clear-Host
        zlupdatetime
        zerolifeheader
        Write-Host "click adds 1 zl point"
        $answer = read-host "click y/n"
        if ($answer -eq 'y') {
            #write-host "zero file +1" -ForegroundColor Yellow
            $script:zlclickproduction = $script:zlclickpower * $script:zlgamereset
            $script:zerolife = $script:zerolife + $script:zlclickproduction
            #Write-Host "$script:zerolife zl points" -ForegroundColor Magenta
        }
        elseif ($answer -eq 'n') {
            $zlclick = 0
        }
    }
}

<#
    ^                                   ^
   /|\       ///             ///       /|\
    |        ///    CLICK    ///        |
    |        ///             ///        |

#>

<#

    |        ///             ///        |
    |        ///    RESET    ///        |
    V        ///             ///        V

#>

function zlreset {
    Write-Host "RESET THE GAME?" -ForegroundColor Red 
    Write-Host "you will resive a x2 multiplier in the next game" -ForegroundColor Red
    $answer = Read-Host "are you sure you want to reset? y/n"
    if ($answer -eq 'y') {
        $script:zlgamereset = $script:zlgamereset + 1
        $script:zldisplaygamereset = $script:zlgamereset - 1
        $script:zerolife = 0
        zlinitunits
        zlupdatetime
        Write-Host "game reset for the $script:zldisplaygamereset time" -ForegroundColor Red 
        pause
    }
}

<#
    ^                                   ^
   /|\       ///             ///       /|\
    |        ///    RESET    ///        |
    |        ///             ///        |

#>

<#

    |        ///                      ///        |
    |        ///  INIT and main loop  ///        |
    V        ///                      ///        V

#>

function zlinitunits {
    $script:zlunit1obj = [PSCustomObject]@{
        name       = 'unit1'
        production = 1
        cost       = 10
        amount     = 0
    }
    $script:zlunit2obj = [PSCustomObject]@{
        name       = 'unit2'
        production = 5
        cost       = 100
        amount     = 0
    }
    $script:zlunit3obj = [PSCustomObject]@{
        name       = 'unit3'
        production = 10
        cost       = 10000
        amount     = 0
    }
}

function zlmain {
    if ($script:zlfirsttime -eq 1) {
        $script:zl99 = 1
    }
    else {
        zlinitunits
        $script:zldate1 = Get-Date
        $script:zlclickpower = 1
        $script:zerolife = 0
        $script:zlgamereset = 1
        $script:zldisplaygamereset = 0
        $script:zlbuyamount = 1
        $script:zlfirsttime = 1
        $script:zl99 = 1
    }
    while ($script:zl99 -eq 1) {
        zlmenu
    }
}

<#
    ^                                            ^
   /|\       ///                      ///       /|\
    |        ///  INIT and main loop  ///        |
    |        ///                      ///        |

#>

#afkcount

#zlmenu

#supermenu