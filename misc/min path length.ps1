# shortest path from node i to node n
# which is same as shortest path from (nodes reachable from i) to node n
# that is:
# determine the nodes reachable from i
#    for each of those, pick the one that has shortest path to n
#       which in turn has a recursion.
#       keep track in a table of path lengths between j, k

$adjacency = @(
    #  0  1  2  3  4  5  6  7
    @( 0, 1, 1, 0, 0, 0, 0, 0 ), #0 
    @( 1, 0, 1, 0, 0, 0, 0, 0 ), #1
    @( 1, 1, 0, 1, 1, 1, 0, 0 ), #2
    @( 0, 0, 1, 0, 0, 0, 1, 0 ), #3
    @( 0, 0, 1, 0, 0, 0, 0, 0 ), #4
    @( 0, 0, 1, 0, 0, 0, 0, 1 ), #5
    @( 0, 0, 0, 1, 0, 0, 0, 1 ), #6
    @( 0, 0, 0, 0, 0, 1, 1, 0 )  #7
)

$pathLengths = @(
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0),
    @( 0 , 0, 0, 0, 0, 0, 0, 0)
)

function printLengths() {
    for ($r = 0; $r -lt $pathLengths.Length; ++$r) {
        write-debug "$($pathLengths[$r])"
    }
}


$visited = @(0, 0, 0, 0, 0, 0, 0, 0)

$start = 0
$end = 7
$nodeCount = 8

function FindPathLengthToEnd($i, $lenSoFar) {
    $ws = "   " * $lenSoFar 
    write-debug "$ws find len $i $lenSoFar"

    if ($i -eq $end) {
        $lenSoFar-- # the last recursion will incr once too many times
        write-debug "$ws at end $i $lenSoFar"
        if ($lenSoFar -lt $pathLengths[$start][$end] -or ($pathLengths[$start][$end] -eq 0)) {
            write-debug "$ws new min $lenSoFar"
            $pathLengths[$start][$end] = $lenSoFar
        }
        return
    }
     
    if ($visited[$i] -ne 0) {
        write-debug "$ws $i already visited"
        return
    }
    $visited[$i] = 1
    
    for ($j = 0; $j -lt $nodeCount; ++$j) {
        if ($adjacency[$i][$j] -eq 1) {
            # j adjacent to i
            $pathLengths[$i][$j] = $pathLengths[$i][$j] + $lenSoFar 
            FindPathLengthToEnd $j ($lenSoFar + 1)

        }
    }

}


$DebugPreference = "Continue"
FindPathLengthToEnd $start 0
printLengths
