# Print the sum of all the numbers at every vertical level in a binary tree

class Node {
   [Node] $left
   [Node] $right
   [int] $data
}

$tree = [Node]::new()
$tree.data = 2

$node = [Node]::new()
$node.data = 3 
$tree.left = $node

$node2 = [Node]::new()
$node2.data = 4 
$node.left = $node2

$node = [Node]::new()
$node.data = 5 
$tree.right = $node

$node2 = [Node]::new()
$node2.data = 6
$node.left = $node2

$node2 = [Node]::new()
$node2.data = 7
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

$queue = New-Object "system.collections.queue"

$level = 0
$sum = 0
$queue.Enqueue(@{val = $tree; level = $level})
while ($queue.Count -ne 0) {
    $q = $queue.Dequeue()
    if ($q.level -eq $level) {
        # same level as current, so add to the sum
        $sum += $q.val.data
    } else {
        # level has changed
        write-host "level $level sum is $sum"
        $level = $q.level
        $sum = $q.val.data
    }
    if ($q.val.left -ne $null) { 
        $queue.Enqueue(@{val = $q.val.left; level = $level + 1})
    }
    if ($q.val.right -ne $null) { 
        $queue.Enqueue(@{val = $q.val.right; level = $level + 1})
    }
}
write-host "level $level sum is $sum"






