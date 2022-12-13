$puzzleInput = @"

"@

$itemArray = $puzzleInput.Split("`r`n")
$fixedInput = @()
foreach ($itemLine in $itemArray) {
    if ($itemLine.Length -gt 1) {
        $fixedInput += $itemLine
    }
}

[int]$maxRows = $fixedInput.Count
[int]$maxColumns = $fixedInput[0].Length

for ($j=0;$j -lt $fixedInput.Count;$j++) {
    New-Variable -Name "row$j" -Value @($fixedInput[$j])
}

for ($i=0;$i -lt $fixedInput[0].Length;$i++) {
    New-Variable -Name "column$i" -Value @()
    for ($j=0;$j -lt $fixedInput.Count;$j++) {
        [array]$tempI = (Get-Variable -Name "column$i").Value
        [array]$tempJ = ((Get-Variable -Name "row$j").Value).ToCharArray()
        $tempI += $tempJ[$i]
        Set-Variable -Name "column$i" -Value $tempI
    }
}

$visible = @()

# loop through all columns
for ($i=0;$i -lt ($maxRows);$i++) {
    [array]$tempI = (Get-Variable -Name "column$i").Value
    Write-Output "column $i"
    if (($i -eq 0) -or ($i -eq ($maxRows-1))) {
        #Write-Output "Column $i is at left or right edge"
        for ($j=0;$j -lt ($maxColumns);$j++) {
            $visible += "$i,$j"
        }
    }
    else {
        # loop number of items in column except first and last
        for ($j=1;$j -lt $tempI.Count -1;$j++) {
            #Write-Output "Item $j"
            # loop number of items before target
            $largest = $false
            for ($k=0;$k -lt $j;$k++) {
                #Write-Output "Comparing with item $k"
                if ($tempI[$j] -le $tempI[$k]) {
                    $largest = $false
                    Break
                }
                else {
                    #Write-Output "$($tempI[$j]) is larger than $($tempI[$k])"
                    $largest = $true
                }
            }
            if ($largest) {
                $visible += "$i,$j"
            }
            # loop number of items after target
            $largest = $false
            for ($k=$tempI.Count -1;$k -gt 0 + $j;$k--) {
                #Write-Output "Comparing with item $k"
                if ($tempI[$j] -le $tempI[$k]) {
                    $largest = $false
                    Break
                }
                else {
                    #Write-Output "$($tempI[$j]) is larger than $($tempI[$k])"
                    $largest = $true
                }
            }
            if ($largest) {
                $visible += "$i,$j"
            }
        }
    }
}

# loop through all rows
for ($i=0;$i -lt ($maxColumns);$i++) {
    [array]$tempI = ((Get-Variable -Name "row$i").Value).ToCharArray()
    Write-Output "row $i"
    if (($i -eq 0) -or ($i -eq ($maxColumns-1))) {
        #Write-Output "Row $i is at top or bottom edge"
        for ($j=0;$j -lt ($maxRows);$j++) {
            $visible += "$j,$i"
        }
    }
    else {
        # loop number of items in column except first and last
        for ($j=1;$j -lt $tempI.Count -1;$j++) {
            #Write-Output "Item $j"
            # loop number of items before target
            $largest = $false
            for ($k=0;$k -lt $j;$k++) {
                #Write-Output "Comparing with item $k"
                if ($tempI[$j] -le $tempI[$k]) {
                    $largest = $false
                    Break
                }
                else {
                    #Write-Output "$($tempI[$j]) is larger than $($tempI[$k])"
                    $largest = $true
                }
            }
            if ($largest) {
                $visible += "$j,$i"
            }
            # loop number of items after target
            $largest = $false
            for ($k=$tempI.Count -1;$k -gt 0 + $j;$k--) {
                #Write-Output "Comparing with item $k"
                if ($tempI[$j] -le $tempI[$k]) {
                    $largest = $false
                    Break
                }
                else {
                    #Write-Output "$($tempI[$j]) is larger than $($tempI[$k])"
                    $largest = $true
                }
            }
            if ($largest) {
                $visible += "$j,$i"
            }
        }
    }
}

Get-Variable -Name "row*" | Foreach {Remove-Variable -Name $_.Name}
Get-Variable -Name "column*" | Foreach {Remove-Variable -Name $_.Name}