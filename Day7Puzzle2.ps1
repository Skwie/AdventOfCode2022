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

$currentPath = $null
$dataTable = [Ordered]@{}

foreach ($line in $fixedInput) {
    if ($line -like '$ cd *') {
        $cdSplit = $line.Split(" ")
        if ($cdSplit[2] -eq '/') {
            $currentPath = 'root/'
            Write-Output "Path changed to $currentPath"
            continue
        }
        if ($cdSplit[2] -eq '..') {
            $tempPathSplit = $currentPath.Split("/")
            for ($i=1;$i -lt ($tempPathSplit.Count -1);$i++) {
                $tempPath += $tempPathSplit[$i-1] + "/"
            }
            $currentPath = $tempPath
            $tempPathSplit = $null
            $tempPath = $null
            Write-Output "Path changed to $currentPath"
            Continue
        }
        $currentPath = $currentPath + "$($cdSplit[2])" + "/"
        Write-Output "Path changed to $currentPath"
    }
    if ($line -like 'dir *') {
        Continue
    }
    if ($line -match '\d{2,}') {
        [int]$currentData += $line.Split(" ")[0]
            $dataTable.$currentPath += $currentData
            Write-Output "Adding $($line.Split(" ")[0]) to data for $currentPath"
            if ((($currentPath.Split("/")).Count -1) -gt 1) {
                [string]$prevPath = $null
                for ($i = 0;$i -lt (($currentPath.Split("/")).Count -2);$i++) {
                    $pathPart = "$($currentPath.Split("/")[$i])" + "/"
                    $prevPath += $pathPart
                }
                Write-Output "Adding data to $prevPath as well"
                $dataTable.$prevPath += $currentData
                if ((($prevPath.Split("/")).Count -1) -gt 1) {
                    [string]$prevPrevPath = $null
                    for ($i = 0;$i -lt (($prevPath.Split("/")).Count -2);$i++) {
                        $pathPart = "$($prevPath.Split("/")[$i])" + "/"
                        $prevPrevPath += $pathPart
                    }
                    Write-Output "Adding data to $prevPrevPath as well"
                    $dataTable.$prevPrevPath += $currentData
                    if ((($prevPrevPath.Split("/")).Count -1) -gt 1) {
                        [string]$prevPrevPrevPath = $null
                        for ($i = 0;$i -lt (($prevPrevPath.Split("/")).Count -2);$i++) {
                            $pathPart = "$($prevPrevPath.Split("/")[$i])" + "/"
                            $prevPrevPrevPath += $pathPart
                        }
                        Write-Output "Adding data to $prevPrevPrevPath as well"
                        $dataTable.$prevPrevPrevPath += $currentData
                        if ((($prevPrevPrevPath.Split("/")).Count -1) -gt 1) {
                            [string]$prev4Path = $null
                            for ($i = 0;$i -lt (($prevPrevPrevPath.Split("/")).Count -2);$i++) {
                                $pathPart = "$($prevPrevPrevPath.Split("/")[$i])" + "/"
                                $prev4Path += $pathPart
                            }
                            Write-Output "Adding data to $prev4Path as well"
                            $dataTable.$prev4Path += $currentData
                            if ((($prev4Path.Split("/")).Count -1) -gt 1) {
                                [string]$prev5Path = $null
                                for ($i = 0;$i -lt (($prev4Path.Split("/")).Count -2);$i++) {
                                    $pathPart = "$($prev4Path.Split("/")[$i])" + "/"
                                    $prev5Path += $pathPart
                                }
                                Write-Output "Adding data to $prev5Path as well"
                                $dataTable.$prev5Path += $currentData
                                if ((($prev5Path.Split("/")).Count -1) -gt 1) {
                                    [string]$prev6Path = $null
                                    for ($i = 0;$i -lt (($prev5Path.Split("/")).Count -2);$i++) {
                                        $pathPart = "$($prev5Path.Split("/")[$i])" + "/"
                                        $prev6Path += $pathPart
                                    }
                                    Write-Output "Adding data to $prev6Path as well"
                                    $dataTable.$prev6Path += $currentData
                                    if ((($prev6Path.Split("/")).Count -1) -gt 1) {
                                        [string]$prev7Path = $null
                                        for ($i = 0;$i -lt (($prev6Path.Split("/")).Count -2);$i++) {
                                            $pathPart = "$($prev6Path.Split("/")[$i])" + "/"
                                            $prev7Path += $pathPart
                                        }
                                        Write-Output "Adding data to $prev7Path as well"
                                        $dataTable.$prev7Path += $currentData

                                    }
                                }
                            }
                        }
                    }
                }
            }
        $currentData = $null
    }
}

foreach ($dataValue in $dataTable) {
    if ($dataValue.Value -gt 22100000) {
        $dataValue
    }
}