# linear time determine max sub-array

$DebugPreference = "Continue"

#$array = @(1, 2, 3, 4, 5)   # whole thing 0..4
$array = @(1, 2, -3, 4, 5)  # 3..4
#$array = @(-1, -1, 2, -1)  # 2..2
#$array = @(0, 0, 0, 1)     # 0..4
#$array = @(0, 0, 0, 0)     # 0..4
#$array = @(-1, -2, -3, -4, -5)  # 1..1




#def max_subarray(A):
#    max_ending_here = max_so_far = A[0]
#    for x in A[1:]:
#        max_ending_here = max(x, max_ending_here + x)
#        max_so_far = max(max_so_far, max_ending_here)
#    return max_so_far


$a = 0
$b = 0
$i = 0
$j = 0
$maxOfMaxSum = $maxSumEndingAtUpper = $array[0]

while ( ($j -lt $array.Length) -and ($i -lt $array.Length) ) {
    write-debug "current interval: [$i..$j], maxSumEndingAtUpper is $maxSumEndingAtUpper, maxOfMaxSum is $maxOfMaxSum, biggest interval: [$a..$b]"

    $newCandidateMax = $maxSumEndingAtUpper + $array[$j + 1]

    if ($newCandidateMax -ge $maxSumEndingAtUpper) {

        # The max sum got bigger or stayed same, so extend the upper bound of the subarray
        # and leave the lower bound alone
        $maxSumEndingAtUpper = $newCandidateMax
        $j++
    } else {
        $j++
        $i = $j
        $maxSumEndingAtUpper = $array[$i]
    }

    if ($maxSumEndingAtUpper -ge $maxOfMaxSum) {
        # this is the biggest interval seen so far
        $a = $i 
        $b = $j
        $maxOfMaxSum = $maxSumEndingAtUpper
    }
        
} 
write-debug "max interval found: [$a..$b], max is $maxOfMaxSum"



