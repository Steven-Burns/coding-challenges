# given a forest of balanced trees and two nodes n1 and n2
# find nearest common parent or null if none
#
# in O(lgN) time and O(1) space
#
# each node has parent, left, right ptrs

class Node {
    [Node] $parent
    [Node] $left 
    [Node] $right
    [char] $c

    Node() {}
    Node([Node] $parent, [char] $c) {
        $this.parent = $parent
        $this.c = $c
    }
}


# idea: nested loops walking upward.
# if n1 and n2 are in the same tree, eventually we'll hit

function FindCommonParent([Node] $n1, [Node] $n2) {
    $found = $false 
    for ($p1 = $n1.parent; ($p1 -ne $null) -and -not $found; $p1 = $p1.parent) {
        for ($p2 = $n2.parent; $p2 -ne $null; $p2 = $p2.parent) {
            if ($p1 -eq $p2) {
                $found = $true
                break
            }
        }        
    }
    if ($found -eq $true) {
        return $p2
    }
    return $null
}

function printTree([Node] $root, $indentLevel) {
    #Write-Debug $indentLevel
    if ($root -eq $null) { return }
    Write-host ((" " * $indentLevel) + $root.c.ToString())
    printTree $root.left ($indentLevel + 3)
    printTree $root.right ($indentLevel + 3)

}


$n = [Node]::new($null, '1')
$l = [Node]::new($n, '2'); $n.left = $l
$r = [Node]::new($n, '3'); $n.right = $r


