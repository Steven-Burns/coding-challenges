# print all paths from root to all leaves in a binary tree

class Node {
   [Node] $left
   [Node] $right
   [char] $data
}

$tree = [Node]::new()
$tree.data = 'a'

$node = [Node]::new()
$node.data = 'b' 
$tree.left = $node

$node2 = [Node]::new()
$node2.data = 'f' 
$node.left = $node2

$node = [Node]::new()
$node.data = 'c' 
$tree.right = $node

$node2 = [Node]::new()
$node2.data = 'd'
$node.left = $node2

$node2 = [Node]::new()
$node2.data = 'e'
$node.right = $node2


function printTree([Node] $root, $indentLevel) {
    #Write-Debug $indentLevel
    if ($root -eq $null) { return }
    Write-host ((" " * $indentLevel) + $root.data.ToString())
    printTree $root.left ($indentLevel + 3)
    printTree $root.right ($indentLevel + 3)

}

$DebugPreference = "Continue"
printTree $tree 0

# idea: accumulate path as depth-first traversal proceeds
# when hitting a leaf node, "snapshot" the accumulated path

function printPath([Node] $root, $pathSoFar) {
    if ($root -eq $null) { return }
    $pathSoFar = $pathSoFar + $root.data
    Write-Debug "pathSoFar = $pathSoFar"
    if (($root.left -eq $null) -and ($root.right -eq $null)) {
        # we're a leaf, so spew.
        write-host $pathSoFar
    }
    printPath $root.left $pathSoFar
    printPath $root.right $pathSoFar
}


printPath $tree ""
