#lang racket

(define prompt?
  (let [(args (current-command-line-arguments))]
    (cond
      [(= (vector-length args) 0) #t]
      [(string=? (vector-ref args 0) "-b") #f]
      [(string=? (vector-ref args 0) "--batch") #f]
      [else #t])))

;;errors are raised as symbols and caught in the eval loop
(define (invalid) (raise 'invalid))
(define (trailing) (raise 'trailing))

(define (skip-ws cs)
  (if (and (pair? cs) (char-whitespace? (car cs)))
      (skip-ws (cdr cs))
      cs))

(define (take-while pred cs)
  (if (and (pair? cs) (pred (car cs)))
      (let ([r (take-while pred (cdr cs))])
        (list (cons (car cs) (car r)) (cadr r)))
      (list '() cs)))

(define (number-char? c) (or (char-numeric? c) (char=? c #\.)))

;; every parse function takes (chars history) and returns
;; (list value remaining-chars), or raises an error
(define (parse-expr cs hist)
  (let ([cs (skip-ws cs)])
    (cond
      [(null? cs) (invalid)]
      [(char=? (car cs) #\+) (parse-binary + (cdr cs) hist)]
      [(char=? (car cs) #\*) (parse-binary * (cdr cs) hist)]
      [(char=? (car cs) #\/) (parse-binary safe-div (cdr cs) hist)]
      [(char=? (car cs) #\-) (parse-negate (cdr cs) hist)]
      [(char=? (car cs) #\$) (parse-history (cdr cs) hist)]
      [(number-char? (car cs)) (parse-number cs)]
      [else (invalid)])))

(define (safe-div a b)
  (if (zero? b) (invalid) (/ a b)))

(define (parse-binary op cs hist)
  (let* ([a (parse-expr cs hist)]
         [b (parse-expr (cadr a) hist)])
    (list (op (car a) (car b)) (cadr b))))

(define (parse-negate cs hist)
  (let ([a (parse-expr cs hist)])
    (list (- (car a)) (cadr a))))

(define (parse-history cs hist)
  (let* ([r (take-while char-numeric? cs)]
         [digits (car r)])
    (if (null? digits)
        (invalid)
        (let ([n (string->number (list->string digits))])
          (if (and (>= n 1) (<= n (length hist)))
              (list (list-ref (reverse hist) (- n 1)) (cadr r))
              (invalid))))))

(define (parse-number cs)
  (let* ([r (take-while number-char? cs)]
         [n (string->number (list->string (car r)))])
    (if (and n (real? n))
        (list n (cadr r))
        (invalid))))

;; sample outputs print 4, so whole numbers print without ".0".
;; set to #t for the 4.0 style
(define show-decimal-point? #f)

(define (show-value v)
  (let ([f (real->double-flonum v)])
    (if (and (not show-decimal-point?) (integer? f))
        (display (inexact->exact f))
        (display f))))

;; history is a parameter; newest value first, id = its position
;; counting from the oldest
(define (eval-loop hist)
  (when prompt?
    (display "> ")
    (flush-output))
  (let ([line (read-line)])
    (cond
      [(eof-object? line) (void)]
      [(string=? (string-trim line "\r" #:left? #f) "quit") (void)]
      [else
       (let ([result
              (with-handlers ([symbol? (lambda (e) e)])
                (let* ([r (parse-expr (string->list line) hist)])
                  (if (null? (skip-ws (cadr r)))
                      (car r)
                      (trailing))))])
         (cond
           [(eq? result 'invalid)
            (displayln "Error: Invalid expression")
            (eval-loop hist)]
           [(eq? result 'trailing)
            (displayln "Error: Unexpected trailing characters") ;; as said in sample
            (eval-loop hist)]
           [else
            (let ([new-hist (cons result hist)])
              (display (length new-hist))
              (display ": ")
              (show-value result)
              (newline)
              (eval-loop new-hist))]))])))

(eval-loop '())