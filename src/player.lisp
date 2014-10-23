(in-package :space)

(defstruct player x y health  chr color )

(defparameter *player* (make-player :x (random *world-width*) 
                                    :y (random *world-height*)
                                    :health 10
                                    :chr #\@
                                    :color +yellow+
                                    ))  

(defun move-left ()) 
(defun move-right ()) 
(defun move-up ()) 
(defun move-down ()) 

(defun draw-player (*player*)
  (with-color ((player-color *player))
    (write-char-at-point *standard-window*
                           
                           (floor (/ *width* 2))
                           (floor (/ *height* 2))
                           ))
  )

