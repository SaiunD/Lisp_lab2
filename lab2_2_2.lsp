(defun duplicate-inner-alt (e res n) 
           (if (> n 0)
               (duplicate-inner e (cons e res) (- n 1))
               res))

(defun duplicate-elements-alt (lst n)
           (let ((result '()))  
             (dolist (elem lst) 
               (setq result (nconc result (duplicate-inner elem nil n)))) 
             result))

(defun check-duplicate-alt (name input-lst input-n expected) 
           "Execute `duplicate-elements-alt' on `input', compare result with `expected' and print comparison status" 
           (format t "~:[FAILED~;passed~]... ~a~%" 
                   (equal (duplicate-elements-alt input-lst input-n) expected) 
                   name))

(defun test-duplicate-elements-alt ()
           (check-duplicate-alt "test-1" '(a b c) 3 '(a a a b b b c c c))
           (check-duplicate-alt "test-2" '((a) b c) 2 '((a) (a) b b c c))
           (check-duplicate-alt "test-3" '(() a) 3 '(nil nil nil a a a))
           (check-duplicate-alt "test-4" '(a b c) 0 nil))
