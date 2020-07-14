$input = "go"
$nearby = @{ 
    "g" = @("g", "h", "i")
    "o" = @("o", "i", "l") 
}

function get_nearby_chars([string] $c) {
    return $nearby[$c]
}


function is_word($word) {
    # TODO: replace with lexcial dictionary lookup 
    return $true;
}


function get_permutations([string] $word) {
    # base-est case
    if ([string]::IsNullOrEmpty($word)) { 
        write-debug "basest case"
        return $null 
    }

    # base case: the permutations of a single letter are just the nearby
    if ($word.Length -eq 1) { 
        write-debug "base case $word"
        $near = get_nearby_chars $word 
        $near
    }

    # recursive case: the permutations are the variations of the 
    # head concatentated with the permutations of the tail
    $variations = get_nearby_chars $word[0]
    write-debug "variations = $variations"
    $tail_permutations = get_permutations ($word.Substring(1, $word.Length - 1))
    write-debug "tail perms = $tail_permutations"
    foreach ($variation in $variations) {
        foreach ($tp in $tail_permutations) {
            write-output ($variation + $tp)
        }
    }
 }

 get_permutations "goo"
