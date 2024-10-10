; SLIME 2.24
CL-USER> (defun duplicate-inner (e n)
           (when (> n 0)
             (cons e (duplicate-inner e (- n 1)))))
DUPLICATE-INNER
CL-USER> (defun duplicate-elements (lst n)
           (when lst
             (nconc (duplicate-inner (car lst) n)
                    (duplicate-elements (cdr lst) n))))
DUPLICATE-ELEMENTS
CL-USER> (defun check-duplicate (name input-lst input-n expected) 
           "Execute `duplicate-elements' on `input', compare result with `expected' and print comparison status" 
           (format t "~:[FAILED~;passed~]... ~a~%" 
                   (equal (duplicate-elements input-lst input-n) expected) 
                   name))
CHECK-DUPLICATE
CL-USER> (defun test-duplicate-elements ()
           (check-duplicate "test-1" '(a b c) 3 '(a a a b b b c c c))
           (check-duplicate "test-2" '((a) b c) 2 '((a) (a) b b c c))
           (check-duplicate "test-3" '(() a) 3 '(nil nil nil a a a))
           (check-duplicate "test-4" '(a b c) 0 nil))
TEST-DUPLICATE-ELEMENTS
CL-USER> (test-duplicate-elements)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
CL-USER> 
