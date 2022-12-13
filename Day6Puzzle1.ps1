$puzzleInput = 
$puzzleChars = $puzzleInput.ToCharArray()

for ($i=0;$i -lt $puzzleChars.Length;$i++) {
    if ($i -gt 2) {
        $minusOne = $i -1
        $minusTwo = $i -2
        $minusThree = $i -3
        if ($puzzleChars[$i] -ne $puzzleChars[$minusOne]) {
            if ($puzzleChars[$i] -ne $puzzleChars[$minusTwo]) {
                if ($puzzleChars[$i] -ne $puzzleChars[$minusThree]) {
                    if ($puzzleChars[$minusOne] -ne $puzzleChars[$minusTwo]) {
                        if ($puzzleChars[$minusTwo] -ne $puzzleChars[$minusThree]) {
                            if ($puzzleChars[$minusOne] -ne $puzzleChars[$minusThree]) {
                                Write-Output "$i has 4 different characters in a row"
                            }
                        }
                    }
                }
            }
        }
    }
}