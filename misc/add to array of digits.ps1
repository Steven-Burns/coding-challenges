# given an arry representing digits in a base-10 number
# and an integer, change the elements of the array such
# that they are the digits of the sum of the represented
# number and the integer.

# what is the range of the integer?
# what is the number base of the array?
# can we turn the array from an array of int to array of char?
# can we use temporary storage or does it need to be inplace?
# will any negative numbers be used?

# idea: mimic tabular arithmatic.
# need to start with the digits of the integer
# convert the integer to a similar array

$DebugPreference = "Continue"

$digits = @("1")
$integer = 9
# result should be @(0, 0, 5)

$digitsI = $integer.ToString()
$digitsA = @()
for ($i = 0; $i -lt $digitsI.Length; ++$i) {
    $digitsA = $digitsA + @($digitsI.Substring($i, 1))
}

$longest = $digits
$shortest = $digitsA
if ($digitsA.Length -gt $digits.Length) {
    $longest = $digitsA
    $shortest = $digits
}

# here we take advantage of a cheat of Powershell -- negative 
# indexing.  Which includes a cheat that unresolved indexes = $null

$index = -1
$carry = $false
$result = @()
for ($i = $longest.Length - 1; $i -ge 0; --$i) {
    $columnSum = [int] $longest[$index] + [int] $shortest[$index]

    # if there is a pending carry from a previous iteration 
    # work that in.
    if ($carry -eq $true) {
        $columnSum++
    }

    # there are two possibilities: we need to carry or not
    if ($columnSum -gt 9) {
        $carry = $true
        $columnSum -= 10
    } else {
        $carry = $false
    }

    # stuff the sum digit at the indexth position of the result
    # but since we're building in reverse, cons it onto the front
    $result = @($columnSum) + $result
    write-debug "result = $result"
    --$index
}

# at the termination of the loop, we've added all the digits 
# together, and might have a carry left over
# to prepend
if ($carry -eq $true) {
    $result = @(1) + $result
}

$result
