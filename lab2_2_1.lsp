(defun duplicate-inner (e n)
           (if (> n 0)
               (cons e (duplicate-inner e (- n 1)))
               nil))

(defun duplicate-elements (lst n)
           (when lst
             (append (duplicate-inner (car lst) n)
                    (duplicate-elements (cdr lst) n))))

(defun check-duplicate (name input-lst input-n expected) 
           "Execute `duplicate-elements' on `input', compare result with `expected' and print comparison status" 
           (format t "~:[FAILED~;passed~]... ~a~%" 
                   (equal (duplicate-elements input-lst input-n) expected) 
                   name))

(defun test-duplicate-elements ()
           (check-duplicate "test-1" '(a b c) 3 '(a a a b b b c c c))
           (check-duplicate "test-2" '((a) b c) 2 '((a) (a) b b c c))
           (check-duplicate "test-3" '(() a) 3 '(nil nil nil a a a))
           (check-duplicate "test-4" '(a b c) 0 nil))
