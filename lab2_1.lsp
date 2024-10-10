; SLIME 2.24
CL-USER> (defun reverse-and-nest-head (lst)
           (when lst
             (if (cdr lst)
                 (cons (reverse-and-nest-head (cdr lst)) (list (car lst)))
                 (list (car lst)))))
REVERSE-AND-NEST-HEAD
CL-USER> (defun check-reverse-and-nest-head (name input expected)
           "Execute `reverse-and-nest-head' on `input', compare result with `expected' and print comparison status"
           (format t "~:[FAILED~;passed~]... ~a~%" 
                   (equal (reverse-and-nest-head input) expected) 
                   name))
CHECK-REVERSE-AND-NEST-HEAD
CL-USER> (defun test-reverse ()
           (check-reverse-and-nest-head "test-1" '(a b c) '(((c) b) a))
           (check-reverse-and-nest-head "test-2" '((a) (b) (c)) '((((c)) (b)) (a)))
           (check-reverse-and-nest-head "test-3" '(a b c ()) '((((nil) c) b) a))
           (check-reverse-and-nest-head "test-4" '(() a b c) '((((c) b) a) nil)))
TEST-REVERSE
CL-USER> (test-reverse)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
CL-USER> 
