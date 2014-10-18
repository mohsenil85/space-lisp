(in-package :space)

(defstruct cell tile color)

(defparameter *cells* (make-hash-table :test 'equal))

(defun translate-cell (cell dir)
  (let ((x (car cell))
        (y (cdr cell)))
    (ecase dir
      (:up (cons x (1- y)))
      (:down (cons x (1+ y)))
      (:right (cons (1+ x) y))
      (:left (cons (1- x) y))))) 


(defun move-cell (cell dir)
  (let* ((new-key (translate-cell cell dir))
         (val (gethash cell *cells*)))
    (remhash cell *cells*)
    (setf (gethash new-key *cells*) val)))

(defun move-cell-by-coords (x y dir)
  (let* ((key (cons x y))
         (new-key (translate-cell key dir))
         (val (gethash key *cells*)))
    (remhash key *cells*)
    (setf (gethash new-key *cells*) val)))

(defun create-cell (x y tile color)
  (let ((coords (cons x y )))
    (setf (gethash coords *cells*)
          (make-cell :tile tile 
                     :color color))))

(defun log-cell (key val)
  (format t "~A~A~%" key val))

(defun log-cells ()
  (maphash  #'log-cell *cells*))


(defun kill-cell (key val)
  (remhash key *cells*))

(defun kill-all ()
(maphash  #'kill-cell *cells*))
