# Given a set of n jobs with [start time, end time, cost] find a subset so that no 2 jobs overlap and the cost is maximum ?
# idea: brute force find all non-overlapping subsets, add up cost, sort

# find all subsets
# eliminate overlaps
# sum cost
# sort, take top

# eliminate overlap
# foreach element, loop thru others to see if there is overlap
# O(N^2)
# overlap = several cases
# s1..e1 fully inside s..e 
# s1..e1 overlaps on start side s1 < s
# s1..e1 overlaps on end side e1 > e
# s1..e1 toally encompasses s..e (both of the above are true)

# find all subsets e1..eN recursive 
# all subsets of the set excluding e1 and all subsets including e1
# all subsets of e2..eN union e1
# subset of empty is empty
# subset of size 1 is itself
# O(N^2)

# sum = O(N)
# sort = O(NlgN)

# can we do better?
# eliminate overlaps first
# answer must not include overlapping elements, so we know those don't need to be considered
# find all subsets
# sum
# sort
# O(N^2) + O(N^2) + O(N) + O(NlgN)
# O(N^2) dominates

# assumptions All times are ints, i < j ==> i before j

class Job {
    [int] $start
    [int] $end
    [int] $cost

    Job () {}
    Job ([int] $s, [int] $e, [int]$c) {
        $this.start = $s
        $this.end = $e
        $this.cost = $c
    }

    [bool] OverlapsWith([Job] $other) {
        $result = $false 

        # is either end is inside the other
        if ( (($this.start -ge $other.start) -and ($this.start -le $other.end)) -or (($this.end -ge $other.start) -and ($this.end -le $other.end)) )  {
            # this is inside $other
            $result = $true
        } elseif ( (($other.start -ge $this.start) -and ($other.start -le $this.end)) -or (($other.end -ge $this.start) -and ($other.end -le $this.end)) ) {
            # $other is inside $this
            $result = $true
        }
    
        return $result
    }
}

# a few test cases

[Job]::new(0, 5, 1).OverlapsWith([Job]::new(6, 10, 1)) 
[Job]::new(0, 5, 1).OverlapsWith([Job]::new(5, 10, 1)) 
[Job]::new(0, 5, 1).OverlapsWith([Job]::new(1, 4, 1)) 
[Job]::new(1, 5, 1).OverlapsWith([Job]::new(0, 1, 1)) 


$jobs = [System.Collections.Generic.HashSet[object]]::new()

$jobs.Add([Job]::new(0, 2, 5))
#$jobs.Add([Job]::new(3, 5, 2))
#$jobs.Add([Job]::new(4, 7, 3))
#$jobs.Add([Job]::new(8, 10, 3))



function RemoveOverlappers($set) {
    $modified = $true 
    :outer while($modified) { 
        $modified = $false 
        foreach ($e in $set) {
            foreach ($o in $set) {
                if ($e -eq $o) {
                    continue
                }
                if ($e.OverlapsWith($o)) {
                    # then $e and $o must go
                    $set.Remove($e)
                    $set.Remove($o)
                    $modified = $true
                    break outer
                }
            }
        }
    } 
}


RemoveOverlappers $jobs
$jobs


function FindAllSubsets($set) {
    $result = [System.Collections.ArrayList]::new()

    if ($set.Count -eq 0) {
        return $result
    }
    if ($set.Count -eq 1) {
        $newSet = [System.Collections.Generic.HashSet[object]]::new()
        $newSet.UnionWith($set)
        $result.Add($newSet)
        return $result
    }
    # the result is the subset containing just the first element
    # and all the subsets of first unioned with (subsets without first)
    
#incomplete:: this is a mess without a decent set class.
# rewrite to use arraylists instead of hashsets
    $setWithoutFirst = [System.Collections.Generic.HashSet[object]]::new()
    select $set -Last ($set.Count - 1) | % { $setWithoutFirst.Add($_) }

}


