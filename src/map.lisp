(in-package :space)

(defparameter *buffer* (make-hash-table ) ')

(defun num-to-char (num)
  (cond
    ((< num .6 ) #\~)
    ;((< num .6 ) #\o)
    ((< num .8 ) #\.)
    ;((< num .8 ) #\()
    ((< num .9 ) #\+)
    (t #\$)))

(defun char-point-color (color chr i j)
  (with-color color
    (write-char-at-point *standard-window* chr i j )))

(defun draw-map-cell (i j)
  (let ((chr (num-to-char (aref *grid* j i))))
    (case chr
      ((#\~) (char-point-color +blue+ chr i j))
      ((#\.) (char-point-color +red+ chr i j))
      ((#\o) (char-point-color +red+ chr i j))
      ((#\() (char-point-color +green+ chr i j))
      ((#\+) (char-point-color +green+ chr i j))
      (otherwise (write-char-at-point *standard-window* chr i j)))) )


(defun draw-map ()
  (loop :for i 
        :below   *width*
        :do
        (loop :for j 
              :below    *height*
              :do
              (draw-map-cell i j))))

