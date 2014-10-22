(in-package :space)

(defparameter *width* 0)
(defparameter *height* 0)
(defparameter *running* t)
(defparameter *grid* ())

(defconstant +red+ 1)
(defconstant +blue+ 2)
(defconstant +green+ 3)


(defun set-w-and-h ()
  (multiple-value-bind (w h)
    (window-dimensions *standard-window*)
    (setf *width* (-  w 1))
    (setf *height* (- h 1))))

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
  (setf *grid* (perlin2d-grid   *width*    *height* 0.1 4) )
  )

(defun testfun ())
(defun move-left ())
(defun move-right ())


(defun quit ()
  (setf *running* nil))


(defmacro with-color (color &body body)
  `(progn
     (cl-charms/low-level:attron (cl-charms/low-level:color-pair ,color))
     ,@body
     (cl-charms/low-level:attroff (cl-charms/low-level:color-pair ,color))))


(defun main ()
  (with-curses  ()
    (init)
    (loop :named main-loop
          :while *running*
          :do
          (get-input)
          (update-world)   
          (draw-world))))

