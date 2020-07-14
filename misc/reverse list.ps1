# reverse a linked list

class Node {
    [Node] $next
    [string] $data

    #Node() { }
    Node([Node] $next, [string] $data) {
        $this.next = $next
        $this.data = $data
    }
}


$list = [Node]::new([Node]::new([Node]::new([Node]::new($null, "d"), "c"), "b"), "a")

function printList($list) {
    while ($list -ne $null) {
        write-debug $list.data
        $list = $list.next
    }
}

function printListInReverse($list) {
    if ($list -ne $null) {
        printListInReverse $list.next
        write-debug $list.data
    }
}

$queue = [System.Collections.Queue]::new()
$head = $list 

function reverseList($list) {
    if ($list -ne $null) {
        $queue.Enqueue($list)
        reverseList($list.next)
        if ($queue.Count -ne 0) {
            $list.next = $queue.Dequeue()
        } else {
            $list.next = $null
        }
    } else {
        $global:head = $queue[$queue.Count - 1]
    }
}


$DebugPreference = "Continue"

#printList $list

#printListInReverse $list

reverseList $list

printList $head
