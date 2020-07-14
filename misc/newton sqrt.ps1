# newton's method to calc sqrt.

# x = sqrt(n) is the same as x^2 = n, which is the same as X^2 - n = 0
# the method is to make a guess x0 
# the refine the guess x1 = x0 - f(x) / f'(x)
# here f(x) = x^2 - n
# f'(x) = 2x

function refine([double] $x0, [double] $n) {
   return $x0 - ($x0 * $x0 - $n) / (2 * $x0)
}

function newton([double] $n, [double] $startingGuess) {  
    $guess = $startingGuess

    for(;;) {
        write-debug $guess
        $nextGuess = refine $guess $n
        if (($nextGuess - $guess) -eq 0) {
            break;
        }
        $guess = $nextGuess
    }

    return $guess
}


$DebugPreference = "Continue"
newton 4 1