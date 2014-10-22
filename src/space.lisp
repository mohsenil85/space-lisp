;(in-package :cl-user)
;(ql:quickload "cl-charms")
;(ql:quickload "perlin")
;(defpackage space
;  (:use :cl
;        :cl-charms
;        :perlin))
(in-package :space)

(defstruct player health cells)
;;cells = a list of coords.  
;; looks like:

;     A
;   <}V{>


(defparameter *width* 0)
(defparameter *height* 0)
(defparameter *running* t)
(defparameter *player* nil)

(defun testfun ())
(defun move-left ())
(defun move-right ())

(defun get-input ()
 (let ((c (get-char *standard-window* :ignore-error t)))
  (case c
    ((#\t) (testfun))   
    ((#\l) (move-left))
    ((#\h) (move-right))
    ((#\q) (quit)))))

;(defparameter *grid* (perlin:perlin2d-grid *width* *height* .01 4 ))

(defun num-to-char (num)
  (cond
    ((< num .4 ) #\~)
    ((< num .6 ) #\o)
    ((< num .7 ) #\^)
    ((< num .8 ) #\()
    ((< num .9 ) #\+)
    (t #\$)))

(defun update-world ()
  )


(defun draw-map-cell (i j)
  (write-char-at-point *standard-window*
                       (num-to-char (aref *grid* j i))
                       i j
                       )
  
  )

(defun draw-world ()
  (loop :for i 
        :below   *width*
        :do
        (loop :for j 
              :below    *height*
              :do
              (draw-map-cell i j)
               
              )
        )
  
  )


