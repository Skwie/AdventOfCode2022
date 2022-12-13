$puzzleInput = 
$puzzleChars = $puzzleInput.ToCharArray()

for ($i=0;$i -lt $puzzleChars.Length;$i++) {
    if ($i -gt 13) {
        $tempArray = $puzzleChars[($i-13)..($i)] | Sort-Object | Get-Unique
        if ($tempArray.Count -eq 14) {
            Write-Output "No duplicates at marker $($i+1)"
        }
    }
}