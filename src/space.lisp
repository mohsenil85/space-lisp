(in-package :cl-user)
(ql:quickload "cl-charms")
(defpackage space
  (:use :cl
        :cl-charms))
(in-package :space)
(defstruct player health cells)
;;cells = a list of coords.  
;; looks like:

;     A
;   <}V{>


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
    (setf *cells* (make-hash-table :size (* w h) :test 'equal))))

(defun init ()
  (kill-all)
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

(defparameter *dbg* (format nil "foo ~A" *player*))
(defun move-left (p)
  (write-string-at-point  *standard-window* *dbg* 5 5 )
  )

(defun move-right (p)
  (move-left p))

(defun testfun ()
  (write-string-at-point *standard-window*)
  )

(defun quit ()
  (setf *running* nil))

(defun get-input ()
 (let ((c (get-char *standard-window* :ignore-error t)))
  (case c
    ((#\t) (testfun))   
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

(defstruct tile x y chr color)
(defun create-tile (x y chr color)
  (create-cell x y chr color))

;     A
;   <}V{>
(defun player-cells ()
  (let ((x (floor (/ (- *width* 3) 2)))
        (y (- *height* 2)))
    (list (make-tile :x x :y y :chr #\V :color blue)
          (make-tile :x x :y (- y 1) :chr #\A :color blue)
          (make-tile :x (- x 1) :y y :chr #\} :color blue)
          (make-tile :x (+ x 1) :y y :chr #\{ :color blue)
          (make-tile :x (- x 2) :y y :chr #\< :color blue)
          (make-tile :x (+ x 2) :y y :chr #\> :color blue))))

(defun init-player ()
  (let ((cls (player-cells)))
    (setf *player* (make-player :health 100 :cells cls))
    (loop for p in cls do
          (create-cell (tile-x p) (tile-y p) (tile-chr p)  (tile-color p)))))


;(- 10 1)

;*cells*
;(log-cells)
;(kill-all)

(defun update-world ()
  (create-cell 2 2 #\# red)
  (create-cell 2 3 #\$ blue)
  (create-cell 2 4 #\# red)
  )
;*player*

;(update-world)
(defun draw-world ()
  (maphash #'draw-cell *cells*))

(defun main ()
  (with-curses  ()
    (init)
    (init-player)
    (loop :named main-loop
          :while *running*
          :do
          (get-input)
          (update-world)   
          (draw-world))))

