
# set is array 
function printSet([object[]] $set) {
    $display = "{ "
    foreach ($e in $set) {
        $display = $display + $e + " " 
    }
    $display = $display + "}"
    write-debug $display

}

function printPermutations([System.Collections.ArrayList] $a) {
    write-debug "["
    foreach ($p in $a) {
        printSet $p
    }
    write-debug "]"
}

# set is an array of letters 

function setDifference([object[]] $set, $e) {
    $result = @()
    for ($i = 0; $i -lt $set.Length; $i++) {
        if ($set[$i] -ne $e) {
            $result = $result + $set[$i]
        }
    }
    return $result
}

# returns an ArrayList containing arrays, each a permutation of a set

function permute([object[]] $set) {
    $result = [System.Collections.ArrayList]::new()
    if ($set.Length -eq 0) {
        return $result
    }
    if ($set.Length -eq 1) {
        $result.Add($set[0]) | out-null
        return $result
    }
    foreach ($e in $set) {
        write-debug "element $e"
        $tail = setDifference $set $e
        write-debug "tail $tail" 
        $permutationsofTail = permute $tail
        foreach ($p in $permutationsofTail) {
            # form a new array of char, appending the permutations of the subset to the head element
            $newPermutation = @($e) + $p
            write-debug "permutation $newPermutation"
            $result.Add($newPermutation) | out-null
        }    
    }
    return $result
}




$DebugPreference = "Continue"

$input = [System.Collections.ArrayList]::new()
$input.Add(@('a', 'b', 'c')) | out-null


#$d = setDifference $input[0] 'a'
#printSet $d


printPermutations $input

$permutations = permute $input[0]

printPermutations $permutations