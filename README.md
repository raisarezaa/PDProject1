   # CS 4337 Project 1: Prefix Calculator

   ## Files
   - project1.rkt: the calculator program
   - devlog.md: development log
   - README.md: this file

   ## How to run
   Interactive mode:
       racket project1.rkt

   Batch mode (only prints results and errors):
       racket project1.rkt -b

   Type quit to exit.

   ## Supported expressions
- + and * take two expressions
- / takes two expressions (division by zero is an error)
- - is unary and negates one expression (there is no subtraction)
- $n uses the history value with id n (ids start at 1)
- numbers, including decimals
Whitespace between tokens is ignored (tested with edge case)

## Errors
Bad input prints "Error: Invalid expression". Text left over after a
complete expression prints "Error: Unexpected trailing characters". A
failed expression is not added to the history.

## How it works
Each parse function takes the remaining characters and the history and
returns a two element list: the value and the remaining characters. 

## Notes for the TA
- The mode detection code at the top of project1.rkt was provided by
  the professor.
- The spec says "/" is integer division and to print with
  real->double-flonum (which would print 4.0). The sample outputs show
  2.5 and 4, so I followed the samples: "/" is regular division and whole
  numbers print without ".0".
- I tested all 5 sample runs including edge cases.
