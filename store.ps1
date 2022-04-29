

function storemenu {
	Clear-Host
	Write-Host "---store---" -ForegroundColor Magenta
	Write-Host "99 - return to game select" -ForegroundColor Green
	Write-Host "0 - bag" 
	Write-Host "1 - restock" -ForegroundColor Yellow
	Write-Host "2 - eat" -ForegroundColor Yellow
	Write-Host "3 - work" -ForegroundColor Yellow
	Write-Host "4 - buy a apple" -ForegroundColor Green
	Write-Host "5 - buy a banana" -ForegroundColor Green
	Write-Host "-----------" 
	$answer = Read-Host "choose option"
	if ($answer -eq '0') {
		bag
	}
	elseif ($answer -eq '1') {
		restock
	}
	elseif ($answer -eq '2') {
		eat
	}
	elseif ($answer -eq '3') {
		work
	}
	elseif ($answer -eq '4') {
		buyapple
	}
	elseif ($answer -eq '5') {
		buybanana
	}
	elseif ($answer -eq '98') {
		food
	}
	elseif ($answer -eq '99') {
		$script:store99 = 0
	}
}

function bag {
	$food = ($script:bagapple + $script:bagbanana)
	Clear-Host
	Write-Host "----bag----" -ForegroundColor Magenta 
	Write-Host "money: $script:money" -ForegroundColor Yellow
	Write-Host "apple: $script:bagapple" -ForegroundColor Green
	Write-Host "banana: $script:bagbanana" -ForegroundColor Green
	Write-Host "-----------" 
	Write-Host "total food: $food" -ForegroundColor Green
	Write-Host "energy: $script:energy" -ForegroundColor Blue
	pause
}

function buyapple {
	$buyapple = 1
	while ($buyapple -eq 1) {
		if ($script:apple -gt 0) {
			Write-Host "apple: $script:apple" -ForegroundColor Green
			Write-Host "money: $script:money" -ForegroundColor Yellow
			$answer = Read-Host "buy apple? y/n"
			if ($answer -eq 'y') {
				if ($script:money -gt 0) {
					Clear-Host
					$script:apple = $script:apple - 1 
					$script:money = $script:money - 1
					Write-Host "added one apple" -ForegroundColor Green
					Write-Host "removed one money" -ForegroundColor Yellow
					$script:bagapple = $script:bagapple + 1
				}
				else {
					Write-Host "you dont have enought money!" -ForegroundColor Red
					pause
					$buyapple = 0
				}
			}
			elseif ($answer -eq 'n') {
				$buyapple = 0
			}
		}
		else {
			Write-Host "no apples" -ForegroundColor Red
			pause
			$buyapple = 0
		}
	}
}

function buybanana {
	$buybanana = 1
	while ($buybanana -eq 1) {
		if ($script:banana -gt 0) {
			Write-Host "banana: $script:banana" -ForegroundColor Green
			Write-Host "money: $script:money" -ForegroundColor Yellow
			$answer = Read-Host "buy banana? y/n"
			if ($answer -eq 'y') {
				if ($script:money -gt 0) {
					Clear-Host
					$script:banana = $script:banana - 1 
					$script:money = $script:money - 1
					Write-Host "added one banana" -ForegroundColor Green
					Write-Host "removed one money" -ForegroundColor Yellow
					$script:bagbanana = $script:bagbanana + 1
				}
				else {
					Write-Host "you dont have enought money!" -ForegroundColor Red
					pause
					$buybanana = 0
				}
			}
			elseif ($answer -eq 'n') {
				$buybanana = 0
			}
		}
		else {
			Write-Host "no bananas" -ForegroundColor Red
			pause
			$buybanana = 0
		}
	}
}

function restock {
	Clear-Host
	$script:apple = $script:apple + 5
	$script:banana = $script:banana + 5
	Write-Host "Restocked!" -ForegroundColor Yellow
	Write-Host "apple: $script:apple" -ForegroundColor Green
	Write-Host "banana: $script:banana" -ForegroundColor Green
	pause
}

function work {
	if ($script:energy -ge 5) {
		Clear-Host
		$script:energy = $script:energy - 2
		$script:money = $script:money + 5
		Write-Host "you lost 2 energy" -ForegroundColor Blue
		Write-Host "energy: $script:energy" -ForegroundColor Blue
		Write-Host "earned +5 money!" -ForegroundColor Yellow
		Write-Host "money: $script:money" -ForegroundColor Yellow
		pause
	}
	else {
		Write-Host "you need at least 5 energy to work, go eat some food" -ForegroundColor Red
		Write-Host "energy: $script:energy" -ForegroundColor Blue
		pause
	}
}


function eat {
	$food = ($script:bagapple + $script:bagbanana)
	if ($food -gt 0) {
		$random = get-random -minimum 1 -maximum 3
		if ($random -eq 1) {
			eatapple
		}
		elseif ($random -eq 2) {
			eatbanana
		}
	}
	else {
		write-host "you have no food!" -ForegroundColor Red
		pause
	}
}

function eatapple {
	if ($script:bagapple -gt 0) {
		$script:energy = $script:energy + 1
		$script:bagapple = $script:bagapple - 1
		Write-Host "you ate 1 apple" -ForegroundColor Green
		Write-Host "you gained 1 energy" -ForegroundColor Blue
		Write-Host "energy: $script:energy" -ForegroundColor Blue
		Write-Host "$script:bagapple apple left" -ForegroundColor Green
		Pause
	}
	else {
		Write-Host "eating banana"
		eatbanana
		#Write-Host "you dont have any apples to eat" -ForegroundColor Red
		#Pause
		#storemenu
	}
}

function eatbanana {
	if ($script:bagbanana -gt 0) {
		$script:energy = $script:energy + 1
		$script:bagbanana = $script:bagbanana - 1
		Write-Host "you ate 1 banana" -ForegroundColor Green
		Write-Host "you gained 1 energy" -ForegroundColor Blue
		Write-Host "energy: $script:energy" -ForegroundColor Blue
		Write-Host "$script:bagbanana banana left" -ForegroundColor Green
		Pause
		#storemenu
	}
	else {
		Write-Host "eating apple"
		eatapple
		#Write-Host "you dont have any bananas to eat" -ForegroundColor Red
		#Pause
		#storemenu
	}
}

function storemain {
	if ($script:storefirsttime -eq 1) {
		$script:store99 = 1
	}
	else {
		#init
		$script:money = 3
		$script:energy = 3
		$script:apple = 3
		$script:bagapple = 0
		$script:banana = 3
		$script:bagbanana = 0
		$script:storefirsttime = 1
		$script:store99 = 1
	}
	while ($script:store99 -eq 1) {
		storemenu
	}
}

#storemain