#|
  This file is a part of space project.
|#

(in-package :cl-user)
(defpackage space-asd
  (:use :cl :asdf))
(in-package :space-asd)

(defsystem space
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:cl-charms)
  :components ((:module "src"
                :components
                ((:file "space"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op space-test))))
