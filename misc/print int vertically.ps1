# Write the function: void PrintVertically(int i) that does not use any character or string manipulation function to print an integer vertically. What is the runtime complexity of your solution?
# Example:
# Input :123
# Output:
# 1
# 2
# 3


$theNumber = -123

if ($theNumber -eq 0) {
    "0" 
} else {
    $isNegative = $false
    if ($theNumber -lt 0) {
        $isNegative = $true
        $theNumber = [math]::Abs($theNumber)
    }
    $s = [System.Collections.Stack]::new()
    while ($theNumber -ne 0) {
        $digit = $theNumber % 10
        write-debug "pushing $digit"
        $s.Push($digit)
        $theNumber = [math]::Truncate($theNumber / 10)
    }

    if ($isNegative) { 
        "-"
    }
    while ($s.Count) {
       $d = $s.Pop()
       $d
    }
}
