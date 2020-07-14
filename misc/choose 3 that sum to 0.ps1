# find three elements in an array that sum to 0
#
# restate this as finding a 3-permutation of the elements that sums to 0
# so, how to find all 3-permutations?
# brute force is N^3 
#
# is there a divide and conquer approach?
#
# idea: random choose with good distribution might not be too bad in practice

# let's do brute force

$DebugPreference = "Continue"

$array = @(1, 3, -2, 4, -1, -1, 1)


# but we don't want duplicates.  So make the tuple a binary number where 
# 1s select the represented elements

function GenerateTuples($array) {

    if ($array.Length -lt 3) {
        throw "array too small"
    }
    if ($array.Length -gt 31) {
        throw "array too large"
    }

    # could also check for non-integer elements or sillinesses like that

    $tuples = [System.Collections.ArrayList]::new()

    for ([int] $i = 0; $i -lt $array.Length; ++$i) {
        for ([int] $j = 0; $j -lt $array.Length; ++$j) {
            for ([int] $k = 0; $k -lt $array.Length; ++$k) {
                $choice1 = $i 
                if ($j -ne $i) {
                    $choice2 = $j
                } else {
                    $choice2 = $null
                }
                if (($k -ne $j) -and ($k -ne $i)) {
                    $choice3 = $k
                } else {
                    $choice3 = $null
                }
                if ($choice2 -ne $null -and $choice3 -ne $null) {
                    # output a tuple of elements to consider
                    $tuple = [math]::Pow(2, $choice1) + [math]::Pow(2, $choice2) + [math]::Pow(2, $choice3)
                    if (-not $tuples.Contains($tuple)) {
                        Write-Debug $tuple 
                        $sum = $array[$choice1] + $array[$choice2] + $array[$choice3]
                        if ($sum -eq 0) {
                            $tuples.Add($tuple) | out-null
                            write-debug "added $tuple"
                        }
                    }
                }
            }
        }
    }
    return $tuples
}

# there should be n choose 3 tuples, where n = $array.Length
# which is n! / (3! (n - 3)!)

$tuples = GenerateTuples $array

                
            