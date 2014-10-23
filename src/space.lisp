(in-package :space)


(defparameter *width* 0)
(defparameter *height* 0)
(defparameter *running* t)

(defun testfun ())

(defun get-input ()
 (let ((c (get-char *standard-window* :ignore-error t)))
  (case c
    ((#\t) (testfun))   
    ((#\k) (move-up))
    ((#\j) (move-down))
    ((#\l) (move-left))
    ((#\h) (move-right))
    ((#\q) (quit)))))



(defun update-world ())

(defun draw-world ()
  (draw-map)
  (draw-player)
  )
