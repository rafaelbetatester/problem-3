(defparameter *visited* (make-hash-table))
(defparameter *S* nil)
	

(defun file->alist (&key (file-input "SCC.txt"))
  (with-open-file (stream file-input)
    (when stream 
	(loop for i = (read stream nil) 
	   while i collect
	     (cons i (read stream nil))))))

(defun generate-graph (alist)
  (let* ((edges (make-hash-table)))
    (loop for i in alist do
	 (push (cdr i) (gethash (car i) edges)))
    edges))

;;(defparameter *alist-data* (file->alist))
;;(defparameter *edges* (generate-graph *alist-data*))
;;(defparameter *reverse-edges* (generate-graph 
;;			       (loop for i in *alist-data*
;;			    collect (cons (cdr i) (car i)))))
	        
(defun dfs (x edges push?)
  (setf (gethash x *visited*) t)
  (let*
      ;;((edges (if push? *edges* *reverse-edges*))
	((vizinhos (gethash x edges))
	(size 
	 (1+
	  (loop for i in vizinhos sum 
	       (if (null (gethash i *visited*))
		   (dfs i edges push?) 0)))))
   (if push? (push x *S*))
    size))
    
  
;; (defun SCC (v)
;; 
;; 	  (sort 
;; 	   (let* ((edge-hash (file->edge-hash)))
;; 	     (loop for i from 1 to v append
;; 		  (if (null (gethash i *marked-hash*))
;; 		      (list (dfs i))))) #'>)))

(defun main (v)
  (let*((alist-data (file->alist))
	(edges (generate-graph alist-data))
	(reverse-edges (generate-graph (mapcar #'(lambda(x)
						   (cons (cdr x)
							 (car x)))
					       alist-data))))
  (loop for i from 1 to v do
       (if (null (gethash i *visited*))
	   (dfs i edges t)))
  (setf *visited* (make-hash-table))
  (format t "~5{~a~^, ~}"
	  (sort
	   (loop for i in *S* append
		(if (null (gethash i *visited*))
		    (list 
		     (dfs i reverse-edges nil))))
	   #'>))))
	     
;; sbcl --control-stack-size 100000
;; (main 875714)
