# 0 = open, 1 = wall, 3 = end, 4 = been there
$maze = @(
    @( 0, 0, 0, 0),
    @( 1, 1, 1, 0),
    @( 3, 1, 0, 0)
    @( 0, 1, 0, 1),
    @( 0, 1, 0, 0)
)


function printMaze($maze) {
    foreach ($y in $maze) {
        $line = "- "
        foreach ($x in $y) {
            $line = $line + "$x"
        }
        write-debug $line
    }
}

function isOnMap($x, $y, $maze) {
    if ( ($x -ge 0) -and ($x -lt $maze[0].Length) -and 
        ($y -ge 0) -and ($y -lt $maze.Length) ) {
        return $true
    }
    return $false
}

function solve($x, $y, $maze) {
    printMaze $maze
    if (-not (isOnMap $x $y $maze)) {
        write-debug "$x, $y not on map"
        return $false
    }
    if ($maze[$y][$x] -eq 3) {
        # yay!
        write-debug "$x, $y is end"
        return $true
    }
    if ($maze[$y][$x] -eq 1) {
        # no go 
        write-debug "$x, $y is a wall"
        return $false
    }
    if ($maze[$y][$x] -eq 0) {
        write-debug "$x, $y is open"
        # mark current position 
        $maze[$y][$x] = 4
        if (solve ($x -1) $y $maze) {
            return $true
        } elseif (solve ($x + 1) $y $maze) {
            return $true
        } elseif (solve $x ($y - 1) $maze) {
            return $true
        } elseif (solve $x ($y + 1) $maze) {
            return $true
        }
    }
    return $false
}


$DebugPreference = "Continue"

#printMaze $maze
solve 0 0 $maze
