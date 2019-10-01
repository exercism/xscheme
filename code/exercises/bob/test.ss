(define (parse-test test)
  (let ((input (lookup 'heyBob (lookup 'input test))))
  `(lambda ()
     (test-success ,(lookup 'description test) equal? response-for
       ,input (lookup 'expected test)))))

(define (spec->tests spec)
  `(,@*test-definitions*
     (define (test . args)
       (apply
         run-test-suite
         (list ,@(map parse-test (lookup 'cases spec)))
         args))))

(put-problem!
  'bob
  `((test . ,(spec->tests (get-test-specification 'bob)))
     (skeleton . ,"bob.scm")
     (solution . ,"example.scm")))
