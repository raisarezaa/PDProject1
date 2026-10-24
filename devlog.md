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
Sample 2 (+1 1, then /5$1) gives 2 and 
then 2.5. This checked history with $1, and showed me / is regular division.

Plan for this session; Continue doing the sample runs that were provided and
use them to test my code, along with some edge cases as well and paste results here.

# 10-23-2026 11:05 pm

Thoughts so far: Continued to test with the samples, for Sample 3 I got 
1: 2
2: 19.5
Sample 4 is all errors. +1 and /5 $1 with no history give "Invalid
expression", +1+1+1 1 1 gives "Unexpected trailing characters", and /5 0
is an error for dividing by zero. +1-1 correctly gives 0.
Sample 5 builds up history ($1 through $4) and gives 6, 30, 120, 360,
720, so the history lookup works.

Plan for this session: Run some edge cases to thoroughly test the code, happy 
that the sample runs worked with the code 

# 10-23-2026 11:37 pm

Thoughts so far: Continued to test some edge cases and here are the results:
Edge case 1: +1.5 2 gave 3.5, shows that decimals work
edge case 2: / 1 0 gave Invalid Expression, shows what happens when div by 0
edge case 3: --5 GAVE 5, shows two negatives cancel
Edge case 4: + 1 gave Invalid expression, shows what happens when missing 2nd oper

Plan for this session: Done with code and testing, will now write the README and
submit zip file for project submission. I enjoyed completing the project using
devlogs as this truly allowed a form of journaling experience for me when coding and 
makes the experience of this project more fun and enjoyable for me. 