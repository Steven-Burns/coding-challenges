# two arrays with sorted, non-overlapping intervals
# merge them, merging the intervals into non-overlapping

# arrays can be different lengths?
# are negative numbers in the interval?
# what does a merged interval mean?
#   I will take it to mean that for every natural number spanned is in at least one interval or the other
#   startI..endI  startJ..endJ 
# is adjacency a possiblility in any of the lists?  where an interval directly follows the prior with no gap
# intervals that are adjacent are merged
# 

# 3-11, 17-25, 58-73
# 6-18, 40-47
# soln: 3-25, 40-47, 58-73

class Interval {
    [int] $start = 0
    [int] $end = 0

    Interval() {}

    Interval([int] $s, [int] $e) {
        $this.start = $s
        $this.end = $e
    }
}


function Munch([Interval] $interval, $list1, $list2) {
    # trim elements off the fronts of the lists until they do not overlap 

    do {
        $expanded = $false
        if ($list1.Length -gt 0 -and ($list1[0].start -le $interval.end)) {
            # expand the interval to include the overlapping element
            $interval.end = $list1[0].end
            $expanded = $true
            $list1.RemoveAt(0) 
        } 
        if ($list2.Length -gt 0 -and ($list2[0].start -le $interval.end)) {
            $interval.end = $list2[0].end
            $expanded = $true
            $list2.RemoveAt(0) 
        }
    } while ($expanded)
    return $interval
}

$result = @()

$list1 = [System.Collections.ArrayList]::new()
@([Interval]::new(3, 11), [Interval]::new(17, 25), [Interval]::new(58, 73)) | % { $list1.Add($_) | Out-Null }

$list2 = [System.Collections.ArrayList]::new()
@([Interval]::new(6, 18), [Interval]::new(40, 47)) | % { $list2.Add($_) | Out-Null }


while ($list1.Count -gt 0 -and $list2.Count -gt 0) {
    $interval = [Interval]::new($list1[0].start, $list1[0].start)
    if ($list2[0].start -lt $list1[0].start) {
        $interval = $list2[0]
    }

    $result = $result + (Munch $interval $list1 $list2)
}

$result = $result + $list1 + $list2

$result
