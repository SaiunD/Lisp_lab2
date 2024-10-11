<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"
</p>
<p align="right">
    <strong>Студентка</strong>: <em><strong>Саюн Дарина Миколаївна</strong></em>
</p>
<p align="right">
    <strong>Група</strong>: <em><strong>КВ-13</strong></em>
</p>
<p align="right">
    <strong>Рік</strong>: <em><strong>2024</strong></em>
</p>

## Загальне завдання

Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно реалізувати, задаються варіантом (п. 2.1.1).
Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій для роботи зі списками, що не наведені в четвертому розділі навчального посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів. 

Кожна реалізована функція має бути протестована для різних тестових наборів. Тести мають бути оформленні у вигляді модульних тестів (див. п. 2.3).

## Варіант 1 (16)
1. Написати функцію `reverse-and-nest-head` , яка обертає вхідний список та утворює вкладeну структуру з підсписків з його елементами, починаючи з голови:
```lisp
CL-USER> (reverse-and-nest-head '(a b c))
(((C) B) A)
```
2. Написати функцію `duplicate-elements` , що дублює елементи вхідного списку задану кількість разів:
```lisp
CL-USER> (duplicate-elements '(a b c) 3)
(A A A B B B C C C)
```

## Лістинг функції `reverse-and-nest-head`
```lisp
CL-USER> (defun reverse-and-nest-head (lst)
           (when lst
             (if (cdr lst)
                 (cons (reverse-and-nest-head (cdr lst)) (list (car lst)))
                 (list (car lst)))))
REVERSE-AND-NEST-HEAD
```
### Тестові набори
```lisp
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
```
### Тестування
```lisp
CL-USER> (test-reverse)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
```

## Лістинг функції `duplicate-elements`
```lisp
CL-USER> (defun duplicate-inner (e n)
           (if (> n 0)
               (cons e (duplicate-inner e (- n 1)))
               nil))
DUPLICATE-INNER
CL-USER> (defun duplicate-elements (lst n)
           (when lst
             (append (duplicate-inner (car lst) n)
                    (duplicate-elements (cdr lst) n))))
DUPLICATE-ELEMENTS
```

### Тестові набори
```lisp
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
```

### Тестування
```lisp
CL-USER> (test-duplicate-elements)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
```

## Лістинг додаткової реалізації функції `duplicate-elements`
В альтернативній версії реалізована хвостова рекурсія та цикл
```lisp
CL-USER> (defun duplicate-inner-alt (e res n) 
           (if (> n 0)
               (duplicate-inner e (cons e res) (- n 1))
               res))
DUPLICATE-INNER-ALT
CL-USER> (defun duplicate-elements-alt (lst n)
           (let ((result '()))  
             (dolist (elem lst) 
               (setq result (nconc result (duplicate-inner elem nil n)))) 
             result))
DUPLICATE-ELEMENTS-ALT
```

### Тестові набори
```lisp
CL-USER> (defun check-duplicate-alt (name input-lst input-n expected) 
           "Execute `duplicate-elements-alt' on `input', compare result with `expected' and print comparison status" 
           (format t "~:[FAILED~;passed~]... ~a~%" 
                   (equal (duplicate-elements-alt input-lst input-n) expected) 
                   name))
CHECK-DUPLICATE-ALT
CL-USER> (defun test-duplicate-elements-alt ()
           (check-duplicate-alt "test-1" '(a b c) 3 '(a a a b b b c c c))
           (check-duplicate-alt "test-2" '((a) b c) 2 '((a) (a) b b c c))
           (check-duplicate-alt "test-3" '(() a) 3 '(nil nil nil a a a))
           (check-duplicate-alt "test-4" '(a b c) 0 nil))
TEST-DUPLICATE-ELEMENTS-ALT
```

### Тестування
```lisp
CL-USER> (test-duplicate-elements-alt)
passed... test-1
passed... test-2
passed... test-3
passed... test-4
NIL
```
