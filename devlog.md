# 10-23-2026 3:41 pm

Thoughts so far: I still need to figure out whether the output should print as 4 or 
4.0, and whether / is integer division, since the sample runs show 2.5 but I am 
assuming it is considered float or regular division

Plan for this session: I'll create project1.rkt with #lang racket 
and paste in the mode detection snippet. Then I'll write a function that reads a 
number from the list of characters and returns the number plus the leftover 
characters. After that I'll add + and *, then unary -, then /. I'll test each one 
and commit after each. My goal for this session is for numbers, +, * and - to work 
on the simple sample inputs. I'm saving history.

# 10-23-2026 8:52 pm 

Thoughts so far: 
- parse functions return (list value remaining-chars), each one leaves
  the rest of the string for the next call
- history is a parameter of the eval loop, built with cons, newest first
- errors are raised as symbols and caught in the eval loop

Answering my earlier questions: the sample runs show 2.5 for /5 $1, so / is
regular division, not integer division. 

Plan for tis sesssion: Eventually test the program against all 5 sample runs in
batch mode, then check edge cases like /5 0, $0 and an empty line. 

# 10-23-2026 10:24pm

Thoughts so far: I forgot to commit during the evening session, so this is a 
catch up. Tonight I got a full working version of the calculator. I tested two 
samples and got this: Sample 1 (*+ 1 1 /4 2) gives 4. 
This checked + and * with nesting, and /. Sample 2 (+1 1, then /5$1) gives 2 and 
then 2.5. This checked history with $1, and showed me / is regular division.

Plan for this session; Continue doing the sample runs that were provided and
use them to test my code, along with some edge cases as well and paste results here.