#|
  This file is a part of space project.
|#

(in-package :cl-user)
(defpackage space-test-asd
  (:use :cl :asdf))
(in-package :space-test-asd)

(defsystem space-test
  :author ""
  :license ""
  :depends-on (:space
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "space"))))

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
