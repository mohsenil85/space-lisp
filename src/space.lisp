(in-package :cl-user)
(ql:quickload "cl-charms")
(defpackage space
  (:use :cl
        :cl-charms))
(in-package :space)
(defstruct player health cells)

(defparameter *width* 0)
(defparameter *height* 0)
(defparameter *running* t)
(defparameter *player* '())

(defparameter red 1)
(defparameter blue 2)
(defparameter green 3)


(defun set-w-and-h ()
  (multiple-value-bind (w h)
    (window-dimensions *standard-window*)
    (setf *width* w)
    (setf *height* h)
    (setf *cells* (make-hash-table :size (* w h) :test 'equal))
    ))

(defun init ()
  (set-w-and-h)
  (disable-echoing)
  (cl-charms/low-level:curs-set 0)
  (enable-raw-input :interpret-control-characters t)
  (enable-non-blocking-mode *standard-window*)
  (cl-charms/low-level:start-color)
  (cl-charms/low-level:init-pair red 
       cl-charms/low-level:color_red charms/ll:color_black )
  (cl-charms/low-level:init-pair blue 
       cl-charms/low-level:color_blue charms/ll:color_black )
  (cl-charms/low-level:init-pair green 
        cl-charms/low-level:color_green charms/ll:color_black ))

(defun quit ()
  (setf *running* nil))

(defun get-input ()
 (let ((c (get-char *standard-window* :ignore-error t)))
  (case c
    ((nil) nil)
    ((#\l) (move-left *player*))   
    ((#\h) (move-right *player*))   
    ((#\q) (quit)))))

(defmacro with-color (color &body body)
  `(progn
     (cl-charms/low-level:attron (cl-charms/low-level:color-pair ,color))
     ,@body
     (cl-charms/low-level:attroff (cl-charms/low-level:color-pair ,color))))

(defun draw-cell (coords cell)
  (with-color (cell-color cell)
    (write-char-at-point  *standard-window* 
                         (cell-tile cell)   
                         (car coords) 
                         (cdr coords))))


(defun update-world ()
  (create-cell 2 2 #\# red)
  (create-cell 2 3 #\$ blue)
  (create-cell 2 4 #\# red)
  )

(update-world)
(defun draw-world ()
  (maphash #'draw-cell *cells*))

(defun main ()
  (with-curses  ()
    (init)
    (loop :named main-loop
          :while *running*
          :do
          (get-input)
          (update-world)   
          (draw-world))))

;(main)
