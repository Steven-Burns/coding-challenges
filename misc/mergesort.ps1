# mergesort

# merge two sorted arrays into a third
function merge([object[]]$a, [object[]]$b) {
    write-debug "merge a = $a b= $b, a.type = $($a.GetType().Name), b.type = $($b.GetType().Name)"
    $ai = 0
    $bi = 0
    $result = @()
     while (($ai -lt $a.Length) -and ($bi -lt $b.Length)) { 
        #write-debug "merge ai = $ai, bi = $bi"
        if ($a[$ai] -lt $b[$bi]) {
            # $a is lowest, take it
            $result = $result + $a[$ai]
            $ai++
        } elseif ($a[$ai] -gt $b[$bi]) {
            #$b is lowest, take it
            $result = $result + $b[$bi]
            $bi++
        } else {
            if (!($a[$ai] -eq $b[$bi])) {
                throw "ai and bi are supposed to ref equal elements"
            }
            # take either
            $result = $result + $a[$ai]
            $ai++
            $bi++
        }
    }
    # now, at this point, we may have run off the end of 
    # either $a or $b.

    if ($ai -ge $a.Length) {
        # take the rest of $b
        #Write-Debug "taking rest of b = $($b[$bi..($b.length - 1)])"
        $result = $result + $b[$bi..($b.length -1 )]
    } elseif ($bi -ge $b.length) {
        # take the rest of $a
        $j = $a.length - 1
        $rest = $a[$ai..$j]
        #Write-Debug "taking rest of a = $a, j = $j rest = $rest, ai = $ai"
        $result = $result + $a[$ai..($a.Length - 1)]
    }
    write-debug "merge end ai = $ai, bi = $bi, result = $result"
    return $result
}


# return a subarray of $a[$low..$high] that is sorted

function mergesort($a, $low, $high) {
    write-debug "mergesort a = $a low = $low high = $high"
    $merged = @()
    if ($low -eq $high) {
        $merged = $merged + $a[$low..$high]
    } else {
        $toBeSorted = $a[$low..$high]
        #write-debug "toBeSorted type = $($toBeSorted.GetType().Name)"
        $mid = [math]::Floor(($high - $low) / 2)
        #write-debug "toBeSorted = $toBeSorted mid = $mid"
        $lower = mergesort $toBeSorted 0 $mid
        $upper = mergesort $toBeSorted ($mid + 1) ($toBeSorted.Length - 1)
        write-debug "lower = $lower, lower.type = $($lower.GetType().Name)"
        write-debug "upper = $upper, upper.type = $($upper.GetType().Name)"
        $merged = merge $lower $upper
    }
    write-debug "merged = $merged, merged.type = $($merged.GetType().Name)"
    return $merged
}


$DebugPreference = "Continue"

# test merge
#merge @(0, 2, 4) @(1, 3, 5)
#merge @() @(1, 2, 3)
#merge @() @()
#merge @(1, 2, 3) @(5)
#merge @(5) @(1, 2, 3, 5)
#merge @(4) @(3)
#merge @(4) @()


$m = @(4, 3, 2, 1)
# $m = @()
# $m = @(odd number of elements)
# $m = @(already sorted)


mergesort $m 0 ($m.length - 1)



