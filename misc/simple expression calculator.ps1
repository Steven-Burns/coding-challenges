# simple expression calculator

function IsNumber($str) {
    if ([string]::IsNullOrWhiteSpace($str)) { 
        return $false
    }
    if ($str -match "^[0-9]+$") {
        return $true
    }
    return $false
}



function calc($expr) {
    write-debug "calc $expr"
    if (IsNumber($expr)) {
        return [System.Convert]::ToInt32($expr)
    }
    # do + - before * / so that the multiply/divide is pushed deeper into recursion than the 
    # add/subtract.  As the recursion pops, it does so depth-first, so mul/div will happen 
    # before add/sub
    $a = $expr.Split("+")
    if ($a.Length -gt 1) {
        # there are at least two addends
        write-debug "add $a"
        $result1 = calc($a[0]) 
        $result2 = calc([string]::Join("+", $a[1..($a.Length - 1)]) )
        return $result1 + $result2
    }
    $a = $expr.Split("*")
    if ($a.Length -gt 1) {
        # there are at least 2 multiplicands
        write-debug "mul $a"
        $result1 = calc($a[0])
        $result2 = calc([string]::Join("*", $a[1..($a.Length - 1)]))
        return $result1 * $result2
    }

}


$DebugPreference = "Continue"

calc("1+2*5+6")

calc("1+2+3+4")
calc("3+2*2*4+7")