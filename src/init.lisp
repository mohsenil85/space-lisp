(in-package :space)


(defparameter *world-width* 0)
(defparameter *world-height* 0)

(defparameter *width* 0)
(defparameter *height* 0)
(defparameter *running* t)
(defparameter *grid* ())

(defconstant +red+ 1)
(defconstant +blue+ 2)
(defconstant +green+ 3)
(defconstant +yellow+ 4)
(defconstant +magenta+ 5)
(defconstant +cyan+ 6)


(defun set-w-and-h ()
  (multiple-value-bind (w h)
    (window-dimensions *standard-window*)
    (setf *width* (-  w 1))
    (setf *height* (- h 1))
    (setf *world-width* (* *width* 3))
    (setf *world-height* (* *height* 3))
    ))

(defun init ()
  (set-w-and-h)
  (disable-echoing)
  (cl-charms/low-level:curs-set 0)
  (enable-raw-input :interpret-control-characters t)
  (enable-non-blocking-mode *standard-window*)
  (cl-charms/low-level:start-color)
  (cl-charms/low-level:init-pair +red+ 
       cl-charms/low-level:color_red charms/ll:color_black )
  (cl-charms/low-level:init-pair +blue+ 
       cl-charms/low-level:color_blue charms/ll:color_black )
  (cl-charms/low-level:init-pair +green+ 
        cl-charms/low-level:color_green charms/ll:color_black )
  (cl-charms/low-level:init-pair +yellow+ 
        cl-charms/low-level:color_yellow  charms/ll:color_black )
  (cl-charms/low-level:init-pair +magenta+ 
        cl-charms/low-level:color_magenta  charms/ll:color_black )
  (cl-charms/low-level:init-pair +cyan+ 
        cl-charms/low-level:color_cyan  charms/ll:color_black )
  (setf *grid* (perlin2d-grid   *world-width* *world-height*  0.1 4) ))


(defun quit ()
  (setf *running* nil))


(defmacro with-color (color &body body)
  `(progn
     (cl-charms/low-level:attron (cl-charms/low-level:color-pair ,color))
     ,@body
     (cl-charms/low-level:attroff (cl-charms/low-level:color-pair ,color))))

(defun game-loop ()
    (loop :named main-loop
          :while *running*
          :do
          (get-input)
          (update-world)   
          (draw-world))  )

(defun start-screen ()
  (let ((w (make-window *width* *height* 0 0 )  )) 
    (write-string-at-point w
                           (format nil "welcome")
                           0 0) 
    (loop :named start-loop
          :for c := (get-char w :ignore-error t)
          :do
          (case c
            ((#\Space) (progn
                        (destroy-window w)
    ;                    (game-loop)      
                         (return-from start-loop)
                         ))))))

(defun main ()
  (with-curses  ()
    (init)
    (start-screen)
    (game-loop)
    ))

