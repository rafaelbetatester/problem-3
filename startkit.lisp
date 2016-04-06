
;; Part 1 - lendo os dados

(ql:quickload :cl-ppcre)

;; Em http://cl-cookbook.sourceforge.net/strings.html temos a função
;; abaixo, mas ela quebra a string em 1 espaço em branco
;; exatamente. Veja que as linhas do arquivo tem um espaço em branco
;; sempre depois do segundo número.

(defun split-by-one-space (string)
  "Returns a list of substrings of string divided by ONE space each.
   Note: Two consecutive spaces will be seen as if there were an empty
   string between them."
  (loop for i = 0 then (1+ j)
	as j = (position #\Space string :start i)
	collect (subseq string i j)
	while j))

;; Duas soluções possiveis:
;; (mapcar #'parse-integer (remove-if #'alexandria:emptyp (split-by-one-space "1 1 ")))
;; (mapcar #'parse-integer (cl-ppcre:split "[ ]+" "1 1 "))

(defun read-data (filename)
  (with-open-file (in filename)
    (let ((res))
      (do ((line (read-line in nil nil)
		 (read-line in nil nil)))
	  ((null line)
	   (reverse res))
	(push (mapcar #'parse-integer (cl-ppcre:split "[ ]+" line)) res)))))


;; CL-USER> (defparameter graph (read-data "/Users/arademaker/Sites/ED-2016/problem-3/SCC.txt"))
;; GRAPH
;; CL-USER> (length graph)
;; 5105043
