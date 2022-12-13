$puzzleInput = @"

"@
$inputArray = $puzzleInput.Split("`r`n")
$fixedInput = @()
$answer = 0

foreach ($i in $inputArray) {
    if ($i.Length -gt 1) {
        $fixedInput += $i
    }
}

$wordInput = @()
foreach ($fix in $fixedInput) {
    $tempFix = $fix.Replace("from 1","from one")
    $tempFix = $tempFix.Replace("from 2","from two")
    $tempFix = $tempFix.Replace("from 3","from three")
    $tempfix = $tempFix.Replace("from 4","from four")
    $tempfix = $tempFix.Replace("from 5","from five")
    $tempfix = $tempFix.Replace("from 6","from six")
    $tempfix = $tempFix.Replace("from 7","from seven")
    $tempfix = $tempFix.Replace("from 8","from eight")
    $tempfix = $tempFix.Replace("from 9","from nine")
    $tempfix = $tempFix.Replace("to 1","to one")
    $tempfix = $tempFix.Replace("to 2","to two")
    $tempfix = $tempFix.Replace("to 3","to three")
    $tempfix = $tempFix.Replace("to 4","to four")
    $tempfix = $tempFix.Replace("to 5","to five")
    $tempfix = $tempFix.Replace("to 6","to six")
    $tempfix = $tempFix.Replace("to 7","to seven")
    $tempfix = $tempFix.Replace("to 8","to eight")
    $tempfix = $tempFix.Replace("to 9","to nine")
    $wordInput += $tempFix
}

$one = @{}
$one.1 = "W"
$one.2 = "B"
$one.3 = "D"
$one.4 = "N"
$one.5 = "C"
$one.6 = "F"
$one.7 = "J"

$two = @{}
$two.1 = "P"
$two.2 = "Z"
$two.3 = "V"
$two.4 = "Q"
$two.5 = "L"
$two.6 = "S"
$two.7 = "T"

$three = @{}
$three.1 = "P"
$three.2 = "Z"
$three.3 = "B"
$three.4 = "G"
$three.5 = "J"
$three.6 = "T"

$four = @{}
$four.1 = "D"
$four.2 = "T"
$four.3 = "L"
$four.4 = "J"
$four.5 = "Z"
$four.6 = "B"
$four.7 = "H"
$four.8 = "C"

$five = @{}
$five.1 = "G"
$five.2 = "V"
$five.3 = "B"
$five.4 = "J"
$five.5 = "S"

$six = @{}
$six.1 = "P"
$six.2 = "S"
$six.3 = "Q"

$seven = @{}
$seven.1 = "B"
$seven.2 = "V"
$seven.3 = "D"
$seven.4 = "F"
$seven.5 = "L"
$seven.6 = "M"
$seven.7 = "P"
$seven.8 = "N"

$eight = @{}
$eight.1 = "P"
$eight.2 = "S"
$eight.3 = "M"
$eight.4 = "F"
$eight.5 = "B"
$eight.6 = "D"
$eight.7 = "L"
$eight.8 = "R"

$nine = @{}
$nine.1 = "V"
$nine.2 = "D"
$nine.3 = "T"
$nine.4 = "R"

foreach ($task in $wordInput) {
    $sourceName = $task.Split(" ")[3]
    $targetName = $task.Split(" ")[5]
    [int]$amount = $task.Split(" ")[1]
    $source = (Get-Variable -Name $sourceName).Value
    $target = (Get-Variable -Name $targetName).Value
    [int]$sourceCount = (Get-Variable -Name $sourceName).Value.Count
    [int]$targetCount = (Get-Variable -Name $targetName).Value.Count
    foreach ($step in $amount..1) {
        [int]$targetNumber = $targetCount+($amount+1)-$step
        [int]$sourceNumber = $sourceCount+1-$step
        $target.$targetNumber = $source.$sourceNumber
        $source.Remove($sourceNumber)
    }
}