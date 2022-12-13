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

$bestPoints = 0

for ($i=0;$i -lt $maxRows;$i++) {
    $tempI = ((Get-Variable -Name "row$i").Value).ToCharArray()
    for ($j=0;$j -lt $maxColumns;$j++) {
        $tempJ = (Get-Variable -Name "column$j").Value
        $target = $tempJ[$i]
        # tree selected, check sides
        # loop number of items above target
        $topPoints = 0
        for ($k=$i-1;$k -gt -1;$k--) {
            #Write-Output "$($tempJ[$k]) is above $target"
            if ($target -lt $tempJ[$k]) {
                $topPoints += 1
                Break
            }
            else {
                $topPoints += 1
                if ($target -eq $tempJ[$k]) {
                    Break
                }
            }
        }
        $topPoints
        # loop number of items below target
        $bottomPoints = 0
        for ($k=$i+1;$k -lt $tempJ.Count;$k++) {
            #Write-Output "$($tempJ[$k]) is below $target"
            if ($target -lt $tempJ[$k]) {
                $bottomPoints += 1
                Break
            }
            else {
                $bottomPoints += 1
                if ($target -eq $tempJ[$k]) {
                    Break
                }
            }
        }
        $bottomPoints
        # loop number of items left of target
        $leftPoints = 0
        for ($k=$j-1;$k -gt -1;$k--) {
            #Write-Output "$($tempI[$k]) is left of $target"
            if ($target -lt $tempI[$k]) {
                $leftPoints += 1
                Break
            }
            else {
                $leftPoints += 1
                if ($target -eq $tempI[$k]) {
                    Break
                }
            }
        }
        $leftPoints
        # loop number of items right of target
        $rightPoints = 0
        for ($k=$j+1;$k -lt $tempI.Count;$k++) {
            #Write-Output "$($tempI[$k]) is right of $target"
            if ($target -lt $tempI[$k]) {
                $rightPoints += 1
                Break
            }
            else {
                $rightPoints += 1
                if ($target -eq $tempI[$k]) {
                    Break
                }
            }
        }
        $rightPoints
        
        $totalPoints = $topPoints * $bottomPoints * $leftPoints * $rightPoints
        Write-Output "Total points for $j $i with value $($tempJ[$i]) is $totalPoints"

        if ($totalPoints -gt $bestPoints) {
            $bestPoints = $totalPoints
        }
    }
}

Get-Variable -Name "row*" | Foreach {Remove-Variable -Name $_.Name}
Get-Variable -Name "column*" | Foreach {Remove-Variable -Name $_.Name}